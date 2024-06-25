import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class DeleteCategoryRepository {
  Future<Either<BaseFailure, void>> deleteBy({required int categoryId});
}
