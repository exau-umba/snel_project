import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:snel_project/utils/constate.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/components/components.dart';

class ModePayment extends StatefulWidget {
  const ModePayment({super.key});

  @override
  State<ModePayment> createState() => _ModePaymentState();
}

class _ModePaymentState extends State<ModePayment> {
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: KColorWhite),
        title:
            text("Mode de paiments", fontSize: 20.sp, textColor: KColorWhite),
        backgroundColor: KcolorPrimary,
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      color: KcolorPrimary.withOpacity(1.5.sp),
      height: double.infinity.h,
      width: Adaptive.w(double.infinity),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: spacing_standard,
              right: spacing_standard,
              left: spacing_standard,
            ),
            child: text(
              "Par carte ou banque",
              fontSize: 18.sp,
              textColor: t12_text_color_primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          CreditCardWidget(
            cardNumber: "1234 5678 9012 3456",
            cardType: CardType.mastercard,
            bankName: "Mosolo",
            cardBgColor: KcolorPrimary,
            expiryDate: "12/25",
            cardHolderName: "Jean Dupont",
            cvvCode: "1234",
            showBackView: isCvvFocused,
            //true when you want to show cvv(back) view
            onCreditCardWidgetChange: (CreditCardBrand
                brand) {}, // Callback for anytime credit card brand is changed
          ),
          Padding(
            padding: EdgeInsets.only(
              top: spacing_standard,
              right: spacing_standard,
              left: spacing_standard,
            ),
            child: text(
              "Mobile money",
              fontSize: 18.sp,
              textColor: t12_text_color_primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: spacing_standard, right: spacing_standard, left: spacing_standard ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                  SizedBox(
                    height: 50.h,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(spacing_standard),
                            color: KcolorPrimary.withOpacity(1.5.sp),
                          ),
                          padding: EdgeInsets.all(spacing_standard),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Adaptive.w(20),
                                height: 10.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(spacing_standard),
                                    color: KColorWhite,
                                    image: DecorationImage(image: AssetImage("assets/mode_payment/Money_Logo_Portrait_Black_RGB.png",),)
                                ),
                              ),
                              SizedBox(width: Adaptive.w(3),),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  text("Orange Money",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: t12_text_color_primary),
                                  text("Devise : FC",
                                      fontSize: textSizeMedium,
                                      fontWeight: FontWeight.w700,
                                      textColor: t12_text_color_primary),
                                  SizedBox(
                                    width: Adaptive.w(60),
                                    child: text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                        fontSize: textSizeNormal,
                                        softWrap: true,
                                        maxLine: 2,
                                        overflow: TextOverflow.visible,
                                        textColor: t12_text_color_primary),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(spacing_standard),
                            color: KcolorPrimary.withOpacity(1.5.sp),
                          ),
                          padding: EdgeInsets.all(spacing_standard),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Adaptive.w(20),
                                height: 10.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(spacing_standard),
                                  color: KColorWhite,
                                  image: DecorationImage(image: AssetImage("assets/mode_payment/49YTv0_o_400x400.png",),)
                                ),
                              ),
                              SizedBox(width: Adaptive.w(3),),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  text("Airtel Money",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: t12_text_color_primary),
                                  text("Devise : USD",
                                      fontSize: textSizeMedium,
                                      fontWeight: FontWeight.w700,
                                      textColor: t12_text_color_primary),
                                  SizedBox(
                                    width: Adaptive.w(60),
                                    child: text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                        fontSize: textSizeNormal,
                                        softWrap: true,
                                        maxLine: 2,
                                        overflow: TextOverflow.visible,
                                        textColor: t12_text_color_primary),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  )
                              ],
                            ),
                ),
              ))
        ],
      ),
    );
  }
}
