import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamphlets_management/features/location/domain/use_cases/get_user_position_use_case.dart';

part 'available_position_event.dart';
part 'available_position_state.dart';

class AvailablePositionBloc
    extends Bloc<AvailablePositionEvent, AvailablePositionState> {
  final GetUserPositionUseCase _getUserPositionUseCase;
  AvailablePositionBloc(this._getUserPositionUseCase)
      : super(AvailablePositionInitial()) {
    on<AvailablePositionStarted>(_onAvailablePositionStarted);
  }

  FutureOr<void> _onAvailablePositionStarted(AvailablePositionStarted event,
      Emitter<AvailablePositionState> emit) async {
    final isAvailablePosition = await _getUserPositionUseCase.call();
    if (isAvailablePosition.value1 != null &&
        isAvailablePosition.value2 != null) {
      emit(const AvailablePositionResult(available: true));
    } else {
      emit(const AvailablePositionResult(available: false));
    }
  }
}
