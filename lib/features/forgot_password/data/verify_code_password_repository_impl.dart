
import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/forgot_password/domain/repositories/verify_code_password_repository.dart';

class VerifyCodePasswordRepositoryImpl implements VerifyCodePasswordRepository {
  final ApiService _apiService;

  VerifyCodePasswordRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, bool>> verifyCode(int user,int code) async {
    try {
      final response = await _apiService.request(
          method: HttpMethod.patch,
          url: '/forgot-password/codeActivation/$user',
          body: {"verificationCode": code}
          );


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
