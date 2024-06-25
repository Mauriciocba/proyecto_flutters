import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/validation/domain/repositories/verify_code_repository.dart';

import '../../../../core/errors/base_failure.dart';

class VerifyCodeRepositoryImpl implements VerifyCodeRepository {
  final ApiService _apiService;

  VerifyCodeRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, bool>> verifyCode(int userId, int code) async {
    try {
      final response = await _apiService.request(
          method: HttpMethod.post,
          url: '/email/validate-email/$userId',
          body: {"verificationCode": code});
      if (response.resultType == ResultType.error) {
        return left(response.body?['message']);
      }
      if (response.resultType == ResultType.failure) {
        return left(response.body?['message']);
      }

      return right(true);
    } catch (e) {
      return left(BaseFailure(message: 'Hubo un error interno'));
    }
  }
}
