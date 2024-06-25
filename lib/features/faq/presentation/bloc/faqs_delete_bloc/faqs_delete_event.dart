part of 'faqs_delete_bloc.dart';

sealed class FaqsDeleteEvent extends Equatable {
  const FaqsDeleteEvent();

  @override
  List<Object> get props => [];
}

final class FaqsDeletePressed extends FaqsDeleteEvent {
  final int faqId;

  const FaqsDeletePressed({required this.faqId});
}
