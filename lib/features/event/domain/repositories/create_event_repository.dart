import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';
import '../entities/create_event_model.dart';
import '../entities/setting_event_model.dart';

abstract interface class CreateEventRepository {
  Future<Either<BaseFailure, int>> createEvent(CreateEventModel newEvent);
  Future<Either<BaseFailure, bool>> addSetting(
      SettingEventModel newSettingEvent, int eventId);
}
