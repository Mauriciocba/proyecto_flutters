import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/login/domain/repositories/credential_repository.dart';
import 'package:pamphlets_management/features/login/domain/service/auth_service.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../../../core/errors/base_failure.dart';

final class LoginByGoogleUseCase {
  LoginByGoogleUseCase({
    required AuthService externalAuthService,
    required CredentialRepository credentialRepository,
  })  : _externalAuthService = externalAuthService,
        _credentialRepository = credentialRepository;
  final AuthService _externalAuthService;
  final CredentialRepository _credentialRepository;

  Future<Either<BaseFailure, bool>> call() async {
    try {
      final codeAccess = await _externalAuthService.authenticate();
      final failOrCredential = await _externalAuthService.login(codeAccess);

      if (failOrCredential.isLeft()) {
        return Left(BaseFailure(message: failOrCredential.getLeft().message));
      }

      final newCredential = failOrCredential.getRight();

      if (newCredential.token.isEmpty) {
        return const Right(false);
      }

      if (newCredential.refreshToken.isEmpty) {
        return const Right(false);
      }

      final failOrSavedCredential =
          await _credentialRepository.save(newCredential);

      if (failOrSavedCredential.isLeft()) {
        return Left(
          BaseFailure(message: 'No se pudo completar su autenticación!'),
        );
      }

      return const Right(true);
    } catch (e) {
      return Left(
        BaseFailure(message: 'No se pudo completar su autenticación'),
      );
    }
  }
}
