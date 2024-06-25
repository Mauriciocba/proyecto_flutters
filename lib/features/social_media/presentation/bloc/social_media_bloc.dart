import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/social_media/domain/entities/social_media.dart';
import 'package:pamphlets_management/features/social_media/domain/use_case/register_social_media.dart';

part 'social_media_event.dart';
part 'social_media_state.dart';

class SocialMediaBloc extends Bloc<SocialMediaEvent, SocialMediaState> {
  final RegisterSocialMediaUseCase _registerSocialMediaUseCase;
  SocialMediaBloc(this._registerSocialMediaUseCase)
      : super(SocialMediaInitial()) {
    on<SocialMediaStart>(onSocialMedia);
  }

  FutureOr<void> onSocialMedia(SocialMediaStart event, emit) async {
    emit(SocialMediaLoading());

    final failOrsocialMedia =
        await _registerSocialMediaUseCase(event.socialMedia);

    failOrsocialMedia.fold(
        (error) => emit(SocialMediaFailure(msgFail: error.message)),
        (data) => emit(SocialMediaSuccess()));
  }
}
