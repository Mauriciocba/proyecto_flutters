import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/sponsors_info/domain/entities/sponsors_info_model.dart';
import 'package:pamphlets_management/features/sponsors_info/domain/repositories/sponsors_info_repository.dart';

import '../../../core/errors/base_failure.dart';

class SponsorsInfoRepositoryImpl implements SponsorsInfoRepository {
  final ApiService apiService;

  const SponsorsInfoRepositoryImpl({required this.apiService});
  @override
  Future<Either<BaseFailure, List<Sponsor>>> getSponsorsInfoByEvent(
      {required int eventId}) async {
    try {
      final result = await apiService.request(
        method: HttpMethod.get,
        url: "/events/datos/$eventId",
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
      final getListListSponsors = SponsorsInfoModel.fromMap(resultData);
      final listSponsors = getListListSponsors.sponsors;

      if (resultData == null) {
        return Left(
            BaseFailure(message: 'No se pudo obtener los datos solicitados'));
      }

      if (resultData is List && resultData.isEmpty) {
        return Right(listSponsors);
      }

      return Right(listSponsors);
    } catch (e) {
      debugPrint(e.toString());
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
