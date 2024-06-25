import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/social_media/domain/entities/social_media.dart';
import 'package:pamphlets_management/features/social_media/domain/use_case/register_social_media.dart';
import 'package:pamphlets_management/features/speakers/domain/use_case/register_speaker_use_case.dart';

part 'create_speaker_event.dart';
part 'create_speaker_state.dart';

class CreateSpeakerBloc extends Bloc<CreateSpeakerEvent, CreateSpeakerState> {
  final RegisterSpeakerUseCase _registerSpeakerUseCase;
  final RegisterSocialMediaUseCase _registerSocialMediaUseCase;
  CreateSpeakerBloc(
      this._registerSpeakerUseCase, this._registerSocialMediaUseCase)
      : super(CreateSpeakerInitial()) {
    on<SpeakerFormEvent>(onSpeakersForm);
    on<SocialMediaSave>(onSocialMedia);
  }

  FutureOr<void> onSpeakersForm(SpeakerFormEvent event, emit) async {
    emit(CreateSpeakerLoading());

    final result = await _registerSpeakerUseCase(
        speakersForm: event.speakerForm,
        speakerSocialMedia: event.speakerSocialMedia);

    result.fold(
        (error) => emit(CreateSpeakerFailure(msgError: error.message)),
        (data) =>
            emit(const CreateSpeakerSuccess(msgSuccess: 'Speaker registrado')));
  }

  FutureOr<void> onSocialMedia(SocialMediaSave event, emit) async {
    emit(CreateSpeakerLoading());

    final failOrSocialMedia =
        await _registerSocialMediaUseCase(event.socialMedia);

    failOrSocialMedia.fold(
        (error) => emit(SocialMediaFail(msgFail: error.message)),
        (data) => emit(SocialMediaSuccess()));
  }
}
