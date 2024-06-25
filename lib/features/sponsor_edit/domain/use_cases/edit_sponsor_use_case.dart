import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/sponsor_edit/domain/entities/sponsors_edit_model.dart';
import 'package:pamphlets_management/features/sponsor_edit/domain/repositories/sponsor_edit_repository.dart';

import '../../../../core/errors/base_failure.dart';

class EditSponsorsUseCase {
  final SponsorsEditRepository _sponsorsEditRepository;

  EditSponsorsUseCase(this._sponsorsEditRepository);

  Future<Either<BaseFailure, bool>> call(
      {required SponsorsEditModel modelSponsors}) async {
    try {
      if (modelSponsors.spoName.isEmpty) {
        return Left(BaseFailure(message: "Nombre no puede ir vació"));
      }
      if (modelSponsors.spoDescription.isEmpty) {
        return Left(BaseFailure(message: "Descripción no puede ir vació"));
      }

      return await _sponsorsEditRepository.loadSponsors(
          sponsorsEditModel: modelSponsors);
    } catch (e) {
      return Left(BaseFailure(message: 'No se pudo editar'));
    }
  }
}
