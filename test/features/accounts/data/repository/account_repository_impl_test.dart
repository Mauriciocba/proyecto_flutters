import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/accounts/data/repository/account_repository_impl.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../../../mock_api_service.dart';

void main() {
  group('AccountRepositoryImpl', () {
    test(
      'should_return_left_when_api_service_throws_exception',
      () async {
        final mockApiService = MockApiService();

        when(
          () => mockApiService.request(
            method: HttpMethod.get,
            url: any(named: "url"),
          ),
        ).thenThrow(Exception());

        final accountRepository = AccountRepositoryImpl(
          apiService: mockApiService,
        );

        final result = await accountRepository.getAllByEvent(eventId: 2);

        expect(result.isLeft(), true);
      },
    );

    test('should_return_left_when_api_service_responds_with_ApiResult.failure',
        () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.get,
          url: any(named: 'url'),
        ),
      ).thenAnswer(
        (invocation) async => ApiResult.failure(),
      );

      final accountRepository = AccountRepositoryImpl(
        apiService: mockApiService,
      );

      final result = await accountRepository.getAllByEvent(eventId: 2);

      expect(result.isLeft(), true);
    });

    test('should_return_left_when_api_service_responds_with_ApiResult.error',
        () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.get,
          url: any(named: 'url'),
        ),
      ).thenAnswer(
        (invocation) async => ApiResult.error(),
      );

      final accountRepository = AccountRepositoryImpl(
        apiService: mockApiService,
      );

      final result = await accountRepository.getAllByEvent(eventId: 2);

      expect(result.isLeft(), true);
    });

    test('should_return_right_when_api_service_responds_with_ApiResult.success',
        () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.get,
          url: any(named: 'url'),
        ),
      ).thenAnswer(
        (invocation) async => ApiResult.success(body: {
          "message": "List of users by event",
          "statusCode": 200,
          "data": [
            {
              "usr_id": 3,
              "name": "jais, elias",
              "company": "",
              "rol": "CEO",
              "photo": null
            },
            {
              "usr_id": 4,
              "name": "jais, elias",
              "company": "",
              "rol": "empleado",
              "photo": null
            }
          ]
        }),
      );

      final accountRepository = AccountRepositoryImpl(
        apiService: mockApiService,
      );

      final result = await accountRepository.getAllByEvent(eventId: 2);

      expect(result.isRight(), true);
    });

    test(
        'should_return_list_of_accounts_when_api_service_responds_with_ApiResult.success',
        () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.get,
          url: any(named: 'url'),
        ),
      ).thenAnswer(
        (invocation) async => ApiResult.success(body: {
          "message": "List of users by event",
          "statusCode": 200,
          "data": [
            {
              "usr_id": 3,
              "name": "jais, elias",
              "company": "",
              "rol": "CEO",
              "photo": null
            },
            {
              "usr_id": 4,
              "name": "jais, elias",
              "company": "",
              "rol": "empleado",
              "photo": null
            }
          ]
        }),
      );

      final accountRepository = AccountRepositoryImpl(
        apiService: mockApiService,
      );

      final result = await accountRepository.getAllByEvent(eventId: 2);

      final accounts = result.getRight();

      expect(accounts.isNotEmpty, true);
    });

    test('should_return_empty_list_when_api_service_responds_with_204',
        () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.get,
          url: any(named: 'url'),
        ),
      ).thenAnswer(
        (invocation) async => ApiResult.success(body: {
          "message": "List of users by event",
          "statusCode": 204,
        }),
      );

      final accountRepository = AccountRepositoryImpl(
        apiService: mockApiService,
      );

      final result = await accountRepository.getAllByEvent(eventId: 2);

      final accounts = result.getRight();

      expect(accounts.isEmpty, true);
    });
  });
}
