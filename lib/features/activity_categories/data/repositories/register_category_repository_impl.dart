import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category_registration_form.dart';
import 'package:pamphlets_management/features/activity_categories/domain/repositories/register_category_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class RegisterCategoryRepositoryImpl
    implements RegisterCategoryRepository {
  final String _NO_RESPONSE_MESSAGE =
      "El servidor no respondió, intente más tarde";
  final String _SOMETHING_WRONG_MESSAGE =
      "Hubo un problema, intente nuevamente";

  final ApiService _apiService;

  RegisterCategoryRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, int>> save(
    CategoryRegistrationForm categoryRegistrationForm,
  ) async {
    try {
      final response = await _sendDataToServer(categoryRegistrationForm);
      return _parseResponse(response);
    } catch (e) {
      debugPrint("CategoryRepositoryImpl-save: ${e.toString()}");
      return Left(BaseFailure(message: _SOMETHING_WRONG_MESSAGE));
    }
  }

  Future<ApiResult> _sendDataToServer(
    CategoryRegistrationForm categoryRegistrationForm,
  ) async {
    return await _apiService.request(
      method: HttpMethod.post,
      url: "/activity-categories/create",
      body: {
        "acc_font_color": categoryRegistrationForm.colorCode,
        "acc_block": categoryRegistrationForm.name,
        "acc_icon": categoryRegistrationForm.iconName,
        "acc_description": categoryRegistrationForm.description,
      },
    );
  }

  Either<BaseFailure, int> _parseResponse(ApiResult response) {
    return switch (response.resultType) {
      ResultType.failure => Left(BaseFailure(
          message: response.body?['message'] ?? _SOMETHING_WRONG_MESSAGE)),
      ResultType.error => Left(BaseFailure(message: _NO_RESPONSE_MESSAGE)),
      ResultType.success => Right(response.body?['data']['acc_id']),
    };
  }
}
