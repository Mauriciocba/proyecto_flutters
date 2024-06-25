import 'dart:convert';

class PaymentNetworkingModel {
  final int eventId;
  final String eveName;
  final DateTime eveEnd;
  final Payments payments;

  PaymentNetworkingModel({
    required this.eventId,
    required this.eveName,
    required this.eveEnd,
    required this.payments,
  });

  factory PaymentNetworkingModel.fromJson(String str) =>
      PaymentNetworkingModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentNetworkingModel.fromMap(Map<String, dynamic> json) =>
      PaymentNetworkingModel(
        eventId: json["eventId"],
        eveName: json["eve_name"],
        eveEnd: DateTime.parse(json["eve_end"]),
        payments: Payments.fromMap(json["payments"]),
      );

  Map<String, dynamic> toMap() => {
        "eventId": eventId,
        "eve_name": eveName,
        "eve_end": eveEnd.toIso8601String(),
        "payments": payments.toMap(),
      };
}

class Payments {
  final String amountOfPayments;

  Payments({
    required this.amountOfPayments,
  });

  factory Payments.fromJson(String str) => Payments.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Payments.fromMap(Map<String, dynamic> json) => Payments(
        amountOfPayments: json["amount_of_payments"],
      );

  Map<String, dynamic> toMap() => {
        "amount_of_payments": amountOfPayments,
      };
}
