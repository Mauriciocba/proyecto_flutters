import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/repositories/sponsors_category_delete_repository.dart';

import '../../../core/errors/base_failure.dart';

class SponsorsCategoryDeleteRepositoryImpl
    implements SponsorsCategoryDeleteRepository {
  final ApiService apiService;

  SponsorsCategoryDeleteRepositoryImpl({required this.apiService});
  @override
  Future<Either<BaseFailure, bool>> deleteSponsorsCategory(int spcId) async {
    try {
      final result = await apiService.request(
          method: HttpMethod.patch, url: "/sponsors-categories/delete/$spcId");

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
