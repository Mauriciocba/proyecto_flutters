import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/activities/domain/entities/activity.dart';
import 'package:pamphlets_management/features/activities/domain/use_case/edit_activity_use_case.dart';
import 'package:pamphlets_management/features/activities/domain/use_case/register_activity_use_case.dart';

import 'mock_activity_repository.dart';

void main() {
  group("EditActivityUseCase", () {
    final ActivityFormInput fakeActivityUpdated = (
      eventId: 2,
      name: "Nueva actividad editada",
      description: "Actividad editada",
      location: "Ubicación editada",
      urlForm: "Formulario editado",
      start: DateTime.now(),
      end: DateTime.now(),
      speakerIds: [],
      categoryId: null,
      actAsk: true,
    );

    //* UT_EAUC_01
    test("should_return_left_when_repository_return_left", () async {
      final activityRepository = MockActivityRepository();

      when(
        () => activityRepository.update(
          activityId: any(named: "activityId"),
          activityData: fakeActivityUpdated,
        ),
      ).thenAnswer((_) async => Left(BaseFailure(message: "Algo fallo")));

      final editActivityUseCase =
          EditActivityUseCase(activityRepository: activityRepository);

      final result = await editActivityUseCase(
        activityId: 2,
        activityFormInput: fakeActivityUpdated,
      );

      expect(result.isLeft(), true);
    });

    //* UT_EAUC_02
    test("should_return_left_when_repository_throw_exception", () async {
      final activityRepository = MockActivityRepository();

      when(
        () => activityRepository.update(
          activityId: any(named: "activityId"),
          activityData: fakeActivityUpdated,
        ),
      ).thenThrow(Exception());

      final editActivityUseCase =
          EditActivityUseCase(activityRepository: activityRepository);

      final result = await editActivityUseCase(
        activityId: 2,
        activityFormInput: fakeActivityUpdated,
      );

      expect(result.isLeft(), true);
    });

    //* UT_EAUC_03
    test('should_return_left_when_activity_id_is_negative', () async {
      final activityRepository = MockActivityRepository();

      when(
        () => activityRepository.update(
          activityId: -2,
          activityData: fakeActivityUpdated,
        ),
      ).thenThrow(Exception());

      final editActivityUseCase =
          EditActivityUseCase(activityRepository: activityRepository);

      final result = await editActivityUseCase(
        activityId: -2,
        activityFormInput: fakeActivityUpdated,
      );

      expect(result.isLeft(), true);
    });

    //* UT_EAUC_04
    test('should_return_right_when_activity_repository_right', () async {
      final activityRepository = MockActivityRepository();

      when(
        () => activityRepository.update(
          activityId: 2,
          activityData: fakeActivityUpdated,
        ),
      ).thenAnswer((_) async => Right(Activity(
            activityId: 2,
            name: fakeActivityUpdated.name,
            start: fakeActivityUpdated.start,
            end: fakeActivityUpdated.end,
            actAsk: true,
          )));

      final editActivityUseCase =
          EditActivityUseCase(activityRepository: activityRepository);

      final result = await editActivityUseCase(
        activityId: 2,
        activityFormInput: fakeActivityUpdated,
      );

      expect(result.isRight(), true);
    });

    //* UT_EAUC_05
    test('should_return_left_when_url_orm_is_empty', () async {
      const activityId = 2;
      final ActivityFormInput fakeActivityWithUrlEmpty = (
        eventId: 2,
        name: "Nueva actividad editada",
        description: "Actividad editada",
        location: "Ubicación editada",
        urlForm: "",
        start: DateTime.now(),
        end: DateTime.now(),
        speakerIds: [],
        categoryId: null,
        actAsk: false
      );
      final activityRepository = MockActivityRepository();

      when(
        () => activityRepository.update(
          activityId: activityId,
          activityData: fakeActivityWithUrlEmpty,
        ),
      ).thenAnswer(
        (_) async => Right(
          Activity(
              activityId: activityId,
              name: fakeActivityUpdated.name,
              start: fakeActivityUpdated.start,
              end: fakeActivityUpdated.end,
              actAsk: false),
        ),
      );

      final editActivityActivityUseCase = EditActivityUseCase(
        activityRepository: activityRepository,
      );

      final result = await editActivityActivityUseCase(
        activityId: activityId,
        activityFormInput: fakeActivityWithUrlEmpty,
      );
      expect(result.isLeft(), true);
    });

    //* UT_EAUC_06
    test(
      'should_return_left_when_the_end_date__is_after_the_start_date',
      () async {
        const activityId = 2;
        final ActivityFormInput fakeActivityWithUrlEmpty = (
          eventId: 2,
          name: "Nueva actividad editada",
          description: "Actividad editada",
          location: "Ubicación editada",
          urlForm: "formulario editado",
          start: DateTime(2023, 7, 12),
          end: DateTime(2023, 7, 10),
          speakerIds: [],
          categoryId: null,
          actAsk: false
        );
        final activityRepository = MockActivityRepository();

        when(
          () => activityRepository.update(
            activityId: activityId,
            activityData: fakeActivityWithUrlEmpty,
          ),
        ).thenAnswer(
          (_) async => Right(
            Activity(
                activityId: activityId,
                name: fakeActivityUpdated.name,
                start: fakeActivityUpdated.start,
                end: fakeActivityUpdated.end,
                actAsk: false),
          ),
        );

        final editActivityActivityUseCase = EditActivityUseCase(
          activityRepository: activityRepository,
        );

        final result = await editActivityActivityUseCase(
          activityId: activityId,
          activityFormInput: fakeActivityWithUrlEmpty,
        );
        expect(result.isLeft(), true);
      },
    );
  });
}
