import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/sponsors_info/domain/entities/sponsors_info_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract class SponsorsInfoRepository {
  Future<Either<BaseFailure, List<Sponsor>>> getSponsorsInfoByEvent(
      {required int eventId});
}
