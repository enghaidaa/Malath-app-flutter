import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/prayer_tracker_model.dart';
import '../../data/repos/prayer_tracker_repo.dart';

part 'prayer_tracker_state.dart';

class PrayerTrackerCubit extends Cubit<PrayerTrackerState> {
  final PrayerTrackerRepo prayerTrackerRepo;

  PrayerTrackerCubit(this.prayerTrackerRepo) : super(PrayerTrackerInitial());

  Future<void> getPrayerTracker(String date) async {
    emit(PrayerTrackerLoading());

    final result = await prayerTrackerRepo.getPrayerTracker(
      date,
    );

    result.fold(
      (failure) => emit(
        PrayerTrackerFailure(
          errorMessage: failure.message,
        ),
      ),
      (tracker) => emit(
        PrayerTrackerLoaded(
          tracker: tracker,
        ),
      ),
    );
  }

  Future<void> updatePrayer({
    required String date,
    required String prayer,
    required bool isPrayed,
  }) async {
    final result = await prayerTrackerRepo.updatePrayer(
      date,
      prayer,
      isPrayed,
    );

    result.fold(
      (failure) => emit(
        PrayerTrackerFailure(
          errorMessage: failure.message,
        ),
      ),
      (tracker) => emit(
        PrayerTrackerLoaded(
          tracker: tracker,
        ),
      ),
    );
  }
}
