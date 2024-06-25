import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/forgot_password/domain/entities/validation_password.dart';


abstract interface class ValidationPasswordRepository {
  Future<Either<BaseFailure, bool>> save(ValidationEmail validationEmail);
}
