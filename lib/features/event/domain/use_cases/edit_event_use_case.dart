import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/event/domain/entities/event_update.dart';

import '../../../../core/errors/base_failure.dart';
import '../repositories/edit_event_repository.dart';

class EditEventUseCase {
  final EditEventRepository _editEventRepository;

  EditEventUseCase(this._editEventRepository);

  Future<Either<BaseFailure, bool>> callConfirm(
      EventUpdate event, int idEvent) async {
    return await _editEventRepository.confirmChange(event, idEvent);
  }
}
