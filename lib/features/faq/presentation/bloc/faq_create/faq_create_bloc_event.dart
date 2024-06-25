part of 'faq_create_bloc_bloc.dart';

sealed class FaqCreateEvent extends Equatable {
  const FaqCreateEvent();

  @override
  List<Object> get props => [];
}

class FaqCreatePressed extends FaqCreateEvent {
  final String question;
  final String answer;
  final int eventId;
  final List<String> urlImages;

  const FaqCreatePressed({
    required this.question,
    required this.answer,
    required this.eventId,
    required this.urlImages,
  });
}
