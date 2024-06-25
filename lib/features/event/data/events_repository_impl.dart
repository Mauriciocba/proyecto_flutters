import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/event/domain/entities/event.dart';
import 'package:pamphlets_management/features/event/domain/repositories/event_all_repository.dart';

import '../../../core/errors/base_failure.dart';

class EventRepositoryImpl implements EventAllRepository {
  final ApiService _apiService;

  EventRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;
  @override
  Future<Either<BaseFailure, List<Event>>> getEventAll() async {
    try {
      final result = await _apiService.request(
        method: HttpMethod.get,
        url: "/events/all-user",
      );

      if (result.resultType == ResultType.failure) {
        return Left(
            BaseFailure(message: 'Hubo una falla en la obtención de datos'));
      }

      if (result.resultType == ResultType.error) {
        return Left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }

      if (result.body == null || result.body?['data'] == null) {
        return left(
            BaseFailure(message: 'No se pudo obtener los datos solicitados'));
      }

      final getEventAll = result.body?["data"];
      final eventList = eventFromMap(jsonEncode(getEventAll));
      return Right(eventList..sort((a, b) => a.eveId > b.eveId ? -1 : 1));
    } catch (e) {
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
