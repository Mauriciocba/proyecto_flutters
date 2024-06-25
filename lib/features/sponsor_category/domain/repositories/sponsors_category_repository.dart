import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract class SponsorsCategoryRepository {
  Future<Either<BaseFailure, List<SponsorsCategoryModel>>> getEventID(
      {required int eventId});
}
