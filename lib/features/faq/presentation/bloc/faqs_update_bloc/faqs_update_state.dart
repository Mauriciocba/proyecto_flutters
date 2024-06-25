part of 'faqs_update_bloc.dart';

sealed class FaqsUpdateState extends Equatable {
  const FaqsUpdateState();

  @override
  List<Object> get props => [];
}

final class FaqsUpdateInitial extends FaqsUpdateState {}

final class FaqsUpdateLoading extends FaqsUpdateState {}

final class FaqsUpdateFailure extends FaqsUpdateState {
  final String message;

  const FaqsUpdateFailure({required this.message});
}

final class FaqsUpdateSuccess extends FaqsUpdateState {}

final class FaqsUpdateFormLoaded extends FaqsUpdateState {
  final FaqForm faqForm;

  const FaqsUpdateFormLoaded({required this.faqForm});
}
