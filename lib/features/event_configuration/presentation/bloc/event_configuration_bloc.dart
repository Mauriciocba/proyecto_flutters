import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/event_configuration/domain/entities/event_configuration_model.dart';
import 'package:pamphlets_management/features/event_configuration/domain/use_cases/event_configuration_edit_use_case.dart';
import 'package:pamphlets_management/features/event_configuration/domain/use_cases/event_configuration_use_case.dart';

part 'event_configuration_event.dart';
part 'event_configuration_state.dart';

class EventConfigurationBloc
    extends Bloc<EventConfigurationEvent, EventConfigurationState> {
  final GetEventConfigurationUseCase _eventConfigurationUseCase;
  final EditConfigurationUseCase _editConfigurationUseCase;
  EventConfigurationBloc(
      this._eventConfigurationUseCase, this._editConfigurationUseCase)
      : super(EventConfigurationInitial()) {
    on<EventConfigurationStart>(onEventConfiguration);
    on<EditEventConfigurationStart>(onEditConfiguration);
  }

  FutureOr<void> onEventConfiguration(
      EventConfigurationStart event, emit) async {
    emit(EventConfigurationLoading());

    final result = await _eventConfigurationUseCase(event.eventId);

    result.fold(
        (error) => emit(EventConfigurationFailure(msgFail: error.message)),
        (data) => emit(EventConfigurationSuccess(modelConfiguration: data)));
  }

  FutureOr<void> onEditConfiguration(
      EditEventConfigurationStart event, emit) async {
    emit(EditEventConfigurationLoading());

    final result = await _editConfigurationUseCase(
        configModel: EventConfigurationModel(
            estId: event.modelConfiguration.estId,
            estPrimaryColorDark: event.modelConfiguration.estPrimaryColorDark,
            estSecondary1ColorDark:
                event.modelConfiguration.estSecondary1ColorDark,
            estSecondary2ColorDark:
                event.modelConfiguration.estSecondary2ColorDark,
            estSecondary3ColorDark:
                event.modelConfiguration.estSecondary3ColorDark,
            estAccentColorDark: event.modelConfiguration.estAccentColorDark,
            estPrimaryColorLight: event.modelConfiguration.estPrimaryColorLight,
            estSecondary1ColorLight:
                event.modelConfiguration.estSecondary1ColorLight,
            estSecondary2ColorLight:
                event.modelConfiguration.estSecondary2ColorLight,
            estSecondary3ColorLight:
                event.modelConfiguration.estSecondary3ColorLight,
            estAccentColorLight: event.modelConfiguration.estAccentColorLight,
            estLanguage: event.modelConfiguration.estLanguage,
            estFont: event.modelConfiguration.estFont,
            estTimeZone: event.modelConfiguration.estTimeZone,
            eveId: event.modelConfiguration.eveId));

    result.fold(
        (error) => emit(EditEventConfigurationFailure(msgFail: error.message)),
        (data) => emit(EditEventConfigurationSuccess()));
  }
}
