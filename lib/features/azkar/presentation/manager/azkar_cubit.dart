import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/azkar_model.dart';
import '../../data/repos/azkar_repo.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  final AzkarRepo azkarRepo;

  AzkarCubit(this.azkarRepo) : super(AzkarInitial());

  Future<void> getAzkar() async {
    emit(AzkarLoading());

    final result = await azkarRepo.getAzkar();

    result.fold(
      (failure) => emit(
        AzkarFailure(
          errorMessage: failure.message,
        ),
      ),
      (azkar) => emit(
        AzkarLoaded(
          azkar: azkar,
        ),
      ),
    );
  }

  Future<void> getAzkarByCategory(String category) async {
    emit(AzkarLoading());

    final result = await azkarRepo.getAzkarByCategory(
      category,
    );

    result.fold(
      (failure) => emit(
        AzkarFailure(
          errorMessage: failure.message,
        ),
      ),
      (azkar) => emit(
        AzkarCategoryLoaded(
          azkar: azkar,
        ),
      ),
    );
  }
}
