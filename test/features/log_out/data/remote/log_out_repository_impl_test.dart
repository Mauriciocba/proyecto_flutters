import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/log_out/data/local/token_deleter.dart';
import 'package:pamphlets_management/features/log_out/data/remote/log_out_repository_impl.dart';

import '../../../../mock_api_service.dart';
import 'mock_token_deleter.dart';

void main() {
  group('LogOutRepositoryImpl', () {
    test("should_return_right_when_logout_is_success", () async {
      final ApiService mockApiService = MockApiService();
      final TokenDeleter mockTokenDeleter = MockTokenDeleter();
      final LogOutRepositoryImpl logOutRepository =
          LogOutRepositoryImpl(mockApiService, mockTokenDeleter);

      when(() => mockApiService.request(
            method: HttpMethod.post,
            url: '/auth/logout',
          )).thenAnswer(
        (_) async => ApiResult.success(statusCode: 200),
      );

      when(() => mockTokenDeleter.deleteToken()).thenAnswer((_) async => true);

      final result = await logOutRepository.logOut();

      expect(result.isRight(), true);
    });

    test("should_return_left_when_api_fails_on_logout", () async {
      final ApiService mockApiService = MockApiService();
      final TokenDeleter mockTokenDeleter = MockTokenDeleter();
      final LogOutRepositoryImpl logOutRepository =
          LogOutRepositoryImpl(mockApiService, mockTokenDeleter);

      when(() => mockApiService.request(
            method: HttpMethod.post,
            url: '/auth/logout',
          )).thenAnswer(
        (_) async => ApiResult.failure(statusCode: 500),
      );

      final result = await logOutRepository.logOut();

      expect(result.isLeft(), true);
    });

    test("should_return_left_when_token_deletion_fails", () async {
      final ApiService mockApiService = MockApiService();
      final TokenDeleter mockTokenDeleter = MockTokenDeleter();
      final LogOutRepositoryImpl logOutRepository =
          LogOutRepositoryImpl(mockApiService, mockTokenDeleter);

      when(() => mockApiService.request(
            method: HttpMethod.post,
            url: '/auth/logout',
          )).thenAnswer(
        (_) async => ApiResult.success(statusCode: 200),
      );

      when(() => mockTokenDeleter.deleteToken()).thenAnswer((_) async => false);

      final result = await logOutRepository.logOut();

      expect(result.isLeft(), true);
    });
  });
}
