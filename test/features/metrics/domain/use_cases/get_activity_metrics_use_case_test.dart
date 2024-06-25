import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/activity_metric.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/activity_metrics_repository.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_activity_metrics_use_case.dart';

import 'mock_activity_metrics_repository.dart';

void main() {
  group('GetActivityMetricsUseCase', () {
    late GetActivityMetricsUseCase getActivityMetricsUseCase;
    late ActivityMetricsRepository mockActivityMetricsRepository;

    setUp(() {
      mockActivityMetricsRepository = MockActivityMetricsRepository();
      getActivityMetricsUseCase =
          GetActivityMetricsUseCase(mockActivityMetricsRepository);
    });

    test('should_return_right_when_repository_return_right', () async {
      const int eventId = 1;
      final DateTime startDate = DateTime(2020, 1, 1);
      final DateTime endDate = DateTime(2025, 1, 31);
      final List<ActivityMetric> activityMetrics = [
        ActivityMetric(actId: 1, actName: 'Activity 1', activityLogs: "5"),
        ActivityMetric(actId: 2, actName: 'Activity 2', activityLogs: "8"),
      ];

      when(() => mockActivityMetricsRepository.getActivityMetrics(
            eventId,
            startDate,
            endDate,
          )).thenAnswer((_) async => Right(activityMetrics));

      final result = await getActivityMetricsUseCase.getActivityMetrics(
        eventId,
        startDate,
        endDate,
      );

      expect(result.isRight(), true);
    });

    test('should_return_left_when_repository_return_left', () async {
      const int eventId = 1;
      final DateTime startDate = DateTime(2020, 1, 1);
      final DateTime endDate = DateTime(2025, 1, 31);
      final BaseFailure failure = BaseFailure(message: 'Error');

      when(() => mockActivityMetricsRepository.getActivityMetrics(
            eventId,
            startDate,
            endDate,
          )).thenAnswer((_) async => Left(failure));

      final result = await getActivityMetricsUseCase.getActivityMetrics(
        eventId,
        startDate,
        endDate,
      );

      expect(result.isLeft(), true);
    });
  });
}
