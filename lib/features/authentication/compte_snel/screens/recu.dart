import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:snel_project/utils/constate.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../data/models/Facture.dart';
import '../../../../utils/Routes.dart';
import '../../../../utils/components/components.dart';

class Recu extends StatefulWidget {
  final Facture recu;
  const Recu({super.key, required this.recu});

  @override
  State<Recu> createState() => _RecuState();
}

class _RecuState extends State<Recu> {
  String _token = generateRandomText(14);
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: KColorWhite),
        leading: IconButton(
          icon: Icon(Icons.close_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: KcolorPrimary,
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KcolorPrimary,
        foregroundColor: KColorWhite,
        onPressed: () {
          // Charger l'image depuis les assets
          //final byteData = await DefaultAssetBundle.of(context).load('assets/logo_snel.png');
          //final directory = await getTemporaryDirectory();
          //final file = File('${directory.path}/logo_snel.png');
          //await file.writeAsBytes(byteData.buffer.asUint8List());
          //final xFile = XFile(file.path);
          Share.share('Snel Pay');
          //Navigator.pushNamed(context, Routes.addAccountSnel);
          /*final result = await Navigator.pushNamed(context, Routes.Subscription);
            if (result != null && result is int) {
              setState(() {
                _remainingSubscription = result;
              });
            }*/
        },
        child: Icon(Icons.share),
      ),
    );
  }
  _body() {
    String displayText = _isHidden
        ? '*' * (_token.length - 5) + _token.substring(_token.length - 5)
        : _token;
    return Container(
      color: KcolorPrimary.withOpacity(1.5.sp),
      height: double.infinity.h,
      child: Stack(
        children: [
          Container(
            width: Adaptive.w(double.infinity),
            height: 20.h,
            padding: EdgeInsets.symmetric(horizontal: spacing_standard),
            decoration: BoxDecoration(
                color: KcolorPrimary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.sp),
                    bottomRight: Radius.circular(25.sp))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: KColorSucces,
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 8.sp),
                    child: text("Reçu prépayé",
                        fontSize: textSizeNormal,
                        textColor: KColorWhite),
                  ),
                ),

                text(
                    "Reçu snel",
                    fontSize: 27.sp,
                    textColor: KColorWhite,
                    fontWeight: FontWeight.bold),
                text("N° reçu : ${widget.recu.numeroFacture?.replaceFirst('F', 'R')}",
                    fontSize: textSizeLarge, textColor: KColorWhite),
              ],
            ),
          ),
          /*Positioned(
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
                      SizedBox(
                        width: Adaptive.w(40),
                        child: text("Exaucé Umba",
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
                        child: text("widget.facture.adresseClient",
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
                        text("\$45",
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
                            text("dec 22, 2022".toUpperCase(),
                                fontSize: textSizeMedium)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),*/
          Positioned(
              top: 55.sp,
              left: spacing_standard,
              right: spacing_standard,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  themeLogo(),
                  text("SNEL PAY", fontWeight: FontWeight.bold, textColor: KcolorPrimary),
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
                      text("Date de paiement :", fontSize: textSizeMedium),
                      text("${widget.recu.periode}",
                          fontSize: textSizeMedium),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text("Type de paiement :", fontSize: textSizeMedium),
                      text("Snel prépayé", fontSize: textSizeMedium),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text("Montant :", fontSize: textSizeMedium),
                      text("${widget.recu.montant} FC", fontSize: textSizeMedium),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text("Total unités :", fontSize: textSizeMedium),
                      text("${widget.recu.montant!/3} Kwh", fontSize: textSizeMedium),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text("Valeur Totale :", fontSize: textSizeMedium),
                      text("${widget.recu.montant} FC", fontSize: textSizeMedium),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text("Initiateur du paiment :", fontSize: textSizeMedium, fontWeight: FontWeight.bold),
                      Padding(
                        padding: EdgeInsets.all(spacing_standard),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                text("Nom complet :", fontSize: textSizeMedium),
                                text("${widget.recu.nomClient}", fontSize: textSizeMedium),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                text("Type :", fontSize: textSizeMedium),
                                text("${widget.recu.typeClient}", fontSize: textSizeMedium),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text("Compte snel bénéficiaire :", fontSize: textSizeMedium),
                      text("Multipay", fontSize: textSizeMedium),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text("Token :", fontSize: textSizeMedium),
                      Row(
                        children: [
                          text(displayText, fontSize: textSizeMedium),
                          IconButton(
                            icon: Icon(_isHidden ? Icons.visibility : Icons.visibility_off, size: 20.sp,),
                            onPressed: () {
                              setState(() {
                                _isHidden = !_isHidden;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text("Opérateur :", fontSize: textSizeMedium),
                      text("Orange Money", fontSize: textSizeMedium),
                    ],
                  ),

                ],
              ))
        ],
      ),
    );
  }
}
