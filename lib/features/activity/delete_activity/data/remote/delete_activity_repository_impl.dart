import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/activity/delete_activity/domain/repositories/delete_activity_repository.dart';

import '../../../../../core/errors/base_failure.dart';

class DeleteActivityRepositoryImpl implements DeleteActivityRepository {
  final ApiService _apiService;

  DeleteActivityRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, bool>> deleteActivity(int idActivity) async {
    try {
      final response = await _apiService.request(
          method: HttpMethod.patch, url: '/activity/delete/$idActivity');

      if (response.body == null) {
        return left(
            BaseFailure(message: 'No se obtuvo respuesta del servidor'));
      }

      if (response.resultType == ResultType.error) {
        return left(BaseFailure(message: response.body?['message']));
      }

      if (response.resultType == ResultType.failure) {
        return left(BaseFailure(message: response.body?['message']));
      }

      return right(true);
    } catch (e) {
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
