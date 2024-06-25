import 'dart:convert';

List<PaymentDateModel> paymentDateModelFromMap(String str) => List<PaymentDateModel>.from(json.decode(str).map((x) => PaymentDateModel.fromMap(x)));

String paymentDateModelToMap(List<PaymentDateModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class PaymentDateModel {
    int eventId;
    String eveName;
    DateTime eveEnd;
    List<Payment> payments;

    PaymentDateModel({
        required this.eventId,
        required this.eveName,
        required this.eveEnd,
        required this.payments,
    });

    factory PaymentDateModel.fromMap(Map<String, dynamic> json) => PaymentDateModel(
        eventId: json["eventId"],
        eveName: json["eve_name"],
        eveEnd: DateTime.parse(json["eve_end"]),
        payments: List<Payment>.from(json["payments"].map((x) => Payment.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "eventId": eventId,
        "eve_name": eveName,
        "eve_end": eveEnd.toIso8601String(),
        "payments": List<dynamic>.from(payments.map((x) => x.toMap())),
    };
}

class Payment {
    String payType;
    String amountOfPayments;

    Payment({
        required this.payType,
        required this.amountOfPayments,
    });

    factory Payment.fromMap(Map<String, dynamic> json) => Payment(
        payType: json["pay_type"],
        amountOfPayments: json["amount_of_payments"],
    );

    Map<String, dynamic> toMap() => {
        "pay_type": payType,
        "amount_of_payments": amountOfPayments,
    };
}