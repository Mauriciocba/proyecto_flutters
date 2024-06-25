import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/event/domain/entities/event_update.dart';
import 'package:pamphlets_management/features/event/domain/use_cases/edit_event_use_case.dart';
import 'package:pamphlets_management/features/event/domain/use_cases/info_event_use_case.dart';

import '../../domain/entities/event.dart';

part 'edit_event_event.dart';
part 'edit_event_state.dart';

class EditEventBloc extends Bloc<EditEventEvent, EditEventState> {
  final EditEventUseCase _editEventUseCase;
  final GetInfoEventUseCase _infoEventUseCase;

  EditEventBloc(this._editEventUseCase, this._infoEventUseCase)
      : super(EditEventInitial()) {
    on<EditEventLoad>(_onEditEventLoad);
    on<EditEventConfirm>(_ondEditEventConfirm);
  }

  FutureOr<void> _onEditEventLoad(EditEventLoad event, emit) async {
    emit(EditEventLoading());

    final failureOrEvent = await _infoEventUseCase(event.eventId);

    failureOrEvent.fold(
        (error) => emit(EditEventFailure(errorMessage: error.message)),
        (data) => emit(EditEventSuccess(eventSelected: data)));
  }

  FutureOr<void> _ondEditEventConfirm(EditEventConfirm event, emit) async {
    emit(EditEventLoading());

    final failureOrSave =
        await _editEventUseCase.callConfirm(event.eventUpdate, event.idEvent);

    failureOrSave.fold(
        (error) => emit(EditEventConfirmFailure(errorMessage: error.message)),
        (data) => emit(EditEventConfirmChange()));
  }
}
