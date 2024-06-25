import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/metrics/data/logins_events_metrics_repository_impl.dart';

import '../../../mock_api_service.dart';

void main() {
  group('LoginsEventsMetricsImpl', () {
    late ApiService mockApiService;
    late LoginsEventsMetricsImpl repository;

    setUp(() {
      mockApiService = MockApiService();
      repository = LoginsEventsMetricsImpl(apiService: mockApiService);
    });

    test("should_return_left_when_api_service_returns_error", () async {
      final DateTime startDate = DateTime(2024, 3, 1);
      final DateTime endDate = DateTime(2024, 3, 3);

      when(() => mockApiService.request(
            method: HttpMethod.get,
            url: any(named: "url"),
          )).thenAnswer((_) async => ApiResult.error());

      final result =
          await repository.getLoginsEventsMetrics(startDate, endDate);

      expect(result.isLeft(), true);
    });

    test("should_return_left_when_response_body_is_null", () async {
      final DateTime startDate = DateTime(2024, 3, 1);
      final DateTime endDate = DateTime(2024, 3, 3);

      when(() => mockApiService.request(
            method: HttpMethod.get,
            url: any(named: "url"),
          )).thenAnswer((_) async => ApiResult.success(statusCode: 200));

      final result =
          await repository.getLoginsEventsMetrics(startDate, endDate);

      expect(result.isLeft(), true);
    });

    test("should_return_right_with_empty_list_when_data_is_null", () async {
      final DateTime startDate = DateTime(2024, 3, 1);
      final DateTime endDate = DateTime(2024, 3, 3);

      final Map<String, dynamic> responseData = {
        'message': 'User Tracking Metrics',
        'statusCode': 200,
        'data': null, // No hay datos disponibles
      };

      when(() => mockApiService.request(
                method: HttpMethod.get,
                url: any(named: "url"),
              ))
          .thenAnswer((_) async =>
              ApiResult.success(statusCode: 200, body: responseData));

      final result =
          await repository.getLoginsEventsMetrics(startDate, endDate);

      expect(result.isRight(), true);
    });

    test("should_return_right_with_metrics_list_when_data_is_available",
        () async {
      final DateTime startDate = DateTime(2024, 3, 1);
      final DateTime endDate = DateTime(2024, 3, 3);

      final Map<String, dynamic> responseData = {
        "message": "Logins per Events",
        "statusCode": 200,
        "data": [
          {
            "logins": {
              "eve_name": "test1",
              "eve_end": "2024-02-14T14:34:00.000Z",
              "eve_id": 2,
              "logins_per_event": "1"
            }
          },
          {
            "logins": {
              "eve_name": "test7",
              "eve_end": "2024-02-15T01:55:00.000Z",
              "eve_id": 16,
              "logins_per_event": "2"
            }
          },
        ]
      };

      when(() => mockApiService.request(
                method: HttpMethod.get,
                url: any(named: "url"),
              ))
          .thenAnswer((_) async =>
              ApiResult.success(statusCode: 200, body: responseData));

      final result =
          await repository.getLoginsEventsMetrics(startDate, endDate);

      expect(result.isRight(), true);
    });
  });
}
