import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user_model.dart';
import '../../data/repos/auth_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepo authRepo;

  SignupCubit(this.authRepo) : super(SignupInitial());

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignupLoading());

    final result = await authRepo.signup(
      name: name,
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(
        SignupFailure(
          errorMessage: failure.message,
        ),
      ),
      (user) => emit(
        SignupSuccess(
          user: user,
        ),
      ),
    );
  }
}
