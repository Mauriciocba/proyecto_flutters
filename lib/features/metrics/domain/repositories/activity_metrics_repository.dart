import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';
import '../entities/activity_metric.dart';

abstract interface class ActivityMetricsRepository {
  Future<Either<BaseFailure, List<ActivityMetric>>> getActivityMetrics(
      int eventId, DateTime? startDate, DateTime? endDate);
}
