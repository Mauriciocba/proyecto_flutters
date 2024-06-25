import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/notifications/domain/entities/notification.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class NotifierService {
  Future<Either<BaseFailure, String>> send({
    required Notification notification,
  });
}
