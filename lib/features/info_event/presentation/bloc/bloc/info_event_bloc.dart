import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/info_event/domain/entities/event.dart';
import 'package:pamphlets_management/features/info_event/domain/use_cases/info_event_use_case.dart';

part 'info_event_event.dart';
part 'info_event_state.dart';

class InfoEventBloc extends Bloc<InfoEventEvent, InfoEventState> {
  final GetInfoEventUseCase _getInfoEventUseCase;
  InfoEventBloc(this._getInfoEventUseCase) : super(InfoEventInitial()) {
    on<InfoEventStart>(onInfoEventStart);
    on<DeletedEvent>(onDeletedEvent);
  }

  FutureOr<void> onInfoEventStart(InfoEventStart event, emit) async {
    emit(InfoEventLoading());

    final failOrInfoEvent = await _getInfoEventUseCase(event.eventId);

    failOrInfoEvent.fold(
        (error) => emit(InfoEventFailure(message: error.message)),
        (data) => emit(InfoEventSuccess(event: data)));
  }

  FutureOr<void> onDeletedEvent(DeletedEvent event, emit) =>
      emit(InfoEventInitial());
}
