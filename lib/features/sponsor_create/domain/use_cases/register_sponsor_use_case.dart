import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/sponsor_create/domain/entities/sponsors_create_model.dart';
import 'package:pamphlets_management/features/sponsor_create/domain/repositories/sponsors_create_repository.dart';

import '../../../../core/errors/base_failure.dart';

class RegisterSponsorUseCase {
  final SponsorCreateRepository _sponsorCreateRepository;

  RegisterSponsorUseCase(this._sponsorCreateRepository);

  Future<Either<BaseFailure, bool>> call(SponsorsCreateModel sponsors) async {
    if (sponsors.spoName.isEmpty) {
      return Left(BaseFailure(message: "Debe contener un nombre"));
    }

    final result = await _sponsorCreateRepository.save(sponsors);

    if (result.isLeft()) {
      return Left(BaseFailure(message: "No se pudo registrar el Sponsor"));
    }

    return const Right(true);
  }
}
