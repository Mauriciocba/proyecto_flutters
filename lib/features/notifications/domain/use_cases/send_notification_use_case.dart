import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/notifications/domain/entities/notification.dart';
import 'package:pamphlets_management/features/notifications/domain/service/notifier_service.dart';

import '../../../../core/errors/base_failure.dart';

final class SendNotificationUseCase {
  final NotifierService _notificationSenderService;

  SendNotificationUseCase({
    required NotifierService notificationSenderService,
  }) : _notificationSenderService = notificationSenderService;

  Future<Either<BaseFailure, String>> call({
    required int eventId,
    required String title,
    required String message,
  }) async {
    return await _notificationSenderService.send(
      notification: Notification(
        title: title,
        message: message,
        senderEventId: eventId,
      ),
    );
  }
}
