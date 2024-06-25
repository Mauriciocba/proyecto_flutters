import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/api_service.dart';
import '../../domain/entities/create_event_model.dart';
import '../../domain/entities/setting_event_model.dart';
import '../../domain/repositories/create_event_repository.dart';

class CreateEventRepositoryImpl implements CreateEventRepository {
  final ApiService _apiService;

  CreateEventRepositoryImpl(this._apiService);

  @override
  Future<Either<BaseFailure, int>> createEvent(
      CreateEventModel newEvent) async {
    try {
      final newEventJson = json.decode(newEvent.toJson());
      final response = await _apiService.request(
          method: HttpMethod.post, url: '/events/create', body: newEventJson);

      if (response.resultType == ResultType.error) {
        return Left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }

      if (response.resultType == ResultType.failure) {
        return Left(
            BaseFailure(message: 'Hubo una falla en la obtención de datos'));
      }

      if (response.body == null || response.body?['eve_id'] == null) {
        return Left(
            BaseFailure(message: 'No se pudo obtener los datos solicitados'));
      }

      return right(response.body!['eve_id']);
    } catch (e) {
      return left(BaseFailure(message: 'Hubo un error interno'));
    }
  }

  @override
  Future<Either<BaseFailure, bool>> addSetting(
      SettingEventModel newSettingEvent, int eventId) async {
    try {
      newSettingEvent.eveId = eventId;
      final newEventJson = newSettingEvent.toMap();

      final response = await _apiService.request(
          method: HttpMethod.post,
          url: '/event-settings/create',
          body: newEventJson);

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
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
