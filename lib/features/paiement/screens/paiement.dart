import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:snel_project/features/paiement/payment/payment_bloc.dart';
import 'package:snel_project/features/paiement/payment/payment_bloc.dart';
import 'package:snel_project/utils/Routes.dart';
import 'package:snel_project/utils/components/formField.dart';
import 'package:snel_project/utils/constate.dart';

import '../../../data/dataBrut.dart';
import '../../../utils/components/components.dart';
import '../../../utils/components/payment_card.dart';

class Paiement extends StatefulWidget {
  const Paiement({super.key});

  @override
  State<Paiement> createState() => _PaiementState();
}

class _PaiementState extends State<Paiement> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KcolorPrimary,
        centerTitle: true,
        title: text(
            "Methode de paiement", fontSize: 20.sp, textColor: KColorWhite),
      ),
      body: _body(),
    );
  }

  _body() {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        if(state is RandomListShuffled){

        }
        return Container(
          decoration: BoxDecoration(
              color: KcolorPrimary.withOpacity(1.5.sp)
          ),
          padding: EdgeInsets.all(20.sp),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              formField(context, "Search",
                  controller: _searchController,
                  prefixIcon: Icons.search_outlined,
                  textInputAction: TextInputAction.done),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // number of items in each row
                    mainAxisSpacing: 8.0.sp, // spacing between rows
                    crossAxisSpacing: 8.0.sp, // spacing between columns
                  ),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8.0.sp),
                  // padding around the grid
                  itemCount: paymentMethods.length,
                  // total number of items
                  itemBuilder: (context, index) {
                    var items = List<Map<String, dynamic>>.from(paymentMethods)..shuffle(Random(2));
                    var item = items[index];
                    return PaymentCard(
                      imageUrl: item['imageUrl']!,
                      mobile_money: item['mobile_money']!,
                      onTap: () {
                        Navigator.pushNamed(context, Routes.formPayment,
                            arguments: {
                          "paie":false,
                              "item":item
                            });
                        print('Card tapped: ${item['mobile_money']}');
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
