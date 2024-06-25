import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/gallery_create/domain/entities/gallery_create_model.dart';
import 'package:pamphlets_management/features/gallery_create/domain/repositories/gallery_create_repository.dart';

import '../../../../core/errors/base_failure.dart';

class RegisterGalleryCreateUseCase {
  final GalleryCreateRepository _galleryCreateRepository;

  RegisterGalleryCreateUseCase(this._galleryCreateRepository);

  Future<Either<BaseFailure, bool>> call(
      GalleryCreateModel galleryCreate) async {
    final result = await _galleryCreateRepository.save(galleryCreate);

    if (galleryCreate.galImage.isEmpty) {
      return Left(BaseFailure(message: "No cargó imagen"));
    }

    if (result.isLeft()) {
      return Left(BaseFailure(message: "No se pudo registrar la imagen"));
    }

    return const Right(true);
  }
}
