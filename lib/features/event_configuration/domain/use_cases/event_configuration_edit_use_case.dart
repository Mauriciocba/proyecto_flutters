import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/event_configuration/domain/entities/event_configuration_model.dart';
import 'package:pamphlets_management/features/event_configuration/domain/repositories/event_configuration_repository.dart';

import '../../../../core/errors/base_failure.dart';

class EditConfigurationUseCase {
  final EventConfigurationRepository _eventConfigurationEditRepository;

  EditConfigurationUseCase(this._eventConfigurationEditRepository);

  Future<Either<BaseFailure, EventConfigurationModel>> call(
      {required EventConfigurationModel configModel}) async {
    try {
      return await _eventConfigurationEditRepository.editConfiguration(
          eventConfigurationModel: configModel);
    } catch (e) {
      return Left(BaseFailure(message: 'No se pudo editar'));
    }
  }
}
