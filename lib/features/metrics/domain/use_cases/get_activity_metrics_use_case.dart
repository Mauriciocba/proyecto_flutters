import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/activity_metrics_repository.dart';

import '../../../../core/errors/base_failure.dart';
import '../entities/activity_metric.dart';

class GetActivityMetricsUseCase {
  final ActivityMetricsRepository _activityMetricsRepository;

  GetActivityMetricsUseCase(this._activityMetricsRepository);

  Future<Either<BaseFailure, List<ActivityMetric>>> getActivityMetrics(
      int eventId, DateTime? startDate, DateTime? endDate) async {
    return await _activityMetricsRepository.getActivityMetrics(
        eventId, startDate, endDate);
  }
}
