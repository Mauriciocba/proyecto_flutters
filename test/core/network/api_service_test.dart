import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';

import 'mock_dio.dart';

/// TEST CASES
/// 1 - Debe devolver Success cuando la solicitud de GET sea 200
/// 2 - Debe devolver un Failure cuando la solicitud de GET no sea 200
/// 3 - Debe devolver un Error cuando no se pueda completar la solicitud GET
/// 4 - Debe llamarse al método get cuando el método  http es GET

void main() {
  group(
    "api_service_class",
    () {
      late Dio dio;

      setUpAll(() {
        registerFallbackValue(MockDio());
        dio = Dio();
      });

      test(
        'should_return_success_when_the_get_request_is_200',
        () async {
          final dioAdapter = DioAdapter(dio: dio);

          dioAdapter.onGet('/test', (server) {
            server.reply(200, {'message': 'Successful mocked GET!'});
          });

          final apiService = ApiService(dio);

          final result = await apiService.request(
            method: HttpMethod.get,
            url: '/test',
            body: null,
          );

          expect(result.resultType, equals(ResultType.success));
        },
      );

      test(
        'should_return_failure_when_the_get_request_is_not_200',
        () async {
          final dioAdapter = DioAdapter(dio: dio);
          dioAdapter.onGet(
              '/test', (server) => server.reply(400, {'data': 'value'}));

          final apiService = ApiService(dio);

          final result = await apiService.request(
            method: HttpMethod.get,
            url: '/test',
          );

          expect(result.resultType, equals(ResultType.failure));
        },
      );

      test(
        'should_return_an_error_when_the_request_cannot_be_completed',
        () async {
          final mockDio = MockDio();

          when(() => mockDio.get(any())).thenAnswer(
            (_) async => throw Exception("Algo fallo, intente nuevamente"),
          );

          final apiService = ApiService(mockDio);

          final result = await apiService.request(
            method: HttpMethod.get,
            url: '/test',
          );

          expect(result.resultType, equals(ResultType.error));
        },
      );

      test(
        'should_call_get_method_when_http_method_is_get',
        () async {
          final dioAdapter = DioAdapter(dio: dio);
          final apiService = ApiService(dio);
          dioAdapter.onGet(
            "/test",
            (server) => server.reply(200, {'message': "Get"}),
          );

          await apiService.request(method: HttpMethod.get, url: '/test');

          expect(dioAdapter.requestMatcher.request.method?.name, equals("GET"));
        },
      );
    },
  );
}
