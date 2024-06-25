import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class GalleryDeleteRepository {
  Future<Either<BaseFailure, bool>> deleteGalleryInfo(int galleryId);
}
