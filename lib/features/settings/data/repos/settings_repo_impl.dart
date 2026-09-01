import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failures.dart';
import '../models/settings_model.dart';
import 'settings_repo.dart';

class SettingsRepoImpl implements SettingsRepo {
  final SharedPreferences sharedPreferences;

  SettingsRepoImpl({
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, SettingsModel>> getSettings() async {
    try {
      final isDarkMode = sharedPreferences.getBool('is_dark_mode') ?? false;
      final languageCode = sharedPreferences.getString('language_code') ?? 'en';
      final fontSize =
          (sharedPreferences.getDouble('font_size') ?? 18.0).toDouble();

      final settings = SettingsModel(
        isDarkMode: isDarkMode,
        languageCode: languageCode,
        fontSize: fontSize,
      );

      return right(settings);
    } catch (e) {
      return left(CacheFailure('Failed to get settings: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveTheme(bool isDark) async {
    try {
      await sharedPreferences.setBool('is_dark_mode', isDark);
      return right(unit);
    } catch (e) {
      return left(CacheFailure('Failed to save theme: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveLanguage(String langCode) async {
    try {
      await sharedPreferences.setString('language_code', langCode);
      return right(unit);
    } catch (e) {
      return left(CacheFailure('Failed to save language: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveFontSize(double fontSize) async {
    try {
      await sharedPreferences.setDouble('font_size', fontSize);
      return right(unit);
    } catch (e) {
      return left(CacheFailure('Failed to save font size: $e'));
    }
  }
}
