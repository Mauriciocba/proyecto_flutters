import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/payment_networking_model.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/payments_networking_repository.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_payments_networking_use_case.dart';

import 'mock_payments_networking_repository.dart';

void main() {
  group('GetPaymentsNetworkingUseCase', () {
    late GetPaymentsNetworkingUseCase getPaymentsNetworkingUseCase;
    late PaymentsNetworkingRepository mockPaymentsNetworkingRepository;

    setUp(() {
      mockPaymentsNetworkingRepository = MockPaymentsNetworkingRepository();
      getPaymentsNetworkingUseCase = GetPaymentsNetworkingUseCase(
          paymentsNetworkingRepository: mockPaymentsNetworkingRepository);
    });

    test('should_return_right_when_repository_return_right', () async {
      final DateTime startDate = DateTime(2020, 1, 1);
      final DateTime endDate = DateTime(2025, 1, 31);
      final List<PaymentNetworkingModel> paymentNetworkingModels = [
        PaymentNetworkingModel(
            eventId: 1,
            eveName: 'Event 1',
            eveEnd: DateTime.now(),
            payments: Payments(amountOfPayments: "5")),
      ];

      when(() => mockPaymentsNetworkingRepository.getPaymentNetworking(
            startDate,
            endDate,
          )).thenAnswer((_) async => Right(paymentNetworkingModels));

      final result = await getPaymentsNetworkingUseCase(startDate, endDate);

      expect(result.isRight(), true);
    });

    test('should_return_left_when_repository_return_left', () async {
      final DateTime startDate = DateTime(2020, 1, 1);
      final DateTime endDate = DateTime(2025, 1, 31);
      final BaseFailure failure = BaseFailure(message: 'Error');

      when(() => mockPaymentsNetworkingRepository.getPaymentNetworking(
            startDate,
            endDate,
          )).thenAnswer((_) async => Left(failure));

      final result = await getPaymentsNetworkingUseCase(startDate, endDate);

      expect(result.isLeft(), true);
    });
  });
}
