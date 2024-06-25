import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/faq/domain/repositories/faq_delete_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class FaqDeleteRepositoryImpl implements FaqDeleteRepository {
  final ApiService _apiService;

  FaqDeleteRepositoryImpl(this._apiService);

  @override
  Future<Either<BaseFailure, bool>> deleteBy({required int faqId}) async {
    try {
      final response = await _apiService.request(
        method: HttpMethod.delete,
        url: '/faqs/delete/$faqId',
      );

      if (response.resultType == ResultType.error) {
        return Left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }

      if (response.resultType == ResultType.failure) {
        return Left(
            BaseFailure(message: 'Hubo una falla en la obtención de datos'));
      }

      if (response.body == null) {
        return Left(
            BaseFailure(message: 'No se pudo obtener los datos solicitados'));
      }

      return const Right(true);
    } catch (e) {
      debugPrint("$e");
      return Left(
        BaseFailure(message: 'Hubo un fallo interno'),
      );
    }
  }
}
