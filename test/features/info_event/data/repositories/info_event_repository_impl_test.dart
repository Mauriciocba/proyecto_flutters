import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/info_event/data/repositories/info_event_repository_impl.dart';

import '../../../../mock_api_service.dart';

void main() {
  group('info_event repository_impl', () {
    test(
      "should_return_left_when_api_service_returns_failure",
      () async {
        final mockApiService = MockApiService();

        when(
          () => mockApiService.request(
            method: HttpMethod.get,
            url: any(named: "url"),
          ),
        ).thenAnswer(
          (_) async => ApiResult.failure(
            statusCode: 400,
            body: {},
          ),
        );

        final infoEventRepositoryImpl =
            InfoEnventRepositoryImpl(apiService: mockApiService);

        final result = await infoEventRepositoryImpl.getInfoEvent(10);

        expect(result.isLeft(), true);
      },
    );

    test(
      'should_return_right_when_api_service_return_success',
      () async {
        final mockApiService = MockApiService();

        when(
          () => mockApiService.request(
            method: HttpMethod.get,
            url: any(named: "url"),
          ),
        ).thenAnswer(
          (_) async => ApiResult.success(statusCode: 200, body: {}),
        );

        final eventAllRepositoryImpl =
            InfoEnventRepositoryImpl(apiService: mockApiService);

        final response = await eventAllRepositoryImpl.getInfoEvent(10);

        expect(response.isRight(), true);
      },
    );
    test(
      'should_return_left_when_api_service_return_error',
      () async {
        final mockApiService = MockApiService();

        when(
          () => mockApiService.request(
            method: HttpMethod.get,
            url: any(named: 'url'),
          ),
        ).thenAnswer(
          (_) async => ApiResult.error(),
        );

        final eventAllRepositoryImpl =
            InfoEnventRepositoryImpl(apiService: mockApiService);

        final result = await eventAllRepositoryImpl.getInfoEvent(10);

        expect(result.isLeft(), true);
      },
    );

    test('should_return_left_when_api_service_throws_an_exception', () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.get,
          url: '/test',
        ),
      ).thenThrow(
        (_) async => throw Exception(),
      );

      final eventAllRepositoryImpl =
          InfoEnventRepositoryImpl(apiService: mockApiService);

      final result = await eventAllRepositoryImpl.getInfoEvent(10);

      expect(result.isLeft(), true);
    });
  });
}
