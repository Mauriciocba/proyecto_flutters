import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/speakers_edit/domain/entities/speaker_edit_model.dart';
import 'package:pamphlets_management/features/speakers_edit/domain/repositories/edit_speakers_repository.dart';

import '../../../../core/errors/base_failure.dart';

class EditSpeakersUseCase {
  final SpeakersEditRepository _speakersEditRepository;

  EditSpeakersUseCase(this._speakersEditRepository);

  Future<Either<BaseFailure, SpeakerEditModel>> call(
      {required SpeakerEditModel speakerEditModel}) async {
    try {
      if (speakerEditModel.speFirstName.isEmpty) {
        return Left(BaseFailure(message: "Debe contener un nombre"));
      }
      if (speakerEditModel.speDescription.isEmpty) {
        return Left(BaseFailure(message: "Debe contener una descripción"));
      }
      if (speakerEditModel.speLastName.isEmpty) {
        return Left(BaseFailure(message: "Debe contener un apellido"));
      }

      return await _speakersEditRepository.getSpeakers(
          speakerEditModel: speakerEditModel);
    } catch (e) {
      return Left(BaseFailure(message: 'No se pudo editar'));
    }
  }
}
