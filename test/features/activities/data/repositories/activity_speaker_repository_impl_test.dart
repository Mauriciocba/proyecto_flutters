import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/activities/data/repositories/activity_speaker_repository_impl.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../../../mock_api_service.dart';

void main() {
  group('ActivitySpeakerRepositoryImpl', () {
    late final ApiService mockApiService;

    setUpAll(() {
      mockApiService = MockApiService();
    });

    //UT_ASRI_01
    test('should_return_left_when_api_service_throw_exception', () async {
      const activityId = 1;
      final speakersIds = [1, 2, 3, 4, 5];
      when(
        () => mockApiService.request(
          method: HttpMethod.post,
          url: any(named: "url"),
          body: any(named: "body"),
        ),
      ).thenThrow(Exception());

      final activitySpeakerRepository =
          ActivitySpeakerRepositoryImpl(apiService: mockApiService);

      final result = await activitySpeakerRepository.save(
        activityId: activityId,
        speakersIds: speakersIds,
      );

      expect(result.isLeft(), true);
    });

    //UT_ASRI_02
    test('should_return_left_when_api_service_response_status_code_400',
        () async {
      const activityId = 1;
      final speakersIds = [1, 2, 3, 4, 5];
      when(
        () => mockApiService.request(
          method: HttpMethod.post,
          url: any(named: "url"),
          body: any(named: "body"),
        ),
      ).thenAnswer(
        (_) async => ApiResult.success(
          statusCode: 400,
          body: {
            "statusCode": 400,
          },
        ),
      );

      final activitySpeakerRepository =
          ActivitySpeakerRepositoryImpl(apiService: mockApiService);

      final result = await activitySpeakerRepository.save(
        activityId: activityId,
        speakersIds: speakersIds,
      );

      expect(result.isLeft(), true);
    });

    //UT_ASRI_03
    test('should_return_left_when_api_service_response_error', () async {
      const activityId = 1;
      final speakersIds = [1, 2, 3, 4, 5];
      when(
        () => mockApiService.request(
          method: HttpMethod.post,
          url: any(named: "url"),
          body: any(named: "body"),
        ),
      ).thenAnswer(
        (_) async => ApiResult.error(),
      );

      final activitySpeakerRepository =
          ActivitySpeakerRepositoryImpl(apiService: mockApiService);

      final result = await activitySpeakerRepository.save(
        activityId: activityId,
        speakersIds: speakersIds,
      );

      expect(result.isLeft(), true);
    });

    //UT_ASRI_04
    test('should_return_left_when_api_service_response_failure', () async {
      const activityId = 1;
      final speakersIds = [1, 2, 3, 4, 5];
      when(
        () => mockApiService.request(
          method: HttpMethod.post,
          url: any(named: "url"),
          body: any(named: "body"),
        ),
      ).thenAnswer(
        (_) async => ApiResult.failure(),
      );

      final activitySpeakerRepository =
          ActivitySpeakerRepositoryImpl(apiService: mockApiService);

      final result = await activitySpeakerRepository.save(
        activityId: activityId,
        speakersIds: speakersIds,
      );

      expect(result.isLeft(), true);
    });

    //UT_ASRI_05
    test('should_return_true_when_api_service_response_status_code_201',
        () async {
      const activityId = 1;
      final speakersIds = [1, 2, 3, 4, 5];
      when(
        () => mockApiService.request(
          method: HttpMethod.post,
          url: any(named: "url"),
          body: any(named: "body"),
        ),
      ).thenAnswer(
        (_) async => ApiResult.success(
          body: {
            'message': 'Activity-Speaker created successfully',
            'statusCode': 201
          },
        ),
      );

      final activitySpeakerRepository =
          ActivitySpeakerRepositoryImpl(apiService: mockApiService);

      final result = await activitySpeakerRepository.save(
        activityId: activityId,
        speakersIds: speakersIds,
      );

      expect(result.isRight(), true);
      expect(result.getRight(), true);
    });
  });
}
