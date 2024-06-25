import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';
import '../repositories/delete_news_repository.dart';

class DeleteNewsUseCase {
  final DeleteNewsRepository _deleteNewsRepository;

  DeleteNewsUseCase(this._deleteNewsRepository);

  Future<Either<BaseFailure, bool>> call(int newsId) async {
    try {
      return await _deleteNewsRepository.deleteNewsInfo(newsId);
    } catch (e) {
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
