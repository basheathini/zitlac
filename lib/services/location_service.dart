import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  LocationService._internal();

  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;

  Future<bool> get _isLocationServiceEnabled async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<LocationPermission> _checkPermission() async {
    return await Geolocator.checkPermission();
  }

  Future<bool> requestPermission() async {
    try {
      if (!await _isLocationServiceEnabled) {
        throw Exception('Location services are disabled');
      }

      LocationPermission permission = await _checkPermission();

      if (permission == LocationPermission.deniedForever) {
        return false;
      }

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse) {
        permission = await Geolocator.requestPermission();
      }

      return permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    } catch (e) {
      debugPrint('Permission error: $e');
      return false;
    }
  }
//change distanceFilter to 0 for testing with emulator
  Stream<Position> getLocationStream() {
    return Geolocator.getPositionStream(
      locationSettings: Platform.isAndroid ? AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
        intervalDuration: Duration(seconds: 10),
      ) :  AppleSettings(
        accuracy: LocationAccuracy.best,
        activityType: ActivityType.fitness,
        distanceFilter: 10,
        pauseLocationUpdatesAutomatically: false,
        showBackgroundLocationIndicator: true,
      ),
    );
  }

  Future<bool> checkPermissionStatus() async {
    final status = await _checkPermission();
    return status == LocationPermission.always ||
        status == LocationPermission.whileInUse;
  }

  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}