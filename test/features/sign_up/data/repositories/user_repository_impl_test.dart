import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/sign_up/data/repositories/user_repository_impl.dart';
import 'package:pamphlets_management/features/sign_up/domain/entities/user.dart';
import 'package:pamphlets_management/features/sign_up/domain/repositories/user_repository.dart';

import '../../../../mock_api_service.dart';

void main() {
  group('UserRepositoryImpl', () {
    setUpAll(() {
      registerFallbackValue(MockApiService());
    });
    test('should_return_left_when_api_service_return_failure', () async {
      final mockApiService = MockApiService();

      UserRepository userRepository = UserRepositoryImpl(
        apiService: mockApiService,
      );

      when(
        () => mockApiService.request(
          method: HttpMethod.post,
          url: "/auth/signup",
          body: {
            'email': 'test@email.com',
            'password': "12345678",
          },
        ),
      ).thenAnswer((_) async => ApiResult.failure());

      final result = await userRepository.add(
        email: "test@email.com",
        password: "12345678",
      );

      expect(result.isLeft(), true);
    });
  });

  test('should_return_left_when_api_service_return_error', () async {
    final mockApiService = MockApiService();

    UserRepository userRepository = UserRepositoryImpl(
      apiService: mockApiService,
    );

    when(
      () => mockApiService.request(
        method: HttpMethod.post,
        url: "/auth/signup",
        body: {
          'email': 'test@email.com',
          'password': "12345678",
        },
      ),
    ).thenAnswer((_) async => ApiResult.error());

    final result = await userRepository.add(
      email: "test@email.com",
      password: "12345678",
    );

    expect(result.isLeft(), true);
  });

  test('should_return_left_when_api_service_throw_exception', () async {
    final mockApiService = MockApiService();

    UserRepository userRepository = UserRepositoryImpl(
      apiService: mockApiService,
    );

    when(
      () => mockApiService.request(
        method: HttpMethod.post,
        url: "/auth/signup",
        body: {
          'email': 'test@email.com',
          'password': "12345678",
        },
      ),
    ).thenThrow(Exception());

    final result = await userRepository.add(
      email: "test@email.com",
      password: "12345678",
    );

    expect(result.isLeft(), true);
  });

  test('should_return_left_when_api_service_return_success_but_body_empty',
      () async {
    final mockApiService = MockApiService();

    UserRepository userRepository = UserRepositoryImpl(
      apiService: mockApiService,
    );

    when(
      () => mockApiService.request(
        method: HttpMethod.post,
        url: "/auth/signup",
        body: {
          'email': 'test@email.com',
          'password': "12345678",
        },
      ),
    ).thenAnswer((_) async => ApiResult.success(body: {}, statusCode: 200));

    final result = await userRepository.add(
      email: "test@email.com",
      password: "12345678",
    );

    expect(result.isLeft(), true);
  });

  test(
      'should_return_right_when_api_service_return_success_with_200_and_json_created_user',
      () async {
    final mockApiService = MockApiService();

    UserRepository userRepository = UserRepositoryImpl(
      apiService: mockApiService,
    );

    when(
      () => mockApiService.request(
        method: HttpMethod.post,
        url: "/auth/signup",
        body: {
          'email': 'test@email.com',
          'password': "12345678",
        },
      ),
    ).thenAnswer((_) async => ApiResult.success(body: {
          "message": "User",
          "statusCode": 200,
          "data": {
            "id": 6,
            "email": "jorge-ruben@gmail.com",
            "password":
                "2b10VCy3hypVrM.idDtagJL5RuZ.FwwHgPa2V/M1dk26UOq1wNSMKG2w.",
            "isActive": 0,
            "createdAt": "2023-07-18T15:25:24.387Z",
            "updatedAt": "2023-07-18T15:25:24.386Z",
            "cor_id": {
              "cor_id": 1,
              "cor_name": "Publico",
              "cor_description": "Publico de empresa"
            }
          }
        }, statusCode: 200));

    final result = await userRepository.add(
      email: "test@email.com",
      password: "12345678",
    );

    expect(result.isRight(), true);
  });

  test(
      'should_return_righ_user_id_6_when_api_service_response_success_result_whith_user_id_6',
      () async {
    final mockApiService = MockApiService();

    UserRepository userRepository = UserRepositoryImpl(
      apiService: mockApiService,
    );

    when(
      () => mockApiService.request(
        method: HttpMethod.post,
        url: "/auth/signup",
        body: {
          'email': 'test@email.com',
          'password': "12345678",
        },
      ),
    ).thenAnswer((_) async => ApiResult.success(body: {
          "message": "User",
          "statusCode": 200,
          "data": {
            "id": 6,
            "email": "jorge-ruben@gmail.com",
            "password":
                "2b10VCy3hypVrM.idDtagJL5RuZ.FwwHgPa2V/M1dk26UOq1wNSMKG2w.",
            "isActive": 0,
            "createdAt": "2023-07-18T15:25:24.387Z",
            "updatedAt": "2023-07-18T15:25:24.386Z",
            "cor_id": {
              "cor_id": 1,
              "cor_name": "Publico",
              "cor_description": "Publico de empresa"
            }
          }
        }, statusCode: 200));

    final result = await userRepository.add(
      email: "test@email.com",
      password: "12345678",
    );

    User user = (result as Right).value;
    expect(user.userId, 6);
    expect(user.email, "jorge-ruben@gmail.com");
  });
}
