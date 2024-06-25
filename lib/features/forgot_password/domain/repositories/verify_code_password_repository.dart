import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';

abstract interface class VerifyCodePasswordRepository {
  Future<Either<BaseFailure, bool>> verifyCode(int user,int code);
}
