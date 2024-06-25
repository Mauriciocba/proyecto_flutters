import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/gallery_delete/domain/repositories/gallery_delete_repository.dart';

import '../../../../core/errors/base_failure.dart';

class DeleteGalleryUseCase {
  final GalleryDeleteRepository _galleryDeleteRepository;

  DeleteGalleryUseCase(this._galleryDeleteRepository);

  Future<Either<BaseFailure, bool>> call(int galleryId) async {
    try {
      return await _galleryDeleteRepository.deleteGalleryInfo(galleryId);
    } catch (e) {
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
