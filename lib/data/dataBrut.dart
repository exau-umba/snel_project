import 'package:flutter/material.dart';

final List<Map<String, dynamic>> paymentMethods = [
  {
    'mobile_money': false,
    'imageUrl': 'assets/mode_payment/visa.png',
  },
  {
    'mobile_money': false,
    'imageUrl': 'assets/mode_payment/mastercard.png',
  },
  {
    'mobile_money': false,
    'imageUrl': 'assets/mode_payment/equity.png',
  },
  {
    'mobile_money': false,
    'imageUrl': 'assets/mode_payment/661b249b-5bf0-4b8d-b7f4-1b3bd2c02a67.png',
  },
  {
    'mobile_money': false,
    'imageUrl': 'assets/mode_payment/images.jpeg',
  },
  {
    'mobile_money': false,
    'imageUrl': 'assets/mode_payment/BOA-CI.webp',
  },
  {
    'mobile_money': false,
    'imageUrl': 'assets/mode_payment/firstbank.png',
  },
  {
    'mobile_money': false,
    'imageUrl': 'assets/mode_payment/rawbank.png',
  },
  {
    'mobile_money': false,
    'imageUrl': 'assets/mode_payment/images.png',
  },
  {
    'mobile_money': false,
    'imageUrl': 'assets/mode_payment/Illicocash-.webp',
  },
  {
    'mobile_money': true,
    'imageUrl': 'assets/mode_payment/Money_Logo_Portrait_Black_RGB.png',
  },
  {
    'mobile_money': true,
    'imageUrl': 'assets/mode_payment/images.jpeg-7.jpg',
  },
  {
    'mobile_money': true,
    'imageUrl': 'assets/mode_payment/49YTv0_o_400x400.png',
  },
  {
    'mobile_money': true,
    'imageUrl': 'assets/mode_payment/AFR.jpg',
  },
  {
    'mobile_money': false,
    'imageUrl': 'assets/mode_payment/Backdrop-RakkaCach.png'
  },
  {
    'mobile_money':false,
    'imageUrl':'assets/mode_payment/mosolo.jpg'
  }
];

final List<Map<String, dynamic>> facture_non_payes = [
  {
    'mois': 'Jav',
    'imageUrl': 'assets/mode_payment/visa.png',
  },
  {
    'mois': 'Fév',
    'imageUrl': 'assets/mode_payment/mastercard.png',
  },
  {
    'mois': 'Mars',
    'imageUrl': 'assets/mode_payment/equity.png',
  },
  {
    'mois': 'Avril',
    'imageUrl': 'assets/mode_payment/661b249b-5bf0-4b8d-b7f4-1b3bd2c02a67.png',
  },
  {
    'mobile_money': true,
    'imageUrl': 'assets/mode_payment/Money_Logo_Portrait_Black_RGB.png',
  },
  {
    'mobile_money': true,
    'imageUrl': 'assets/mode_payment/images.jpeg-7.jpg',
  },
];

 final Map<String, dynamic> factures =
{
  "factures": [
    {
      "numero_facture": "F001",
      "periode": "dec 22, 2022",
      "statut": false,
      "montant": 150.00,
      "point_de_perception": "Centre Commercial Kinshasa",
      "type_client": "Particulier",
      "nom_client": "Jean Dupont",
      "adresse_client": "Avenue Colonel Mondjiba, Kinshasa"
    },
    {
      "numero_facture": "F002",
      "periode": "jan 23, 2023",
      "statut": true,
      "montant": 120.00,
      "point_de_perception": "Bureau Central",
      "type_client": "Entreprise",
      "nom_client": "Société ABC",
      "adresse_client": "Rue de la République, Kinshasa"
    },
    {
      "numero_facture": "F003",
      "periode": "feb 23, 2023",
      "statut": false,
      "montant": 200.00,
      "point_de_perception": "Agences de Kinshasa",
      "type_client": "Particulier",
      "nom_client": "Marie Kasa",
      "adresse_client": "Boulevard du 30 Juin, Kinshasa"
    },
    {
      "numero_facture": "F004",
      "periode": "mar 23, 2023",
      "statut": true,
      "montant": 180.00,
      "point_de_perception": "Centre Commercial Kinshasa",
      "type_client": "Particulier",
      "nom_client": "Pierre Mbuyi",
      "adresse_client": "Avenue de la Réunion, Kinshasa"
    },
    {
      "numero_facture": "F005",
      "periode": "apr 23, 2023",
      "statut": false,
      "montant": 220.00,
      "point_de_perception": "Bureau Central",
      "type_client": "Entreprise",
      "nom_client": "Société XYZ",
      "adresse_client": "Avenue des Héros, Kinshasa"
    },
    {
      "numero_facture": "F006",
      "periode": "may 23, 2023",
      "statut": false,
      "montant": 175.00,
      "point_de_perception": "Agences de Kinshasa",
      "type_client": "Particulier",
      "nom_client": "Alice Ngoyi",
      "adresse_client": "Rue des Acacias, Kinshasa"
    },
    {
      "numero_facture": "F007",
      "periode": "jun 23, 2023",
      "statut": true,
      "montant": 160.00,
      "point_de_perception": "Centre Commercial Kinshasa",
      "type_client": "Particulier",
      "nom_client": "Sophie Tshiaba",
      "adresse_client": "Avenue des Clémentines, Kinshasa"
    },
    {
      "numero_facture": "F008",
      "periode": "jul 23, 2023",
      "statut": false,
      "montant": 190.00,
      "point_de_perception": "Bureau Central",
      "type_client": "Entreprise",
      "nom_client": "Entreprise K",
      "adresse_client": "Avenue du Commerce, Kinshasa"
    },
    {
      "numero_facture": "F009",
      "periode": "aug 23, 2023",
      "statut": true,
      "montant": 210.00,
      "point_de_perception": "Agences de Kinshasa",
      "type_client": "Particulier",
      "nom_client": "Lucie Kambale",
      "adresse_client": "Boulevard de l'Indépendance, Kinshasa"
    },
    {
      "numero_facture": "F010",
      "periode": "sep 23, 2023",
      "statut": false,
      "montant": 230.00,
      "point_de_perception": "Centre Commercial Kinshasa",
      "type_client": "Particulier",
      "nom_client": "François Bula",
      "adresse_client": "Avenue de la Paix, Kinshasa"
    },
    {
      "numero_facture": "F011",
      "periode": "oct 23, 2023",
      "statut": true,
      "montant": 240.00,
      "point_de_perception": "Bureau Central",
      "type_client": "Entreprise",
      "nom_client": "Société DEF",
      "adresse_client": "Avenue du 24 Novembre, Kinshasa"
    },
    {
      "numero_facture": "F012",
      "periode": "nov 24, 2024",
      "statut": false,
      "montant": 250.00,
      "point_de_perception": "Agences de Kinshasa",
      "type_client": "Particulier",
      "nom_client": "Elisa Mwamba",
      "adresse_client": "Avenue des Libertés, Kinshasa"
    },
    {
      "numero_facture": "F013",
      "periode": "dec 24, 2024",
      "statut": true,
      "montant": 260.00,
      "point_de_perception": "Centre Commercial Kinshasa",
      "type_client": "Particulier",
      "nom_client": "Marc Lufungula",
      "adresse_client": "Avenue des Fleurs, Kinshasa"
    }
  ]
};
