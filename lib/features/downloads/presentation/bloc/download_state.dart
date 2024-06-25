part of 'download_bloc.dart';

sealed class DownloadState extends Equatable {
  const DownloadState();

  @override
  List<Object> get props => [];
}

final class DownloadInitial extends DownloadState {}

final class DownloadFinished extends DownloadState {}

final class DownloadFailure extends DownloadState {
  final String errorMessage;
  const DownloadFailure({required this.errorMessage});
}

final class DownloadActivitiesFailure extends DownloadState {
  final String errorMessage;
  const DownloadActivitiesFailure({required this.errorMessage});
}

final class DownloadSpeakersFailure extends DownloadState {
  final String errorMessage;
  const DownloadSpeakersFailure({required this.errorMessage});
}

final class DownloadUsersFailure extends DownloadState {
  final String errorMessage;
  const DownloadUsersFailure({required this.errorMessage});
}

final class RequestedDownload extends DownloadState {
  final String errorMessage;
  const RequestedDownload({required this.errorMessage});
}
