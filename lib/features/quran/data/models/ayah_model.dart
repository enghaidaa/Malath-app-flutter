class AyahModel {
  final int number;
  final int numberInSurah;
  final String text;
  final int juz;
  final int page;
  final int hizbQuarter;

  const AyahModel({
    required this.number,
    required this.numberInSurah,
    required this.text,
    required this.juz,
    required this.page,
    required this.hizbQuarter,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      number: json['number'] ?? 0,
      numberInSurah: json['numberInSurah'] ?? 0,
      text: json['text'] ?? '',
      juz: json['juz'] ?? 0,
      page: json['page'] ?? 0,
      hizbQuarter: json['hizbQuarter'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'numberInSurah': numberInSurah,
      'text': text,
      'juz': juz,
      'page': page,
      'hizbQuarter': hizbQuarter,
    };
  }
}
