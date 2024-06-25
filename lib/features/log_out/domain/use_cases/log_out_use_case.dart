import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/log_out/domain/repositories/log_out_repository.dart';

import '../../../../core/errors/base_failure.dart';

class LogOutUseCase {
  final LogOutRepository _logOutRepository;

  LogOutUseCase({required LogOutRepository logOutRepository})
      : _logOutRepository = logOutRepository;

  Future<Either<BaseFailure, bool>> deleteToken() async {
    return await _logOutRepository.logOut();
  }
}
