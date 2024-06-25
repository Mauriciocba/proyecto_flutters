import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/news_create/domain/entities/news_model.dart';
import 'package:pamphlets_management/features/news_create/domain/repositories/news_repository.dart';

import '../../../../core/errors/base_failure.dart';

class RegisterNewsUseCase {
  final NewsRepository _newsRepository;

  RegisterNewsUseCase(this._newsRepository);

  Future<Either<BaseFailure, bool>> call(NewsModel news) async {
    if (news.newArticle.isEmpty) {
      return Left(BaseFailure(message: "Debe contener un nombre"));
    }

    final result = await _newsRepository.save(news);

    if (result.isLeft()) {
      return Left(BaseFailure(message: "No se pudo registrar la noticia"));
    }

    return const Right(true);
  }
}
