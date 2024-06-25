import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/forgot_password/domain/use_cases/reset_password_use_case.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;
  ResetPasswordBloc(this._resetPasswordUseCase)
      : super(ResetPasswordInitial()) {
    on<PasswordUpdatePressed>(onResetPassword);
  }

  FutureOr<void> onResetPassword(PasswordUpdatePressed event, emit) async{
    emit(ResetPasswordLoading());

    final result = await _resetPasswordUseCase(newPassword: event.newPassword, newPasswordConfirmed: event.newPasswordRepeat);

    result.fold(
      (error) => emit(ResetPasswordFailure(errorMessage: error.message)),
      (data) => emit(ResetPasswordSuccess(message: data)));
  }
}
