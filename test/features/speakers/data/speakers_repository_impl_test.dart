import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/speakers/data/speakers_repository_impl.dart';
import 'package:pamphlets_management/features/speakers/domain/use_case/register_speaker_use_case.dart';

import '../../../mock_api_service.dart';

void main() {
  group('CreateSpeakerRepositoryImpl', () {
    late SpeakerForm fakeModel;
    late ApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();

      fakeModel = (
        eventId: 2,
        name: "Mauricio",
        lastName: 'Torres',
        description: "speaker",
        photo: '',
      );
    });

    test("should_return_left_when_api_service_throw_exception", () async {
      when(
        () => mockApiService.request(
            method: HttpMethod.post, url: '/speakers/create'),
      ).thenThrow(
        Exception(),
      );
      final createSpeakerRepositoryImpl =
          SpeakersRepositoryImpl(apiService: mockApiService);

      final result = await createSpeakerRepositoryImpl.save(fakeModel);

      expect(result.isLeft(), true);
    });

    test('should_return_left_when_api_service_return_error', () async {
      when(
        () => mockApiService.request(
          method: HttpMethod.post,
          url: "/speakers/create",
        ),
      ).thenAnswer(
        (_) async => ApiResult.error(),
      );

      final createSpeakerRepositoryImpl =
          SpeakersRepositoryImpl(apiService: mockApiService);

      final result = await createSpeakerRepositoryImpl.save(fakeModel);

      expect(result.isLeft(), true);
    });

    test('should_return_left_when_api_service_return_failure', () async {
      when(
        () => mockApiService.request(
            method: HttpMethod.post,
            url: "/speakers/create",
            body: any(named: "body")),
      ).thenAnswer(
        (_) async => ApiResult.failure(),
      );

      final createSpeakerRepositoryImpl =
          SpeakersRepositoryImpl(apiService: mockApiService);

      final result = await createSpeakerRepositoryImpl.save(fakeModel);

      expect(result.isLeft(), true);
    });

    test('should_return_right_when_api_service_return_success', () async {
      when(
        () => mockApiService.request(
          method: HttpMethod.post,
          url: "/speakers/create",
          // body: any(named: "body"),
        ),
      ).thenAnswer(
        (_) async => ApiResult.success(
          statusCode: HttpStatus.created,
          body: {
            "message": "Successfully created activity",
            "statusCode": 201,
            "data": {
              "eve_id": 3,
              "spe_first_name": "Mauricio",
              "spe_last_name": "Torres",
              "spe_description": "Speaker Mauricio Torres",
              "spe_photo": ""
            }
          },
        ),
      );

      final createSpeakerRepositoryImpl =
          SpeakersRepositoryImpl(apiService: mockApiService);

      final result = await createSpeakerRepositoryImpl.save(fakeModel);

      expect(result.isRight(), true);
    });
  });
}
