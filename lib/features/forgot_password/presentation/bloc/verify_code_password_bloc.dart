import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamphlets_management/features/forgot_password/domain/use_cases/verify_code_password_use_case.dart';
import 'package:pamphlets_management/features/validation/presentation/bloc/verify_code_bloc.dart';

part 'verify_code_password_event.dart';
part 'verify_code_password_state.dart';

class VerifyCodePasswordBloc extends Bloc<VerifyCodePasswordEvent, VerifyCodePasswordState> {
  final VerifyCodePasswordUseCase _codePasswordUseCase;
  VerifyCodePasswordBloc(this._codePasswordUseCase) : super(VerifyCodePasswordInitial()) {
    on<StartVerifyCode>(_onStartVerifyCodePassword);
  }

  FutureOr<void> _onStartVerifyCodePassword(StartVerifyCode event, emit) async{
   emit(VerifyCodePasswordLoading());

   final result = await _codePasswordUseCase(event.userId,int.parse(event.code));

   result.fold(
    (error) => emit(VerifyCodePasswordFail(msgFail: error.message)),
    (data) => emit(VerifyCodeSuccess()));
  }
}
