import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/gallery_delete/domain/repositories/gallery_delete_repository.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/network/api_service.dart';
import '../../../core/errors/base_failure.dart';

class GalleryDeleteRepositoryImpl implements GalleryDeleteRepository {
  final ApiService apiService;

  GalleryDeleteRepositoryImpl({required this.apiService});
  @override
  Future<Either<BaseFailure, bool>> deleteGalleryInfo(int galleryId) async {
    try {
      final result = await apiService.request(
          method: HttpMethod.patch, url: "/gallery/delete/$galleryId");

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
