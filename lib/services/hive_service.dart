import 'package:hive_ce_flutter/adapters.dart';
import '../utils/constants.dart';

class HiveService {
  HiveService._privateConstructor();

  static final HiveService _instance = HiveService._privateConstructor();
  factory HiveService() => _instance;

  Future<Box> init() async {
    await Hive.initFlutter();
    return await Hive.openBox(AppKeys.appName);
  }

  Future<Box<T>> openBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    }
    return Hive.box<T>(boxName);
  }

  Future<T?> get<T>(String boxName, String key) async {
    final box = await openBox<T>(boxName);
    return box.get(key);
  }

  Future<void> put<T>(String boxName, String key, T value) async {
    final box = await openBox<T>(boxName);
    await box.put(key, value);
  }
}

