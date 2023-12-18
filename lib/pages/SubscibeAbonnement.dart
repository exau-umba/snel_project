import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SubscriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Réabonnement'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Choisissez votre abonnement:',
              style: TextStyle(fontSize: 20),
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