import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/login/data/repositories/credential_repository_impl.dart';
import 'package:pamphlets_management/features/login/domain/entities/credential.dart';

import '../../../../mock_api_service.dart';
import 'mock_credential_local_storage.dart';

void main() {
  group("CredentialRepositoryImplClass", () {
    test(
      "should_return_left_when_api_service_returns_failure",
      () async {
        final mockApiService = MockApiService();

        when(
          () => mockApiService.request(
            method: HttpMethod.post,
            url: any(named: "url"),
            body: any(named: "body"),
          ),
        ).thenAnswer(
          (_) async => ApiResult.failure(
            statusCode: 400,
            body: {},
          ),
        );

        final credentialRepositoryImpl = CredentialRepositoryImpl(
            mockApiService, MockCredentialLocalStorage());

        final result = await credentialRepositoryImpl.getBy(
          email: 'test@mail.com',
          password: '12345678',
        );

        expect(result.isLeft(), true);
      },
    );

    test(
      'should_return_right_when_api_service_return_success',
      () async {
        final mockApiService = MockApiService();

        when(
          () => mockApiService.request(
            method: HttpMethod.post,
            url: any(named: "url"),
            body: any(named: "body"),
          ),
        ).thenAnswer(
          (_) async => ApiResult.success(
            statusCode: 200,
            body: {
              "access_token": "valid_token",
              "refreshToken": "valid_token}"
            },
          ),
        );

        final repository = CredentialRepositoryImpl(
          mockApiService,
          MockCredentialLocalStorage(),
        );

        final response = await repository.getBy(
          email: 'test@mail.com',
          password: '12345678',
        );

        expect(response.isRight(), true);
      },
    );

    test(
      'should_return_left_when_api_service_return_success_and_body_is_invalid',
      () async {
        final mockApiService = MockApiService();

        when(
          () => mockApiService.request(
            method: HttpMethod.post,
            url: '/test',
          ),
        ).thenAnswer(
          (_) async => ApiResult.success(
            statusCode: 200,
            body: {"formate invalid": "invalid"},
          ),
        );

        final repository = CredentialRepositoryImpl(
          mockApiService,
          MockCredentialLocalStorage(),
        );

        final response = await repository.getBy(
          email: 'test@mail.com',
          password: '12345678',
        );

        expect(response.isLeft(), true);
      },
    );

    test('should_return_left_when_api_service_throws_an_exception', () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.post,
          url: '/test',
        ),
      ).thenThrow(
        (_) async => throw Exception(),
      );

      final credentialRepositoryImpl = CredentialRepositoryImpl(
        mockApiService,
        MockCredentialLocalStorage(),
      );

      final result = await credentialRepositoryImpl.getBy(
        email: 'test@mail.com',
        password: '12345678',
      );

      expect(result.isLeft(), true);
    });

    test(
      'should_return_left_when_api_service_return_error',
      () async {
        final mockApiService = MockApiService();

        when(
          () => mockApiService.request(
            method: HttpMethod.post,
            url: any(named: 'url'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => ApiResult.error(),
        );

        final credentialRepositoryImpl = CredentialRepositoryImpl(
          mockApiService,
          MockCredentialLocalStorage(),
        );

        final result = await credentialRepositoryImpl.getBy(
          email: 'test@mail.com',
          password: '12345678',
        );

        expect(result.isLeft(), true);
      },
    );

    test('should_return_left_when_credential_local_storage_throw_error',
        () async {
      final mockApiService = MockApiService();
      final mockCredentialLocalStorage = MockCredentialLocalStorage();
      final fakeCredential = Credential(
        token: "test_token",
        refreshToken: "test_refresh_token",
      );

      final credentialRepositoryImpl =
          CredentialRepositoryImpl(mockApiService, mockCredentialLocalStorage);

      when(() => mockCredentialLocalStorage.save(fakeCredential))
          .thenThrow(Exception());

      final result = await credentialRepositoryImpl.save(fakeCredential);

      expect(result.isLeft(), true);
    });

    test('should_return_right_when_credential_local_storage_save_credential',
        () async {
      final mockApiService = MockApiService();
      final mockCredentialLocalStorage = MockCredentialLocalStorage();

      final fakeCredential = Credential(
        token: "test_token",
        refreshToken: "test_refresh_token",
      );

      final credentialRepositoryImpl = CredentialRepositoryImpl(
        mockApiService,
        mockCredentialLocalStorage,
      );

      final result = await credentialRepositoryImpl.save(fakeCredential);

      expect(result.isRight(), true);
    });

    test(
        'should_return_left_when_call_save_from_credential_local_storage_throw_exception',
        () async {
      final fakeCredential =
          Credential(token: "fake_token", refreshToken: "fake_refresh_token");
      final mockApiService = MockApiService();
      final mockCredentialLocalStorage = MockCredentialLocalStorage();

      when(
        () => mockCredentialLocalStorage.save(fakeCredential),
      ).thenThrow(Exception());

      final credentialRepository = CredentialRepositoryImpl(
        mockApiService,
        mockCredentialLocalStorage,
      );

      final result = await credentialRepository.save(fakeCredential);
      expect(result.isLeft(), true);
    });

    test(
        'should_return_right_when_call_read_from_credential_local_storage_return_credential',
        () async {
      final fakeCredential =
          Credential(token: "fake_token", refreshToken: "fake_refresh_token");
      final mockApiService = MockApiService();
      final mockCredentialLocalStorage = MockCredentialLocalStorage();

      when(
        () => mockCredentialLocalStorage.read(),
      ).thenAnswer((_) async => fakeCredential);

      final credentialRepository = CredentialRepositoryImpl(
        mockApiService,
        mockCredentialLocalStorage,
      );

      final result = await credentialRepository.read();
      expect(result.isRight(), true);
    });
  });
}
