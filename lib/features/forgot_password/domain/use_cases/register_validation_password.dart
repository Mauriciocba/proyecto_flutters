import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/forgot_password/domain/entities/validation_password.dart';
import 'package:pamphlets_management/features/forgot_password/domain/repositories/validation_password.dart';



class RegisterValidationPassword {
  final ValidationPasswordRepository _passwordRepository;

  RegisterValidationPassword(this._passwordRepository);

  Future<Either<BaseFailure, bool>> call(ValidationEmail validationEmail) async {
    if (validationEmail.email.isEmpty) {
      return Left(BaseFailure(message: "Debe ingresar su correo"));
    }

    final result = await _passwordRepository.save(validationEmail);

    if (result.isLeft()) {
      return Left(BaseFailure(message: "Hubo un error"));
    }

    return const Right(true);
  }
}
