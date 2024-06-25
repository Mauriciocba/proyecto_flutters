import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/create_event_model.dart';
import '../../domain/entities/setting_event_model.dart';
import '../../domain/use_cases/create_event_use_case.dart';

part 'create_event_event.dart';
part 'create_event_state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final CreateEventUseCase _createEventUseCase;

  CreateEventBloc(this._createEventUseCase) : super(CreateEventInitial()) {
    on<SentData>(_sentData);
  }

  FutureOr<void> _sentData(SentData event, emit) async {
    emit(CreateEventLoading());

    final failureOrData = await _createEventUseCase(
        event.createEventModel, event.newSettingEvent);

    failureOrData.fold(
        (error) => emit(CreateEventFailure(errorMessage: error.message)),
        (data) => emit(CreateEventSuccess()));
  }
}
