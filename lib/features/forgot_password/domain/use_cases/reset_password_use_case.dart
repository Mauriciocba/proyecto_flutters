import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/forgot_password/domain/repositories/reset_password_repository.dart';

final class ResetPasswordUseCase {
  final ResetPasswordRepository _resetPasswordRepository;

  ResetPasswordUseCase({required ResetPasswordRepository resetPasswordRepository}) : _resetPasswordRepository = resetPasswordRepository;

  Future<Either<BaseFailure, String>> call({
    required String newPassword,
    required String newPasswordConfirmed,
  }) async {
    if (newPassword != newPasswordConfirmed) {
      return Left(BaseFailure(message: 'Las contraseñas no coincide'));
    }
    return await _resetPasswordRepository.update(
      newPassword: newPassword,
      newPasswordConfirmed: newPasswordConfirmed,
    );
  }
}