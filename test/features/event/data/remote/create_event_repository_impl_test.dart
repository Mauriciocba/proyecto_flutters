import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/event/data/remote/create_event_repository_impl.dart';
import 'package:pamphlets_management/features/event/domain/entities/create_event_model.dart';

import '../../../../mock_api_service.dart';

void main() {
  group('CreateEventRepository', () {
    test("should_return_left_when_api_service_returns_failure", () async {
      final mockApiService = MockApiService();
      final fakeModel = CreateEventModel(
          eveName: 'eveName',
          eveDescription: 'eveDescription',
          eveStart: DateTime.now(),
          eveEnd: DateTime.now(),
          eveTicket: false,
          eveNetworking: false);

      when(
        () => mockApiService.request(
            method: HttpMethod.post, url: '/events/create'),
      ).thenAnswer(
        (_) async => ApiResult.failure(statusCode: 400, body: {}),
      );
      final createEventRepositoryImpl =
          CreateEventRepositoryImpl(mockApiService);

      final result = await createEventRepositoryImpl.createEvent(fakeModel);

      expect(result.isLeft(), true);
    });

    test("should_return_right_when_api_service_returns_200", () async {
      final mockApiService = MockApiService();
      final CreateEventModel fakeModel = CreateEventModel(
          eveName: 'eveName',
          eveDescription: 'eveDescription',
          eveStart: DateTime.now(),
          eveEnd: DateTime.now(),
          eveTicket: false,
          eveNetworking: false);

      when(() => mockApiService.request(
              method: HttpMethod.post, url: '/events/create'))
          .thenAnswer((_) async => ApiResult.success(statusCode: 200));

      final createEventRepositoryImpl =
          CreateEventRepositoryImpl(mockApiService);

      final result = await createEventRepositoryImpl.createEvent(fakeModel);

      expect(result.isRight(), true);
    });
  });
}
