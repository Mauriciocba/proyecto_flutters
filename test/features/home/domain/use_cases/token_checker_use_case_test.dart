import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/features/home/domain/use_cases/token_checker_use_case.dart';

import 'mock_token_checker_repository.dart';

void main() {
  group('token_checker_use_case_test', () {
    test('should_return_true_if_token_exists', () async {
      final MockTokenCheckerRepository mockTokenCheckerRepository =
          MockTokenCheckerRepository();
      final TokenCheckerUseCase tokenCheckerUseCase = TokenCheckerUseCase(
        tokenCheckerRepository: mockTokenCheckerRepository,
      );

      when(() => mockTokenCheckerRepository.checkToken())
          .thenAnswer((_) async => true);

      final result = await tokenCheckerUseCase.checkToken();

      expect(result, true);
      verify(() => mockTokenCheckerRepository.checkToken()).called(1);
    });

    test('should_return_false_if_token_does_not_exist', () async {
      final MockTokenCheckerRepository mockTokenCheckerRepository =
          MockTokenCheckerRepository();
      final TokenCheckerUseCase tokenCheckerUseCase = TokenCheckerUseCase(
        tokenCheckerRepository: mockTokenCheckerRepository,
      );

      when(() => mockTokenCheckerRepository.checkToken())
          .thenAnswer((_) async => false);

      final result = await tokenCheckerUseCase.checkToken();

      expect(result, false);
      verify(() => mockTokenCheckerRepository.checkToken()).called(1);
    });
  });
}
