import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';
import '../entities/event.dart';

abstract interface class EventAllRepository {
  Future<Either<BaseFailure, List<Event>>> getEventAll();
}
