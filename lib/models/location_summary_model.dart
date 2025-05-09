class LocationSummaryModel {
  final String locationName;
  final Duration duration;
  final dynamic arrivalTime;
  final dynamic departTime;

  LocationSummaryModel({
    required this.locationName,
    required this.duration,
    this.arrivalTime,
    this.departTime,
  });

  Map<String, dynamic> toJson() => {
    'locationName': locationName,
    'duration': duration.inMicroseconds,
    'arrivalTime': arrivalTime?.toIso8601String(),
    'departTime': departTime?.toIso8601String(),
  };

  factory LocationSummaryModel.fromJson(Map<dynamic, dynamic> json) {
    return LocationSummaryModel(
      locationName: json['locationName'] as String,
      duration: Duration(microseconds: json['duration'] as int),
      arrivalTime: json['arrivalTime'] != null ? DateTime.parse(json['arrivalTime'] as String) : null,
      departTime: json['departTime'] != null ? DateTime.parse(json['departTime'] as String) : null,
    );
  }
}
