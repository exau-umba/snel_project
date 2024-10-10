import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../utils/Routes.dart';
import '../../utils/components/components.dart';
import '../../utils/constate.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
        isLoaded = true;
        Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false,);
      }));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color : KcolorPrimary.withOpacity(1.5.sp),
        child: Center(child: themeLogo()),
      ),
    );
  }
}
