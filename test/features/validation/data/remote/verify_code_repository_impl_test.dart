import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/validation/data/remote/verify_code_repository_impl.dart';
import 'package:pamphlets_management/features/validation/domain/repositories/verify_code_repository.dart';

import '../../../../mock_api_service.dart';

void main() {
  group("VerifyCodeRepositoryImpl", () {
    setUpAll(() {
      registerFallbackValue(MockApiService());
    });

    test(
      "should_return_left_when_api_service_returns_failure",
      () async {
        final mockApiService = MockApiService();
        VerifyCodeRepository userRepository =
            VerifyCodeRepositoryImpl(apiService: mockApiService);

        when(
          () => mockApiService.request(
            method: HttpMethod.post,
            url: "/email/validate-email/1",
            body: {"verificationCode": 123456},
          ),
        ).thenAnswer(
          (_) async => ApiResult.failure(
            statusCode: 400,
            body: {},
          ),
        );

        final result = await userRepository.verifyCode(1, 123456);

        expect(result.isLeft(), true);
      },
    );

    test(
      'should_return_right_when_api_service_return_success',
      () async {
        final mockApiService = MockApiService();
        VerifyCodeRepository userRepository =
            VerifyCodeRepositoryImpl(apiService: mockApiService);

        when(
          () => mockApiService.request(
            method: HttpMethod.post,
            url: "/email/validate-email/1",
            body: {"verificationCode": 123456},
          ),
        ).thenAnswer(
          (_) async => ApiResult.success(
            statusCode: 200,
            body: {"message": "Correctly verified email"},
          ),
        );

        final response = await userRepository.verifyCode(1, 123456);

        expect(response.isRight(), true);
      },
    );
  });
}
