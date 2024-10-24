import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:snel_project/utils/components/components.dart';
import 'package:snel_project/utils/constate.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Abonnement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text('Consomation',
            textColor: KColorWhite, fontSize: textSizeLarge),
        backgroundColor: KcolorPrimary,
        centerTitle: true,
        iconTheme: IconThemeData(color: KColorWhite),
        elevation: 0,
      ),
      body: Container(
        color: KcolorPrimary.withOpacity(1.5.sp),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatisticCard('89', 'kWh'),
                _buildStatisticCard('74', 'USD'),
              ],
            ),
            SizedBox(height: 2.h,),
            Container(
              height: 20.h,
              child: Chart(
                data: [
                  {'day': 'Mon', 'value': 10},
                  {'day': 'Tue', 'value': 15},
                  {'day': 'Wed', 'value': 20},
                  {'day': 'Thu', 'value': 18},
                  {'day': 'Fri', 'value': 25},
                  {'day': 'Sat', 'value': 10},
                  {'day': 'Sun', 'value': 12},
                ],
                variables: {
                  'day': Variable(
                    accessor: (Map map) => map['day'] as String,
                  ),
                  'value': Variable(
                    accessor: (Map map) => map['value'] as num,
                  ),
                },
                marks: [
                  AreaMark(
                    label: LabelEncode(
                        encoder: (tuple) => Label(tuple['value'].toString())),
                    elevation: ElevationEncode(value: 0, updaters: {
                      'day': {true: (_) => 5}
                    }),
                    color: ColorEncode(value: Defaults.primaryColor, updaters: {
                      'day': {false: (color) => color.withAlpha(100)}
                    }),
                  ),

                ],
                axes: [
                  Defaults.horizontalAxis,
                  Defaults.verticalAxis,
                ],
              ),
            ),
            //SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticCard(String value, String unit) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(spacing_standard),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2.sp,
            blurRadius: 5.sp,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
          ),
          Text(unit),
        ],
      ),
    );
  }
}
