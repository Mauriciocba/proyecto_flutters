import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/event/domain/entities/setting_event_model.dart';
import 'package:pamphlets_management/features/event/domain/repositories/get_configure_repository.dart';

import '../../../../core/errors/base_failure.dart';

class GetConfigureUseCase {
  final GetConfigureRepository _getConfigureRepository;

  GetConfigureUseCase(this._getConfigureRepository);

  Future<Either<BaseFailure, SettingEventModel>> callLanguage(
      int idEvent) async {
    return await _getConfigureRepository.getConfigureEvent(idEvent);
  }
}
