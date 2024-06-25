import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/event/domain/entities/setting_event_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class GetConfigureRepository {
  Future<Either<BaseFailure, SettingEventModel>> getConfigureEvent(int idEvent);
}
