import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/faq/domain/domain/faq.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class FaqRepository {
  Future<Either<BaseFailure, Faq>> saveFaqByEvent({
    required String question,
    required String answer,
    required int eventId,
  });
}
