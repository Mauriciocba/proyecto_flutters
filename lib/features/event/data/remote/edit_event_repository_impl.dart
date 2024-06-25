import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/event/domain/entities/event_update.dart';
import 'package:pamphlets_management/features/event/domain/repositories/edit_event_repository.dart';

import '../../../../core/errors/base_failure.dart';

class EditEventRepositoryImpl implements EditEventRepository {
  final ApiService _apiService;

  EditEventRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, bool>> confirmChange(
      EventUpdate event, int idEvent) async {
    try {
      final response = await _apiService.request(
          method: HttpMethod.patch,
          url: '/events/update/$idEvent',
          body: event.toMap());

      if (response.resultType == ResultType.error) {
        return Left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }

      if (response.resultType == ResultType.failure) {
        return Left(
            BaseFailure(message: 'Hubo una falla en la obtención de datos'));
      }

      return right(true);
    } catch (e) {
      debugPrint("$e");
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
