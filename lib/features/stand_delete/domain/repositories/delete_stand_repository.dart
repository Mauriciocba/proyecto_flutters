import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class DeleteStandRepository {
  Future<Either<BaseFailure, bool>> deleteStandInfo(int stdId);
}
