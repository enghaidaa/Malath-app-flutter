import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/settings_model.dart';
import '../../data/repos/settings_repo.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepo settingsRepo;

  SettingsCubit(this.settingsRepo) : super(SettingsInitial());

  Future<void> loadSettings() async {
    if (isClosed) return;

    emit(SettingsLoading());

    final result = await settingsRepo.getSettings();

    if (isClosed) return;

    result.fold(
      (failure) {
        if (isClosed) return;

        emit(
          SettingsFailure(
            errorMessage: failure.message,
          ),
        );
      },
      (settings) {
        if (isClosed) return;

        emit(
          SettingsLoaded(
            settings: settings,
          ),
        );
      },
    );
  }

  Future<void> toggleTheme() async {
    if (isClosed) return;

    if (state is! SettingsLoaded) return;

    final currentSettings = (state as SettingsLoaded).settings;
    final newTheme = !currentSettings.isDarkMode;

    final result = await settingsRepo.saveTheme(newTheme);

    if (isClosed) return;

    result.fold(
      (failure) {
        if (isClosed) return;

        emit(
          SettingsFailure(
            errorMessage: failure.message,
          ),
        );
      },
      (_) {
        if (isClosed) return;

        final updatedSettings = currentSettings.copyWith(
          isDarkMode: newTheme,
        );

        emit(
          SettingsLoaded(
            settings: updatedSettings,
          ),
        );
      },
    );
  }

  Future<void> changeLanguage(String langCode) async {
    if (isClosed) return;

    if (state is! SettingsLoaded) return;

    final currentSettings = (state as SettingsLoaded).settings;

    final result = await settingsRepo.saveLanguage(langCode);

    if (isClosed) return;

    result.fold(
      (failure) {
        if (isClosed) return;

        emit(
          SettingsFailure(
            errorMessage: failure.message,
          ),
        );
      },
      (_) {
        if (isClosed) return;

        final updatedSettings = currentSettings.copyWith(
          languageCode: langCode,
        );

        emit(
          SettingsLoaded(
            settings: updatedSettings,
          ),
        );
      },
    );
  }

  Future<void> updateFontSize(double fontSize) async {
    if (isClosed) return;

    if (state is! SettingsLoaded) return;

    final currentSettings = (state as SettingsLoaded).settings;

    final result = await settingsRepo.saveFontSize(fontSize);

    if (isClosed) return;

    result.fold(
      (failure) {
        if (isClosed) return;

        emit(
          SettingsFailure(
            errorMessage: failure.message,
          ),
        );
      },
      (_) {
        if (isClosed) return;

        final updatedSettings = currentSettings.copyWith(
          fontSize: fontSize,
        );

        emit(
          SettingsLoaded(
            settings: updatedSettings,
          ),
        );
      },
    );
  }
}
