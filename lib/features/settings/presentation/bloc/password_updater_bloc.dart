import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/settings/domain/use_cases/update_password_use_case.dart';

part 'password_updater_event.dart';
part 'password_updater_state.dart';

class PasswordUpdaterBloc
    extends Bloc<PasswordUpdaterEvent, PasswordUpdaterState> {
  final UpdatePasswordUseCase _updateChangeUseCase;

  PasswordUpdaterBloc(this._updateChangeUseCase)
      : super(PasswordUpdaterInitial()) {
    on<PasswordUpdaterUpdatePressed>(_onPasswordUpdaterUpdatePressed);
  }

  FutureOr<void> _onPasswordUpdaterUpdatePressed(
      PasswordUpdaterUpdatePressed event, emit) async {
    emit(PasswordUpdaterLoading());

    final result = await _updateChangeUseCase(
      currentPassword: event.currentPassword,
      newPassword: event.newPassword,
      newPasswordConfirmed: event.newPasswordRepeat,
    );

    result.fold(
      (error) => emit(PasswordUpdaterLoadFailure(errorMessage: error.message)),
      (success) => emit(PasswordUpdaterLoadSuccess(message: success)),
    );
  }
}
