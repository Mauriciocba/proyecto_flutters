import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/activities/domain/entities/activity.dart';
import 'package:pamphlets_management/features/activities/domain/repositories/activity_repository.dart';
import 'package:pamphlets_management/features/activities/domain/use_case/register_activity_use_case.dart';

import '../../../../core/errors/base_failure.dart';

final class EditActivityUseCase {
  final ActivityRepository _activityRepository;

  EditActivityUseCase({required ActivityRepository activityRepository})
      : _activityRepository = activityRepository;

  Future<Either<BaseFailure, Activity>> call({
    required int activityId,
    required ActivityFormInput activityFormInput,
  }) async {
    try {
      if (activityFormInput.end.isBefore(activityFormInput.start)) {
        return Left(
            BaseFailure(message: "La fecha de finalización es invalida"));
      }

      return await _activityRepository.update(
        activityId: activityId,
        activityData: activityFormInput,
      );
    } catch (e) {
      return Left(BaseFailure(message: 'No se pudo editar la actividad'));
    }
  }
}
