import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/features/sponsor_category/data/model/sponsors_category_response.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_model.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/repositories/sponsors_category_repository.dart';

import '../../../core/errors/base_failure.dart';
import '../../../core/network/api_service.dart';

class SponsorsCategoryRepositoryImpl implements SponsorsCategoryRepository {
  final ApiService apiService;

  const SponsorsCategoryRepositoryImpl({required this.apiService});
  @override
  Future<Either<BaseFailure, List<SponsorsCategoryModel>>> getEventID({
    required int eventId,
  }) async {
    try {
      final result = await apiService.request(
        method: HttpMethod.get,
        url: "/sponsors-categories/eveId/$eventId",
      );

      if (result.resultType == ResultType.failure) {
        return Left(
            BaseFailure(message: 'Hubo una falla en la obtención de datos'));
      }

      if (result.resultType == ResultType.error) {
        return Left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }

      if (result.body?['statusCode'] == HttpStatus.noContent) {
        return const Right([]);
      }

      if (result.body == null || result.body?['data'] == null) {
        return left(
            BaseFailure(message: 'No se pudo obtener los datos solicitados'));
      }

      final resultData = result.body?['data'];
      final infoCategorySponsors =
          sponsorsCategoryResponseFromJson(jsonEncode(resultData));

      final List<SponsorsCategoryModel> lstSpoCategory = infoCategorySponsors
          .map((e) => SponsorsCategoryModel(
              spcId: e.spcId,
              spcName: e.spcName,
              spcDescription: e.spcDescription,
              eveId: e.eveId['eve_id']))
          .toList();

      return Right(lstSpoCategory);
    } catch (e) {
      debugPrint(e.toString());
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
