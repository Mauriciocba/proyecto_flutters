import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/login/domain/entities/credential.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class AuthService {
  Future<String> authenticate();
  Future<Either<BaseFailure, Credential>> login(String token);
}
