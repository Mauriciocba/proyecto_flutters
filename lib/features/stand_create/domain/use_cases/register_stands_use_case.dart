import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/stand_create/domain/entities/stands_model.dart';
import 'package:pamphlets_management/features/stand_create/domain/repositories/stands_repository.dart';

import '../../../../core/errors/base_failure.dart';

class RegisterStandsUseCase {
  final StandsCreateRepository _standsCreateRepository;

  RegisterStandsUseCase(this._standsCreateRepository);

  Future<Either<BaseFailure, bool>> call(StandsModel stands) async {
    if (stands.stdName.isEmpty) {
      return Left(BaseFailure(message: "Debe contener un nombre"));
    }

    final result = await _standsCreateRepository.save(stands);

    if (result.isLeft()) {
      return Left(BaseFailure(message: "No se pudo registrar el stand"));
    }

    return const Right(true);
  }
}
