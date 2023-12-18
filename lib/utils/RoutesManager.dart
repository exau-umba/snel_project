

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snel_project/pages/Dashboard.dart';
import 'package:snel_project/pages/SubscibeAbonnement.dart';
import 'package:snel_project/pages/loginPage.dart';

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
      case Routes.Subscription:
        return MaterialPageRoute(builder: (_)=>SubscriptionScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_)=>LoginPage());
      default:
        return MaterialPageRoute(builder: (_)=> HomePage());
    }
  }
}