import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/home/domain/use_cases/token_checker_use_case.dart';
import 'package:pamphlets_management/features/location/domain/use_cases/request_permission_use_case.dart';
import 'package:pamphlets_management/features/login/domain/use_cases/login_by_google_use_case.dart';
import 'package:pamphlets_management/features/login/domain/use_cases/login_use_case.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final TokenCheckerUseCase _tokenCheckerUseCase;
  final RequestPermissionUseCase _requestPermissionUseCase;
  final LoginByGoogleUseCase _loginByGoogleUseCase;

  LoginBloc(
    this._loginUseCase,
    this._tokenCheckerUseCase,
    this._loginByGoogleUseCase,
    this._requestPermissionUseCase,
  ) : super(LoginInitial()) {
    on<LoginPressed>(_onLoginPressed);
    on<LoadLogin>(_onLoadLogin);
    on<GoogleLoginPressed>(_onGoogleLoginPressed);
  }

  FutureOr<void> _onLoginPressed(LoginPressed event, emit) async {
    emit(LoginInProgress());
    final result = await _loginUseCase(
      email: event.email,
      password: event.password,
    );

    if (result.isLeft()) {
      return emit(LoginFailure(errorMessage: result.getLeft().message));
    }

    if (!(result as Right).value) {
      return emit(
          LoginFailure(errorMessage: "Sus credenciales fueron incorrectas"));
    }
    _requestPermissionUseCase.call();
    return emit(LoginSuccess());
  }

  FutureOr<void> _onLoadLogin(LoadLogin event, Emitter<LoginState> emit) async {
    final isTokenOrNot = await _tokenCheckerUseCase.checkToken();

    if (!isTokenOrNot) {
      return null;
    } else {
      emit(IsLogged());
    }
  }

  FutureOr<void> _onGoogleLoginPressed(
    GoogleLoginPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginInProgress());
    final failOrSuccess = await _loginByGoogleUseCase();

    failOrSuccess.fold(
      (fail) => emit(LoginFailure(errorMessage: fail.message)),
      (success) => emit(LoginSuccess()),
    );
  }
}
