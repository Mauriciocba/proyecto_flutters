import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/login/data/storage/credential_local_storage.dart';
import 'package:pamphlets_management/features/login/domain/entities/credential.dart';
import 'package:pamphlets_management/features/login/domain/repositories/credential_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class CredentialRepositoryImpl implements CredentialRepository {
  final ApiService _apiService;
  final CredentialLocalStorage _credentialLocalStorage;

  CredentialRepositoryImpl(this._apiService, this._credentialLocalStorage);

  @override
  Future<Either<BaseFailure, Credential>> getBy({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _apiService.request(
        method: HttpMethod.post,
        url: "/auth/login/admin",
        body: {
          'email': email,
          'password': password,
        },
      );

      if (result.resultType == ResultType.failure) {
        return Left(BaseFailure(message: result.body?['message']));
      }

      if (result.resultType == ResultType.error) {
        return Left(BaseFailure(
            message: result.body?['message'] ??
                'Sucedió un error, intente nuevamente'));
      }

      if (result.body?['statusCode'] == HttpStatus.unauthorized) {
        return Left(BaseFailure(
            message: result.body?['message'] ?? 'Cuenta no autorizada'));
      }

      final credential = Credential(
        token: result.body?['access_token'],
        refreshToken: result.body?["refreshToken"],
      );

      return Right(credential);
    } catch (e) {
      return Left(BaseFailure(message: 'Sucedió un error, intente nuevamente'));
    }
  }

  @override
  Future<Either<BaseFailure, bool>> save(Credential credential) async {
    try {
      _credentialLocalStorage.save(credential);
      return const Right(true);
    } catch (e) {
      return Left(BaseFailure(message: 'Sucedió un error, intente nuevamente'));
    }
  }

  @override
  Future<Either<BaseFailure, Credential>> read() async {
    try {
      final credentialSaved = await _credentialLocalStorage.read();
      return Right(credentialSaved);
    } catch (e) {
      return Left(BaseFailure(message: 'Sucedió un error, intente nuevamente'));
    }
  }
}
