import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/speakers_info/data/speakers_info_repository_impl.dart';

import '../../../mock_api_service.dart';

void main() {
  group('SpeakerInfoRepositoryImpl', () {
    //UT_SIR_01
    test('should_return_left_when_api_service_throw_exception', () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.get,
          url: any(
            named: 'url',
          ),
        ),
      ).thenThrow(Exception());

      final speakerInfoRepo =
          SpeakersInfoRepositoryImpl(apiService: mockApiService);

      final result = await speakerInfoRepo.getSpeakersByEvent(eventId: 2);

      expect(result.isLeft(), true);
    });

    //UT_SIR_02
    test('should_return_left_when_api_service_return_failure', () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.get,
          url: any(
            named: 'url',
          ),
        ),
      ).thenAnswer((invocation) async => ApiResult.failure());

      final speakerInfoRepo =
          SpeakersInfoRepositoryImpl(apiService: mockApiService);

      final result = await speakerInfoRepo.getSpeakersByEvent(eventId: 2);

      expect(result.isLeft(), true);
    });

    //UT_SIR_03
    test('should_return_left_when_api_service_return_error', () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.get,
          url: any(
            named: 'url',
          ),
        ),
      ).thenAnswer((invocation) async => ApiResult.error());

      final speakerInfoRepo =
          SpeakersInfoRepositoryImpl(apiService: mockApiService);

      final result = await speakerInfoRepo.getSpeakersByEvent(eventId: 2);

      expect(result.isLeft(), true);
    });

    //UT_SIR_04
    test(
        'should_return_left_when_api_service_response_success_and_status_code_400',
        () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.get,
          url: any(
            named: 'url',
          ),
        ),
      ).thenAnswer((invocation) async => ApiResult.success(statusCode: 400));

      final speakerInfoRepo =
          SpeakersInfoRepositoryImpl(apiService: mockApiService);

      final result = await speakerInfoRepo.getSpeakersByEvent(eventId: 2);

      expect(result.isLeft(), true);
    });

    //UT_SIR_05
    test(
        'should_return_left_when_api_service_return_success_and_data_in_unexpected_format',
        () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.get,
          url: any(
            named: 'url',
          ),
        ),
      ).thenAnswer(
        (invocation) async => ApiResult.success(
          body: {"sin-formato": "sin_formato"},
        ),
      );

      final speakerInfoRepo =
          SpeakersInfoRepositoryImpl(apiService: mockApiService);

      final result = await speakerInfoRepo.getSpeakersByEvent(eventId: 2);

      expect(result.isLeft(), true);
    });

    //UT_SIR_06
    test(
        'should_return_right_and_empty_list_when_api_service_return_success_and_204',
        () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.get,
          url: any(named: 'url'),
        ),
      ).thenAnswer(
        (invocation) async => ApiResult.success(
          statusCode: 204,
          body: {
            "statusCode": 204,
            "data": {"speakersWhitActivity": "[]"}
          },
        ),
      );

      final speakerInfoRepo =
          SpeakersInfoRepositoryImpl(apiService: mockApiService);

      final result = await speakerInfoRepo.getSpeakersByEvent(eventId: 2);

      expect(result.isRight(), true);
    });

    //UT_SIR_07
    test('should_return_right_when_api_service_return_success', () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.get,
          url: any(named: 'url'),
        ),
      ).thenAnswer(
        (invocation) async => ApiResult.success(statusCode: 204, body: {
          "message": "Speakers",
          "statusCode": 200,
          "data": {
            "speakersWithActivity": [],
            "speakersWithoutActivity": [
              {
                "spe_id": 5,
                "spe_first_name": "boca 3",
                "spe_last_name": "sobol",
                "spe_description": "prueba2",
                "spe_photo": "imagen",
                "social_media": []
              },
              {
                "spe_id": 4,
                "spe_first_name": "candelaria 3",
                "spe_last_name": "sobol",
                "spe_description": "prueba2",
                "spe_photo": "asdf",
                "social_media": []
              }
            ]
          }
        }),
      );

      final speakerInfoRepo =
          SpeakersInfoRepositoryImpl(apiService: mockApiService);

      final result = await speakerInfoRepo.getSpeakersByEvent(eventId: 2);

      expect(result.isRight(), true);
    });

    //UT_SIR_08
    test(
        'should_return_left_when_api_service_return_success_and_speaker_in_unexpected_format',
        () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.get,
          url: any(named: 'url'),
        ),
      ).thenAnswer(
        (invocation) async => ApiResult.success(statusCode: 200, body: {
          "message": "Speakers",
          "statusCode": 200,
          "data": {
            "speakersWithActivity": [],
            "speakersWithoutActivity": [
              {
                "spe_id": 5,
                "nombre_sin_formato": "boca 3",
                "apellido_sin_formato": "Sobol",
                "spe_description": "prueba2",
                "spe_photo": "imagen",
                "social_media": []
              },
            ]
          }
        }),
      );

      final speakerInfoRepo =
          SpeakersInfoRepositoryImpl(apiService: mockApiService);

      final result = await speakerInfoRepo.getSpeakersByEvent(eventId: 2);

      expect(result.isLeft(), true);
    });
  });
}
