import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/stand_create/domain/entities/stands_model.dart';
import 'package:pamphlets_management/features/stand_create/domain/repositories/stands_repository.dart';

import '../../../core/errors/base_failure.dart';

final class StandsCreateRepositoryImpl implements StandsCreateRepository {
  final ApiService _apiService;

  StandsCreateRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, bool>> save(StandsModel stands) async {
    try {
      final result = await _apiService
          .request(method: HttpMethod.post, url: '/stands/create', body: {
        "eve_id": stands.eveId,
        "std_name": stands.stdName,
        "std_name_company": stands.stdNameCompany,
        "std_description": stands.stdDescription,
        "std_number": stands.stdNumber,
        "std_referent": stands.stdReferent,
        "std_logo": stands.stdLogo,
        "std_startup": stands.stdStartup
      });

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
