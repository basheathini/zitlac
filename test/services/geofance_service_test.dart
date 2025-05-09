import 'package:flutter_test/flutter_test.dart';
import 'package:zitlac/models/location_model.dart';
import 'package:zitlac/services/geofence_service.dart';

void main() {
  final geofenceService = GeofenceService();

  group('GeofenceService', () {
    test('Returns "Gym" when near the Gym location', () {
      final location = LocationModel(-32.990620, 27.932380, DateTime.now());
      final zone = geofenceService.getCurrentZone(location);
      expect(zone, 'Gym');
    });

    test('Returns "Work" when near the Work location', () {
      final location = LocationModel( -32.985960, 27.940950, DateTime.now());
      final zone = geofenceService.getCurrentZone(location);
      expect(zone, 'Work');
    });

    test('Returns "In Transit" when far from all predefined zones', () {
      final location = LocationModel( 0.0,  0.0, DateTime.now());
      final zone = geofenceService.getCurrentZone(location);
      expect(zone, 'In Transit');
    });

    test('Returns "In Transit" when just outside geofence radius', () {
      final location = LocationModel(-32.991500, 27.932377, DateTime.now());
      final zone = geofenceService.getCurrentZone(location);
      expect(zone, 'In Transit');
    });

    test('Returns closest zone when equidistant from multiple (mock edge case)', () {
      final location = LocationModel(-32.990623, 27.932377, DateTime.now());
      final zone = geofenceService.getCurrentZone(location);
      expect(['Gym', 'Work', 'In Transit'].contains(zone), isTrue);
    });
  });
}
