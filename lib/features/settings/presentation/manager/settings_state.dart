part of 'settings_cubit.dart';

sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsLoaded extends SettingsState {
  final SettingsModel settings;

  SettingsLoaded({
    required this.settings,
  });
}

final class SettingsFailure extends SettingsState {
  final String errorMessage;

  SettingsFailure({
    required this.errorMessage,
  });
}
