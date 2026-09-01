part of 'prayer_tracker_cubit.dart';

sealed class PrayerTrackerState {}

final class PrayerTrackerInitial extends PrayerTrackerState {}

final class PrayerTrackerLoading extends PrayerTrackerState {}

final class PrayerTrackerLoaded extends PrayerTrackerState {
  final PrayerTrackerModel tracker;

  PrayerTrackerLoaded({
    required this.tracker,
  });
}

final class PrayerTrackerFailure extends PrayerTrackerState {
  final String errorMessage;

  PrayerTrackerFailure({
    required this.errorMessage,
  });
}
