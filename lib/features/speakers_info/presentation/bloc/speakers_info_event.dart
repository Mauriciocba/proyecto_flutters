part of 'speakers_info_bloc.dart';

sealed class SpeakersInfoEvent extends Equatable {
  const SpeakersInfoEvent();

  @override
  List<Object> get props => [];
}

class SpeakersOnStart extends SpeakersInfoEvent {
  final int eventId;
  final int? page;
  final int? limit;
  final String? search;

  const SpeakersOnStart({
    required this.eventId,
    required this.page,
    required this.limit,
    required this.search,
  });
}
