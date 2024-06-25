import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/payment_event_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class PaymentEventsRepository {
  Future<Either<BaseFailure, List<PaymentEventModel>>> getPaymentEvents(
      DateTime? startDate, DateTime? endDate);
}
