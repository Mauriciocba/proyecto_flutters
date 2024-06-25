import 'package:dartz/dartz.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/network/api_service.dart';
import '../../../core/errors/base_failure.dart';
import '../domain/repositories/delete_news_repository.dart';

class DeleteNewsRepositoryImpl implements DeleteNewsRepository {
  final ApiService apiService;

  DeleteNewsRepositoryImpl({required this.apiService});
  @override
  Future<Either<BaseFailure, bool>> deleteNewsInfo(int newsId) async {
    try {
      final result = await apiService.request(
          method: HttpMethod.patch, url: "/news/delete/$newsId");

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
