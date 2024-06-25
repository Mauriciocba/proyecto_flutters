part of 'edit_speaker_bloc.dart';

sealed class EditSpeakerState extends Equatable {
  const EditSpeakerState();
  
  @override
  List<Object> get props => [];
}

final class EditSpeakerInitial extends EditSpeakerState {}

final class EditSpeakerSuccess extends EditSpeakerState {}

final class EditSpeakerFailure extends EditSpeakerState {
  final String msgFail;

  const EditSpeakerFailure({required this.msgFail});

}

final class EditSpeakerLoading extends EditSpeakerState {}

final class LoadFormSpeakersFail extends EditSpeakerState {
  final String msgFailLoadForm;

  const LoadFormSpeakersFail({required this.msgFailLoadForm});
}

final class LoadFormSpeakersLoading extends EditSpeakerState {}

final class LoadFormSpeakersSuccess extends EditSpeakerState {
  final SpeakerEditModel speaker;

  const LoadFormSpeakersSuccess({required this.speaker});
}