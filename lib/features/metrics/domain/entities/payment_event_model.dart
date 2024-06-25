import 'dart:convert';

class PaymentEventModel {
  final int eventId;
  final String eveName;
  final DateTime eveEnd;
  final Payments payments;

  PaymentEventModel({
    required this.eventId,
    required this.eveName,
    required this.eveEnd,
    required this.payments,
  });

  factory PaymentEventModel.fromJson(String str) =>
      PaymentEventModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentEventModel.fromMap(Map<String, dynamic> json) =>
      PaymentEventModel(
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
