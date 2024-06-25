import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/sponsor_edit/domain/entities/sponsors_edit_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class SponsorsEditRepository {
  Future<Either<BaseFailure, bool>> loadSponsors(
      {required SponsorsEditModel sponsorsEditModel});
}
