import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/info_event/domain/entities/event.dart';
import 'package:pamphlets_management/features/info_event/domain/repositories/info_event_repository.dart';

import '../../../../core/errors/base_failure.dart';
import '../../../../core/network/api_result.dart';

class InfoEnventRepositoryImpl implements InfoEventRepository {
  final ApiService apiService;

  InfoEnventRepositoryImpl({required this.apiService});
  @override
  Future<Either<BaseFailure, Event>> getInfoEvent(int id) async {
    try {
      final result = await apiService.request(
          method: HttpMethod.get, url: "/events/id/admin/$id");

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

      final getInfoEvent = result.body?["data"];
      final infoEventList = Event.fromMap(getInfoEvent);

      return Right(infoEventList);
    } catch (e) {
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
