part of 'delete_speaker_bloc.dart';

sealed class DeleteSpeakerEvent extends Equatable {
  const DeleteSpeakerEvent();

  @override
  List<Object> get props => [];
}

class DeleteSpeaker extends DeleteSpeakerEvent {
  final int speakerId;

  const DeleteSpeaker({required this.speakerId});
}
