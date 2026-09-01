class AzkarItemModel {
  final int id;
  final String text;
  final String translation;
  final String transliteration;
  final int repetitions;
  final String benefit;
  final String reference;

  const AzkarItemModel({
    required this.id,
    required this.text,
    required this.translation,
    required this.transliteration,
    required this.repetitions,
    required this.benefit,
    required this.reference,
  });

  factory AzkarItemModel.fromJson(Map<String, dynamic> json) {
    return AzkarItemModel(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
      translation: json['translation'] ?? '',
      transliteration: json['transliteration'] ?? '',
      repetitions: json['repetitions'] ?? 0,
      benefit: json['benefit'] ?? '',
      reference: json['reference'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'translation': translation,
      'transliteration': transliteration,
      'repetitions': repetitions,
      'benefit': benefit,
      'reference': reference,
    };
  }
}
