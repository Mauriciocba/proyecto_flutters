import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category_registration_form.dart';
import 'package:pamphlets_management/features/activity_categories/domain/repositories/update_category_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class UpdateCategoryRepositoryImpl implements UpdateCategoryRepository {
  final ApiService _apiService;

  UpdateCategoryRepositoryImpl(this._apiService);

  @override
  Future<Either<BaseFailure, Category>> update({
    required int categoryId,
    required CategoryRegistrationForm newCategoryData,
  }) async {
    try {
      final result = await _apiService.request(
        method: HttpMethod.patch,
        url: '/activity-categories/update/id/$categoryId',
        body: {
          'acc_font_color': newCategoryData.colorCode,
          'acc_block': newCategoryData.name,
          'acc_icon': newCategoryData.iconName,
          'acc_description': newCategoryData.description,
          'asc_id': null,
        },
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

      if (result.body!['statusCode'] != HttpStatus.created) {
        return Left(BaseFailure(message: result.body!['message']));
      }

      final updatedCategory = Category(
        categoryId: categoryId,
        name: newCategoryData.name,
        description: newCategoryData.description,
        iconName: newCategoryData.iconName,
        color: newCategoryData.colorCode,
      );

      return Right(updatedCategory);
    } catch (e) {
      return Left(BaseFailure(message: "Hubo un fallo interno"));
    }
  }
}
