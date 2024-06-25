import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/speakers_edit/domain/entities/speaker_edit_model.dart';
import 'package:pamphlets_management/features/speakers_edit/domain/repositories/edit_speakers_repository.dart';

import '../../../core/errors/base_failure.dart';

final class EditSpeakersRepositoryImpl implements SpeakersEditRepository {
  final ApiService _apiService;

  EditSpeakersRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, SpeakerEditModel>> getSpeakers(
      {required SpeakerEditModel speakerEditModel}) async {
    try {
      final result = await _apiService.request(
        method: HttpMethod.patch,
        url: '/speakers/update/${speakerEditModel.speId}',
        body: {
          "eve_id": speakerEditModel.eveId,
          "spe_first_name": speakerEditModel.speFirstName,
          "spe_last_name": speakerEditModel.speLastName,
          "spe_description": speakerEditModel.speDescription,
          "spe_photo": speakerEditModel.spePhoto
        },
      );

      if (result.resultType == ResultType.failure) {
        return Left(
            BaseFailure(message: 'Hubo una falla en la obtención de datos'));
      }

      if (result.resultType == ResultType.error) {
        return Left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }

      return Right(SpeakerEditModel(
          speId: speakerEditModel.speId,
          eveId: speakerEditModel.eveId,
          speFirstName: speakerEditModel.speFirstName,
          speLastName: speakerEditModel.speLastName,
          speDescription: speakerEditModel.speDescription,
          spePhoto: speakerEditModel.spePhoto));
    } catch (e) {
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
