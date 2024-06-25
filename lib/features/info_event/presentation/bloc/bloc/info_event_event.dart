part of 'info_event_bloc.dart';

sealed class InfoEventEvent {}

class InfoEventStart extends InfoEventEvent {
  final int eventId;

  InfoEventStart({required this.eventId});
}

class DeletedEvent extends InfoEventEvent {}
