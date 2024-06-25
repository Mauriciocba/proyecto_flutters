import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/event_configuration/domain/entities/event_configuration_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract class EventConfigurationRepository {
  Future<Either<BaseFailure, EventConfigurationModel>> getEventConfiguration({
    required int eventId,
  });

  Future<Either<BaseFailure, EventConfigurationModel>> editConfiguration(
      {required EventConfigurationModel eventConfigurationModel});
}
