part of 'faqs_bloc.dart';

sealed class FaqsEvent extends Equatable {
  const FaqsEvent();

  @override
  List<Object> get props => [];
}

final class FaqsStarted extends FaqsEvent {
  final int eventId;

  const FaqsStarted({required this.eventId});
}
