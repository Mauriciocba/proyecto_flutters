import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pamphlets_management/features/speakers_delete/domain/repository/delete_speakers_repository.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/network/api_service.dart';
import '../../../core/errors/base_failure.dart';

class DeleteSpeakerRepositoryImpl implements DeleteSpeakerRepository {
  final ApiService apiService;

  DeleteSpeakerRepositoryImpl({required this.apiService});
  @override
  Future<Either<BaseFailure, bool>> deleteSpeakers(int id) async {
    try {
      final result = await apiService.request(
          method: HttpMethod.patch, url: "/speakers/delete/$id");

      if (result.resultType == ResultType.failure) {
        return Left(
            BaseFailure(message: 'Hubo una falla en la obtención de datos'));
      }

      if (result.resultType == ResultType.error) {
        return Left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }

      return const Right(true);
    } catch (e) {
      debugPrint(e.toString());
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
