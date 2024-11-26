class SfaLocationData {
  double latitude;
  double longitude;
  double accuracy;
  double altitude;
  double speed;
  double speedAccuracy;
  double heading;
  DateTime time;
  bool isMocked;
  String provider;

  SfaLocationData({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.altitude,
    required this.speed,
    required this.speedAccuracy,
    required this.heading,
    required this.time,
    required this.isMocked,
    required this.provider,
  });

  factory SfaLocationData.fromJson(Map<String, dynamic> json) {
    return SfaLocationData(
      latitude: json['latitude'],
      longitude: json['longitude'],
      accuracy: json['accuracy'],
      altitude: json['altitude'],
      speed: json['speed'],
      speedAccuracy: json['speed_accuracy'],
      heading: json['heading'],
      time: json['time'] is String
          ? DateTime.parse(json['time'])
          : DateTime.fromMillisecondsSinceEpoch(json['time'].toInt()),
      isMocked: json['is_mocked'],
      provider: json['provider'],
    );
  }

  Map<String, dynamic> toJson() => {
        "lat": latitude,
        "long": longitude,
        "created_at": time.toIso8601String()
      };
}
