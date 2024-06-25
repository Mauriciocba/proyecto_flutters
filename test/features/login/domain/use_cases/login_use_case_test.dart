import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/login/domain/entities/credential.dart';
import 'package:pamphlets_management/features/login/domain/use_cases/login_use_case.dart';

import 'mock_credential_repository.dart';

void main() {
  group('LoginUseCase', () {
    setUpAll(() {
      registerFallbackValue(MockCredentialRepository);
    });

    test(
      'should_return_left_with_an_exception_when_getby_from_repository_return_left',
      () async {
        final credentialRepository = MockCredentialRepository();
        final loginUseCase = LoginUseCase(
          credentialRepository: credentialRepository,
        );

        when(
          () => credentialRepository.getBy(
            email: 'test@mail.com',
            password: '12345678',
          ),
        ).thenAnswer(
          (_) async => Left(BaseFailure(message: '')),
        );

        Either<BaseFailure, void> result = await loginUseCase(
          email: "test@mail.com",
          password: "12345678",
        );

        expect(result.isLeft(), true);
      },
    );

    test(
      'should_return_true_when_getby_from_repository_return_right_true',
      () async {
        final credentialRepository = MockCredentialRepository();
        final fakeCredential =
            Credential(token: "token", refreshToken: "refreshToken");

        when(
          () => credentialRepository.getBy(
            email: 'test@mail.com',
            password: "12345678",
          ),
        ).thenAnswer(
          (_) async => Right(fakeCredential),
        );

        when(() => credentialRepository.save(fakeCredential))
            .thenAnswer((_) async => const Right(true));

        final loginUseCase = LoginUseCase(
          credentialRepository: credentialRepository,
        );

        final result =
            await loginUseCase(email: "test@mail.com", password: "12345678");

        expect((result as Right).value, true);
      },
    );

    test(
      'should_return_right_false_when_getby_from_repository_return_true_but_credential_is_empty_string',
      () async {
        final credentialRepository = MockCredentialRepository();

        when(
          () => credentialRepository.getBy(
            email: 'test@mail.com',
            password: "12345678",
          ),
        ).thenAnswer(
          (_) async => Right(Credential(token: "", refreshToken: "")),
        );

        final loginUseCase =
            LoginUseCase(credentialRepository: credentialRepository);

        final result = await loginUseCase(
          email: 'test@mail.com',
          password: '12345678',
        );

        expect((result as Right).value, false);
      },
    );

    test(
        'should_return_right_false_when_getby_from_repository_return_right_but_credential_have_refresh_token_is_empty_string',
        () async {
      final credentialRepository = MockCredentialRepository();

      when(
        () => credentialRepository.getBy(
          email: 'test@mail.com',
          password: "12345678",
        ),
      ).thenAnswer(
        (_) async => Right(Credential(token: "token", refreshToken: "")),
      );

      final loginUseCase =
          LoginUseCase(credentialRepository: credentialRepository);

      final result = await loginUseCase(
        email: 'test@mail.com',
        password: '12345678',
      );

      expect((result as Right).value, false);
    });

    test(
      'should_return_left_when_call_save_from_repository_return_left_when_try_save_new_credential_in_storage',
      () async {
        final fakeCredential =
            Credential(token: "fake_token", refreshToken: "fake_refresh_token");

        final credentialRepository = MockCredentialRepository();

        when(
          () => credentialRepository.getBy(
              email: "test@email.com", password: "123456678"),
        ).thenAnswer(
          (_) async => Right(fakeCredential),
        );

        when(
          () => credentialRepository.save(fakeCredential),
        ).thenAnswer((_) async => Left(BaseFailure(message: '')));

        final loginUseCase =
            LoginUseCase(credentialRepository: credentialRepository);

        final result =
            await loginUseCase(email: "test@email.com", password: "123456678");

        expect(result.isLeft(), true);
      },
    );
  });
}
