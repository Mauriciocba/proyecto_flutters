import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/sign_up/domain/repositories/user_repository.dart';
import 'package:pamphlets_management/utils/extensions/strings_validations_extension.dart';

import '../../../../core/errors/base_failure.dart';

final class SignUpUseCase {
  final UserRepository _userRepository;
  SignUpUseCase({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<Either<BaseFailure, bool>> call({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty || !email.isEmail()) {
        return Left(BaseFailure(message: 'Email no es valido'));
      }

      if (password.isEmpty || !password.isPasswordGreaterThan7digits()) {
        return Left(BaseFailure(message: 'La contraseña no es valida'));
      }

      final failOrUser = await _userRepository.add(
        email: email,
        password: password,
      );

      if (failOrUser.isLeft()) {
        return left(BaseFailure(message: 'Falló la creación de la cuenta'));
      }
      return const Right(true);
    } catch (e) {
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
