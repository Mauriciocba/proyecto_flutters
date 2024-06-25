import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/speakers_info/domain/entities/speakers_info_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract class SpeakersInfoRepository {
  Future<Either<BaseFailure, List<SpeakersModel>>> getSpeakersByEvent({
    required int eventId,
    int? page,
    int? limit,
    String? search,
  });
}
