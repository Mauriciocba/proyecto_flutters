import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/gallery_create/domain/entities/gallery_create_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class GalleryCreateRepository {
  Future<Either<BaseFailure, bool>> save(GalleryCreateModel galleryCreate);
}
