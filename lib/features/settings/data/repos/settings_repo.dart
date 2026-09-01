import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/settings_model.dart';

abstract class SettingsRepo {
  Future<Either<Failure, SettingsModel>> getSettings();

  Future<Either<Failure, Unit>> saveTheme(bool isDark);

  Future<Either<Failure, Unit>> saveLanguage(String langCode);

  Future<Either<Failure, Unit>> saveFontSize(double fontSize);
}
