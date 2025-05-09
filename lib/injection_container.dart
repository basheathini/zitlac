import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zitlac/services/geofence_service.dart';
import 'package:zitlac/services/location_service.dart';

import 'datasource/hive_tracking_data_source.dart';
import 'services/hive_service.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerLazySingleton<HiveService>(() => HiveService());
  var box = await getIt<HiveService>().init();
  getIt.registerLazySingleton<HiveTrackingDataSource>(() => HiveTrackingDataSource(box),
  );
  getIt.registerLazySingleton<GeofenceService>(() => GeofenceService());
  getIt.registerLazySingleton<LocationService>(() => LocationService());
}
