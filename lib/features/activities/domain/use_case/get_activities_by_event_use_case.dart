import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/activities/domain/entities/activity.dart';
import 'package:pamphlets_management/features/activities/domain/repositories/activity_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class GetActivitiesByEventUseCase {
  final ActivityRepository _activityRepository;

  GetActivitiesByEventUseCase({
    required ActivityRepository activityRepository,
  }) : _activityRepository = activityRepository;

  Future<Either<BaseFailure, List<Activity>>> call({
    required int eventId,
    int? page,
    int? limit,
    String? search,
  }) async {
    try {
      if (eventId.isNegative) {
        return Left(BaseFailure(
            message:
                'El evento no existe, por lo tanto no contiene actividades'));
      }

      return await _activityRepository.getAllByEvent(
        eventId: eventId,
        page: page,
        limit: limit,
        search: search,
      );
    } catch (e) {
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
