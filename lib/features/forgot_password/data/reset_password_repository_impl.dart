import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/forgot_password/domain/repositories/reset_password_repository.dart';

final class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  final ApiService _apiService;

  ResetPasswordRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, String>> update(
      {
      required String newPassword,
      required String newPasswordConfirmed}) async {
    try {
      final response = await _apiService.request(
        method: HttpMethod.patch,
        url: '/user/update-password',
        body: {
           "newPassword": newPassword,
           "newPasswordRepeat": newPasswordConfirmed
        },
      );

      if (response.resultType == ResultType.error) {
        return Left(
          BaseFailure(message: "Hubo una falla al actualizar la contraseña"),
        );
      }

      if (response.resultType == ResultType.failure) {
        return Left(
          BaseFailure(message: "Hubo una falla al actualizar la contraseña"),
        );
      }

      if (response.body == null) {
        return Left(
          BaseFailure(message: "Hubo una falla al actualizar la contraseña"),
        );
      }

      if (response.body?['statusCode'] != HttpStatus.created) {
        return Left(
          BaseFailure(message: "Hubo una falla al actualizar la contraseña"),
        );
      }

      return const Right('Contraseña actualizada');
    } catch (e) {
      return Left(
        BaseFailure(message: "Hubo una falla al actualizar la contraseña"),
      );
    }
  }
}