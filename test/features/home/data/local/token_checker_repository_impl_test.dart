import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/features/home/data/local/token_checker_repository_impl.dart';
import 'package:pamphlets_management/features/login/data/storage/credential_local_storage_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mock_shared_preferences.dart';

void main() {
  group('token_checker_repository_impl', () {
    test('should_return_true_if_token_key_exists_in_shared_preferences',
        () async {
      final TokenCheckerRepositoryImpl tokenCheckerRepository =
          TokenCheckerRepositoryImpl();
      final MockSharedPreferences mockSharedPreferences =
          MockSharedPreferences();

      when(() => mockSharedPreferences.containsKey(any())).thenReturn(true);
      SharedPreferences.setMockInitialValues({});

      SharedPreferences.setMockInitialValues({
        CredentialLocalStorageImpl.tokenKey: 'TOKEN',
      });

      final result = await tokenCheckerRepository.checkToken();

      expect(result, true);
    });

    test(
        'should_return_false_if_token_key_does_not_exist_in_shared_preferences',
        () async {
      final TokenCheckerRepositoryImpl tokenCheckerRepository =
          TokenCheckerRepositoryImpl();
      final MockSharedPreferences mockSharedPreferences =
          MockSharedPreferences();

      when(() => mockSharedPreferences.containsKey(any())).thenReturn(false);
      SharedPreferences.setMockInitialValues({});

      final result = await tokenCheckerRepository.checkToken();

      expect(result, false);
    });
  });
}
