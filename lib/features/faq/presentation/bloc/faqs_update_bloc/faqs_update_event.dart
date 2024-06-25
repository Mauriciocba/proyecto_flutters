part of 'faqs_update_bloc.dart';

sealed class FaqsUpdateEvent extends Equatable {
  const FaqsUpdateEvent();

  @override
  List<Object> get props => [];
}

final class FaqsUpdateStarted extends FaqsUpdateEvent {
  final FaqForm faqForm;

  const FaqsUpdateStarted({required this.faqForm});
}

final class FaqsUpdatePressed extends FaqsUpdateEvent {
  final FaqForm faqsData;
  final List<ImageFaq> currentImages;

  const FaqsUpdatePressed({
    required this.faqsData,
    required this.currentImages,
  });
}
