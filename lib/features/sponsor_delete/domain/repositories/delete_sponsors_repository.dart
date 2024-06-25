import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class DeleteSponsorsRepository {
  Future<Either<BaseFailure, bool>> deleteSponsorsInfo(int spoId);
}
