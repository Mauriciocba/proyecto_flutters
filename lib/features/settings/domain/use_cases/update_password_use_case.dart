import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/settings/domain/repositories/password_updater_repository.dart';

final class UpdatePasswordUseCase {
  final PasswordUpdaterRepository _passwordUpdaterRepository;

  UpdatePasswordUseCase({
    required PasswordUpdaterRepository passwordUpdaterRepository,
  }) : _passwordUpdaterRepository = passwordUpdaterRepository;

  Future<Either<BaseFailure, String>> call({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmed,
  }) async {
    if (newPassword != newPasswordConfirmed) {
      return Left(BaseFailure(message: 'Las contraseñas no coincide'));
    }
    return await _passwordUpdaterRepository.update(
      currentPassword: currentPassword,
      newPassword: newPassword,
      newPasswordConfirmed: newPasswordConfirmed,
    );
  }
}
