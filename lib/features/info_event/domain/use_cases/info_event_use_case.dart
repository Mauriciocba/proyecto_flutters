import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/info_event/domain/entities/event.dart';
import 'package:pamphlets_management/features/info_event/domain/repositories/info_event_repository.dart';

import '../../../../core/errors/base_failure.dart';

class GetInfoEventUseCase {
  final InfoEventRepository _infoEventRepository;

  GetInfoEventUseCase(this._infoEventRepository);

  Future<Either<BaseFailure, Event>> call(int eventId) async {
    return await _infoEventRepository.getInfoEvent(eventId);
  }
}
