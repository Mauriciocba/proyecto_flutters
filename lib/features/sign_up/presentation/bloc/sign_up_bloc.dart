import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/sign_up/domain/use_cases/sign_up_use_cases.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpBloc(this._signUpUseCase) : super(SignUpInitial()) {
    on<SignUpPressed>(onSignUpPressed);
  }

  FutureOr<void> onSignUpPressed(SignUpPressed event, emit) async {
    emit(SignUpLoading());

    final failOrData = await _signUpUseCase.call(
      email: event.email,
      password: event.password,
    );

    failOrData.fold(
      (fail) => emit(SignUpLoadFailure(errorMessage: fail.message)),
      (data) => emit(SignUpLoadSuccess()),
    );
  }
}
