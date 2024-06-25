import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/gallery_create/domain/entities/gallery_create_model.dart';
import 'package:pamphlets_management/features/gallery_create/domain/repositories/gallery_create_repository.dart';

import '../../../core/errors/base_failure.dart';

final class GalleryCreateRepositoryImpl implements GalleryCreateRepository {
  final ApiService _apiService;

  GalleryCreateRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, bool>> save(GalleryCreateModel gallery) async {
    try {
      final result = await _apiService.request(
          method: HttpMethod.post,
          url: '/gallery/create',
          body: {"gal_image": gallery.galImage, "eve_id": gallery.eveId});

      if (result.resultType == ResultType.failure) {
        return Left(
            BaseFailure(message: 'Hubo una falla en la obtención de datos'));
      }

      if (result.resultType == ResultType.error) {
        return Left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }

      return const Right(true);
    } catch (e) {
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
