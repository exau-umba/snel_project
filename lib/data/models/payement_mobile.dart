// To parse this JSON data, do
//
//     final paymentMobile = paymentMobileFromJson(jsonString);

import 'dart:convert';

PaymentMobile paymentMobileFromJson(String str) => PaymentMobile.fromJson(json.decode(str));

String paymentMobileToJson(PaymentMobile data) => json.encode(data.toJson());

class PaymentMobile {
  int? id;
  String? numero;
  String? devise;
  int? idClient;

  PaymentMobile({
    this.id,
    this.numero,
    this.devise,
    this.idClient
  });

  factory PaymentMobile.fromJson(Map<String, dynamic> json) => PaymentMobile(
    id: json["id"],
    numero: json["numero"],
    devise: json["devise"],
    idClient: json["idClient"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "numero": numero,
    "devise": devise,
    "idClient": idClient,
  };
}
