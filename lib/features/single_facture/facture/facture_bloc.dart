import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snel_project/data/dataBrut.dart';

import '../../../data/models/Facture.dart';

part 'facture_event.dart';
part 'facture_state.dart';

class FactureBloc extends Bloc<FactureEvent, FactureState> {

  final List<Facture> _factures = [
    // Insérez vos données de factures JSON ici
    Facture.fromJson({
      "numero_facture": "F001",
      "periode": "dec 22, 2022",
      "statut": false,
      "montant": 150.00,
      "point_de_perception": "Centre Commercial Kinshasa",
      "type_client": "Particulier",
      "nom_client": "Jean Dupont",
      "adresse_client": "Avenue Colonel Mondjiba, Kinshasa"
    }),
    Facture.fromJson({
      "numero_facture": "F002",
      "periode": "jan 23, 2023",
      "statut": true,
      "montant": 120.00,
      "point_de_perception": "Bureau Central",
      "type_client": "Entreprise",
      "nom_client": "Société ABC",
      "adresse_client": "Rue de la République, Kinshasa"
    }),
    Facture.fromJson({
      "numero_facture": "F003",
      "periode": "feb 23, 2023",
      "statut": false,
      "montant": 200.00,
      "point_de_perception": "Agences de Kinshasa",
      "type_client": "Particulier",
      "nom_client": "Marie Kasa",
      "adresse_client": "Boulevard du 30 Juin, Kinshasa"
    }),
    Facture.fromJson({
      "numero_facture": "F004",
      "periode": "mar 23, 2023",
      "statut": true,
      "montant": 180.00,
      "point_de_perception": "Centre Commercial Kinshasa",
      "type_client": "Particulier",
      "nom_client": "Pierre Mbuyi",
      "adresse_client": "Avenue de la Réunion, Kinshasa"
    }),
    Facture.fromJson({
      "numero_facture": "F005",
      "periode": "apr 23, 2023",
      "statut": false,
      "montant": 220.00,
      "point_de_perception": "Bureau Central",
      "type_client": "Entreprise",
      "nom_client": "Société XYZ",
      "adresse_client": "Avenue des Héros, Kinshasa"
    }),
    Facture.fromJson({
      "numero_facture": "F006",
      "periode": "may 23, 2023",
      "statut": false,
      "montant": 175.00,
      "point_de_perception": "Agences de Kinshasa",
      "type_client": "Particulier",
      "nom_client": "Alice Ngoyi",
      "adresse_client": "Rue des Acacias, Kinshasa"
    }),
    Facture.fromJson({
      "numero_facture": "F007",
      "periode": "jun 23, 2023",
      "statut": true,
      "montant": 160.00,
      "point_de_perception": "Centre Commercial Kinshasa",
      "type_client": "Particulier",
      "nom_client": "Sophie Tshiaba",
      "adresse_client": "Avenue des Clémentines, Kinshasa"
    }),
    Facture.fromJson({
      "numero_facture": "F008",
      "periode": "jul 23, 2023",
      "statut": false,
      "montant": 190.00,
      "point_de_perception": "Bureau Central",
      "type_client": "Entreprise",
      "nom_client": "Entreprise K",
      "adresse_client": "Avenue du Commerce, Kinshasa"
    }),
    Facture.fromJson({
      "numero_facture": "F009",
      "periode": "aug 23, 2023",
      "statut": true,
      "montant": 210.00,
      "point_de_perception": "Agences de Kinshasa",
      "type_client": "Particulier",
      "nom_client": "Lucie Kambale",
      "adresse_client": "Boulevard de l'Indépendance, Kinshasa"
    }),
    Facture.fromJson({
      "numero_facture": "F010",
      "periode": "sep 23, 2023",
      "statut": false,
      "montant": 230.00,
      "point_de_perception": "Centre Commercial Kinshasa",
      "type_client": "Particulier",
      "nom_client": "François Bula",
      "adresse_client": "Avenue de la Paix, Kinshasa"
    }),
  ];
  FactureBloc() : super(FactureInitial()) {
    on<FactureEvent>((event, emit) {
      if(event is FetchFactures){
        emit(FactureLoading());
        try{
          emit(FacturesLoaded(_factures));
          
        }catch(e){
          emit(FactureError("Erreur inatendue"));
        }
      }else if(event is FetchFacture){
        try{
          final facture = _factures.firstWhere((f) => f.numeroFacture == event.facture);
          emit(FactureLoaded(facture));
        }catch(e){
          emit(FactureError("Une erreur s'est produit"));
        }
      }
    });
  }
}
