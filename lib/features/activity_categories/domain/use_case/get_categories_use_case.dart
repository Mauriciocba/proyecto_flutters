import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/domain/repositories/categories_repository.dart';

import '../../../../core/errors/base_failure.dart';

class GetCategoriesUseCase {
  final CategoriesRepository _categoriesRepository;

  GetCategoriesUseCase({required CategoriesRepository categoriesRepository})
      : _categoriesRepository = categoriesRepository;

  Future<Either<BaseFailure, List<Category>>> call() async {
    return _categoriesRepository.getAllByEvent(1);
  }
}
