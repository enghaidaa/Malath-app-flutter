import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/settings_model.dart';
import '../../data/repos/settings_repo.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepo settingsRepo;

  SettingsCubit(this.settingsRepo) : super(SettingsInitial());

  Future<void> loadSettings() async {
    emit(SettingsLoading());
    final result = await settingsRepo.getSettings();
    result.fold(
      (failure) => emit(SettingsFailure(errorMessage: failure.message)),
      (settings) => emit(SettingsLoaded(settings: settings)),
    );
  }

  Future<void> toggleTheme() async {
    if (state is SettingsLoaded) {
      final currentSettings = (state as SettingsLoaded).settings;
      final newTheme = !currentSettings.isDarkMode;

      final result = await settingsRepo.saveTheme(newTheme);
      result.fold(
        (failure) => emit(SettingsFailure(errorMessage: failure.message)),
        (_) {
          final updatedSettings =
              currentSettings.copyWith(isDarkMode: newTheme);
          emit(SettingsLoaded(settings: updatedSettings));
        },
      );
    }
  }

  Future<void> changeLanguage(String langCode) async {
    if (state is SettingsLoaded) {
      final currentSettings = (state as SettingsLoaded).settings;

      final result = await settingsRepo.saveLanguage(langCode);
      result.fold(
        (failure) => emit(SettingsFailure(errorMessage: failure.message)),
        (_) {
          final updatedSettings =
              currentSettings.copyWith(languageCode: langCode);
          emit(SettingsLoaded(settings: updatedSettings));
        },
      );
    }
  }

  Future<void> updateFontSize(double fontSize) async {
    if (state is SettingsLoaded) {
      final currentSettings = (state as SettingsLoaded).settings;

      final result = await settingsRepo.saveFontSize(fontSize);
      result.fold(
        (failure) => emit(SettingsFailure(errorMessage: failure.message)),
        (_) {
          final updatedSettings = currentSettings.copyWith(fontSize: fontSize);
          emit(SettingsLoaded(settings: updatedSettings));
        },
      );
    }
  }
}
