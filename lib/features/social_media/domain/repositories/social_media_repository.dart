import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/social_media/domain/entities/social_media.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class SocialMediaRepository {
  Future<Either<BaseFailure, bool>> save(
      SocialMediaModel socialMediaModel, int typeId, String type);
}
