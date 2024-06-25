import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/errors/base_failure.dart';
import 'package:pamphlets_management/features/event/domain/entities/create_event_model.dart';
import 'package:pamphlets_management/features/event/domain/entities/setting_event_model.dart';
import 'package:pamphlets_management/features/event/domain/use_cases/create_event_use_case.dart';

import 'mock_create_event_repository.dart';

void main() {
  group('CreateEventUseCase', () {
    setUpAll(() {
      registerFallbackValue(MockCreateEventRepository());
    });

    test(
      'Debe devolver un true cuando el usuario crea el evento correctamente',
      () async {
        final createEventRepository = MockCreateEventRepository();
        final createUseCase = CreateEventUseCase(createEventRepository);

        final CreateEventModel fakeModel = CreateEventModel(
            eveName: 'nombre',
            eveDescription: 'descripcion',
            eveNetworking: false,
            eveTicket: false,
            eveLogo: 'logo',
            eveIcon: 'icon',
            eveAdditionalInfo: 'info',
            evePhoto: 'photo',
            eveSubtitle: 'subtitle',
            siteWeb: 'htpsaoidf',
            eveAddress: 'eveAddress',
            eveUrlMap: 'asdfas',
            eveStart: DateTime.now(),
            eveEnd: DateTime.now());

        when(
          () => createEventRepository.createEvent(
            fakeModel,
          ),
        ).thenAnswer(
          (_) async => right(1),
        );

        Either<BaseFailure, bool> result = await createUseCase(
            fakeModel, SettingEventModel(eveId: 1, estLanguage: 'es'));

        expect(result.isRight(), true);
      },
    );

    test(
      'Debe devolver un Left si la fecha final es menor a la fecha de inicio',
      () async {
        final createEventRepository = MockCreateEventRepository();
        final createUseCase = CreateEventUseCase(createEventRepository);

        final CreateEventModel fakeModel = CreateEventModel(
          eveName: 'eveName',
          eveDescription: 'eveDescription',
          eveLogo: 'adf31dasd',
          eveIcon: 'asd12d12',
          siteWeb: 'htpsaoidf',
          eveAddress: 'eveAddress',
          eveUrlMap: 'https:google',
          eveStart: DateTime.now(),
          eveEnd: DateTime.now().subtract(const Duration(days: 1)),
          eveNetworking: false,
          eveTicket: false,
        );

        when(
          () => createEventRepository.createEvent(
            fakeModel,
          ),
        ).thenAnswer(
          (_) async => left(BaseFailure(
              message: 'La fecha de inicio es mayor que la fecha de fin')),
        );

        Either<BaseFailure, bool> result = await createUseCase(
            fakeModel, SettingEventModel(eveId: 1, estLanguage: 'es'));

        expect(result.isLeft(), true);
      },
    );

    test(
      'Debe devolver un true si la foto, subtitulo y info adicional son null',
      () async {
        final createEventRepository = MockCreateEventRepository();
        final createUseCase = CreateEventUseCase(createEventRepository);

        final CreateEventModel fakeModel = CreateEventModel(
            eveName: 'eveName',
            eveDescription: 'eveDescription',
            eveLogo: 'dfasdifo2j3f2',
            eveIcon: 'asdfoi2jn312k0',
            evePhoto: null,
            eveSubtitle: null,
            eveAdditionalInfo: null,
            siteWeb: 'htpsaoidf',
            eveAddress: 'eveAddress',
            eveUrlMap: 'https:google....',
            eveStart: DateTime.now(),
            eveEnd: DateTime.now(),
            eveTicket: false,
            eveNetworking: false);

        when(
          () => createEventRepository.createEvent(
            fakeModel,
          ),
        ).thenAnswer(
          (_) async => right(1),
        );

        Either<BaseFailure, bool> result = await createUseCase(
            fakeModel, SettingEventModel(eveId: 1, estLanguage: 'es'));

        expect(result.isRight(), true);
      },
    );
  });
}
