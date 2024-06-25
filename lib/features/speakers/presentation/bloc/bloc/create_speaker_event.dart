part of 'create_speaker_bloc.dart';

sealed class CreateSpeakerEvent extends Equatable {
  const CreateSpeakerEvent();

  @override
  List<Object> get props => [];
}

class SpeakerFormEvent extends CreateSpeakerEvent {
  final SpeakerForm speakerForm;
  final List<SocialMediaModel>? speakerSocialMedia;
  const SpeakerFormEvent({required this.speakerForm, this.speakerSocialMedia});
}

class SocialMediaSave extends CreateSpeakerEvent {
  final SocialMediaModel socialMedia;

  const SocialMediaSave({required this.socialMedia});
}
