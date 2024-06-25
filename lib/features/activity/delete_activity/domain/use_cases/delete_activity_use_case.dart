import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/activity/delete_activity/domain/repositories/delete_activity_repository.dart';

import '../../../../../core/errors/base_failure.dart';

class DeleteActivityUseCase {
  final DeleteActivityRepository _deleteActivityRepository;

  DeleteActivityUseCase(
      {required DeleteActivityRepository deleteActivityRepository})
      : _deleteActivityRepository = deleteActivityRepository;

  Future<Either<BaseFailure, bool>> call(int idActivity) async {
    return await _deleteActivityRepository.deleteActivity(idActivity);
  }
}
