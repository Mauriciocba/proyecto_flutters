import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/activities/domain/entities/activity.dart';
import 'package:pamphlets_management/features/activities/domain/use_case/get_activities_by_event_use_case.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import 'mock_activity_repository.dart';

void main() {
  group('GetActivitiesByEventUseCase', () {
    setUpAll(() {
      registerFallbackValue(MockActivityRepository);
    });

    test('should_return_left_when_repository_response_left', () async {
      final activityRepository = MockActivityRepository();

      when(() => activityRepository.getAllByEvent(eventId: 2)).thenAnswer(
          (_) async =>
              Left(BaseFailure(message: 'Obtención de actividades falló')));

      final getActivitiesByEventUseCase =
          GetActivitiesByEventUseCase(activityRepository: activityRepository);

      final response = await getActivitiesByEventUseCase(eventId: 2);

      expect(response.isLeft(), true);
    });

    test('should_return_right_when_repository_response_right', () async {
      final activityRepository = MockActivityRepository();

      when(() => activityRepository.getAllByEvent(eventId: 2))
          .thenAnswer((_) async => const Right([]));

      final getActivitiesByEventUseCase =
          GetActivitiesByEventUseCase(activityRepository: activityRepository);

      final response = await getActivitiesByEventUseCase(eventId: 2);

      expect(response.isRight(), true);
    });

    test(
        "should_return_right_whit_activities_when_repository_return_right_whit_activities",
        () async {
      final activityRepository = MockActivityRepository();
      when(
        () => activityRepository.getAllByEvent(eventId: 2),
      ).thenAnswer(
        (_) async => Right([
          Activity(
              activityId: 1,
              name: "name1",
              start: DateTime.now(),
              end: DateTime.now(),
              actAsk: false),
          Activity(
              activityId: 2,
              name: "name2",
              start: DateTime.now(),
              end: DateTime.now(),
              actAsk: false)
        ]),
      );

      final getActivitiesByEventUseCase = GetActivitiesByEventUseCase(
        activityRepository: activityRepository,
      );

      final response = await getActivitiesByEventUseCase(eventId: 2);

      expect(response.isRight(), true);
      expect(response.getRight().isNotEmpty, true);
    });

    test("should_return_left_when_repository_throw_exception", () async {
      final activityRepository = MockActivityRepository();
      when(
        () => activityRepository.getAllByEvent(eventId: 2),
      ).thenThrow(Exception());

      final getActivitiesByEventUseCase = GetActivitiesByEventUseCase(
        activityRepository: activityRepository,
      );

      final response = await getActivitiesByEventUseCase(eventId: 2);

      expect(response.isLeft(), true);
    });

    test("should_return_left_when_event_id_is_negative", () async {
      const eventId = -2;

      final activityRepository = MockActivityRepository();

      when(
        () => activityRepository.getAllByEvent(eventId: 2),
      ).thenAnswer(
        (_) async => Right([
          Activity(
              activityId: 1,
              name: "name1",
              start: DateTime.now(),
              end: DateTime.now(),
              actAsk: false),
          Activity(
              activityId: 2,
              name: "name2",
              start: DateTime.now(),
              end: DateTime.now(),
              actAsk: false)
        ]),
      );

      final getActivitiesByEventUseCase = GetActivitiesByEventUseCase(
        activityRepository: activityRepository,
      );

      final response = await getActivitiesByEventUseCase(eventId: eventId);

      expect(response.isLeft(), true);
    });
  });
}
