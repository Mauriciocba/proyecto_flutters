import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/social_media/domain/entities/social_media.dart';
import 'package:pamphlets_management/features/social_media/domain/repositories/social_media_repository.dart';
import 'package:pamphlets_management/features/social_media/domain/use_case/register_social_media.dart';

class MockSocialMediaRepository extends Mock implements SocialMediaRepository {}

void main() {
  group('registerSocialMediaUseCase', () {});

  late RegisterSocialMediaUseCase useCase;
  late MockSocialMediaRepository mockRepository;

  setUp(() {
    mockRepository = MockSocialMediaRepository();
    useCase = RegisterSocialMediaUseCase(mockRepository);
  });

  test("should_return_left_with_invalid_name", () async {
    final invalidSocialMedia =
        SocialMediaModel(somName: '', somUrl: 'validUrl');

    final result = await useCase(invalidSocialMedia);

    expect(result.isLeft(), true);
  });

  test("should_return_left_with_invalid_url", () async {
    final invalidSocialMedia =
        SocialMediaModel(somName: 'validName', somUrl: '');

    final result = await useCase(invalidSocialMedia);

    expect(result.isLeft(), true);
  });

  test("should_return_left_when_repository_fails", () async {
    final validSocialMedia =
        SocialMediaModel(somName: 'validName', somUrl: 'validUrl');

    when(() => mockRepository.save(validSocialMedia, 3, 'spe'))
        .thenAnswer((_) async => Left(BaseFailure(message: 'Error')));

    final result = await useCase(validSocialMedia);

    expect(result.isLeft(), true);
  });

  test("should_return_right_when_repository_succeeds", () async {
    final validSocialMedia =
        SocialMediaModel(somName: 'validName', somUrl: 'validUrl');

    when(() => mockRepository.save(validSocialMedia, 3, 'spe'))
        .thenAnswer((_) async => const Right(true));

    final result = await useCase(validSocialMedia);

    expect(result.isRight(), true);
  });
}
