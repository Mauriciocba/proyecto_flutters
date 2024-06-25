import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/activities/domain/entities/activity.dart';
import 'package:pamphlets_management/features/activities/domain/use_case/register_activity_use_case.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class ActivityRepository {
  Future<Either<BaseFailure, List<Activity>>> getAllByEvent(
      {required int eventId, int? page, int? limit, String? search});

  Future<Either<BaseFailure, Activity>> save(ActivityFormInput newActivity);

  Future<Either<BaseFailure, Activity>> update(
      {required int activityId, required ActivityFormInput activityData});
}
