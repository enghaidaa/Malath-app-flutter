class SettingsModel {
  final bool isDarkMode;
  final String languageCode;
  final double fontSize;

  const SettingsModel({
    required this.isDarkMode,
    required this.languageCode,
    required this.fontSize,
  });

  SettingsModel copyWith({
    bool? isDarkMode,
    String? languageCode,
    double? fontSize,
  }) {
    return SettingsModel(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      isDarkMode: json['isDarkMode'] ?? false,
      languageCode: json['languageCode'] ?? 'en',
      fontSize: (json['fontSize'] ?? 18.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'languageCode': languageCode,
      'fontSize': fontSize,
    };
  }
}
