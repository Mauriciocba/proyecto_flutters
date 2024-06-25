part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class LoadPayment extends PaymentEvent {
  final DateTime? startDate;
  final DateTime? endDate;

  const LoadPayment({required this.startDate, required this.endDate});
}
