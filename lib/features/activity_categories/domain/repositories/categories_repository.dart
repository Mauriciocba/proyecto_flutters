import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class CategoriesRepository {
  Future<Either<BaseFailure, List<Category>>> getAllByEvent(int eventId);
}
