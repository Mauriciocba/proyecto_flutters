import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/metrics/data/payments_data_repository_impl.dart';

import '../../../mock_api_service.dart';

void main() {
  group('PaymentDataRepositoryImpl', () {
    late ApiService mockApiService;
    late PaymentDataRepositoryImpl repository;

    setUp(() {
      mockApiService = MockApiService();
      repository = PaymentDataRepositoryImpl(apiService: mockApiService);
    });

    test("should_return_left_when_api_service_returns_error", () async {
      final DateTime startDate = DateTime(2024, 3, 1);
      final DateTime endDate = DateTime(2024, 3, 3);

      when(() => mockApiService.request(
            method: HttpMethod.get,
            url: any(named: "url"),
          )).thenAnswer((_) async => ApiResult.error());

      final result = await repository.getPaymentData(startDate, endDate);

      expect(result.isLeft(), true);
    });

    test("should_return_left_when_response_body_is_null", () async {
      final DateTime startDate = DateTime(2024, 3, 1);
      final DateTime endDate = DateTime(2024, 3, 3);

      when(() => mockApiService.request(
            method: HttpMethod.get,
            url: any(named: "url"),
          )).thenAnswer((_) async => ApiResult.success(statusCode: 200));

      final result = await repository.getPaymentData(startDate, endDate);

      expect(result.isLeft(), true);
    });

    test("should_return_right_with_payment_data_list_when_data_is_available",
        () async {
      final DateTime startDate = DateTime(2020, 3, 1);
      final DateTime endDate = DateTime(2024, 3, 3);

      final Map<String, dynamic> responseData = {
        "message": "Payments for user",
        "statusCode": 200,
        "data": [
          {
            "eventId": 35,
            "eve_name": "test12",
            "eve_end": "2024-02-27T10:57:00.000Z",
            "payments": []
          },
          {
            "eventId": 36,
            "eve_name": "test14",
            "eve_end": "2024-02-27T14:06:00.000Z",
            "payments": [
              {"pay_type": "evento", "amount_of_payments": "2"},
              {"pay_type": "networking", "amount_of_payments": "1"}
            ]
          }
        ]
      };

      when(() => mockApiService.request(
                method: HttpMethod.get,
                url: any(named: "url"),
              ))
          .thenAnswer((_) async =>
              ApiResult.success(statusCode: 200, body: responseData));

      final result = await repository.getPaymentData(startDate, endDate);

      expect(result.isRight(), true);
    });
  });
}
