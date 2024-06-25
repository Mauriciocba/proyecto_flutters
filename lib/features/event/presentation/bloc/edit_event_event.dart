part of 'edit_event_bloc.dart';

sealed class EditEventEvent extends Equatable {
  const EditEventEvent();

  @override
  List<Object> get props => [];
}

class EditEventLoad extends EditEventEvent {
  final int eventId;

  const EditEventLoad({required this.eventId});
}

class EditEventConfirm extends EditEventEvent {
  final int idEvent;
  final EventUpdate eventUpdate;

  const EditEventConfirm({required this.idEvent, required this.eventUpdate});
}
