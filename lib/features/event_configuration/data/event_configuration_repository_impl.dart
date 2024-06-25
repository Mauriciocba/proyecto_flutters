import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/event_configuration/domain/entities/event_configuration_model.dart';
import 'package:pamphlets_management/features/event_configuration/domain/repositories/event_configuration_repository.dart';

import '../../../core/errors/base_failure.dart';

class EventConfigurationRepositoryImpl implements EventConfigurationRepository {
  final ApiService apiService;

  const EventConfigurationRepositoryImpl({required this.apiService});
  @override
  Future<Either<BaseFailure, EventConfigurationModel>> getEventConfiguration(
      {required int eventId}) async {
    try {
      final result = await apiService.request(
        method: HttpMethod.get,
        url: "/event-settings/eventID/$eventId",
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

      final resultData = result.body?['data'];
      final eventConfiguration = EventConfigurationModel.fromMap(resultData);

      if (resultData == null) {
        return Left(
            BaseFailure(message: 'No se pudo obtener los datos solicitados'));
      }

      if (resultData is List && resultData.isEmpty) {
        return Right(eventConfiguration);
      }

      return Right(eventConfiguration);
    } catch (e) {
      debugPrint(e.toString());
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }

  @override
  Future<Either<BaseFailure, EventConfigurationModel>> editConfiguration(
      {required EventConfigurationModel eventConfigurationModel}) async {
    try {
      final result = await apiService.request(
        method: HttpMethod.patch,
        url: "/event-settings/update/${eventConfigurationModel.estId}",
        body: {
          "est_primary_color_dark": eventConfigurationModel.estPrimaryColorDark,
          "est_secondary_1_color_dark":
              eventConfigurationModel.estSecondary1ColorDark,
          "est_secondary_2_color_dark":
              eventConfigurationModel.estSecondary2ColorDark,
          "est_secondary_3_color_dark":
              eventConfigurationModel.estSecondary3ColorDark,
          "est_accent_color_dark": eventConfigurationModel.estAccentColorDark,
          "est_primary_color_light":
              eventConfigurationModel.estPrimaryColorLight,
          "est_secondary_1_color_light":
              eventConfigurationModel.estSecondary1ColorLight,
          "est_secondary_2_color_light":
              eventConfigurationModel.estSecondary2ColorLight,
          "est_secondary_3_color_light":
              eventConfigurationModel.estSecondary3ColorLight,
          "est_accent_color_light": eventConfigurationModel.estAccentColorLight,
          "est_language": eventConfigurationModel.estLanguage,
          "est_font": eventConfigurationModel.estFont,
          "est_time_zone": eventConfigurationModel.estTimeZone,
          "eve_id": eventConfigurationModel.eveId,
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

      return Right(EventConfigurationModel(
          estId: eventConfigurationModel.estId,
          estPrimaryColorDark: eventConfigurationModel.estPrimaryColorDark,
          estSecondary1ColorDark:
              eventConfigurationModel.estSecondary1ColorDark,
          estSecondary2ColorDark:
              eventConfigurationModel.estSecondary2ColorDark,
          estSecondary3ColorDark:
              eventConfigurationModel.estSecondary3ColorDark,
          estAccentColorDark: eventConfigurationModel.estAccentColorDark,
          estPrimaryColorLight: eventConfigurationModel.estPrimaryColorLight,
          estSecondary1ColorLight:
              eventConfigurationModel.estSecondary1ColorLight,
          estSecondary2ColorLight:
              eventConfigurationModel.estSecondary2ColorLight,
          estSecondary3ColorLight:
              eventConfigurationModel.estSecondary3ColorLight,
          estAccentColorLight: eventConfigurationModel.estAccentColorLight,
          estLanguage: eventConfigurationModel.estLanguage,
          estFont: eventConfigurationModel.estFont,
          estTimeZone: eventConfigurationModel.estTimeZone,
          eveId: eventConfigurationModel.eveId));
    } catch (e) {
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
