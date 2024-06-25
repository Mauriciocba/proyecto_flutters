import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class DeleteEventRepository {
  Future<Either<BaseFailure, bool>> deleteInfoEvent(int eventId);
}
