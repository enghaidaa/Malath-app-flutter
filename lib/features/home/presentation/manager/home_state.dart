part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final PrayerTimingsModel prayerTimings;
  final NextPrayerModel nextPrayer;

  HomeLoaded({
    required this.prayerTimings,
    required this.nextPrayer,
  });
}

final class HomeFailure extends HomeState {
  final String errorMessage;

  HomeFailure({
    required this.errorMessage,
  });
}
