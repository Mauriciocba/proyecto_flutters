import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamphlets_management/features/forgot_password/domain/entities/validation_password.dart';
import 'package:pamphlets_management/features/forgot_password/domain/use_cases/register_validation_password.dart';

part 'validation_password_event.dart';
part 'validation_password_state.dart';

class ValidationPasswordBloc extends Bloc<ValidationPasswordEvent, ValidationPasswordState> {
  final RegisterValidationPassword _registerValidationPassword;
  ValidationPasswordBloc(this._registerValidationPassword) : super(ValidationPasswordInitial()) {
    on<ValidationPasswordStart>(onValidationPassword);
  }

  FutureOr<void> onValidationPassword(ValidationPasswordStart event, emit)async {
    emit(ValidationPasswordLoading());

    final result = await _registerValidationPassword(event.validationEmail);

    result.fold(
      (error) => emit(ValidationPasswordFail(msgFail: error.message)),
      (data) => emit(ValidationPasswordSuccess()));
  }
}
