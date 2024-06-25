import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/info_event/domain/entities/event.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class InfoEventRepository {
  Future<Either<BaseFailure, Event>> getInfoEvent(int eventId);
}
