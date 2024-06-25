import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/event/domain/entities/event.dart';
import 'package:pamphlets_management/features/event/domain/use_cases/get_events_all_use_case.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import 'mock_event_all_repository.dart';

void main() {
  group('get events all use case ...', () {
    setUpAll(() {
      registerFallbackValue(MockEventAllRepository);
    });

    test(
        'Should return right with a list of events when the repository returns rigth with a list of events',
        () async {
      final eventallRepository = MockEventAllRepository();
      final getEventAllUseCase = GetEventAllUseCase(eventallRepository);
      final listFake = [
        Event(
            eveId: 2,
            eveName: "Extradosssss",
            eveDescription: " empresa de software",
            eveLogo: "",
            eveUrl: "www.google.com",
            eveIcon: "",
            eveAddress: "abc 123",
            eveUrlMap: "ubicacionFake",
            eveStart: DateTime.parse("2023-10-11 08:00:00"),
            eveEnd: DateTime.parse("2023-10-11 08:00:00"),
            evePhoto: "www.google.com",
            eveSubtitle: "evento",
            eveAdditionalInfo: "evento 2"),
      ];

      when(
        () => eventallRepository.getEventAll(),
      ).thenAnswer((_) async => Right(listFake));

      Either<BaseFailure, List<Event>> result = await getEventAllUseCase();

      expect(result.isRight(), true);
      expect(result.getRight().isNotEmpty, true);
    });

    test('should return left when the repository throws an exception',
        () async {
      final eventallRepository = MockEventAllRepository();
      final getEventAllUseCase = GetEventAllUseCase(eventallRepository);

      when(
        () => eventallRepository.getEventAll(),
      ).thenThrow(Exception());

      Either<BaseFailure, List<Event>> result = await getEventAllUseCase();
      expect(result.isLeft(), true);
    });
  });
}
