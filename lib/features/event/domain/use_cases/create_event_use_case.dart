import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../../../core/errors/base_failure.dart';
import '../entities/create_event_model.dart';
import '../entities/setting_event_model.dart';
import '../repositories/create_event_repository.dart';

class CreateEventUseCase {
  final CreateEventRepository _createEventRepository;

  CreateEventUseCase(this._createEventRepository);

  Future<Either<BaseFailure, bool>> call(
      CreateEventModel newEvent, SettingEventModel configureEvent) async {
    final createEventResult =
        await _createEventRepository.createEvent(newEvent);

    if (createEventResult.isLeft()) {
      return left(BaseFailure(message: createEventResult.getLeft().message));
    }

    final int id = createEventResult.getRight();
    final addSettingResult =
        await _createEventRepository.addSetting(configureEvent, id);

    if (addSettingResult.isLeft()) {
      return left(BaseFailure(message: addSettingResult.getLeft().message));
    }

    return const Right(true);
  }
}
