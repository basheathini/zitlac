import '../models/location_summary_model.dart';
import 'package:hive_ce/hive.dart';

class HiveTrackingDataSource {
  final Box _box;
  HiveTrackingDataSource(this._box);

  Future<void> saveTrackingSummary(LocationSummaryModel summary) async {
    final uniqueKey = '${summary.locationName}_${summary.arrivalTime.millisecondsSinceEpoch}';
    await _box.put(uniqueKey, summary.toJson());
  }

  Future<List<LocationSummaryModel>> getAllSummaries() async {
    try {
      return _box.values.map((json) => LocationSummaryModel.fromJson(Map<dynamic, dynamic>.from(json))).toList()
    ..sort((a, b) => b.arrivalTime.compareTo(a.arrivalTime));
    } catch (e) {
      return [];
    }
  }
}
