part of 'azkar_cubit.dart';

sealed class AzkarState {}

final class AzkarInitial extends AzkarState {}

final class AzkarLoading extends AzkarState {}

final class AzkarLoaded extends AzkarState {
  final List<AzkarModel> azkar;

  AzkarLoaded({
    required this.azkar,
  });
}

final class AzkarCategoryLoaded extends AzkarState {
  final AzkarModel azkar;

  AzkarCategoryLoaded({
    required this.azkar,
  });
}

final class AzkarFailure extends AzkarState {
  final String errorMessage;

  AzkarFailure({
    required this.errorMessage,
  });
}
