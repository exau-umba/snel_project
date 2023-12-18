import 'dart:async';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:snel_project/utils/Routes.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _consumption = 0;
  int _remainingSubscription = 0; // Montant de l'abonnement restant
  Timer? _timer;
  bool _isPopupShown = false;
  bool _isPopupShownE = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 10), (_) {
      if (!_isPopupShown && _remainingSubscription>20) {
        _showPopup();
      } else if(!_isPopupShownE && _remainingSubscription == 0){
        _showPopupE();
      }
    });
  }

  void _showPopup() {
    _isPopupShown = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      // Empêche de fermer le popup en cliquant à l'extérieur
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('Vous avez consomé 20 kWh'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _isPopupShown = false;
                Navigator.of(context).pop();
                _increaseConsumption();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
  void _showPopupE() {
    _isPopupShownE = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      // Empêche de fermer le popup en cliquant à l'extérieur
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('Votre abonnement est épuisé'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _increaseConsumption() async {
    setState(() {
      _consumption += 20;
      _remainingSubscription -= 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Tableau de Bord', style: TextStyle(color: Colors.white, fontSize: 23.sp),),
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu, color: Colors.white,),),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications, color: Colors.white))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result =
                await Navigator.pushNamed(context, Routes.Subscription);
            if (result != null && result is int) {
              setState(() {
                _remainingSubscription = result;
              });
            }
          },
          child: Icon(Icons.add),
        ),
        body: _body());
  }

  Widget _body() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 25.h,
              width: Adaptive.w(double.infinity),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
            ),
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Quantité Consommée:',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$_consumption kWh',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Quantité Restante: $_remainingSubscription kWh',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // SizedBox(height: 20.h),

        // SizedBox(height: 20),
        // ElevatedButton(
        //   onPressed: () {
        //     _showPopup();
        //   },
        //   child: Text('Afficher le Popup'),
        // ),
      ],
    );
  }
}
