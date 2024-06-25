part of 'event_configuration_bloc.dart';

sealed class EventConfigurationEvent extends Equatable {
  const EventConfigurationEvent();

  @override
  List<Object> get props => [];
}

final class EventConfigurationStart extends EventConfigurationEvent {
  final int eventId;

  const EventConfigurationStart({required this.eventId});
}

class EditEventConfigureConfirmed extends EventConfigurationEvent {
  final EventConfigurationModel modelEventConfiguration;

  const EditEventConfigureConfirmed({required this.modelEventConfiguration});
}

class EditEventConfigurationStart extends EventConfigurationEvent {
  final EventConfigurationModel modelConfiguration;

  const EditEventConfigurationStart({required this.modelConfiguration});
}
