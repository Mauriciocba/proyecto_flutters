part of 'create_event_bloc.dart';

sealed class CreateEventEvent {}

class SentData extends CreateEventEvent {
  final CreateEventModel createEventModel;
  final SettingEventModel newSettingEvent;

  SentData({required this.createEventModel, required this.newSettingEvent});
}
