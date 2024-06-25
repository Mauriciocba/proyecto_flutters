import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class ActivitySpeakerRepository {
  Future<Either<BaseFailure, bool>> save({
    required int activityId,
    required List<int> speakersIds,
  });
}
