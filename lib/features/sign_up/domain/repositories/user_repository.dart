import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/sign_up/domain/entities/user.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class UserRepository {
  Future<Either<BaseFailure, User>> add({
    required String email,
    required String password,
  });
}
