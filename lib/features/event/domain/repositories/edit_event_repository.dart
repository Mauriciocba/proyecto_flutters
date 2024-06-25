import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/event/domain/entities/event_update.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class EditEventRepository {
  Future<Either<BaseFailure, bool>> confirmChange(
      EventUpdate event, int idEvent);
}
