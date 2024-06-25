part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class SignUpPressed extends SignUpEvent {
  final String email;
  final String password;

  const SignUpPressed({required this.email, required this.password});
}
