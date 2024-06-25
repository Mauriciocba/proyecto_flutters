import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';
import '../use_case/register_speaker_use_case.dart';

abstract interface class SpeakerRepository {
  Future<Either<BaseFailure, int>> save(SpeakerForm speakers);
}
