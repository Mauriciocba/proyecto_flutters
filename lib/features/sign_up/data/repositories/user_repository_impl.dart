import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/sign_up/data/models/user_model_response.dart';
import 'package:pamphlets_management/features/sign_up/domain/entities/user.dart';
import 'package:pamphlets_management/features/sign_up/domain/repositories/user_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class UserRepositoryImpl implements UserRepository {
  final ApiService _apiService;

  UserRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, User>> add({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _apiService.request(
        method: HttpMethod.post,
        url: "/auth/signup",
        body: {
          "email": email,
          "password": password,
        },
      );

      if (result.resultType == ResultType.failure) {
        return Left(
            BaseFailure(message: 'Hubo una falla en la obtención de datos'));
      }

      if (result.resultType == ResultType.error) {
        return Left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }

      final userModelResponse = UserModelResponse.fromJson(result.body!);

      return Right(User(
        userId: userModelResponse.data.id,
        email: userModelResponse.data.email,
      ));
    } catch (e) {
      debugPrint(e.toString());
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
