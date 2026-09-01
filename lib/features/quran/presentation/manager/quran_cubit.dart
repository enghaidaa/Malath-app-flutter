import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/surah_model.dart';
import '../../data/repos/quran_repo.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  final QuranRepo quranRepo;

  QuranCubit(this.quranRepo) : super(QuranInitial());

  Future<void> getSurahs() async {
    emit(QuranLoading());

    final result = await quranRepo.getSurahs();

    result.fold(
      (failure) => emit(
        QuranFailure(
          errorMessage: failure.message,
        ),
      ),
      (surahs) => emit(
        QuranLoaded(
          surahs: surahs,
        ),
      ),
    );
  }

  Future<void> getSurahById(int id) async {
    emit(QuranLoading());

    final result = await quranRepo.getSurahById(id);

    result.fold(
      (failure) => emit(
        QuranFailure(
          errorMessage: failure.message,
        ),
      ),
      (surah) => emit(
        SurahLoaded(
          surah: surah,
        ),
      ),
    );
  }
}
