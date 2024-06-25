import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/event/domain/entities/event_update.dart';
import 'package:pamphlets_management/features/event/domain/use_cases/edit_event_use_case.dart';

import 'mock_edit_event_repository.dart';

void main() {
  group('CreateEventUseCase', () {
    setUpAll(() {
      registerFallbackValue(MockEditEventRepository());
    });

    test(
        'Debe devolver un true cuando el usuario edita correctamente un evento',
        () async {
      final editEventRepository = MockEditEventRepository();
      final editEventUseCase = EditEventUseCase(editEventRepository);

      final EventUpdate fakeModel = EventUpdate(
          eveName: 'eveName',
          eveDescription: 'eveDescription',
          eveStart: DateTime.now(),
          eveEnd: DateTime.now());

      when(
        () => editEventRepository.confirmChange(fakeModel, 1),
      ).thenAnswer(
        (_) async => right(true),
      );

      Either<BaseFailure, bool> response =
          await editEventUseCase.callConfirm(fakeModel, 1);

      expect(response.isRight(), true);
    });

    test('Debe devolver left cuando el usuario  un evento', () async {
      final editEventRepository = MockEditEventRepository();
      final editEventUseCase = EditEventUseCase(editEventRepository);

      final EventUpdate fakeModel = EventUpdate(
          eveName: 'eveName',
          eveDescription: 'eveDescription',
          eveStart: DateTime.now(),
          eveEnd: DateTime.now());

      when(
        () => editEventRepository.confirmChange(fakeModel, 1),
      ).thenAnswer(
        (_) async => right(true),
      );

      Either<BaseFailure, bool> response =
          await editEventUseCase.callConfirm(fakeModel, 1);

      expect(response.isRight(), true);
    });
  });
}
