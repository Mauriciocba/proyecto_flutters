import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/news_create/domain/entities/news_model.dart';
import 'package:pamphlets_management/features/news_create/domain/repositories/news_repository.dart';

import '../../../core/errors/base_failure.dart';

final class NewsRepositoryImpl implements NewsRepository {
  final ApiService _apiService;

  NewsRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, bool>> save(NewsModel news) async {
    try {
      final result = await _apiService.request(
        method: HttpMethod.post,
        url: '/news/create',
        body: {
          "new_article": news.newArticle,
          "eve_id": news.eveId,
          "new_url": news.newUrl,
          "new_image": news.newImage,
          "new_created_at": news.newCreatedAt?.toIso8601String(),
        },
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
