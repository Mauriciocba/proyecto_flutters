import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/stand_delete/domain/repositories/delete_stand_repository.dart';

import '../../../../core/errors/base_failure.dart';

class DeleteStandUseCase {
  final DeleteStandRepository _deleteStandRepository;

  DeleteStandUseCase(this._deleteStandRepository);

  Future<Either<BaseFailure, bool>> call(int stdId) async {
    try {
      return await _deleteStandRepository.deleteStandInfo(stdId);
    } catch (e) {
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
