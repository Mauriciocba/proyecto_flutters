part of 'payment_bloc.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymetInitial extends PaymentState {}

class PaymentFailure extends PaymentState {
  final String errorMessage;

  const PaymentFailure({required this.errorMessage});
}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final List<PaymentEventModel> listPaymentEvents;
  final List<PaymentDateModel> listPaymentDateEvents;
  final List<PaymentNetworkingModel> listPaymentNetworking;

  const PaymentSuccess(
      {required this.listPaymentEvents,
      required this.listPaymentNetworking,
      required this.listPaymentDateEvents});

  @override
  List<Object> get props => [listPaymentEvents, listPaymentNetworking];
}
