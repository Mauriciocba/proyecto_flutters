import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/stand_delete/domain/repositories/delete_stand_repository.dart';

import '../../../core/errors/base_failure.dart';

class DeleteStandRepositoryImpl implements DeleteStandRepository {
  final ApiService apiService;

  DeleteStandRepositoryImpl({required this.apiService});
  @override
  Future<Either<BaseFailure, bool>> deleteStandInfo(int stdId) async {
    try {
      final result = await apiService.request(
          method: HttpMethod.patch, url: "/stands/delete/$stdId");

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
