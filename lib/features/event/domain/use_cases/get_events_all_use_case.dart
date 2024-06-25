import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/event/domain/entities/event.dart';
import 'package:pamphlets_management/features/event/domain/repositories/event_all_repository.dart';

import '../../../../core/errors/base_failure.dart';

class GetEventAllUseCase {
  final EventAllRepository _eventAllRepository;

  GetEventAllUseCase(this._eventAllRepository);

  Future<Either<BaseFailure, List<Event>>> call() async {
    try {
      return await _eventAllRepository.getEventAll();
    } catch (e) {
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
