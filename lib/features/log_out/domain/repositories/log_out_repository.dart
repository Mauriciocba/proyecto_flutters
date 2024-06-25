import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class LogOutRepository {
  Future<Either<BaseFailure, bool>> logOut();
}
