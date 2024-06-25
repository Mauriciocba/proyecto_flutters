part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class PasswordUpdatePressed extends ResetPasswordEvent {
  final String newPassword, newPasswordRepeat;

  const PasswordUpdatePressed({
    required this.newPassword,
    required this.newPasswordRepeat,
  });
}
