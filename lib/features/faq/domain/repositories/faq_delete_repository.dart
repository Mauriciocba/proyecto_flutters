import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class FaqDeleteRepository {
  Future<Either<BaseFailure, bool>> deleteBy({required int faqId});
}
