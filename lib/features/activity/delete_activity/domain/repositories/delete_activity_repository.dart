import 'package:dartz/dartz.dart';

import '../../../../../core/errors/base_failure.dart';

abstract interface class DeleteActivityRepository {
  Future<Either<BaseFailure, bool>> deleteActivity(int activityId);
}
