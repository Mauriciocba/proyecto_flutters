import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/speakers_delete/domain/repository/delete_speakers_repository.dart';

import '../../../../core/errors/base_failure.dart';

class GetDeleteSpeakerUseCase {
  final DeleteSpeakerRepository _deleteSpeakerRepository;

  GetDeleteSpeakerUseCase(this._deleteSpeakerRepository);

  Future<Either<BaseFailure, bool>> call(int speakerId) async {
    try {
      return await _deleteSpeakerRepository.deleteSpeakers(speakerId);
    } catch (e) {
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
