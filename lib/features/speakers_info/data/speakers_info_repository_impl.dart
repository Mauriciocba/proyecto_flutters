import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/speakers_info/domain/entities/speakers_info_model.dart';
import 'package:pamphlets_management/features/speakers_info/domain/repositories/speakers_info_repository.dart';

import '../../../core/errors/base_failure.dart';

class SpeakersInfoRepositoryImpl implements SpeakersInfoRepository {
  final ApiService apiService;

  const SpeakersInfoRepositoryImpl({required this.apiService});
  @override
  Future<Either<BaseFailure, List<SpeakersModel>>> getSpeakersByEvent({
    required int eventId,
    int? page,
    int? limit,
    String? search,
  }) async {
    var searchQuery = "&search=";
    if (search != null) {
      searchQuery += search;
    }

    try {
      final result = await apiService.request(
        method: HttpMethod.get,
        url: "/speakers/admin/$eventId/?page=$page&limit=$limit$searchQuery",
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
      final List<SpeakersModel> listSpeaker = [];

      if (resultData == null) {
        return Left(
            BaseFailure(message: 'No se pudo obtener los datos solicitados'));
      }

      if (resultData is List && resultData.isEmpty) {
        return Right(listSpeaker);
      }

      final speakerWhitActivityJson = resultData['speakersWithActivity'];
      final speakerWithoutActivityJson = resultData['speakersWithoutActivity'];

      final listSpeakerWhitActivity =
          speakersModelFromJson(jsonEncode(speakerWhitActivityJson));
      final listSpeakerWhitOutActivity =
          speakersModelFromJson(jsonEncode(speakerWithoutActivityJson));

      listSpeaker.addAll(listSpeakerWhitOutActivity);
      listSpeaker.addAll(listSpeakerWhitActivity);

      return Right(listSpeaker);
    } catch (e) {
      debugPrint(e.toString());
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
