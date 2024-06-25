import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/stand_edit/domain/entities/stands_edit_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class StandEditRepository {
  Future<Either<BaseFailure, StandsEditModel>> loadStands(
      {required StandsEditModel standEditModel});
}
