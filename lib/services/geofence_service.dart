import 'dart:math';
import '../models/geofacing_model.dart';
import '../models/location_model.dart';

class GeofenceService {
  static const double _earthRadiusMeters = 6371000;
  static const double _geofenceRadiusMeters = 50.0;
  static const String _defaultZoneName = 'In Transit';

  GeofenceService._internal();

  static final GeofenceService _sharedInstance = GeofenceService._internal();
  factory GeofenceService() => _sharedInstance;

  final List<GeofenceModel> _predefinedGeofences = [
    GeofenceModel(name: 'Gym', latitude: -32.990623, longitude: 27.932377),
    GeofenceModel(name: 'Work', latitude: -32.985962, longitude: 27.940951),
  ];

  String getCurrentZone(LocationModel currentLocation) {
    for (final geofence in _predefinedGeofences) {
      final distanceFromGeofence = _calculateHaversineDistance(
        currentLocation.latitude,
        currentLocation.longitude,
        geofence.latitude,
        geofence.longitude,
      );

      if (distanceFromGeofence <= _geofenceRadiusMeters) {
        return geofence.name;
      }
    }
    return _defaultZoneName;
  }

  double _calculateHaversineDistance(
      double currentLatitude,
      double currentLongitude,
      double targetLatitude,
      double targetLongitude,
      ) {
    final latitudeDifferenceRadians = _convertDegreesToRadians(targetLatitude - currentLatitude);
    final longitudeDifferenceRadians = _convertDegreesToRadians(targetLongitude - currentLongitude);

    final haversineLatitudeComponent = pow(sin(latitudeDifferenceRadians / 2), 2);
    final haversineLongitudeComponent = pow(sin(longitudeDifferenceRadians / 2), 2);

    final sphericalCorrelationFactor = cos(_convertDegreesToRadians(currentLatitude)) * cos(_convertDegreesToRadians(targetLatitude));

    final haversineIntermediateResult = haversineLatitudeComponent + sphericalCorrelationFactor * haversineLongitudeComponent;

    final centralAngleRadians = 2 * atan2(sqrt(haversineIntermediateResult), sqrt(1 - haversineIntermediateResult));

    return _earthRadiusMeters * centralAngleRadians;
  }

  double _convertDegreesToRadians(double degrees) => degrees * pi / 180;
}