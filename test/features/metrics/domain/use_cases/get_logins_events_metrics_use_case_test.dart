import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/logins_events_metrics_model.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/logins_events_metrics_repository.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_logins_events_metrics_use_case.dart';

import 'mock_logins_events_metrics_repository.dart';

void main() {
  group('GetLoginsEventsMetricsUseCase', () {
    late GetLoginsEventsMetricsUseCase getLoginsEventsMetricsUseCase;
    late LoginsEventsMetricsRepository mockLoginsEventsMetricsRepository;

    setUp(() {
      mockLoginsEventsMetricsRepository = MockLoginsEventsMetricsRepository();
      getLoginsEventsMetricsUseCase = GetLoginsEventsMetricsUseCase(
          getLoginsEventsMetrics: mockLoginsEventsMetricsRepository);
    });

    test('should_return_right_when_repository_return_right', () async {
      final DateTime startDate = DateTime(2020, 1, 1);
      final DateTime endDate = DateTime(2025, 1, 31);
      final List<LoginsEventsMetricsModel> loginsEventsMetrics = [
        LoginsEventsMetricsModel(
            logins: Logins(
                eveEnd: DateTime.now(),
                eveId: 1,
                eveName: "event 1",
                loginsPerEvent: "5")),
      ];

      when(() => mockLoginsEventsMetricsRepository.getLoginsEventsMetrics(
            startDate,
            endDate,
          )).thenAnswer((_) async => Right(loginsEventsMetrics));

      final result = await getLoginsEventsMetricsUseCase(startDate, endDate);

      expect(result.isRight(), true);
    });

    test('should_return_left_when_repository_return_left', () async {
      final DateTime startDate = DateTime(2020, 1, 1);
      final DateTime endDate = DateTime(2025, 1, 31);
      final BaseFailure failure = BaseFailure(message: 'Error');

      when(() => mockLoginsEventsMetricsRepository.getLoginsEventsMetrics(
            startDate,
            endDate,
          )).thenAnswer((_) async => Left(failure));

      final result = await getLoginsEventsMetricsUseCase(startDate, endDate);

      expect(result.isLeft(), true);
    });
  });
}
