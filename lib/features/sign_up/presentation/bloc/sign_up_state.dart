part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpLoadSuccess extends SignUpState {}

final class SignUpLoadFailure extends SignUpState {
  final String errorMessage;

  const SignUpLoadFailure({required this.errorMessage});
}
