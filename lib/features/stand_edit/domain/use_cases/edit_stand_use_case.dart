import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/stand_edit/domain/entities/stands_edit_model.dart';
import 'package:pamphlets_management/features/stand_edit/domain/repositories/stand_edit_repository.dart';

import '../../../../core/errors/base_failure.dart';

class EditStandsUseCase {
  final StandEditRepository _standEditRepository;

  EditStandsUseCase(this._standEditRepository);

  Future<Either<BaseFailure, StandsEditModel>> call(
      {required StandsEditModel modelStands}) async {
    try {
      if (modelStands.stdName.isEmpty) {
        return Left(BaseFailure(message: "Debe contener un nombre"));
      }
      if (modelStands.stdDescription.isEmpty) {
        return Left(BaseFailure(message: "Debe contener una descripción"));
      }
      if (modelStands.stdNameCompany.isEmpty) {
        return Left(
            BaseFailure(message: "Debe contener un nombre de compañía"));
      }

      return await _standEditRepository.loadStands(standEditModel: modelStands);
    } catch (e) {
      return Left(BaseFailure(message: 'No se pudo editar'));
    }
  }
}
