import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/payment_event_model.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/payment_events_repository.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_payment_events_use_case.dart';

import 'mock_payment_events_repository.dart';

void main() {
  group('GetPaymentEventsUseCase', () {
    late GetPaymentEventsUseCase getPaymentEventsUseCase;
    late PaymentEventsRepository mockPaymentEventsRepository;

    setUp(() {
      mockPaymentEventsRepository = MockPaymentEventsRepository();
      getPaymentEventsUseCase = GetPaymentEventsUseCase(
          getPaymentEventsRepository: mockPaymentEventsRepository);
    });

    test('should_return_right_when_repository_return_right', () async {
      final DateTime startDate = DateTime(2020, 1, 1);
      final DateTime endDate = DateTime(2025, 1, 31);
      final List<PaymentEventModel> paymentEvents = [
        PaymentEventModel(
            eventId: 1,
            eveEnd: DateTime.now(),
            eveName: "event 1",
            payments: Payments(amountOfPayments: "5")),
      ];

      when(() => mockPaymentEventsRepository.getPaymentEvents(
            startDate,
            endDate,
          )).thenAnswer((_) async => Right(paymentEvents));

      final result = await getPaymentEventsUseCase(startDate, endDate);

      expect(result.isRight(), true);
    });

    test('should_return_left_when_repository_return_left', () async {
      final DateTime startDate = DateTime(2020, 1, 1);
      final DateTime endDate = DateTime(2025, 1, 31);
      final BaseFailure failure = BaseFailure(message: 'Error');

      when(() => mockPaymentEventsRepository.getPaymentEvents(
            startDate,
            endDate,
          )).thenAnswer((_) async => Left(failure));

      final result = await getPaymentEventsUseCase(startDate, endDate);

      expect(result.isLeft(), true);
    });
  });
}
