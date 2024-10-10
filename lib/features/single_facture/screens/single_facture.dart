import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snel_project/data/models/Facture.dart';
import 'package:snel_project/features/single_facture/facture/facture_bloc.dart';
import 'package:snel_project/utils/Routes.dart';
import 'package:snel_project/utils/constate.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/components/components.dart';

class SingleFacture extends StatefulWidget {
  final Facture facture;

  const SingleFacture({super.key, required this.facture});

  @override
  State<SingleFacture> createState() => _SingleFactureState();
}

class _SingleFactureState extends State<SingleFacture> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FactureBloc()..add(FetchFacture(widget.facture)),
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: KColorWhite),
          backgroundColor: KcolorPrimary,
          leading: IconButton(
            icon: Icon(Icons.close_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            widget.facture.statut==true? Container():
            PopupMenuButton<String>(
              onSelected: (value) {
                // Gérer l'option sélectionnée
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$value sélectionné')),
                );
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'Payé',
                    onTap: () {
                      mCornerBottomSheet(context);
                    },
                    child: Text('Payé'),
                  ),
                  PopupMenuItem<String>(
                    value: 'Reclamé',
                    child: Text('Reclamé'),
                  ),
                ];
              },
            ),
          ],
        ),
        body: _body(),
      )),
    );
  }

  _body() {
    return Container(
      color: KcolorPrimary.withOpacity(1.5.sp),
      height: double.infinity.h,
      child: Stack(
        children: [
          Container(
            width: Adaptive.w(double.infinity),
            height: 28.h,
            padding: EdgeInsets.symmetric(horizontal: spacing_standard),
            decoration: BoxDecoration(
                color: KcolorPrimary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(spacing_standard),
                    bottomRight: Radius.circular(spacing_standard))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color:
                      widget.facture.statut == true ? KColorSucces : KColorRed,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.sp, vertical: 8.sp),
                    child: text(
                        widget.facture.statut == true ? "Payée" : "Non payée",
                        fontSize: textSizeNormal,
                        textColor: KColorWhite),
                  ),
                ),
                text(
                    "Facture ${widget.facture.statut == true ? 'payée' : 'non payée'}",
                    fontSize: 27.sp,
                    textColor: KColorWhite,
                    fontWeight: FontWeight.bold),
                text("ID : ${widget.facture.numeroFacture}",
                    fontSize: textSizeLarge, textColor: KColorWhite),
              ],
            ),
          ),
          widget.facture.statut == true
              ? Container()
              : Positioned(
                  bottom: 20.sp,
                  left: spacing_standard,
                  right: spacing_standard,
                  child: SizedBox(
                    width: Adaptive.w(double.infinity),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: spacing_standard,
                          right: spacing_standard,
                          left: spacing_standard),
                      child: MaterialButton(
                        padding: EdgeInsets.only(
                            top: spacing_standard,
                            bottom: spacing_standard,
                            left: spacing_standard,
                            right: spacing_standard),
                        child: Text("Regulariser",
                            style: TextStyle(color: KColorWhite)),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                new BorderRadius.circular(spacing_standard)),
                        color: KcolorPrimary,
                        onPressed: () {
                          mCornerBottomSheet(context);
                          //Navigator.pushNamed(context, Routes.formPayment, arguments: widget.facture);
                        },
                      ),
                    ),
                  )),
          Positioned(
            right: spacing_standard,
            left: spacing_standard,
            top: 50.sp,
            child: Container(
              //height: 25.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(spacing_standard),
                  color: KColorWhite),
              padding: EdgeInsets.all(spacing_standard),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      text("Facture pour", fontSize: textSizeMedium),
                      SizedBox(
                        height: 1.h,
                      ),
                      SizedBox(
                        width: Adaptive.w(40),
                        child: text(widget.facture.nomClient,
                            fontSize: 20.sp,
                            maxLine: 3,
                            softWrap: true,
                            height: 4.5.sp,
                            overflow: TextOverflow.visible,
                            textColor: t12_text_color_primary,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      SizedBox(
                        width: Adaptive.w(40),
                        child: text(widget.facture.adresseClient,
                            fontSize: textSizeNormal,
                            maxLine: 3,
                            isLongText: true,
                            softWrap: true,
                            overflow: TextOverflow.visible),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: KcolorPrimary.withOpacity(1.5.sp),
                        borderRadius: BorderRadius.circular(spacing_standard)),
                    width: Adaptive.w(45),
                    padding: EdgeInsets.all(spacing_standard),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("Montant à payer", fontSize: textSizeMedium),
                        text("\$${widget.facture.montant}",
                            fontSize: 28.sp,
                            textColor: t12_text_color_primary,
                            fontWeight: FontWeight.bold),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              size: textSizeMedium,
                              color: KColorRed,
                            ),
                            SizedBox(
                              width: Adaptive.w(2),
                            ),
                            text("${widget.facture.periode}".toUpperCase(),
                                fontSize: textSizeMedium)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: 75.sp,
              left: spacing_standard,
              right: spacing_standard,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text("INFO",
                          fontSize: textSizeMedium,
                          fontWeight: FontWeight.bold),
                      text("VALEUR",
                          fontSize: textSizeMedium,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text("Point de reception :", fontSize: textSizeMedium),
                      text(widget.facture.pointDePerception,
                          fontSize: textSizeMedium),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text("Type de client :", fontSize: textSizeMedium),
                      text(widget.facture.typeClient, fontSize: textSizeMedium),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text("Période :", fontSize: textSizeMedium),
                      text(widget.facture.periode, fontSize: textSizeMedium),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
  mCornerBottomSheet(BuildContext aContext) {
    showModalBottomSheet(
        context: aContext,
        backgroundColor: KColorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (builder) {
          return Container(
            height: 20.h,
            padding: EdgeInsets.all(spacing_standard),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                text(
                  "Choix de mode paiement",
                  fontSize: 18.sp,
                  textColor: t12_text_color_primary,
                  fontWeight: FontWeight.bold,
                  isCentered: true
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: spacing_standard, right: spacing_standard, left: spacing_standard ),
                      child: SizedBox(
                        width: Adaptive.w(35),
                        child: MaterialButton(
                          padding: EdgeInsets.only(
                              top: spacing_standard,
                              bottom: spacing_standard,
                              left: spacing_standard,
                              right: spacing_standard),
                          child: Text("Mobile money", style: TextStyle(color: KColorWhite)),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(spacing_standard)),
                          color: KcolorPrimary,
                          onPressed: () {
                            Navigator.pop(aContext);
                            Navigator.pushNamed(context, Routes.formPayment, arguments: {
                              "banque":false,
                              "paie":true,
                              "facture":widget.facture
                            });

                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: spacing_standard, right: spacing_standard, left: spacing_standard ),
                      child: SizedBox(
                        width: Adaptive.w(35),
                        child: MaterialButton(
                          padding: EdgeInsets.only(
                              top: spacing_standard,
                              bottom: spacing_standard,
                              left: spacing_standard,
                              right: spacing_standard),
                          child: Text("Banque", style: TextStyle(color: KColorWhite)),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(spacing_standard)),
                          color: KcolorPrimary,
                          onPressed: () {
                            Navigator.pop(aContext);
                            Navigator.pushNamed(context, Routes.formPayment, arguments: {
                              "banque":true,
                              "paie":true,
                              "facture":widget.facture
                            });
                          },
                        ),
                      ),
                    )
                  ],
                )

              ],
            ),
          );
        });
  }
}
