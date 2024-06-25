import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/faq/domain/repositories/faq_image_delete_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class FaqImageDeleteRepositoryImpl implements FaqImageDeleteRepository {
  final ApiService _apiService;

  FaqImageDeleteRepositoryImpl(this._apiService);

  @override
  Future<Either<BaseFailure, bool>> deleteBy(int faqImageId) async {
    try {
      final response = await _apiService.request(
        method: HttpMethod.patch,
        url: '/image-faqs/delete/$faqImageId',
      );

      if (response.resultType == ResultType.error) {
        return Left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }

      if (response.resultType == ResultType.failure) {
        return Left(
            BaseFailure(message: 'Hubo una falla en la obtención de datos'));
      }

      return const Right(true);
    } catch (e) {
      debugPrint('$e');
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
