part of 'create_speaker_bloc.dart';

sealed class CreateSpeakerState extends Equatable {
  const CreateSpeakerState();

  @override
  List<Object> get props => [];
}

final class CreateSpeakerInitial extends CreateSpeakerState {}

final class CreateSpeakerSuccess extends CreateSpeakerState {
  final String msgSuccess;

  const CreateSpeakerSuccess({required this.msgSuccess});
}

final class CreateSpeakerFailure extends CreateSpeakerState {
  final String msgError;

  const CreateSpeakerFailure({required this.msgError});
}

final class CreateSpeakerLoading extends CreateSpeakerState {}

final class SocialMediaSuccess extends CreateSpeakerState {}

final class SocialMediaFail extends CreateSpeakerState {
  final String msgFail;

  const SocialMediaFail({required this.msgFail});
}
