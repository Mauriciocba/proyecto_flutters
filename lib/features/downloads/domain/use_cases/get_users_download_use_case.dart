import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/downloads/domain/repository/download_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class GetUsersDownloadUseCase {
  final DownloadRepository _downloadRepository;
  GetUsersDownloadUseCase(this._downloadRepository);

  Future<Either<BaseFailure, String>> call(
      int? eventId, String eventName) async {
    final result = await _downloadRepository.downloadUsers(eventId, eventName);
    return result;
  }
}
