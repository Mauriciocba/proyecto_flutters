part of 'delete_speaker_bloc.dart';

sealed class DeleteSpeakerState extends Equatable {
  const DeleteSpeakerState();
  
  @override
  List<Object> get props => [];
}

final class DeleteSpeakerInitial extends DeleteSpeakerState {}

class DeleteSpeakerSuccess extends DeleteSpeakerState {}

class DeleteSpeakerLoading extends DeleteSpeakerState {}

class DeleteSpeakerFailure extends DeleteSpeakerSuccess {
  final String msgFail;

  DeleteSpeakerFailure({required this.msgFail});

}