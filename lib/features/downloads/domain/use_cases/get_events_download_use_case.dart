import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/downloads/domain/repository/download_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class GetEventsDownloadUseCase {
  final DownloadRepository _downloadRepository;
  GetEventsDownloadUseCase(this._downloadRepository);

  Future<Either<BaseFailure, String>> call() async {
    final result = await _downloadRepository.downloadArchiveEvents();
    return result;
  }
}
