part of 'signup_cubit.dart';

sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  final UserModel user;

  SignupSuccess({
    required this.user,
  });
}

final class SignupFailure extends SignupState {
  final String errorMessage;

  SignupFailure({
    required this.errorMessage,
  });
}
