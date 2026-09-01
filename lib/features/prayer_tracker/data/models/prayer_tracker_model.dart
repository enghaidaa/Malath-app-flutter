class PrayerTrackerModel {
  final String date;
  final bool fajr;
  final bool dhuhr;
  final bool asr;
  final bool maghrib;
  final bool isha;

  const PrayerTrackerModel({
    required this.date,
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory PrayerTrackerModel.fromJson(Map<String, dynamic> json) {
    return PrayerTrackerModel(
      date: json['date'] ?? '',
      fajr: json['fajr'] ?? false,
      dhuhr: json['dhuhr'] ?? false,
      asr: json['asr'] ?? false,
      maghrib: json['maghrib'] ?? false,
      isha: json['isha'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'fajr': fajr,
      'dhuhr': dhuhr,
      'asr': asr,
      'maghrib': maghrib,
      'isha': isha,
    };
  }

  PrayerTrackerModel copyWith({
    String? date,
    bool? fajr,
    bool? dhuhr,
    bool? asr,
    bool? maghrib,
    bool? isha,
  }) {
    return PrayerTrackerModel(
      date: date ?? this.date,
      fajr: fajr ?? this.fajr,
      dhuhr: dhuhr ?? this.dhuhr,
      asr: asr ?? this.asr,
      maghrib: maghrib ?? this.maghrib,
      isha: isha ?? this.isha,
    );
  }
}
