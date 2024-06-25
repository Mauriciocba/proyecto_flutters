import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/stand_create/domain/entities/stands_model.dart';
import 'package:pamphlets_management/features/stand_create/domain/use_cases/register_stands_use_case.dart';

part 'stands_create_event.dart';
part 'stands_create_state.dart';

class StandsCreateBloc extends Bloc<StandsCreateEvent, StandsCreateState> {
  final RegisterStandsUseCase _registerStandsUseCase;
  StandsCreateBloc(this._registerStandsUseCase) : super(StandsCreateInitial()) {
    on<StandsStart>(onStandsCreateStart);
  }

  FutureOr<void> onStandsCreateStart(StandsStart event, emit) async {
    emit(StandsCreateLoading());

    final result = await _registerStandsUseCase(event.stdModel);

    result.fold((error) => emit(StandsCreateFailure(msgFail: error.message)),
        (data) => emit(StandsCreateSuccess()));
  }
}
