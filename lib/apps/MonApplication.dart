import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/services.dart';

import '../utils/Routes.dart';
import '../utils/RoutesManager.dart';

// ignore: must_be_immutable
class MonApplication extends StatelessWidget{
  MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RoutesManager.route,
          initialRoute: Routes.splashscreen,
        );
      },
    );
  }
}