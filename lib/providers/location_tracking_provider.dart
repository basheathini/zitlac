import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../datasource/hive_tracking_data_source.dart';
import '../injection_container.dart';
import '../models/location_model.dart';
import '../models/location_summary_model.dart';
import '../services/location_service.dart';
import '../services/geofence_service.dart';
import '../utils/helper_functions.dart';

class TrackingProvider extends ChangeNotifier {
  final LocationService _locationService = getIt<LocationService>();
  final GeofenceService _geofenceService = getIt<GeofenceService>();
  final HiveTrackingDataSource _trackingDataSource = getIt<HiveTrackingDataSource>();

  StreamSubscription<Position>? _locationSubscription;
  List<LocationSummaryModel> _trackingHistory = [];
  List<LocationModel> _trackedPoints = [];
  bool _isTracking = false;
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  bool get isTracking => _isTracking;
  List<LocationModel> get trackedPoints => _trackedPoints;
  List<LocationSummaryModel> get trackingHistory => _trackingHistory;

  TrackingProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await fetchTrackingHistory();
      _isInitialized = true;
    } catch (e) {
      debugPrint('Initialization error: $e');
      _isInitialized = false;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  Future<void> toggleTracking() async {
    if (_isTracking) {
      await _stopTracking();
    } else {
      await _startTracking();
    }
    notifyListeners();
  }

  Future<void> _startTracking() async {
    final permissionGranted = await _locationService.requestPermission();
    if (!permissionGranted) return;
    _locationSubscription?.cancel();
    _trackedPoints.clear();
    _isTracking = true;
    _locationSubscription = _locationService.getLocationStream().listen((position) {
        _addTrackedPoint(LocationModel(
          position.latitude,
          position.longitude,
          DateTime.now(),
        ));
      },
      onError: (error) => debugPrint('Location error: $error'),
    );
    notifyListeners();
  }

  Future<void> _stopTracking() async {
    await _locationSubscription?.cancel();
    _isTracking = false;

    if (_trackedPoints.length >= 2) {
      final first = _trackedPoints.first;
      final last = _trackedPoints.last;
      final summary = LocationSummaryModel(
        locationName: await HelperFunctions().getLocationName(first.latitude, first.longitude),
        duration: last.timestamp.difference(first.timestamp),
        arrivalTime: first.timestamp,
        departTime: DateTime.now(),
      );
      await _trackingDataSource.saveTrackingSummary(summary);
      await fetchTrackingHistory();
    }

    _trackedPoints.clear();
    notifyListeners();
  }

  void _addTrackedPoint(LocationModel position) {
    _trackedPoints = [..._trackedPoints, position];
    notifyListeners();
  }

  Map<String, Duration> calculateTimeDistribution() {
    final distribution = <String, Duration>{};
    for (var i = 1; i < _trackedPoints.length; i++) {
      final current = _trackedPoints[i];
      final previous = _trackedPoints[i - 1];
      final duration = current.timestamp.difference(previous.timestamp);
      if (duration.isNegative) continue;
      final zone = _geofenceService.getCurrentZone(current);
      distribution[zone] = (distribution[zone] ?? Duration.zero) + duration;
    }
    return distribution;
  }

  Future<void> fetchTrackingHistory() async {
    _trackingHistory = await _trackingDataSource.getAllSummaries();
    notifyListeners();
  }
}