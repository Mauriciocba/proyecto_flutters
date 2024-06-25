part of 'faqs_bloc.dart';

sealed class FaqsState extends Equatable {
  const FaqsState();

  @override
  List<Object> get props => [];
}

final class FaqsInitial extends FaqsState {}

final class FaqsLoading extends FaqsState {}

final class FaqsSuccess extends FaqsState {
  final List<Faq> faqs;

  const FaqsSuccess({required this.faqs});
}

final class FaqsFailure extends FaqsState {
  final String message;

  const FaqsFailure({required this.message});
}
