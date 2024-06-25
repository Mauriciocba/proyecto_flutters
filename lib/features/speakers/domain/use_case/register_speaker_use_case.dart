import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/social_media/domain/entities/social_media.dart';
import 'package:pamphlets_management/features/social_media/domain/repositories/social_media_repository.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../../../core/errors/base_failure.dart';
import '../repositories/speaker_repository.dart';

class RegisterSpeakerUseCase {
  final SpeakerRepository speakerRepository;
  final SocialMediaRepository _socialmediaRepository;

  RegisterSpeakerUseCase(this.speakerRepository, this._socialmediaRepository);

  Future<Either<BaseFailure, bool>> call(
      {required SpeakerForm speakersForm,
      required List<SocialMediaModel>? speakerSocialMedia}) async {
    if (speakersForm.eventId <= 0) {
      return Left(BaseFailure(message: 'El id no puede ser negativo'));
    }

    if (speakersForm.name.trim().isEmpty) {
      return Left(BaseFailure(message: 'Debe contener un nombre'));
    }

    if (speakersForm.lastName.trim().isEmpty) {
      return Left(BaseFailure(message: 'Debe contener un apellido'));
    }

    if (speakersForm.description.isEmpty) {
      return Left(BaseFailure(message: "Debe contener una descripción"));
    }

    final result = await speakerRepository.save(speakersForm);

    if (result.isLeft()) {
      return Left(BaseFailure(message: "No se pudo registrar el Speaker"));
    }
    final int speakerId = result.getRight();

    if (speakerSocialMedia != null && speakerSocialMedia.isNotEmpty) {
      for (var item in speakerSocialMedia) {
        final socialmedia =
            await _socialmediaRepository.save(item, speakerId, 'spe');

        if (socialmedia.isLeft()) {
          return Left(BaseFailure(
              message:
                  "No se pudo guardar la siguiente red social: ${item.somName}"));
        }
      }
    }

    return const Right(true);
  }
}

typedef SpeakerForm = ({
  int eventId,
  String name,
  String lastName,
  String description,
  String? photo
});
