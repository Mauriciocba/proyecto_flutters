import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/sponsor_delete/domain/repositories/delete_sponsors_repository.dart';

import '../../../core/errors/base_failure.dart';

class DeleteSponsorsRepositoryImpl implements DeleteSponsorsRepository {
  final ApiService apiService;

  DeleteSponsorsRepositoryImpl({required this.apiService});
  @override
  Future<Either<BaseFailure, bool>> deleteSponsorsInfo(int spoId) async {
    try {
      final result = await apiService.request(
          method: HttpMethod.patch, url: "/sponsors/delete/$spoId");

      if (result.resultType == ResultType.failure) {
        return Left(BaseFailure(message: "Ruta inexistente."));
      }

      if (result.resultType == ResultType.error) {
        return Left(BaseFailure(message: "Error"));
      }

      return const Right(true);
    } catch (e) {
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
