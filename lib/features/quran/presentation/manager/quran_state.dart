part of 'quran_cubit.dart';

sealed class QuranState {}

final class QuranInitial extends QuranState {}

final class QuranLoading extends QuranState {}

final class QuranLoaded extends QuranState {
  final List<SurahModel> surahs;

  QuranLoaded({
    required this.surahs,
  });
}

final class SurahLoaded extends QuranState {
  final SurahModel surah;

  SurahLoaded({
    required this.surah,
  });
}

final class QuranFailure extends QuranState {
  final String errorMessage;

  QuranFailure({
    required this.errorMessage,
  });
}
