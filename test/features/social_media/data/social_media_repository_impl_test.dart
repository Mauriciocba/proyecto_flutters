import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/social_media/data/social_media_repository_impl.dart';
import 'package:pamphlets_management/features/social_media/domain/entities/social_media.dart';

import '../../../mock_api_service.dart';

void main() {
  group('', () {});

  late SocialMediaModel fakeModel;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();

    fakeModel = SocialMediaModel(somName: 'ig', somUrl: 'ig');
  });

  test("should_return_left_when_api_service_throw_exception", () async {
    const typeId = 3;
    const type = 'spe';

    when(() => mockApiService.request(
          method: HttpMethod.post,
          url: '/social-media?id=$typeId&type=$type',
        )).thenThrow(Exception());

    final socialMediaRepository =
        SocialMediaRepositoryImpl(apiService: mockApiService);

    final result = await socialMediaRepository.save(fakeModel, typeId, type);

    expect(result.isLeft(), true);
  });

  test('should_return_left_when_api_service_return_error', () async {
    const typeId = 3;
    const type = 'spe';
    when(
      () => mockApiService.request(
        method: HttpMethod.post,
        url: "/social-media?id=$typeId&type=$type",
      ),
    ).thenAnswer(
      (_) async => ApiResult.error(),
    );

    final socialMediaRepository =
        SocialMediaRepositoryImpl(apiService: mockApiService);

    final result = await socialMediaRepository.save(fakeModel, typeId, type);

    expect(result.isLeft(), true);
  });

  test('should_return_left_when_api_service_return_failure', () async {
    const typeId = 3;
    const type = 'spe';
    when(
      () => mockApiService.request(
          method: HttpMethod.post,
          url: "/social-media?id=$typeId&type=$type",
          body: any(named: "body")),
    ).thenAnswer(
      (_) async => ApiResult.failure(),
    );

    final socialMediaRepository =
        SocialMediaRepositoryImpl(apiService: mockApiService);

    final result = await socialMediaRepository.save(fakeModel, typeId, type);

    expect(result.isLeft(), true);
  });
}
