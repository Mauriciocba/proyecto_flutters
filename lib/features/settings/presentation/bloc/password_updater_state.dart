part of 'password_updater_bloc.dart';

sealed class PasswordUpdaterState extends Equatable {
  const PasswordUpdaterState();

  @override
  List<Object> get props => [];
}

final class PasswordUpdaterInitial extends PasswordUpdaterState {}

final class PasswordUpdaterLoading extends PasswordUpdaterState {}

final class PasswordUpdaterLoadSuccess extends PasswordUpdaterState {
  final String message;

  const PasswordUpdaterLoadSuccess({required this.message});
}

final class PasswordUpdaterLoadFailure extends PasswordUpdaterState {
  final String errorMessage;

  const PasswordUpdaterLoadFailure({required this.errorMessage});
}
