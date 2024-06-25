import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/notifications/domain/use_cases/send_notification_use_case.dart';

part 'notifier_event.dart';
part 'notifier_state.dart';

class NotifierBloc extends Bloc<NotifierEvent, NotifierState> {
  final SendNotificationUseCase _sendNotificationUseCase;

  NotifierBloc(this._sendNotificationUseCase) : super(NotifierInitial()) {
    on(_onSendPressed);
  }

  FutureOr<void> _onSendPressed(
    NotifierSendPressed event,
    Emitter<NotifierState> emit,
  ) async {
    emit(NotifierInProgress());

    final failOrData = await _sendNotificationUseCase(
      eventId: event.eventId,
      message: event.message,
      title: event.title,
    );

    failOrData.fold(
      (fail) => emit(NotifierFailure(errorMessage: fail.message)),
      (success) => emit(NotifierSuccess(message: success)),
    );
  }
}
