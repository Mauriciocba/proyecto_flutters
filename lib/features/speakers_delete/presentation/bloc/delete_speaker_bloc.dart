import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/speakers_delete/domain/use_case/delete_speakers_use_case.dart';

part 'delete_speaker_event.dart';
part 'delete_speaker_state.dart';

class DeleteSpeakerBloc extends Bloc<DeleteSpeakerEvent, DeleteSpeakerState> {
  final GetDeleteSpeakerUseCase _deleteSpeakerUseCase;
  DeleteSpeakerBloc(this._deleteSpeakerUseCase)
      : super(DeleteSpeakerInitial()) {
    on<DeleteSpeaker>(onDeleteSpeaker);
  }

  FutureOr<void> onDeleteSpeaker(DeleteSpeaker event, emit) async {
    emit(DeleteSpeakerLoading());

    final failOrDelete = await _deleteSpeakerUseCase(event.speakerId);

    failOrDelete.fold(
        (error) => emit(DeleteSpeakerFailure(msgFail: error.message)),
        (data) => emit(DeleteSpeakerSuccess()));
  }
}
