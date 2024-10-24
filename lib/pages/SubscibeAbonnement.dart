import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/components/components.dart';
import '../utils/constate.dart';

class SubscriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text("Abonnement", textColor: KColorWhite, fontSize: 20.sp),
        centerTitle: true,
        backgroundColor: KcolorPrimary,
        iconTheme: IconThemeData(color: KColorWhite),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            text(
              'Choisissez votre abonnement:',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 500); // Montant de l'abonnement
              },
              child: Text('Abonnement à 500 kWh'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 1000); // Montant de l'abonnement
              },
              child: Text('Abonnement à 1000 kWh'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 1000); // Montant de l'abonnement
              },
              child: Text('Abonnement à 2000 kWh'),
            ),
            // Ajoutez d'autres boutons d'abonnement au besoin
          ],
        ),
      ),
    );
  }
}