import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/speakers_info/domain/entities/speakers_info_model.dart';
import 'package:pamphlets_management/features/speakers_info/domain/repositories/speakers_info_repository.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../../../core/errors/base_failure.dart';

class GetSpeakersInfoUseCase {
  final SpeakersInfoRepository _speakersRepository;

  GetSpeakersInfoUseCase(this._speakersRepository);

  Future<Either<BaseFailure, List<SpeakersModel>>> call(
      {required int eventId, int? page, int? limit, String? search}) async {
    final failOrSpeakers = await _speakersRepository.getSpeakersByEvent(
      eventId: eventId,
      page: page,
      limit: limit,
      search: search,
    );
    if (failOrSpeakers.isLeft()) {
      return Left(failOrSpeakers.getLeft());
    }

    if (failOrSpeakers.getRight().isEmpty) {
      return Left(BaseFailure(message: "No hay speakers"));
    }

    return Right(failOrSpeakers.getRight());
  }
}
