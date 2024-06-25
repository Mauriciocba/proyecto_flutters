import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/stand_create/domain/entities/stands_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class StandsCreateRepository {
  Future<Either<BaseFailure, bool>> save(StandsModel stands);
}
