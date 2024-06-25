import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';

abstract interface class ResetPasswordRepository {
  Future<Either<BaseFailure, String>> update({
    required String newPassword,
    required String newPasswordConfirmed,
  });
}
