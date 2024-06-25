import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/stand_info/domain/entities/stands_info_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract class StandsInfoRepository {
  Future<Either<BaseFailure, List<StandsInfoModel>>> getStandsInfoByEvent(
      {required int eventId});
}
