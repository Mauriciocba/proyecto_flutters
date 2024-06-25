import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/news_create/domain/entities/news_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class NewsRepository {
  Future<Either<BaseFailure, bool>> save(NewsModel news);
}
