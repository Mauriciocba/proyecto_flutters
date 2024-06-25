import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/delete_event/domain/use_cases/delete_event_use_case.dart';

part 'delete_event_event.dart';
part 'delete_event_state.dart';

class DeleteEventBloc extends Bloc<DeleteEventEvent, DeleteEventState> {
  final GetDeleteEventUseCase _deleteEventUseCase;
  DeleteEventBloc(this._deleteEventUseCase) : super(DeleteEventInitial()) {
    on<DeleteEvent>(onDeleteEvent);
  }

  FutureOr<void> onDeleteEvent(DeleteEvent event, emit) async {
    emit(LoadingDeleteEvent());

    final failOrDelete = await _deleteEventUseCase(event.eventId);

    failOrDelete.fold(
        (error) => emit(FailureDeleteEvent(message: error.message)),
        (data) => emit(SuccessDeleteEvent()));
  }
}
