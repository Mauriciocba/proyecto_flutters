import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class FaqImageDeleteRepository {
  Future<Either<BaseFailure, bool>> deleteBy(int faqImageId);
}
