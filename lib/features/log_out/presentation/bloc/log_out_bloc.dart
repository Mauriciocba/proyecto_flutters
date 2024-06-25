import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/log_out/domain/repositories/log_out_repository.dart';

part 'log_out_event.dart';
part 'log_out_state.dart';

class LogOutBloc extends Bloc<LogOutEvent, LogOutState> {
  final LogOutRepository _logOutRepository;

  LogOutBloc(this._logOutRepository) : super(LogOutInitial()) {
    on<StartLogOut>(_onStartLogOut);
  }

  FutureOr<void> _onStartLogOut(event, emit) async {
    emit(LogOutLoading());

    final logOutOrFailure = await _logOutRepository.logOut();

    logOutOrFailure.fold(
        (error) => emit(LogOutFailure(errorMessage: error.message)),
        (data) => emit(LogOutSuccess()));
  }
}
