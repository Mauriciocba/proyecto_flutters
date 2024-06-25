import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/news_info/domain/entities/news_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract class NewsInfoRepository {
  Future<Either<BaseFailure, List<NewsModel>>> getNewsInfoByEvent({
    required int eventId,
  });
}
