import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_register_form.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/repositories/sponsors_category_create_repository.dart';

import '../../../core/errors/base_failure.dart';

final class SponsorCategoryCreateRepositoryImpl
    implements SponsorCategoryCreateRepository {
  final String _NO_RESPONSE_MESSAGE =
      "El servidor no respondió, intente más tarde";
  final String _SOMETHING_WRONG_MESSAGE =
      "Hubo un problema, intente nuevamente";

  final ApiService _apiService;

  SponsorCategoryCreateRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, int>> save(
      SponsorsCategoryRegistrationForm spcModel) async {
    try {
      final response = await _sendDataToServer(spcModel);
      return _parseResponse(response);
    } catch (e) {
      debugPrint("SponsorCategoryRepositoryImpl-save: ${e.toString()}");
      return Left(BaseFailure(message: _SOMETHING_WRONG_MESSAGE));
    }
  }

  Future<ApiResult> _sendDataToServer(
    SponsorsCategoryRegistrationForm spcModel,
  ) async {
    return await _apiService.request(
      method: HttpMethod.post,
      url: "/sponsors-categories/create",
      body: {
        "spc_name": spcModel.spcName,
        "spc_description": spcModel.spcDescription,
        "eve_id": spcModel.eventId
      },
    );
  }

  Either<BaseFailure, int> _parseResponse(ApiResult response) {
    return switch (response.resultType) {
      ResultType.failure =>
        Left(BaseFailure(message: _SOMETHING_WRONG_MESSAGE)),
      ResultType.error => Left(BaseFailure(message: _NO_RESPONSE_MESSAGE)),
      ResultType.success => Right(response.body?['data']['spc_id']),
    };
  }
}
