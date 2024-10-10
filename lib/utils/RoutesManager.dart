import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snel_project/data/models/Facture.dart';
import 'package:snel_project/features/authentication/auth/screens/sign_up.dart';
import 'package:snel_project/features/form_mode_payment/screens/form_payment.dart';
import 'package:snel_project/features/paiement/screens/mode_payment.dart';
import 'package:snel_project/features/single_facture/screens/single_facture.dart';
import 'package:snel_project/pages/Dashboard.dart';
import 'package:snel_project/pages/SubscibeAbonnement.dart';

import '../features/Navifation/screens/navigation_home.dart';
import '../features/authentication/compte_snel/screens/account_form.dart';
import '../features/authentication/auth/screens/loginPage.dart';
import '../pages/home/HomePage.dart';
import '../pages/welcome/SplashScreen.dart';
import 'Routes.dart';

class RoutesManager{
  static Route? route(RouteSettings r) {
    switch (r.name) {
      case Routes.splashscreen:
        return MaterialPageRoute(builder: (_)=> Splashscreen());
      case Routes.dashboard:
        return MaterialPageRoute(builder: (_)=>DashboardScreen());
      case Routes.addAccountSnel:
        return MaterialPageRoute(builder: (_)=>AccountForm());
      case Routes.Subscription:
        return MaterialPageRoute(builder: (_)=>SubscriptionScreen());
      case Routes.modePayment:
        return MaterialPageRoute(builder: (_)=>ModePayment());
      case Routes.single_fature:
        print("============================================ ${r.arguments}");
        var facture = r.arguments as Map<String, dynamic>;
        var factureFinale = Facture.fromJson(facture);
        return MaterialPageRoute(builder: (_)=>SingleFacture(facture: factureFinale,));
      case Routes.formPayment:
        print("================= ${r.arguments}");
        var item = r.arguments;
        return MaterialPageRoute(builder: (_)=>FormPayment(item: item,));
      case Routes.login:
        return MaterialPageRoute(builder: (_)=>LoginPage());
      case Routes.signUp:
        return MaterialPageRoute(builder: (_)=>SignUpPage());
      default:
        return MaterialPageRoute(builder: (_)=> HomeScreen());
    }
  }
}