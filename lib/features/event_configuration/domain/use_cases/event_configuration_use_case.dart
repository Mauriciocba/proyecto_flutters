import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/event_configuration/domain/entities/event_configuration_model.dart';
import 'package:pamphlets_management/features/event_configuration/domain/repositories/event_configuration_repository.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../../../core/errors/base_failure.dart';

class GetEventConfigurationUseCase {
  final EventConfigurationRepository _eventConfigurationRepository;

  GetEventConfigurationUseCase(this._eventConfigurationRepository);

  Future<Either<BaseFailure, EventConfigurationModel>> call(int eventId) async {
    final failOrConfiguration = await _eventConfigurationRepository
        .getEventConfiguration(eventId: eventId);

    if (failOrConfiguration.isLeft()) {
      return Left(failOrConfiguration.getLeft());
    }

    return Right(failOrConfiguration.getRight());
  }
}
