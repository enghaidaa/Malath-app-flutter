import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user_model.dart';
import '../../data/repos/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit(this.authRepo) : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    final result = await authRepo.login(
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(
        LoginFailure(
          errorMessage: failure.message,
        ),
      ),
      (user) => emit(
        LoginSuccess(
          user: user,
        ),
      ),
    );
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoading());

    final result = await authRepo.loginWithGoogle();

    result.fold(
      (failure) => emit(
        LoginFailure(
          errorMessage: failure.message,
        ),
      ),
      (user) => emit(
        LoginSuccess(
          user: user,
        ),
      ),
    );
  }
}
