part of 'edit_speaker_bloc.dart';

sealed class EditSpeakerEvent extends Equatable {
  const EditSpeakerEvent();

  @override
  List<Object> get props => [];
}

class EditSpeakerConfirmed extends EditSpeakerEvent {
  final SpeakerEditModel speakersModel;

  const EditSpeakerConfirmed({required this.speakersModel});
}

class EditSpeakerStart extends EditSpeakerEvent {
  final SpeakerEditModel speakerEditModel;

  const EditSpeakerStart({required this.speakerEditModel});
}

class RequestedEditSpeaker extends EditSpeakerEvent {
  final int eventId;

  const RequestedEditSpeaker({required this.eventId});
}
