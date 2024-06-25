part of 'notifier_bloc.dart';

sealed class NotifierEvent extends Equatable {
  const NotifierEvent();

  @override
  List<Object> get props => [];
}

final class NotifierSendPressed extends NotifierEvent {
  final String title;
  final String message;
  final int eventId;

  const NotifierSendPressed(
      {required this.title, required this.message, required this.eventId});
}
