part of 'my_azkar_cubit.dart';

sealed class MyAzkarState {}

final class MyAzkarInitial extends MyAzkarState {}

final class MyAzkarLoading extends MyAzkarState {}

final class MyAzkarLoaded extends MyAzkarState {
  final List<MyAzkarModel> azkar;

  MyAzkarLoaded({
    required this.azkar,
  });
}

final class MyAzkarFailure extends MyAzkarState {
  final String errorMessage;

  MyAzkarFailure({
    required this.errorMessage,
  });
}
