import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/gallery_info.dart/domain/entities/gallery_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract class GalleryInfoRepository {
  Future<Either<BaseFailure, List<GalleryModel>>> getGalleryInfoByEvent({
    required int eventId,
  });
}
