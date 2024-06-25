import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class DownloadRepository {
  Future<Either<BaseFailure, String>> downloadArchiveEvents();
  Future<Either<BaseFailure, String>> downloadArchiveActivities(
      int? eventId, String eventName);
  Future<Either<BaseFailure, String>> downloadArchiveSpeakers(
      int? eventId, String eventName);
  Future<Either<BaseFailure, String>> downloadUsers(
      int? eventId, String eventName);
}
