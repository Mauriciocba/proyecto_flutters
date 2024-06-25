part of 'news_info_bloc.dart';

sealed class NewsInfoEvent extends Equatable {
  const NewsInfoEvent();

  @override
  List<Object> get props => [];
}

class NewsInfoStart extends NewsInfoEvent {
  final int eventId;

  const NewsInfoStart({required this.eventId});
}
