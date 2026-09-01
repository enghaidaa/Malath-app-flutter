class MyAzkarModel {
  final int id;
  final String category;
  final String text;
  final String translation;
  final String transliteration;
  final int repetitions;
  final String benefit;
  final String reference;

  const MyAzkarModel({
    required this.id,
    required this.category,
    required this.text,
    required this.translation,
    required this.transliteration,
    required this.repetitions,
    required this.benefit,
    required this.reference,
  });

  factory MyAzkarModel.fromJson(Map<String, dynamic> json) {
    return MyAzkarModel(
      id: json['id'] ?? 0,
      category: json['category'] ?? '',
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
      'category': category,
      'text': text,
      'translation': translation,
      'transliteration': transliteration,
      'repetitions': repetitions,
      'benefit': benefit,
      'reference': reference,
    };
  }
}
