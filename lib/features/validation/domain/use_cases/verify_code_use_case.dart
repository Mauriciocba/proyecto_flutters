import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/validation/domain/repositories/verify_code_repository.dart';

import '../../../../core/errors/base_failure.dart';

class GetVerifyCodeUseCase {
  final VerifyCodeRepository _verifyCodeRepository;

  GetVerifyCodeUseCase(this._verifyCodeRepository);

  Future<Either<BaseFailure, bool>> call(int userId, int code) async {
    return await _verifyCodeRepository.verifyCode(userId, code);
  }
}
