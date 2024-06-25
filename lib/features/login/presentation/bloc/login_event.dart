part of 'login_bloc.dart';

sealed class LoginEvent {}

final class LoginPressed extends LoginEvent {
  final String email;
  final String password;

  LoginPressed({required this.email, required this.password});
}

final class LoadLogin extends LoginEvent {}

final class GoogleLoginPressed extends LoginEvent {}
