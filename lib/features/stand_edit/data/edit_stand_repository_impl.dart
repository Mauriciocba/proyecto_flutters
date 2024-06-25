import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/stand_edit/domain/entities/stands_edit_model.dart';
import 'package:pamphlets_management/features/stand_edit/domain/repositories/stand_edit_repository.dart';

import '../../../core/errors/base_failure.dart';

final class EditStandRepositoryImpl implements StandEditRepository {
  final ApiService _apiService;

  EditStandRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, StandsEditModel>> loadStands(
      {required StandsEditModel standEditModel}) async {
    try {
      final result = await _apiService.request(
        method: HttpMethod.patch,
        url: '/stands/update/${standEditModel.stdId}',
        body: {
          "std_name": standEditModel.stdName,
          "std_name_company": standEditModel.stdNameCompany,
          "std_description": standEditModel.stdDescription,
          "std_number": standEditModel.stdNumber,
          "std_referent": standEditModel.stdReferent,
          "std_startup": standEditModel.stdStartup,
          "std_logo": standEditModel.stdLogo,
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

      return Right(StandsEditModel(
        stdId: standEditModel.stdId,
        stdName: standEditModel.stdName,
        stdNameCompany: standEditModel.stdNameCompany,
        stdDescription: standEditModel.stdDescription,
        stdNumber: standEditModel.stdNumber,
        stdReferent: standEditModel.stdReferent,
        stdStartup: standEditModel.stdStartup,
        stdLogo: standEditModel.stdLogo,
      ));
    } catch (e) {
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
