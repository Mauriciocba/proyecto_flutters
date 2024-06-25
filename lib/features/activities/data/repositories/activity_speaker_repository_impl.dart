import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/activities/domain/repositories/activity_speaker_repository.dart';

import '../../../../core/errors/base_failure.dart';

class ActivitySpeakerRepositoryImpl implements ActivitySpeakerRepository {
  final ApiService _apiService;

  ActivitySpeakerRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, bool>> save({
    required int activityId,
    required List<int> speakersIds,
  }) async {
    try {
      final result = await _apiService.request(
        method: HttpMethod.post,
        url: '/activity-speakers/create',
        body: {
          'act_id': activityId,
          'spe_id': speakersIds,
        },
      );

      if (result.resultType == ResultType.failure) {
        return Left(
            BaseFailure(message: "Hubo un error al asignar los speakers"));
      }

      if (result.resultType == ResultType.error) {
        return Left(
            BaseFailure(message: "Hubo un error al asignar los speakers"));
      }

      if (result.body?['statusCode'] == null) {
        return Left(
            BaseFailure(message: "Hubo un error al asignar los speakers"));
      }

      if (result.body?['statusCode'] != HttpStatus.created) {
        return Left(
            BaseFailure(message: "Hubo un error al asignar los speakers"));
      }
      return const Right(true);
    } catch (e) {
      return Left(
          BaseFailure(message: "Hubo un error al asignar los speakers"));
    }
  }
}
