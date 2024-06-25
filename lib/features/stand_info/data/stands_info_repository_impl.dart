import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/stand_info/domain/entities/stands_info_model.dart';
import 'package:pamphlets_management/features/stand_info/domain/repositories/stands_info_repository.dart';

import '../../../core/errors/base_failure.dart';

class StandsInfoRepositoryImpl implements StandsInfoRepository {
  final ApiService apiService;

  const StandsInfoRepositoryImpl({required this.apiService});
  @override
  Future<Either<BaseFailure, List<StandsInfoModel>>> getStandsInfoByEvent(
      {required int eventId}) async {
    try {
      final result = await apiService.request(
        method: HttpMethod.get,
        url: "/stands/$eventId",
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
      final infoListStands = standsInfoFromMap(jsonEncode(resultData));

      if (resultData == null) {
        return Left(
            BaseFailure(message: 'No se pudo obtener los datos solicitados'));
      }

      if (resultData is List && resultData.isEmpty) {
        return Right(infoListStands);
      }

      return Right(infoListStands);
    } catch (e) {
      debugPrint(e.toString());
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
