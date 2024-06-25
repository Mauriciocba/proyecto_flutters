import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/metrics/data/payments_networking_repository_impl.dart';

import '../../../mock_api_service.dart';

void main() {
  group('PaymentsNetworkingRepositoryImpl', () {
    late ApiService mockApiService;
    late PaymentsNetworkingRepositoryImpl repository;

    setUp(() {
      mockApiService = MockApiService();
      repository = PaymentsNetworkingRepositoryImpl(apiService: mockApiService);
    });

    test("should_return_left_when_api_service_returns_error", () async {
      final DateTime startDate = DateTime(2024, 3, 1);
      final DateTime endDate = DateTime(2024, 3, 3);

      when(() => mockApiService.request(
            method: HttpMethod.get,
            url: any(named: "url"),
          )).thenAnswer((_) async => ApiResult.error());

      final result = await repository.getPaymentNetworking(startDate, endDate);

      expect(result.isLeft(), true);
    });

    test("should_return_left_when_response_body_is_null", () async {
      final DateTime startDate = DateTime(2024, 3, 1);
      final DateTime endDate = DateTime(2024, 3, 3);

      when(() => mockApiService.request(
            method: HttpMethod.get,
            url: any(named: "url"),
          )).thenAnswer((_) async => ApiResult.success(statusCode: 200));

      final result = await repository.getPaymentNetworking(startDate, endDate);

      expect(result.isLeft(), true);
    });

    test(
        "should_return_right_with_payment_networking_list_when_data_is_available",
        () async {
      final DateTime startDate = DateTime(2024, 3, 1);
      final DateTime endDate = DateTime(2024, 3, 3);

      final Map<String, dynamic> responseData = {
        "message": "Payments for networking",
        "statusCode": 200,
        "data": [
          {
            "eventId": 26,
            "eve_name": "test10",
            "eve_end": "2024-02-21T23:43:00.000Z",
            "payments": {"amount_of_payments": "0"}
          },
        ]
      };

      when(() => mockApiService.request(
                method: HttpMethod.get,
                url: any(named: "url"),
              ))
          .thenAnswer((_) async =>
              ApiResult.success(statusCode: 200, body: responseData));

      final result = await repository.getPaymentNetworking(startDate, endDate);

      expect(result.isRight(), true);
    });
  });
}
