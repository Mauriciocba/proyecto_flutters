import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/social_media/domain/entities/social_media.dart';
import 'package:pamphlets_management/features/social_media/domain/repositories/social_media_repository.dart';

import '../../../../core/errors/base_failure.dart';

class RegisterSocialMediaUseCase {
  final SocialMediaRepository _socialMediaRepository;

  RegisterSocialMediaUseCase(this._socialMediaRepository);

  Future<Either<BaseFailure, bool>> call(SocialMediaModel socialMedia) async {
    if (socialMedia.somName != null && socialMedia.somUrl != null) {
      if (socialMedia.somName!.isEmpty) {
        return Left(BaseFailure(message: 'Debe contener un nombre'));
      }

      if (socialMedia.somUrl!.isEmpty) {
        return Left(
            BaseFailure(message: "Debe contener un link de red social"));
      }
    }

    final result = await _socialMediaRepository.save(socialMedia, 3, 'spe');

    if (result.isLeft()) {
      return Left(BaseFailure(message: "No se pudo registrar Social Media"));
    }

    return const Right(true);
  }
}
