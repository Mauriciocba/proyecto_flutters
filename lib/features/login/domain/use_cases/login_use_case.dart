import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/login/domain/entities/credential.dart';
import 'package:pamphlets_management/features/login/domain/repositories/credential_repository.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../../../core/errors/base_failure.dart';

final class LoginUseCase {
  final CredentialRepository _credentialRepository;

  LoginUseCase({required CredentialRepository credentialRepository})
      : _credentialRepository = credentialRepository;

  Future<Either<BaseFailure, bool>> call({
    required String email,
    required String password,
  }) async {
    final failOrCredential = await _credentialRepository.getBy(
      email: email,
      password: password,
    );

    if (failOrCredential.isLeft()) {
      return Left(failOrCredential.getLeft());
    }

    Credential newCredential = failOrCredential.getRight();

    if (newCredential.token.isEmpty) {
      return const Right(false);
    }

    if (newCredential.refreshToken.isEmpty) {
      return const Right(false);
    }

    final failOrSavedCredential =
        await _credentialRepository.save(newCredential);

    if (failOrSavedCredential.isLeft()) {
      return Left(failOrSavedCredential.getLeft());
    }

    return const Right(true);
  }
}
