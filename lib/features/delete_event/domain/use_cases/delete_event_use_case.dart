import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/delete_event/domain/repositories/delete_event_repository.dart';

import '../../../../core/errors/base_failure.dart';

class GetDeleteEventUseCase {
  final DeleteEventRepository _deleteEventRepository;

  GetDeleteEventUseCase(this._deleteEventRepository);

  Future<Either<BaseFailure, bool>> call(int eventId) async {
    try {
      return await _deleteEventRepository.deleteInfoEvent(eventId);
    } catch (e) {
      return left(BaseFailure(message: 'Ocurrió un error'));
    }
  }
}
