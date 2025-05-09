# zitlac

A Flutter-based location tracking app that uses geofencing to identify user zones, 
save visit summaries locally using Hive, 
and convert coordinates into human-readable addresses. 
This solution is designed for efficiency, offline access, and real-time location processing.

# Features
- Real-time location tracking using geolocator
- Local data storage via Hive
- Formatted tracking durations and history summaries
- Location permission handling for Android and iOS

# Testing
- main.dart
- geofence_service
- helper functions

LocationService (mocked streams and permissions)

**To fix an individual diagnostic**

dart fix --apply --code=empty_statements
dart fix --apply --code=unnecessary_import
dart fix --apply --code=unnecessary_non_null_assertion
dart fix --apply --code=unnecessary_overrides
dart fix --apply --code=unused_import 


**Android commands**

./gradlew clean