import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphic/graphic.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:snel_project/data/models/compte_snel.dart';

import '../../../../utils/Routes.dart';
import '../../../../utils/components/components.dart';
import '../../../../utils/components/formField.dart';
import '../../../../utils/constate.dart';
import '../../../single_facture/facture/facture_bloc.dart';

class DetailCompte extends StatefulWidget {
  final CompteSnel compteSnel;
  const DetailCompte({super.key, required this.compteSnel});

  @override
  State<DetailCompte> createState() => _DetailCompteState();
}

class _DetailCompteState extends State<DetailCompte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text(widget.compteSnel.label, textColor: KColorWhite, fontSize: 20.sp),
        centerTitle: true,
        iconTheme: IconThemeData(color: KColorWhite),
        backgroundColor: KcolorPrimary,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KcolorPrimary,
        foregroundColor: KColorWhite,
        onPressed: () async {
          Navigator.pushNamed(context, Routes.Subscription);
          /*final result = await Navigator.pushNamed(context, Routes.Subscription);
            if (result != null && result is int) {
              setState(() {
                _remainingSubscription = result;
              });
            }*/
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(spacing_standard),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Facture récente
              facture_recente(
                  amount: 75.50,
                  dueDate: '2024-10-15',
                  history: 'Paiement le 2024-09-10'),
              SizedBox(height: 2.h),

              // Graphique des ventes par mois
              Container(
                width: Adaptive.w(100),
                height: 35.h,
                child: Chart(
                  rebuild: true,
                  data: [
                    {'mois': 'Janv', 'sold': 75},
                    {'mois': 'Fév', 'sold': 50},
                    {'mois': 'Mars', 'sold': 65},
                    {'mois': 'Avril', 'sold': 20},
                    {'mois': 'Mai', 'sold': 30},
                    {'mois': 'Juin', 'sold': 34},
                    {'mois': 'Juil', 'sold': 65},
                    {'mois': 'Aôut', 'sold': 36},
                    {'mois': 'Sept', 'sold': 18},
                    {'mois': 'Oct', 'sold': 32},
                    {'mois': 'Nov', 'sold': 45},
                    {'mois': 'Déc', 'sold': 15},
                  ],
                  variables: {
                    'mois': Variable(
                      accessor: (Map map) => map['mois'] as String,
                    ),
                    'sold': Variable(
                      accessor: (Map map) => map['sold'] as num,
                    ),
                  },
                  marks: [
                    IntervalMark(
                      label: LabelEncode(
                          encoder: (tuple) =>
                              Label(tuple['sold'].toString())),
                      elevation: ElevationEncode(
                          value: 0,
                          updaters: {
                            'tap': {true: (_) => 5}
                          }),
                      color: ColorEncode(
                          value: Defaults.primaryColor,
                          updaters: {
                            'tap': {false: (color) => color.withAlpha(100)}
                          }),
                    )
                  ],
                  axes: [
                    Defaults.horizontalAxis,
                    Defaults.verticalAxis,
                  ],
                  selections: {
                    'tap': PointSelection(dim: Dim.x)
                  },
                  tooltip: TooltipGuide(),
                  crosshair: CrosshairGuide(),
                ),
              ),
              SizedBox(height: 2.h),

              // BlocBuilder pour factures chargées
              BlocBuilder<FactureBloc, FactureState>(builder: (context, state) {
                if (state is FacturesLoaded) {
                  return Column(
                    children: [
                      // Statistiques de factures non payées
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _factureNonPaye("5 Factures non payées", montant: 450, icon: Icons.article_rounded),
                          _factureNonPaye("Récentes", montant: 10, icon: Icons.article_outlined),
                        ],
                      ),
                      SizedBox(height: 2.h),

                      // Liste des factures
                      SizedBox(
                        height: 25.h,
                        child: ListView.separated(
                          itemCount: state.factures.length,
                          itemBuilder: (context, index) {
                            var items = state.factures[index];
                            return InkWell(
                              onTap: () {
                                //Navigator.pushNamed(context, Routes.single_fature, arguments: items.toJson());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(spacing_standard),
                                  color: KcolorPrimary.withOpacity(1.5.sp),
                                ),
                                padding: EdgeInsets.all(spacing_standard),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Informations de la facture
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        text(items.numeroFacture, fontSize: textSizeMedium, textColor: t12_text_color_primary),
                                        text("\$${items.montant}", fontSize: 18.sp, fontWeight: FontWeight.bold, textColor: t12_text_color_primary),
                                      ],
                                    ),

                                    // Statut de la facture
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        text(items.periode, fontSize: textSizeMedium),
                                        Card(
                                          color: items.statut == true ? KColorSucces : KColorRed,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 8.sp),
                                            child: text(items.statut == true ? "Payée" : "Non payée", fontSize: textSizeNormal, textColor: KColorWhite),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(),
                        ),
                      ),
                    ],
                  );
                } else if (state is FactureError) {
                  return Center(child: text(state.message));
                }
                return Center(child: onLoading(context));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _factureNonPaye(
      String title, {
        required montant,
        required icon,
      }) {
    return Container(
      width: Adaptive.w(30),
      height: 14.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(spacing_standard),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: KColorGris.withOpacity(1.5.sp),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 6.h,
                child: Icon(icon, size: 24.sp, color: KcolorPrimary),
                padding: EdgeInsets.all(spacing_standard),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: spacing_standard),
                child: text(title,
                    fontSize: textSizeNormal,
                    fontWeight: FontWeight.bold,
                    isLongText: true),
              )
            ],
          ),
          Container(
            width: Adaptive.w(30),
            height: 4.h,
            decoration: BoxDecoration(
                color: KcolorPrimary,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(spacing_standard),
                    bottomLeft: Radius.circular(spacing_standard))),
            child: text(
              "\$$montant",
              fontSize: textSizeLarge,
              textColor: KColorWhite,
              isCentered: true,
            ),
          )
        ],
      ),
    );
  }

  Widget facture_recente(
      {required double amount,
        required String dueDate,
        required String history}) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 14.sp),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              KcolorPrimary, // Couleur de départ
              KcolorPrimaryPall, // Couleur de fin
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(25.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Montant à Payer: \$${amount.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 20.sp,
                  color: KColorWhite,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 0.5.h),
            Text(
              'Date d\'Échéance: ${dueDate}',
              style: TextStyle(fontSize: 17.sp, color: KColorSecondary),
            ),
            SizedBox(height: 2.h),
            Text(
              'Historique: ${history}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
