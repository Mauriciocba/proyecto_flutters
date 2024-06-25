import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/metrics/data/activity_metrics_repository_impl.dart';

import '../../../mock_api_service.dart';

class MockActivityMetricsRepositoryImpl extends Mock
    implements ActivityMetricsRepositoryImpl {}

void main() {
  group('ActivityMetricsRepositoryImpl', () {
    late ApiService mockApiService;
    late ActivityMetricsRepositoryImpl repository;

    setUp(() {
      mockApiService = MockApiService();
      repository = ActivityMetricsRepositoryImpl(apiService: mockApiService);
    });

    test("should_return_left_when_api_service_returns_error", () async {
      const int eventId =
          1; // Acá puse evento que no existe, para así probar mejor el test
      final DateTime startDate = DateTime(2024, 3, 1);
      final DateTime endDate = DateTime(2024, 3, 3);

      when(() => mockApiService.request(
            method: HttpMethod.get,
            url: any(named: "url"),
          )).thenAnswer((_) async => ApiResult.error());

      final result =
          await repository.getActivityMetrics(eventId, startDate, endDate);

      expect(result.isLeft(), true);
    });

    test("should_return_left_when_response_body_is_null", () async {
      const int eventId =
          1; // Acá puse evento que no existe, para así probar mejor el test
      final DateTime startDate = DateTime(2024, 3, 1);
      final DateTime endDate = DateTime(2024, 3, 3);

      when(() => mockApiService.request(
            method: HttpMethod.get,
            url: any(named: "url"),
          )).thenAnswer((_) async => ApiResult.success(statusCode: 200));

      final result =
          await repository.getActivityMetrics(eventId, startDate, endDate);

      expect(result.isLeft(), true);
    });

    test("should_return_right_with_empty_list_when_event_does_not_exist",
        () async {
      const int eventId =
          1; // Acá puse evento que no existe, para así probar mejor el test
      final DateTime startDate = DateTime(2020, 3, 1);
      final DateTime endDate = DateTime(2024, 3, 3);

      final Map<String, dynamic> responseData = {
        "message": "Attendees per Activity",
        "statusCode": 401,
        'data': null,
      };

      when(() => mockApiService.request(
                method: HttpMethod.get,
                url: any(named: "url"),
              ))
          .thenAnswer((_) async =>
              ApiResult.success(statusCode: 401, body: responseData));

      final result =
          await repository.getActivityMetrics(eventId, startDate, endDate);

      expect(result.isRight(), true);
      expect(result.getOrElse(() => []), isEmpty);
    });

    test("should_return_right_with_activity_metrics_when_event_exists",
        () async {
      const int eventId =
          36; // Puse 36 por que es un evento que si existe. Para así probar bien este test
      const DateTime? startDate = null;
      const DateTime? endDate = null;

      final Map<String, dynamic> responseData = {
        "message": "Attendees per Activity",
        "statusCode": 200,
        "data": [
          {
            "act_id": 30,
            "act_name": "Nuevas Tendencias prueba eliminacion",
            "registros_actividad": "1"
          }
        ]
      };

      when(() => mockApiService.request(
                method: HttpMethod.get,
                url: any(named: "url"),
              ))
          .thenAnswer((_) async =>
              ApiResult.success(statusCode: 200, body: responseData));

      final result =
          await repository.getActivityMetrics(eventId, startDate, endDate);

      expect(result.isRight(), true);
    });
  });
}
