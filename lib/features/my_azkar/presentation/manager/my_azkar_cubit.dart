import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/my_azkar_model.dart';
import '../../data/repos/my_azkar_repo.dart';

part 'my_azkar_state.dart';

class MyAzkarCubit extends Cubit<MyAzkarState> {
  final MyAzkarRepo myAzkarRepo;

  MyAzkarCubit(this.myAzkarRepo) : super(MyAzkarInitial());

  Future<void> getMyAzkar() async {
    emit(MyAzkarLoading());

    final result = await myAzkarRepo.getMyAzkar();

    result.fold(
      (failure) => emit(
        MyAzkarFailure(
          errorMessage: failure.message,
        ),
      ),
      (azkar) => emit(
        MyAzkarLoaded(
          azkar: azkar,
        ),
      ),
    );
  }

  Future<void> addAzkar(MyAzkarModel azkar) async {
    final result = await myAzkarRepo.addAzkar(azkar);

    result.fold(
      (failure) => emit(
        MyAzkarFailure(
          errorMessage: failure.message,
        ),
      ),
      (_) => getMyAzkar(),
    );
  }

  Future<void> deleteAzkar(int id) async {
    final result = await myAzkarRepo.deleteAzkar(id);

    result.fold(
      (failure) => emit(
        MyAzkarFailure(
          errorMessage: failure.message,
        ),
      ),
      (_) => getMyAzkar(),
    );
  }
}
