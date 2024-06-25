import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/activity_categories/domain/repositories/delete_category_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class DeleteCategoryUseCase {
  final DeleteCategoryRepository _deleteCategoryRepository;

  DeleteCategoryUseCase(this._deleteCategoryRepository);

  Future<Either<BaseFailure, void>> call(int categoryId) async {
    return await _deleteCategoryRepository.deleteBy(categoryId: categoryId);
  }
}
