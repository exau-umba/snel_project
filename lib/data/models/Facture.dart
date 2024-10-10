// To parse this JSON data, do
//
//     final facture = factureFromJson(jsonString);

import 'dart:convert';

Facture factureFromJson(String str) => Facture.fromJson(json.decode(str));

String factureToJson(Facture data) => json.encode(data.toJson());

class Facture {
  String? numeroFacture;
  String? periode;
  bool? statut;
  double? montant;
  String? pointDePerception;
  String? typeClient;
  String? nomClient;
  String? adresseClient;

  Facture({
    this.numeroFacture,
    this.periode,
    this.statut,
    this.montant,
    this.pointDePerception,
    this.typeClient,
    this.nomClient,
    this.adresseClient,
  });

  factory Facture.fromJson(Map<String, dynamic> json) => Facture(
    numeroFacture: json["numero_facture"],
    periode: json["periode"],
    statut: json["statut"],
    montant: json["montant"],
    pointDePerception: json["point_de_perception"],
    typeClient: json["type_client"],
    nomClient: json["nom_client"],
    adresseClient: json["adresse_client"],
  );

  Map<String, dynamic> toJson() => {
    "numero_facture": numeroFacture,
    "periode": periode,
    "statut": statut,
    "montant": montant,
    "point_de_perception": pointDePerception,
    "type_client": typeClient,
    "nom_client": nomClient,
    "adresse_client": adresseClient,
  };
}
