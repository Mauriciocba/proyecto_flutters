part of 'password_updater_bloc.dart';

sealed class PasswordUpdaterEvent extends Equatable {
  const PasswordUpdaterEvent();

  @override
  List<Object> get props => [];
}

class PasswordUpdaterUpdatePressed extends PasswordUpdaterEvent {
  final String currentPassword, newPassword, newPasswordRepeat;

  const PasswordUpdaterUpdatePressed({
    required this.currentPassword,
    required this.newPassword,
    required this.newPasswordRepeat,
  });
}
