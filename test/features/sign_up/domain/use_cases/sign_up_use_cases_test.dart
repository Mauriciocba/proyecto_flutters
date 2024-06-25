import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/sign_up/domain/entities/user.dart';
import 'package:pamphlets_management/features/sign_up/domain/repositories/user_repository.dart';
import 'package:pamphlets_management/features/sign_up/domain/use_cases/sign_up_use_cases.dart';

import 'mock_user_repository.dart';

void main() {
  group('SignUpUseCase', () {
    setUpAll(() {
      registerFallbackValue(MockUserRepository());
    });

    test('should_return_left_when_email_is_not_valid', () async {
      final signUpUseCase = SignUpUseCase(userRepository: MockUserRepository());

      final response = await signUpUseCase(
        email: "email_invalid",
        password: "",
      );

      expect(response.isLeft(), true);
    });

    test('should_return_left_when_password_length_is_not_greater_than_8',
        () async {
      final signUpUseCase = SignUpUseCase(userRepository: MockUserRepository());

      final response = await signUpUseCase(
        email: "email_invalid",
        password: "21",
      );

      expect(response.isLeft(), true);
    });

    test('should_return_left_when_repository_return_left', () async {
      final UserRepository userRepository = MockUserRepository();

      final signUpUseCase = SignUpUseCase(userRepository: userRepository);

      when(
        () => userRepository.add(
          email: "test@email.com",
          password: "12345678",
        ),
      ).thenAnswer(
        (_) async => Left(BaseFailure(message: '')),
      );

      final result = await signUpUseCase(
        email: "test@email.com",
        password: "12345678",
      );

      expect(result.isLeft(), true);
    });

    test('should_return_left_when_user_repository_throw_exception', () async {
      final UserRepository userRepository = MockUserRepository();

      final signUpUseCase = SignUpUseCase(userRepository: userRepository);

      when(
        () => userRepository.add(
          email: "test@email.com",
          password: "12345678",
        ),
      ).thenThrow(Exception());

      final result = await signUpUseCase(
        email: "test@email.com",
        password: "12345678",
      );

      expect(result.isLeft(), true);
    });

    test('should_return_right_when_user_repository_return_right', () async {
      UserRepository userRepository = MockUserRepository();

      SignUpUseCase signUpUseCase =
          SignUpUseCase(userRepository: userRepository);

      when(
        () => userRepository.add(
          email: "test@email.com",
          password: "12345678",
        ),
      ).thenAnswer(
        (_) async => const Right(User(userId: 2, email: "mail")),
      );

      final result = await signUpUseCase(
        email: "test@email.com",
        password: "12345678",
      );

      expect(result.isRight(), true);
    });
  });
}
