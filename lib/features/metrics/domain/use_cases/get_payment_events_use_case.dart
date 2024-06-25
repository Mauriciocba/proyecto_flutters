import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/payment_event_model.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/payment_events_repository.dart';

import '../../../../core/errors/base_failure.dart';

class GetPaymentEventsUseCase {
  final PaymentEventsRepository _getPaymentEventsRepository;

  GetPaymentEventsUseCase(
      {required PaymentEventsRepository getPaymentEventsRepository})
      : _getPaymentEventsRepository = getPaymentEventsRepository;

  Future<Either<BaseFailure, List<PaymentEventModel>>> call(
      DateTime? startDate, DateTime? endDate) async {
    return await _getPaymentEventsRepository.getPaymentEvents(
        startDate, endDate);
  }
}
