import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_register_form.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class SponsorCategoryCreateRepository {
  Future<Either<BaseFailure, int>> save(
      SponsorsCategoryRegistrationForm spcModel);
}
