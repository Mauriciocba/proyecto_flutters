import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/forgot_password/domain/repositories/verify_code_password_repository.dart';

class VerifyCodePasswordUseCase {
  final VerifyCodePasswordRepository _codePasswordRepository;

  VerifyCodePasswordUseCase(this._codePasswordRepository);

  Future<Either<BaseFailure, bool>> call(int user,int code) async {
    return await _codePasswordRepository.verifyCode(user,code);
  }
}
