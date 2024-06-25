import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/sponsor_edit/domain/repositories/sponsor_edit_repository.dart';

import '../../../core/errors/base_failure.dart';
import '../domain/entities/sponsors_edit_model.dart';

final class EditSponsorRepositoryImpl implements SponsorsEditRepository {
  final ApiService _apiService;

  EditSponsorRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, bool>> loadSponsors(
      {required SponsorsEditModel sponsorsEditModel}) async {
    try {
      final result = await _apiService.request(
        method: HttpMethod.patch,
        url: '/sponsors/update/${sponsorsEditModel.spoId}',
        body: {
          "eve_id": sponsorsEditModel.eveId,
          "spc_id": sponsorsEditModel.spcId,
          "spo_name": sponsorsEditModel.spoName,
          "spo_description": sponsorsEditModel.spoDescription,
          "spo_logo": sponsorsEditModel.spoLogo,
          "spo_url": sponsorsEditModel.spoUrl,
        },
      );

      if (result.resultType == ResultType.failure) {
        return Left(BaseFailure(message: 'Ruta inexistente.'));
      }

      if (result.resultType == ResultType.error) {
        return Left(BaseFailure(message: 'Hubo un error interno.'));
      }

      return const Right(true);
    } catch (e) {
      return Left(BaseFailure(message: '$e'));
    }
  }
}
