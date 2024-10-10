// To parse this JSON data, do
//
//     final paymentCard = paymentCardFromJson(jsonString);

import 'dart:convert';

PaymentCard paymentCardFromJson(String str) => PaymentCard.fromJson(json.decode(str));

String paymentCardToJson(PaymentCard data) => json.encode(data.toJson());

class PaymentCard {
  int? id;
  String? numero;
  String? cvv;
  String? date;
  String? nom;
  int? idClient;

  PaymentCard({
    this.id,
    this.numero,
    this.cvv,
    this.date,
    this.nom,
    this.idClient
  });

  factory PaymentCard.fromJson(Map<String, dynamic> json) => PaymentCard(
    id: json["id"],
    numero: json["numero"],
    cvv: json["cvv"],
    date: json["date"],
    nom: json["nom"],
    idClient: json["idClient"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "numero": numero,
    "cvv": cvv,
    "date": date,
    "nom": nom,
    "idClient": idClient,
  };
}
