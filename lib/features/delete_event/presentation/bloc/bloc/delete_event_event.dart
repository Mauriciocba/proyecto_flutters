part of 'delete_event_bloc.dart';

sealed class DeleteEventEvent extends Equatable {
  const DeleteEventEvent();

  @override
  List<Object> get props => [];
}

class DeleteEvent extends DeleteEventEvent {
  final int eventId;

  const DeleteEvent({required this.eventId});
}
