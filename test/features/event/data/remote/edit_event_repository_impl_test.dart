import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/event/data/remote/edit_event_repository_impl.dart';
import 'package:pamphlets_management/features/event/domain/entities/event_update.dart';

import '../../../../mock_api_service.dart';

void main() {
  group('EditEventRepository', () {
    test('should_return_left_when_api_service_returns_failure', () async {
      final mockApiService = MockApiService();

      when(
        () => mockApiService.request(
          method: HttpMethod.post,
          url: 'activities/delete',
        ),
      ).thenAnswer(
        (_) async => ApiResult.failure(
          statusCode: 400,
          body: {},
        ),
      );

      final editEventRepositoryImpl =
          EditEventRepositoryImpl(apiService: mockApiService);

      final response = await editEventRepositoryImpl.confirmChange(
          EventUpdate(
              eveName: 'eveName',
              eveDescription: 'eveDescription',
              eveStart: DateTime.now(),
              eveEnd: DateTime.now()),
          1);

      expect(response.isLeft(), true);
    });
  });
}
