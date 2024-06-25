import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/activity_categories/domain/repositories/delete_category_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class DeleteCategoryRepositoryImpl implements DeleteCategoryRepository {
  final ApiService _apiService;

  DeleteCategoryRepositoryImpl(this._apiService);

  @override
  Future<Either<BaseFailure, void>> deleteBy({required int categoryId}) async {
    try {
      final result = await _apiService.request(
        method: HttpMethod.patch,
        url: '/activity-categories/delete/$categoryId',
      );

      if (result.resultType == ResultType.failure) {
        return Left(BaseFailure(message: "Hubo un error, vuelve a intentar"));
      }

      if (result.resultType == ResultType.error) {
        return Left(BaseFailure(
            message:
                "No se pudo comunicar con el servidor, intenta nuevamente"));
      }
      if (result.body == null) {
        return Left(BaseFailure(message: "Hubo un error, vuelve a intentar"));
      }

      if (result.body!['statusCode'] != HttpStatus.ok) {
        return Left(BaseFailure(message: result.body!['message']));
      }

      return right(null);
    } catch (e) {
      return Left(BaseFailure(message: "Hubo un error, vuelve a intentar"));
    }
  }
}
