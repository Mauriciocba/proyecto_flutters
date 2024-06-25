import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/delete_event/domain/repositories/delete_event_repository.dart';

import '../../../../core/errors/base_failure.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/api_service.dart';

class DeleteEventRepositoryImpl implements DeleteEventRepository {
  final ApiService apiService;

  DeleteEventRepositoryImpl({required this.apiService});
  @override
  Future<Either<BaseFailure, bool>> deleteInfoEvent(int eventId) async {
    try {
      final result = await apiService.request(
          method: HttpMethod.patch, url: "/events/delete/$eventId");

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
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
