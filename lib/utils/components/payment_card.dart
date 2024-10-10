import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constate.dart';

class PaymentCard extends StatelessWidget {
  final String imageUrl; // URL de l'image
  final bool mobile_money;
  final VoidCallback onTap;

  const PaymentCard({
    Key? key,
    required this.imageUrl,
    required this.mobile_money,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: KColorGris),
          borderRadius: BorderRadius.circular(15.sp),
          color: KColorWhite
        ),
        width: Adaptive.w(5),
        margin: EdgeInsets.all(10.sp),
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Image.asset(
            imageUrl,
            height: 10.h, // Hauteur de l'image
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}