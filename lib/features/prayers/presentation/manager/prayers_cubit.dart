import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/prayer_times_model.dart';
import '../../data/repos/prayers_repo.dart';

part 'prayers_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  final PrayerRepo prayerRepo;

  PrayerCubit(this.prayerRepo) : super(PrayerInitial());

  Future<void> getPrayerTimings({
    required double latitude,
    required double longitude,
    String? date,
  }) async {
    emit(PrayerLoading());

    final result = await prayerRepo.getPrayerTimings(
      latitude: latitude,
      longitude: longitude,
      date: date,
    );

    result.fold(
      (failure) => emit(
        PrayerFailure(
          errorMessage: failure.message,
        ),
      ),
      (prayerTimings) => emit(
        PrayerLoaded(
          prayerTimings: prayerTimings,
        ),
      ),
    );
  }
}
