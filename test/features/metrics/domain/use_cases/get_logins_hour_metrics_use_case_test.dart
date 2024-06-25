import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/logins_hour_metrics_model.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/logins_hour_metrics_repository.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_logins_hour_metrics_use_case.dart';

import 'mock_logins_hour_metrics_repository.dart';

void main() {
  group('GetLoginsHourMetricsUseCase', () {
    late GetLoginsHourMetricsUseCase getLoginsHourMetricsUseCase;
    late LoginsHourMetricsRepository mockLoginsHourMetricsRepository;

    setUp(() {
      mockLoginsHourMetricsRepository = MockLoginsHourMetricsRepository();
      getLoginsHourMetricsUseCase = GetLoginsHourMetricsUseCase(
          getLoginsHourMetricsRepository: mockLoginsHourMetricsRepository);
    });

    test('should_return_right_when_repository_return_right', () async {
      final DateTime startDate = DateTime(2022, 1, 1);
      final DateTime endDate = DateTime(2022, 1, 31);
      final List<LoginsHourMetricsModel> loginsHourMetrics = [
        LoginsHourMetricsModel(
          eveName: "event 1",
          eventId: 1,
          logins: [Login(loginHour: DateTime.now(), loginsPerHour: "5")],
        ),
      ];

      when(() => mockLoginsHourMetricsRepository.getLoginsHourMetrics(
            startDate,
            endDate,
          )).thenAnswer((_) async => Right(loginsHourMetrics));

      final result = await getLoginsHourMetricsUseCase(startDate, endDate);

      expect(result.isRight(), true);
    });

    test('should_return_left_when_repository_return_left', () async {
      final DateTime startDate = DateTime(2020, 1, 1);
      final DateTime endDate = DateTime(2025, 1, 31);
      final BaseFailure failure = BaseFailure(message: 'Error');

      when(() => mockLoginsHourMetricsRepository.getLoginsHourMetrics(
            startDate,
            endDate,
          )).thenAnswer((_) async => Left(failure));

      final result = await getLoginsHourMetricsUseCase(startDate, endDate);

      expect(result.isLeft(), true);
    });
  });
}
