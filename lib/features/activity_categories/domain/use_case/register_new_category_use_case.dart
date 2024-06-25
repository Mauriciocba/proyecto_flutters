import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category_registration_form.dart';
import 'package:pamphlets_management/features/activity_categories/domain/repositories/register_category_repository.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../../../core/errors/base_failure.dart';

final class RegisterNewCategoryUseCase {
  final RegisterCategoryRepository _categoryRepository;

  RegisterNewCategoryUseCase(
      {required RegisterCategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository;

  Future<Either<BaseFailure, Category>> call(
    CategoryRegistrationForm categoryRegistrationForm,
  ) async {
    final failOrCategoryId =
        await _categoryRepository.save(categoryRegistrationForm);

    if (failOrCategoryId.isLeft()) {
      return Left(BaseFailure(message: failOrCategoryId.getLeft().message));
    }

    final savedCategory = Category(
      categoryId: failOrCategoryId.getRight(),
      name: categoryRegistrationForm.name,
      description: categoryRegistrationForm.description,
      color: categoryRegistrationForm.colorCode,
      iconName: categoryRegistrationForm.iconName,
      isActive: true,
      subCategory: null,
    );
    return Right(savedCategory);
  }
}
