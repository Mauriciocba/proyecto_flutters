import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/payment_date_model.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/payments_data_repository.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_payments_data_use_case.dart';

import 'mock_payments_data_repository.dart';

void main() {
  group('GetPaymentsDataUseCase', () {
    late GetPaymentsDataUseCase getPaymentsDataUseCase;
    late PaymentsDataRepository mockPaymentsDataRepository;

    setUp(() {
      mockPaymentsDataRepository = MockPaymentsDataRepository();
      getPaymentsDataUseCase = GetPaymentsDataUseCase(
          getPaymentDataRepository: mockPaymentsDataRepository);
    });

    test('should_return_right_when_repository_return_right', () async {
      final DateTime startDate = DateTime(2020, 1, 1);
      final DateTime endDate = DateTime(2025, 1, 31);
      final List<PaymentDateModel> paymentDates = [
        PaymentDateModel(
            eventId: 1,
            eveName: 'event 1',
            eveEnd: DateTime.now(),
            payments: [Payment(payType: 'evento', amountOfPayments: "6")]),
      ];

      when(() => mockPaymentsDataRepository.getPaymentData(
            startDate,
            endDate,
          )).thenAnswer((_) async => Right(paymentDates));

      final result = await getPaymentsDataUseCase(startDate, endDate);

      expect(result.isRight(), true);
    });

    test('should_return_left_when_repository_return_left', () async {
      final DateTime startDate = DateTime(2020, 1, 1);
      final DateTime endDate = DateTime(2025, 1, 31);
      final BaseFailure failure = BaseFailure(message: 'Error');

      when(() => mockPaymentsDataRepository.getPaymentData(
            startDate,
            endDate,
          )).thenAnswer((_) async => Left(failure));

      final result = await getPaymentsDataUseCase(startDate, endDate);

      expect(result.isLeft(), true);
    });
  });
}
