import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/activities/data/repositories/activity_repository_impl.dart';
import 'package:pamphlets_management/features/activities/domain/use_case/register_activity_use_case.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../../../mock_api_service.dart';

void main() {
  group("ActivityRepositoryImpl", () {
    test("should_return_left_when_api_service_throw_exception", () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.get,
          url: any(named: "url"),
        ),
      ).thenThrow(Exception());

      final activityRepository = ActivityRepositoryImpl(
        apiService: mockApiService,
      );

      final result = await activityRepository.getAllByEvent(eventId: 2);

      expect(result.isLeft(), true);
    });

    test("should_return_right_when_api_service_response_200_and_activity_list",
        () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.get,
          url: any(named: "url"),
        ),
      ).thenAnswer(
        (_) async => ApiResult.success(
          statusCode: HttpStatus.ok,
          body: {
            "message": "Actividades por evento",
            "statusCode": 200,
            "data": [
              {
                "act_id": 22,
                "act_name": "Nuevas Tendencias",
                "act_description": "Presentacion de nuevos desarrollos",
                "act_location": "Prado 135 1B",
                "act_start": "2023-09-21T18:40:00.000Z",
                "act_end": "2023-09-21T13:59:00.000Z",
                "speaker": [
                  {"spe_first_name": "Carlitos", "spe_last_name": "Tevez"},
                  {"spe_first_name": "candelaria", "spe_last_name": "sobol"},
                  {"spe_first_name": "Carlitos", "spe_last_name": "Tevez"}
                ]
              }
            ]
          },
        ),
      );

      final activityRepository = ActivityRepositoryImpl(
        apiService: mockApiService,
      );

      final result = await activityRepository.getAllByEvent(eventId: 2);

      expect(result.isRight(), true);
      expect(result.getRight().isNotEmpty, true);
    });

    test(
      "should_return_return_left_when_api_service_response_status_code_400",
      () async {
        final mockApiService = MockApiService();

        when(
          () => mockApiService.request(
            method: HttpMethod.get,
            url: any(named: "url"),
          ),
        ).thenAnswer(
          (_) async => ApiResult.failure(
            statusCode: HttpStatus.badRequest,
            body: {},
          ),
        );

        final activityRepository = ActivityRepositoryImpl(
          apiService: mockApiService,
        );

        final result = await activityRepository.getAllByEvent(eventId: 2);

        expect(result.isLeft(), true);
      },
    );

    test(
      "should_return_left_when_api_service_response_error",
      () async {
        final mockApiService = MockApiService();

        when(
          () => mockApiService.request(
            method: HttpMethod.get,
            url: any(named: "url"),
          ),
        ).thenAnswer(
          (_) async => ApiResult.error(),
        );

        final activityRepository = ActivityRepositoryImpl(
          apiService: mockApiService,
        );

        final result = await activityRepository.getAllByEvent(eventId: 2);

        expect(result.isLeft(), true);
      },
    );

    test(
      "should_return_left_when_api_service_return_success_but_format_json_is_not_compatible",
      () async {
        final mockApiService = MockApiService();

        when(
          () => mockApiService.request(
            method: HttpMethod.get,
            url: any(named: "url"),
          ),
        ).thenAnswer(
          (_) async => ApiResult.success(
            statusCode: HttpStatus.ok,
            body: {
              "message": "Actividades por evento",
              "statusCode": 200,
              "data": [
                {
                  "act_id": 22,
                  "fomato_cambiado": "formato_cambiado",
                }
              ]
            },
          ),
        );

        final activityRepository = ActivityRepositoryImpl(
          apiService: mockApiService,
        );

        final result = await activityRepository.getAllByEvent(eventId: 2);
        expect(result.isLeft(), true);
      },
    );
  });

  group('ActivityReppositoryImpl.save', () {
    late ActivityFormInput fakeActivity;
    late ApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();

      fakeActivity = (
        name: "Evento test",
        description: "Evento test",
        location: "location",
        urlForm: "",
        start: DateTime.now(),
        end: DateTime.now(),
        eventId: 2,
        speakerIds: [],
        categoryId: null,
        actAsk: true,
      );
    });

    test('should_return_left_when_api_service_throw_exception', () async {
      when(
        () => mockApiService.request(
          method: HttpMethod.post,
          url: "/activity/create",
        ),
      ).thenThrow(
        Exception(),
      );

      final activityRepository =
          ActivityRepositoryImpl(apiService: mockApiService);

      final result = await activityRepository.save(fakeActivity);

      expect(result.isLeft(), true);
    });

    test('should_return_left_when_api_service_return_error', () async {
      when(
        () => mockApiService.request(
          method: HttpMethod.post,
          url: "/activity/create",
        ),
      ).thenAnswer(
        (_) async => ApiResult.error(),
      );

      final activityRepository =
          ActivityRepositoryImpl(apiService: mockApiService);

      final result = await activityRepository.save(fakeActivity);

      expect(result.isLeft(), true);
    });

    test('should_return_left_when_api_service_return_failure', () async {
      when(
        () => mockApiService.request(
            method: HttpMethod.post,
            url: "/activity/create",
            body: any(named: "body")),
      ).thenAnswer(
        (_) async => ApiResult.failure(),
      );

      final activityRepository =
          ActivityRepositoryImpl(apiService: mockApiService);

      final result = await activityRepository.save(fakeActivity);

      expect(result.isLeft(), true);
    });

    test('should_return_right_when_api_service_return_success', () async {
      when(
        () => mockApiService.request(
          method: HttpMethod.post,
          url: "/activity/create",
          body: any(named: "body"),
        ),
      ).thenAnswer(
        (_) async => ApiResult.success(
          statusCode: HttpStatus.created,
          body: {
            "message": "Successfully created activity",
            "statusCode": 201,
            "data": {
              "act_id": 51,
              "act_name": "Prueba stand elias",
              "act_description":
                  "STARTUPS: INVERSIONES, INTERNACIONALIZACIÓN Y NEGOCIOS",
              "act_location": "Zona Charlas Ágiles",
              "act_form": "",
              "act_start": "2023-10-12T14:00:00.000Z",
              "act_end": "2023-10-12T15:00:00.000Z",
              "act_is_active": null,
            }
          },
        ),
      );

      final activityRepository =
          ActivityRepositoryImpl(apiService: mockApiService);

      final result = await activityRepository.save(fakeActivity);

      expect(result.isRight(), true);
    });
  });

  group("ActivityRepositoryImpl.update", () {
    late ApiService mockApiService;
    late ActivityFormInput fakeInputData;

    setUp(() {
      mockApiService = MockApiService();

      fakeInputData = (
        eventId: 2,
        name: "Nueva actividad editada",
        description: "Actividad editada",
        location: "Ubicación editada",
        urlForm: "Formulario editado",
        start: DateTime.now(),
        end: DateTime.now(),
        speakerIds: [],
        categoryId: null,
        actAsk: false,
      );
    });

    test('should_return_left_when_api_service_throw_exception', () async {
      const activityId = 2;
      when(
        () => mockApiService.request(
          method: HttpMethod.patch,
          url: "/activity/update/$activityId",
        ),
      ).thenThrow(
        Exception(),
      );

      final activityRepository =
          ActivityRepositoryImpl(apiService: mockApiService);

      final result = await activityRepository.update(
        activityId: activityId,
        activityData: fakeInputData,
      );

      expect(result.isLeft(), true);
    });

    test('should_return_left_when_api_service_return_error', () async {
      const activityId = 2;
      when(
        () => mockApiService.request(
          method: HttpMethod.patch,
          url: "/activity/update/$activityId",
        ),
      ).thenAnswer(
        (_) async => ApiResult.error(),
      );

      final activityRepository =
          ActivityRepositoryImpl(apiService: mockApiService);

      final result = await activityRepository.update(
        activityId: activityId,
        activityData: fakeInputData,
      );

      expect(result.isLeft(), true);
    });

    test('should_return_left_when_api_service_return_failure', () async {
      const activityId = 2;
      when(
        () => mockApiService.request(
          method: HttpMethod.patch,
          url: "/activity/update/$activityId",
        ),
      ).thenAnswer(
        (_) async => ApiResult.failure(),
      );

      final activityRepository =
          ActivityRepositoryImpl(apiService: mockApiService);

      final result = await activityRepository.update(
        activityId: activityId,
        activityData: fakeInputData,
      );

      expect(result.isLeft(), true);
    });
  });
}
