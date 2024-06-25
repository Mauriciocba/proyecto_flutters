import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';
import '../entities/event.dart';

abstract interface class InfoEventRepository {
  Future<Either<BaseFailure, Event>> getInfoEvent(int eventId);
}
