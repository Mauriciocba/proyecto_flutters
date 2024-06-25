import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/activities/domain/repositories/activity_speaker_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class AssignSpeakerToSpeakerUseCase {
  final ActivitySpeakerRepository _activitySpeakerRepository;

  AssignSpeakerToSpeakerUseCase({
    required ActivitySpeakerRepository activitySpeakerRepository,
  }) : _activitySpeakerRepository = activitySpeakerRepository;

  Future<Either<BaseFailure, bool>> call({
    required int activityId,
    required List<int> speakerIds,
  }) async {
    return _activitySpeakerRepository.save(
      activityId: activityId,
      speakersIds: speakerIds,
    );
  }
}
