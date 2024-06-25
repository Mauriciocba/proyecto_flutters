part of 'event_configuration_bloc.dart';

sealed class EventConfigurationState extends Equatable {
  const EventConfigurationState();

  @override
  List<Object> get props => [];
}

final class EventConfigurationInitial extends EventConfigurationState {}

final class EventConfigurationSuccess extends EventConfigurationState {
  final EventConfigurationModel modelConfiguration;

  const EventConfigurationSuccess({required this.modelConfiguration});
}

final class EventConfigurationFailure extends EventConfigurationState {
  final String msgFail;

  const EventConfigurationFailure({required this.msgFail});
}

final class EventConfigurationLoading extends EventConfigurationState {}

final class EditEventConfigurationSuccess extends EventConfigurationState {}

final class EditEventConfigurationFailure extends EventConfigurationState {
  final String msgFail;

  const EditEventConfigurationFailure({required this.msgFail});
}

final class EditEventConfigurationLoading extends EventConfigurationState {}
