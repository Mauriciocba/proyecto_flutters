import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/sponsor_delete/domain/repositories/delete_sponsors_repository.dart';

import '../../../../core/errors/base_failure.dart';

class DeleteSponsorsUseCase {
  final DeleteSponsorsRepository _deleteSponsorsRepository;

  DeleteSponsorsUseCase(this._deleteSponsorsRepository);

  Future<Either<BaseFailure, bool>> call(int spoId) async {
    try {
      return await _deleteSponsorsRepository.deleteSponsorsInfo(spoId);
    } catch (e) {
      return left(BaseFailure(message: 'Ocurrió un error'));
    }
  }
}
