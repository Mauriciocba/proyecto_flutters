import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class SponsorsCategoryDeleteRepository {
  Future<Either<BaseFailure, bool>> deleteSponsorsCategory(int spcId);
}
