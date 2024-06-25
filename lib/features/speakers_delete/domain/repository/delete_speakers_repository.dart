import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class DeleteSpeakerRepository {
  Future<Either<BaseFailure, bool>> deleteSpeakers(int speakerId);
}
