import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/services.dart';
import 'package:snel_project/data/models/Facture.dart';
import 'package:snel_project/data/services/database_helper.dart';
import 'package:snel_project/features/Navifation/bottom_navigation/navigation_bloc.dart';
import 'package:snel_project/features/authentication/auth/auth_bloc.dart';
import 'package:snel_project/features/authentication/compte_snel/ajout_compte_snel/ajout_compte_snel_bloc.dart';
import 'package:snel_project/features/paiement/payment/payment_bloc.dart';

import '../features/single_facture/facture/facture_bloc.dart';
import '../utils/Routes.dart';
import '../utils/RoutesManager.dart';

// ignore: must_be_immutable
class MonApplication extends StatelessWidget{
  MonApplication({super.key,});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_)=> AuthBloc()),
            BlocProvider(create: (_)=> NavigationBloc()),
            BlocProvider(create: (_)=> FactureBloc()),
            BlocProvider(create: (_)=> PaymentBloc(DatabaseHelper())),
            BlocProvider(create: (_)=> AjoutCompteSnelBloc(DatabaseHelper())),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RoutesManager.route,
            initialRoute: Routes.splashscreen,
          ),
        );
      },
    );
  }
}