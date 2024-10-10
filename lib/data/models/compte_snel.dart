// To parse this JSON data, do
// Quicktype.io
//     final compteSnel = compteSnelFromJson(jsonString);

import 'dart:convert';

CompteSnel compteSnelFromJson(String str) => CompteSnel.fromJson(json.decode(str));

String compteSnelToJson(CompteSnel data) => json.encode(data.toJson());

class CompteSnel {
  int? id;
  String? label;
  int? idClient;

  CompteSnel({
    this.id,
    this.label,
    this.idClient,
  });

  factory CompteSnel.fromJson(Map<String, dynamic> json) => CompteSnel(
    id: json["id"],
    label: json["label"],
    idClient: json["idClient"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "idClient": idClient,
  };
}
