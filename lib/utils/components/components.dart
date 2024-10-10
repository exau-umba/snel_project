import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constate.dart';

Widget themeLogo() {
  return Container(
    child: Image.asset("assets/logo.png", width: Adaptive.w(20), height: 6.h)
  );
}

Widget onLoading(BuildContext context) {
  return Container(
    width: Adaptive.w(35),
    height: 20.h,
    child: AlertDialog(
      backgroundColor: t12_edittext_background,
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(spacing_standard))),
      //contentPadding: EdgeInsets.all(.0.sp),
      insetPadding: EdgeInsets.symmetric(horizontal: 0.sp),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: KcolorPrimary,),
          SizedBox(height: 2.h,),
          text("Patientez...", textColor: KcolorPrimary, fontSize: textSizeMedium)
        ],
      ),
    ),
  );
}

AlertDialog alertDialogue= AlertDialog(
  backgroundColor: KColorWhite,
  content: Container(
    width: Adaptive.w(double.infinity),
    child: Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: KColorSucces,
              height: 12.h,
            ),
            Column(
              children: [
                Image.asset("assets/succes.png", width: Adaptive.w(20),),
                SizedBox(height: 1.h,),
                text("SUCCES", fontSize: textSizeLarge),
              ],
            )
          ],
        )
      ],
    ),
  ),
);

Widget text(
  String? text, {
  var fontSize = 18.0,
      var fontWeight,
  Color? textColor,
  var fontFamily,
  var overflow,
  var height,
  var isCentered = false,
  var maxLine = 1,
  var latterSpacing = 0.5,
  bool textAllCaps = false,
  bool softWrap = false,
  var isLongText = false,
  bool lineThrough = false,
}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: overflow?? TextOverflow.ellipsis,
    softWrap: softWrap? true:null,
    style: TextStyle(
      fontFamily: fontFamily ?? null,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: textColor ?? Color(0xFF5A5C5E),
      height: height,
      letterSpacing: latterSpacing,
      decoration:
          lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}
