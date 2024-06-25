import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/log_out/domain/repositories/log_out_repository.dart';
import 'package:pamphlets_management/features/log_out/domain/use_cases/log_out_use_case.dart';

class MockLogOutRepository extends Mock implements LogOutRepository {}

void main() {
  group('LogOutUseCase', () {
    test('should log out successfully', () async {
      final LogOutRepository mockLogOutRepository = MockLogOutRepository();
      final LogOutUseCase logOutUseCase =
          LogOutUseCase(logOutRepository: mockLogOutRepository);

      // Simulate successful log out
      when(() => mockLogOutRepository.logOut())
          .thenAnswer((_) async => const Right(true));

      final result = await logOutUseCase.deleteToken();

      expect(result.isRight(), true);
    });

    test(
        'should return a left failure when log out fails due to repository error',
        () async {
      final LogOutRepository mockLogOutRepository = MockLogOutRepository();
      final LogOutUseCase logOutUseCase =
          LogOutUseCase(logOutRepository: mockLogOutRepository);

      when(() => mockLogOutRepository.logOut()).thenAnswer(
          (_) async => Left(BaseFailure(message: 'Falló en caso de uso')));

      final result = await logOutUseCase.deleteToken();

      expect(result.isLeft(), true);
    });

    test(
        'should return a left failure when log out fails due to token deletion issue',
        () async {
      final LogOutRepository mockLogOutRepository = MockLogOutRepository();
      final LogOutUseCase logOutUseCase =
          LogOutUseCase(logOutRepository: mockLogOutRepository);

      when(() => mockLogOutRepository.logOut())
          .thenAnswer((_) async => const Right(true));
      when(() => mockLogOutRepository.logOut()).thenAnswer(
          (_) async => Left(BaseFailure(message: 'Falló en caso de uso')));

      final result = await logOutUseCase.deleteToken();

      expect(result.isLeft(), true);
    });
  });
}
