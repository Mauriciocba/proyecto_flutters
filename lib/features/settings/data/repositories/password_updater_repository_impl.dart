import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/settings/domain/repositories/password_updater_repository.dart';

final class PasswordUpdaterRepositoryImpl implements PasswordUpdaterRepository {
  final ApiService _apiService;

  PasswordUpdaterRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, String>> update(
      {required String currentPassword,
      required String newPassword,
      required String newPasswordConfirmed}) async {
    try {
      final response = await _apiService.request(
        method: HttpMethod.patch,
        url: '/user/update-password',
        body: {
          "oldPassword": currentPassword,
          "newPassword": newPassword,
          "newPasswordRepeat": newPasswordConfirmed,
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
