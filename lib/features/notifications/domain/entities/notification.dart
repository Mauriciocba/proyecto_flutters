final class Notification {
  final String title;
  final String message;
  final int senderEventId;

  Notification(
      {required this.title,
      required this.message,
      required this.senderEventId});
}
