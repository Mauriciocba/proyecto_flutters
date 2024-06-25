import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/speakers/domain/repositories/speaker_repository.dart';

import '../../../../core/errors/base_failure.dart';

class RegisterSpeakerUseCase {
  final SpeakerRepository speakerRepository;

  RegisterSpeakerUseCase(this.speakerRepository);

  Future<Either<BaseFailure, bool>> call(
      {required SpeakerForm speakersForm}) async {
    if (speakersForm.name.trim().isEmpty) {
      return Left(BaseFailure(message: 'Debe contener un nombre'));
    }

    if (speakersForm.lastName.trim().isEmpty) {
      return Left(BaseFailure(message: 'Debe contener un apellido'));
    }

    if (speakersForm.description.isEmpty) {
      return Left(BaseFailure(message: "Debe contener una descripción"));
    }

    if (speakersForm.photo.isEmpty) {
      return Left(BaseFailure(message: "Debe contener una foto"));
    }

    final result = await speakerRepository.save(speakersForm);

    if (result.isLeft()) {
      return Left(BaseFailure(message: "No se pudo registrar el Speaker"));
    }

    return const Right(true);
  }
}

typedef SpeakerForm = ({
  int eventId,
  String name,
  String lastName,
  String description,
  String photo
});
