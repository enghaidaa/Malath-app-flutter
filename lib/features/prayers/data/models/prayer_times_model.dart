class PrayerTimingsModel {
  final String date;
  final String hijriDate;
  final double latitude;
  final double longitude;
  final String calculationMethod;
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  const PrayerTimingsModel({
    required this.date,
    required this.hijriDate,
    required this.latitude,
    required this.longitude,
    required this.calculationMethod,
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory PrayerTimingsModel.fromJson(Map<String, dynamic> json) {
    final timings = json['timings'] as Map<String, dynamic>;
    final location = json['location'] as Map<String, dynamic>;

    return PrayerTimingsModel(
      date: json['date'] ?? '',
      hijriDate: json['hijriDate']['formatted'] ?? '',
      latitude: (location['latitude'] ?? 0).toDouble(),
      longitude: (location['longitude'] ?? 0).toDouble(),
      calculationMethod: json['calculationMethod'] ?? '',
      fajr: timings['fajr'] ?? '',
      sunrise: timings['sunrise'] ?? '',
      dhuhr: timings['dhuhr'] ?? '',
      asr: timings['asr'] ?? '',
      maghrib: timings['maghrib'] ?? '',
      isha: timings['isha'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'hijriDate': hijriDate,
      'latitude': latitude,
      'longitude': longitude,
      'calculationMethod': calculationMethod,
      'fajr': fajr,
      'sunrise': sunrise,
      'dhuhr': dhuhr,
      'asr': asr,
      'maghrib': maghrib,
      'isha': isha,
    };
  }
}
