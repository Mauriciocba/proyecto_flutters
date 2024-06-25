import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/gallery_info.dart/domain/entities/gallery_model.dart';
import 'package:pamphlets_management/features/gallery_info.dart/domain/repositories/gallery_info_repository.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../../../core/errors/base_failure.dart';

class GetGalleryInfoUseCase {
  final GalleryInfoRepository _galleryInfoRepository;

  GetGalleryInfoUseCase(this._galleryInfoRepository);

  Future<Either<BaseFailure, List<GalleryModel>>> call(int eventId) async {
    final failOrGalleryInfo =
        await _galleryInfoRepository.getGalleryInfoByEvent(
      eventId: eventId,
    );

    if (failOrGalleryInfo.isLeft()) {
      return Left(failOrGalleryInfo.getLeft());
    }

    if (failOrGalleryInfo.getRight().isEmpty) {
      return Left(BaseFailure(message: "Esta Galería no contiene imágenes"));
    }

    return Right(failOrGalleryInfo.getRight());
  }
}
