import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/social_media/domain/entities/social_media.dart';
import 'package:pamphlets_management/features/social_media/domain/repositories/social_media_repository.dart';

import '../../../core/errors/base_failure.dart';

final class SocialMediaRepositoryImpl implements SocialMediaRepository {
  final ApiService _apiService;

  SocialMediaRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, bool>> save(
      SocialMediaModel socialmedia, int typeId, String type) async {
    try {
      final result = await _apiService.request(
        method: HttpMethod.post,
        url: '/social-media?id=$typeId&type=$type',
        body: {"som_name": socialmedia.somName, "som_url": socialmedia.somUrl},
      );

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
