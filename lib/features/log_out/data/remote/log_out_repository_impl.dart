import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/features/log_out/data/local/token_deleter.dart';
import 'package:pamphlets_management/features/log_out/domain/repositories/log_out_repository.dart';

import '../../../../core/errors/base_failure.dart';
import '../../../../core/network/api_service.dart';

class LogOutRepositoryImpl implements LogOutRepository {
  final ApiService _apiService;
  final TokenDeleter _deleteToken;

  LogOutRepositoryImpl(this._apiService, this._deleteToken);

  @override
  Future<Either<BaseFailure, bool>> logOut() async {
    try {
      final response = await _apiService.request(
          method: HttpMethod.post, url: '/auth/logout');

      if (response.resultType == ResultType.error) {
        return left(BaseFailure(message: 'No se pudo cerrar sesión'));
      }

      if (response.resultType == ResultType.failure) {
        return left(BaseFailure(message: 'No se pudo cerrar sesión'));
      }

      if (response.resultType == ResultType.success) {
        if (await _deleteToken.deleteToken() == false) {
          return left(BaseFailure(message: 'Hubo un error interno'));
        } else {
          return right(true);
        }
      }

      return right(true);
    } catch (e) {
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
