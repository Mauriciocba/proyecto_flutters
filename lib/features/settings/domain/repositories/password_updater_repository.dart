import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';

abstract interface class PasswordUpdaterRepository {
  Future<Either<BaseFailure, String>> update({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmed,
  });
}
