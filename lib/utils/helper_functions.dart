import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';

class HelperFunctions {

  Future<String> getLocationName(double latitude, double longitude) async {
    try {
      final placeMarks = await placemarkFromCoordinates(latitude, longitude);
      if (placeMarks.isNotEmpty) {
        final placeMark = placeMarks.first;
        return '${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.country}';
      }
    } catch (e) {
      debugPrint("Error retrieving location name: $e");
    }
    return 'Unknown Location';
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    final milliseconds = duration.inMilliseconds.remainder(1000);
    final microseconds = duration.inMicroseconds.remainder(1000);

    final parts = <String>[];
    if (hours > 0) parts.add('$hours h');
    if (minutes > 0) parts.add('$minutes m');
    if (seconds > 0) parts.add('$seconds s');
    if (milliseconds > 0) parts.add('$milliseconds ms');
    if (microseconds > 0) parts.add('$microseconds µs');

    return parts.isNotEmpty ? parts.join(', ') : '0 µs';
  }
}