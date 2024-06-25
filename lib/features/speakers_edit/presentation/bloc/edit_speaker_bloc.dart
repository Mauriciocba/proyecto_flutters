import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/speakers_edit/domain/entities/speaker_edit_model.dart';
import 'package:pamphlets_management/features/speakers_edit/domain/use_case/edit_speakers_use_case.dart';

part 'edit_speaker_event.dart';
part 'edit_speaker_state.dart';

class EditSpeakerBloc extends Bloc<EditSpeakerEvent, EditSpeakerState> {
  final EditSpeakersUseCase _editSpeakersUseCase;

  EditSpeakerBloc(this._editSpeakersUseCase) : super(EditSpeakerInitial()) {
    on<EditSpeakerStart>(onEditSpeakers);
    on<EditSpeakerConfirmed>(speakersLoadForm);
  }

  FutureOr<void> onEditSpeakers(EditSpeakerStart event, emit) async {
    emit(EditSpeakerLoading());

    emit(LoadFormSpeakersSuccess(speaker: event.speakerEditModel));
  }

  FutureOr<void> speakersLoadForm(EditSpeakerConfirmed event, emit) async {
    emit(EditSpeakerLoading());
    final result = await _editSpeakersUseCase(
      speakerEditModel: SpeakerEditModel(
          speId: event.speakersModel.speId,
          eveId: event.speakersModel.eveId,
          speFirstName: event.speakersModel.speFirstName,
          speLastName: event.speakersModel.speLastName,
          speDescription: event.speakersModel.speDescription,
          spePhoto: event.speakersModel.spePhoto),
    );

    result.fold(
        (error) => emit(LoadFormSpeakersFail(msgFailLoadForm: error.message)),
        (data) => emit(EditSpeakerSuccess()));
  }
}
