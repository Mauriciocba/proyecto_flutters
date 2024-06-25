part of 'faq_create_bloc_bloc.dart';

sealed class FaqCreateState extends Equatable {
  const FaqCreateState();

  @override
  List<Object> get props => [];
}

final class FaqCreateBlocInitial extends FaqCreateState {}

final class FaqCreateBlocLoading extends FaqCreateState {}

final class FaqCreateBlocSuccess extends FaqCreateState {
  final Faq faqModel;

  const FaqCreateBlocSuccess({required this.faqModel});
}

final class FaqCreateBlocFailure extends FaqCreateState {
  final String message;

  const FaqCreateBlocFailure({required this.message});
}
