import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/news_info/domain/entities/news_model.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../../../core/errors/base_failure.dart';
import '../repositories/news_info_repository.dart';

class GetNewsInfoUseCase {
  final NewsInfoRepository _newsInfoRepository;

  GetNewsInfoUseCase(this._newsInfoRepository);

  Future<Either<BaseFailure, List<NewsModel>>> call(int eventId) async {
    final failOrNewsInfo =
        await _newsInfoRepository.getNewsInfoByEvent(eventId: eventId);

    if (failOrNewsInfo.isLeft()) {
      return Left(failOrNewsInfo.getLeft());
    }

    if (failOrNewsInfo.getRight().isEmpty) {
      return Left(BaseFailure(message: "No hay Noticias"));
    }

    return Right(failOrNewsInfo.getRight());
  }
}
