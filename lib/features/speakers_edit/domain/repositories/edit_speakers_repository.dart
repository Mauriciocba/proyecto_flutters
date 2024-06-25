import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/speakers_edit/domain/entities/speaker_edit_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class SpeakersEditRepository {
  Future<Either<BaseFailure, SpeakerEditModel>> getSpeakers(
      {required SpeakerEditModel speakerEditModel});
}
