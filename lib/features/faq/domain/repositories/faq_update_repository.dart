import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/faq/domain/domain/faq_form.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class FaqUpdateRepository {
  Future<Either<BaseFailure, String>> update(FaqForm newFaqData);
}
