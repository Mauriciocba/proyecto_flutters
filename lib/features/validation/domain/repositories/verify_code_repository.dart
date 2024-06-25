import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class VerifyCodeRepository {
  Future<Either<BaseFailure, bool>> verifyCode(int userId, int code);
}
