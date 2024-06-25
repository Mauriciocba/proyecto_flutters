import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/validation/domain/use_cases/verify_code_use_case.dart';

part 'verify_code_event.dart';
part 'verify_code_state.dart';

class VerifyCodeBloc extends Bloc<VerifyCodeEvent, VerifyCodeState> {
  final GetVerifyCodeUseCase _getVerifyCodeUseCase;

  VerifyCodeBloc(this._getVerifyCodeUseCase) : super(VerifyCodeInitial()) {
    on<StartVerifyCode>(_onStartVerifyCode);
  }

  FutureOr<void> _onStartVerifyCode(StartVerifyCode event, emit) async {
    emit(VerifyCodeLoading());

    final dataOrFailure =
        await _getVerifyCodeUseCase(event.userId, int.parse(event.code));

    dataOrFailure.fold(
        (error) => emit(VerifyCodeFailure(errorMessage: error.message)),
        (data) => emit(VerifyCodeSuccess()));
  }
}
