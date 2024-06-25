import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category_registration_form.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class UpdateCategoryRepository {
  Future<Either<BaseFailure, Category>> update({
    required int categoryId,
    required CategoryRegistrationForm newCategoryData,
  });
}
