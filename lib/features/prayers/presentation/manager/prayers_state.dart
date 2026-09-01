part of 'prayers_cubit.dart';

sealed class PrayerState {}

final class PrayerInitial extends PrayerState {}

final class PrayerLoading extends PrayerState {}

final class PrayerLoaded extends PrayerState {
  final PrayerTimingsModel prayerTimings;

  PrayerLoaded({
    required this.prayerTimings,
  });
}

final class PrayerFailure extends PrayerState {
  final String errorMessage;

  PrayerFailure({
    required this.errorMessage,
  });
}
