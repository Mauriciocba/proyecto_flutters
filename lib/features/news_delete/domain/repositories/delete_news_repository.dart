import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class DeleteNewsRepository {
  Future<Either<BaseFailure, bool>> deleteNewsInfo(int newsId);
}
