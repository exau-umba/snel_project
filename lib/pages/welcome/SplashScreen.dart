import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../utils/Routes.dart';

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
    return Stack(
        alignment : AlignmentDirectional.center,
      children: [
        Container(
            color : Colors.white
        ),
        Image.asset("assets/logo.png", width : Adaptive.w(50)),
      ],
    );
  }
}
