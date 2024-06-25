import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/payment_event_model.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/payment_networking_model.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_payment_events_use_case.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_payments_data_use_case.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_payments_networking_use_case.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../domain/entities/payment_date_model.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final GetPaymentEventsUseCase getPaymentEventsUseCase;
  final GetPaymentsDataUseCase getPaymentsDataUseCase;
  final GetPaymentsNetworkingUseCase getPaymentsNetworkingUseCase;

  PaymentBloc({
    required this.getPaymentEventsUseCase,
    required this.getPaymentsNetworkingUseCase,
    required this.getPaymentsDataUseCase,
  }) : super(PaymetInitial()) {
    on<LoadPayment>(_onLoadPayment);
  }

  FutureOr<void> _onLoadPayment(LoadPayment event, emit) async {
    emit(PaymentLoading());

    final failureOrDataPayments =
        await getPaymentEventsUseCase.call(event.startDate, event.endDate);
    final failureOrPayments =
        await getPaymentsDataUseCase.call(event.startDate, event.endDate);
    final failureOrNetworking =
        await getPaymentsNetworkingUseCase.call(event.startDate, event.endDate);

    if (failureOrNetworking.isLeft()) {
      emit(PaymentFailure(errorMessage: failureOrNetworking.getLeft().message));
    }
    if (failureOrPayments.isLeft()) {
      emit(PaymentFailure(errorMessage: failureOrNetworking.getLeft().message));
    }

    failureOrDataPayments.fold(
        (error) => null,
        (data) => emit(PaymentSuccess(
            listPaymentEvents: data,
            listPaymentDateEvents: failureOrPayments.getRight(),
            listPaymentNetworking: failureOrNetworking.getRight())));
  }
}
