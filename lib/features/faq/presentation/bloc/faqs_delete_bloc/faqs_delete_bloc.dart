import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/faq/domain/use_case/delete_faq_use_case.dart';

part 'faqs_delete_event.dart';
part 'faqs_delete_state.dart';

class FaqsDeleteBloc extends Bloc<FaqsDeleteEvent, FaqsDeleteState> {
  final DeleteFaqUseCase _deleteFaqUseCase;

  FaqsDeleteBloc(this._deleteFaqUseCase) : super(FaqsDeleteInitial()) {
    on<FaqsDeletePressed>(_onDeletePressed);
  }

  FutureOr<void> _onDeletePressed(
    FaqsDeletePressed event,
    Emitter<FaqsDeleteState> emit,
  ) async {
    emit(FaqsDeleteLoading());

    final failOrData = await _deleteFaqUseCase(faqId: event.faqId);

    failOrData.fold(
      (fail) => emit(FaqsDeleteFailure(message: fail.message)),
      (data) => emit(FaqsDeleteSuccess()),
    );
  }
}
