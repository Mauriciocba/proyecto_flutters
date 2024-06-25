import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/forgot_password/domain/entities/validation_password.dart';
import 'package:pamphlets_management/features/forgot_password/domain/repositories/validation_password.dart';

final class ValidationPasswordRepositoryImpl implements ValidationPasswordRepository {
  final ApiService _apiService;

  ValidationPasswordRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, bool>> save(ValidationEmail validationEmail) async {
    try {
      final result = await _apiService.request(
        method: HttpMethod.post,
        url: '/forgot-password/sending-code',
        body: {
           "email": validationEmail.email
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
      return const Right(true);
    } catch (e) {
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
