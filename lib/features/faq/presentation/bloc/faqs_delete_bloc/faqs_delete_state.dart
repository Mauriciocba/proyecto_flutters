part of 'faqs_delete_bloc.dart';

sealed class FaqsDeleteState extends Equatable {
  const FaqsDeleteState();

  @override
  List<Object> get props => [];
}

final class FaqsDeleteInitial extends FaqsDeleteState {}

final class FaqsDeleteLoading extends FaqsDeleteState {}

final class FaqsDeleteSuccess extends FaqsDeleteState {}

final class FaqsDeleteFailure extends FaqsDeleteState {
  final String message;

  const FaqsDeleteFailure({required this.message});
}
