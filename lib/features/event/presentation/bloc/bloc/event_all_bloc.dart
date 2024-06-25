import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/home/domain/use_cases/token_checker_use_case.dart';

import '../../../domain/entities/event.dart';
import '../../../domain/use_cases/get_events_all_use_case.dart';

part 'event_all_event.dart';
part 'event_all_state.dart';

class EventAllBloc extends Bloc<EventAllEvent, EventAllState> {
  final GetEventAllUseCase _getEventAllUseCase;
  final TokenCheckerUseCase _tokenCheckerUseCase;

  EventAllBloc(this._getEventAllUseCase, this._tokenCheckerUseCase)
      : super(EventAllInitial()) {
    on<EventAllStart>(_onEventAll);
  }

  FutureOr<void> _onEventAll(EventAllEvent event, emit) async {
    final bool loggedInOrNot = await _tokenCheckerUseCase.checkToken();

    if (!loggedInOrNot) {
      emit(NotLoggedIn());
    } else {
      emit(EventAllLoading());

      final failureOrEvent = await _getEventAllUseCase();

      failureOrEvent.fold(
          (error) => emit(EventAllFailure(message: error.message)),
          (data) => emit(EventAllSuccess(event: data)));
    }
  }
}
