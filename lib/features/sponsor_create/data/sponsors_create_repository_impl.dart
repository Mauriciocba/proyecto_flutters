import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/sponsor_create/domain/entities/sponsors_create_model.dart';
import 'package:pamphlets_management/features/sponsor_create/domain/repositories/sponsors_create_repository.dart';

import '../../../core/errors/base_failure.dart';

final class SponsorsCreateRepositoryImpl implements SponsorCreateRepository {
  final ApiService _apiService;

  SponsorsCreateRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, bool>> save(
      SponsorsCreateModel sponsorModel) async {
    try {
      final result = await _apiService.request(
        method: HttpMethod.post,
        url: '/sponsors/create',
        body: {
          "eve_id": sponsorModel.eveId,
          "spc_id": sponsorModel.spcId,
          "spo_name": sponsorModel.spoName,
          "spo_description": sponsorModel.spoDescription,
          "spo_logo": sponsorModel.spoLogo,
          "spo_url": sponsorModel.spoUrl
        },
      );

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
