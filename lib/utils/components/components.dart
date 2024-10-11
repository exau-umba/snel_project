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

Widget onLoading2(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    child: Container(
      width: Adaptive.w(35),
      height: 15.h,
      alignment: Alignment.center,
      margin:  EdgeInsets.all(spacing_standard),
      padding:  EdgeInsets.all(spacing_standard),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(spacing_standard),
        color: t12_edittext_background
      ),
      child:Column(
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

Widget succes(BuildContext context){
  return Container(
    alignment: Alignment.center,
    child: Container(
      margin:  EdgeInsets.all(spacing_standard),
      padding:  EdgeInsets.all(spacing_standard),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(spacing_standard),
        color: KColorWhite,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
         // const SizedBox(height: 10.0),
          Icon(
            Icons.check_circle_outline,
            color: KColorSucces,
            size: 30.sp,
          ),
          SizedBox(height: 3.h),
          text(
            "Succes",
            fontSize: textSizeLarge,
            textColor: KcolorPrimary,
            isCentered: true,
          ),
          Divider(),
          text(
            "Transaction a réussi",
            fontSize: textSizeMedium,
            textColor: t12_text_color_primary,
            isCentered: true,
          ),
          SizedBox(height: 5.h),
          SizedBox(
            width: Adaptive.w(double.infinity) ,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(5.0),
              ),
              child: text("OK", textColor: KcolorPrimary),
              onPressed: () => Navigator.pop(context, true),
            ),
          ),
        ],
      ),
    ),
  );
}

void showSuccesDialog(BuildContext context) {
  // Affiche la boîte de dialogue
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return succes(context);
    },
  );

  // Ferme la boîte de dialogue après la durée spécifiée
  Future.delayed(Duration(seconds: 2), () {
    Navigator.of(context).pop(); // Ferme la boîte de dialogue
  });


}

// Fonction pour afficher la boîte de dialogue et la fermer après un certain temps
void showLoadingDialog(BuildContext context, Duration duration) {
  // Affiche la boîte de dialogue
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return onLoading2(context);
    },
  );

  // Ferme la boîte de dialogue après la durée spécifiée
  Future.delayed(duration, () {
    Navigator.of(context).pop(); // Ferme la boîte de dialogue
  });
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
