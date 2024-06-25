import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/sponsor_create/domain/entities/sponsors_create_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class SponsorCreateRepository {
  Future<Either<BaseFailure, bool>> save(SponsorsCreateModel modelSponsors);
}
