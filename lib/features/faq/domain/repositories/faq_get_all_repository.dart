import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/faq/domain/domain/faq.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class FaqGetAllRepository {
  Future<Either<BaseFailure, List<Faq>>> getAllByEvent(int eventId);
}
