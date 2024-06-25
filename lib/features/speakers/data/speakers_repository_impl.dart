import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/speakers/domain/repositories/speaker_repository.dart';
import 'package:pamphlets_management/features/speakers/domain/use_case/register_speaker_use_case.dart';

import '../../../core/errors/base_failure.dart';

final class SpeakersRepositoryImpl implements SpeakerRepository {
  final ApiService _apiService;

  SpeakersRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, int>> save(
    SpeakerForm speakerForm,
  ) async {
    try {
      final result = await _apiService.request(
        method: HttpMethod.post,
        url: '/speakers/create',
        body: {
          "eve_id": speakerForm.eventId,
          "spe_first_name": speakerForm.name,
          "spe_last_name": speakerForm.lastName,
          "spe_description": speakerForm.description,
          "spe_photo": speakerForm.photo
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

      if (result.body == null || result.body?['data'] == null) {
        return left(
            BaseFailure(message: 'No se pudo obtener los datos solicitados'));
      }

      final speakerId = result.body?['data'];

      return Right(speakerId['spe_id']);
    } catch (e) {
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
