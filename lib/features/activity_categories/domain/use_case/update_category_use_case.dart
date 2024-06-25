import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category_registration_form.dart';
import 'package:pamphlets_management/features/activity_categories/domain/repositories/update_category_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class UpdateCategoryUseCase {
  final UpdateCategoryRepository _updateCategoryRepository;

  UpdateCategoryUseCase(this._updateCategoryRepository);

  Future<Either<BaseFailure, Category>> call({
    required int categoryId,
    required CategoryRegistrationForm newCategoryData,
  }) async {
    return await _updateCategoryRepository.update(
      categoryId: categoryId,
      newCategoryData: newCategoryData,
    );
  }
}
