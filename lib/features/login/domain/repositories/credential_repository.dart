import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/login/domain/entities/credential.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class CredentialRepository {
  Future<Either<BaseFailure, Credential>> getBy({
    required String email,
    required String password,
  });

  Future<Either<BaseFailure, bool>> save(Credential credential);

  Future<Either<BaseFailure, Credential>> read();
}
