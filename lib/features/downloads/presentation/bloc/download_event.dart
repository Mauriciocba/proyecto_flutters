part of 'download_bloc.dart';

class DownloadEvent extends Equatable {
  const DownloadEvent();

  @override
  List<Object> get props => [];
}

class RequestedDownloadEvents extends DownloadEvent {}

class RequestedDownloadEvent extends DownloadEvent {
  final int? eventId;
  final String eventName;
  final List<PopupMenuItemGroupDownload> items;
  const RequestedDownloadEvent(
      {required this.eventId, required this.eventName, required this.items});
}

class RequestedDownloadActivity extends DownloadEvent {
  final int? eventId;
  final String eventName;
  const RequestedDownloadActivity(
      {required this.eventId, required this.eventName});
}

class RequestedDownloadSpeakers extends DownloadEvent {
  final int? eventId;
  final String eventName;
  const RequestedDownloadSpeakers(
      {required this.eventId, required this.eventName});
}

class RequestedDownloadUsers extends DownloadEvent {
  final int? eventId;
  final String eventName;
  const RequestedDownloadUsers(
      {required this.eventId, required this.eventName});
}
