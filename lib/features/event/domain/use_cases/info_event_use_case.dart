import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';
import '../entities/event.dart';
import '../repositories/info_event_repository.dart';

class GetInfoEventUseCase {
  final InfoEventRepository _infoEventRepository;

  GetInfoEventUseCase(this._infoEventRepository);

  Future<Either<BaseFailure, Event>> call(int eventId) async {
    try {
      return await _infoEventRepository.getInfoEvent(eventId);
    } catch (e) {
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
