import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphic/graphic.dart';
import 'package:snel_project/utils/components/components.dart';
import 'package:snel_project/utils/constate.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:clipboard/clipboard.dart';
import '../../../../data/dataBrut.dart';
import '../../../../utils/Routes.dart';
import '../../../../utils/components/formField.dart';
import '../../../single_facture/facture/facture_bloc.dart';
import '../ajout_compte_snel/ajout_compte_snel_bloc.dart';

class Abonnement extends StatefulWidget {
  @override
  State<Abonnement> createState() => _AbonnementState();
}

class _AbonnementState extends State<Abonnement> {
  String _token = generateRandomText(14);
  bool _isHidden = true;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text('Tableau de bord prépayé',
            textColor: KColorWhite, fontSize: textSizeLarge),
        backgroundColor: KcolorPrimary,
        centerTitle: true,
        iconTheme: IconThemeData(color: KColorWhite),
        elevation: 0,
      ),
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: KcolorPrimary,
        foregroundColor: KColorWhite,
        onPressed: () async {
          Navigator.pushNamed(context, Routes.add_abonnement);
          /*final result = await Navigator.pushNamed(context, Routes.Subscription);
            if (result != null && result is int) {
              setState(() {
                _remainingSubscription = result;
              });
            }*/
        },
        child: Icon(Icons.add),
      ),*/
      body: _body()
    );
  }

  _body2(){
    return Container(
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

  Widget _body() {
    String displayText = _isHidden
        ? '*' * (_token.length - 5) + _token.substring(_token.length - 5)
        : _token;
    context.read<AjoutCompteSnelBloc>().add(GetAccountSnel());
    return BlocBuilder<AjoutCompteSnelBloc, AjoutCompteSnelState>(
      builder: (context, state) {
        if (state is AccountSnelLoaded) {
          final account = state.accounts;
          return account.isEmpty
              ? Center(child: Text("Aucun compte snel trouvé"))
              : Container(
            padding: EdgeInsets.all(spacing_standard),
                height: double.infinity.h,
                decoration: BoxDecoration(
                  color: KcolorPrimary.withOpacity(1.5.sp)
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        //height: 25.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(spacing_standard),
                            color: KcolorPrimary.withOpacity(1.5.sp)),
                        padding: EdgeInsets.all(spacing_standard),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                text("Aujourd'hui", fontSize: textSizeMedium),
                                SizedBox(
                                  height: 1.h,
                                ),
                                SizedBox(
                                  width: Adaptive.w(40),
                                  child: text("83Kwh",
                                      fontSize: 20.sp,
                                      maxLine: 3,
                                      softWrap: true,
                                      height: 4.5.sp,
                                      overflow: TextOverflow.visible,
                                      textColor: t12_text_color_primary,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                GestureDetector(
                                  child:
                                  Row(
                                    children: [
                                      text(displayText, fontSize: textSizeMedium),
                                      IconButton(
                                        icon: Icon(_isHidden ? Icons.visibility : Icons.visibility_off, size: 20.sp,),
                                        onPressed: () {
                                          setState(() {
                                            _isHidden = !_isHidden;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    _copyText(displayText);
                                  },
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: spacing_standard,
                                  left: spacing_standard),
                              child: MaterialButton(
                                padding: EdgeInsets.only(
                                    top: spacing_standard,
                                    bottom: spacing_standard,
                                    left: spacing_standard,
                                    right: spacing_standard),
                                child: Text("Se reabonner",
                                    style: TextStyle(color: KColorWhite)),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(spacing_standard)),
                                color: KcolorPrimary,
                                onPressed: () {
                                  //mCornerBottomSheet(context);
                                  Navigator.pushNamed(context, Routes.add_abonnement,);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                          padding: EdgeInsets.only(left: spacing_standard),
                          alignment: Alignment.centerLeft,
                          child: text("Cette semaine", textColor: t12_text_color_primary, fontSize: textSizeMedium)
                      ),
                      Container(
                        //margin: EdgeInsets.only(top: 10.sp),
                        width: Adaptive.w(90),
                        height: 30.h,
                        child: Chart(
                          rebuild: true,
                          data: [
                            {'jour': 'Lundi', 'sold': 75},
                            {'jour': 'Mardi', 'sold': 50},
                            {'jour': 'Merc.', 'sold': 65},
                            {'jour': 'Jeudi', 'sold': 20},
                            {'jour': 'Vend.', 'sold': 30},
                            {'jour': 'Sam.', 'sold': 34},
                            {'jour': 'Dim.', 'sold': 65},
                          ],
                          variables: {
                            'jour': Variable(
                              accessor: (Map map) =>
                              map['jour'] as String,
                            ),
                            'sold': Variable(
                              accessor: (Map map) =>
                              map['sold'] as num,
                            ),
                          },
                          marks: [
                            IntervalMark(
                              label: LabelEncode(
                                  encoder: (tuple) => Label(
                                      tuple['sold']
                                          .toString())),
                              elevation: ElevationEncode(
                                  value: 0,
                                  updaters: {
                                    'tap': {true: (_) => 5}
                                  }),
                              color: ColorEncode(
                                  value: Defaults.primaryColor,
                                  updaters: {
                                    'tap': {
                                      false: (color) =>
                                          color.withAlpha(100)
                                    }
                                  }),
                            )
                          ],
                          axes: [
                            Defaults.horizontalAxis,
                            Defaults.verticalAxis,
                          ],
                          selections: {
                            'tap': PointSelection(dim: Dim.x)
                          },
                          tooltip: TooltipGuide(),
                          crosshair: CrosshairGuide(),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      BlocBuilder<FactureBloc, FactureState>(
                          builder: (context, state){
                            if (state is FacturesLoaded){
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                    child: ListView.separated(
                                      itemCount: state.factures.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        var items = state.factures[index];
                                        return InkWell(
                                          onTap: (){
                                            Navigator.pushNamed(context, Routes.recu, arguments: items.toJson());
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(spacing_standard),
                                              color: KcolorPrimary.withOpacity(1.5.sp),
                                            ),
                                            padding: EdgeInsets.all(spacing_standard),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    text(items.numeroFacture?.replaceFirst('F', 'R'), fontSize: textSizeMedium, textColor: t12_text_color_primary),
                                                    text("${index==0?45:index*78}Kwh/\$${items.montant}", fontSize: 18.sp, fontWeight: FontWeight.bold,textColor: t12_text_color_primary),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    text("Date de paiement", fontSize: textSizeMedium),
                                                    text(items.periode, fontSize: textSizeMedium),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return Divider();
                                      },
                                    ),
                                  )
                                ],
                              );
                            }else if(state is FactureError){
                              return Center(child: text(state.message));
                            }
                            return Center(child: onLoading(context),);
                          }),
                    ],
                  ),
                ),
              );
        } else if (state is AjoutCompteSnelError) {
          return Center(
            child: Text(state.error),
          );
        }
        context.read<AjoutCompteSnelBloc>().add(GetAccountSnel());
        return Center(child: onLoading(context));
      },
    );
  }

  Widget favture_non_paye() {
    return SizedBox(
      height: 10.h,
      width: double.infinity,
      child: Stack(
        children: [
          ...facture_non_payes
              .asMap()
              .map(
                (i, e) => MapEntry(
              i,
              Transform.translate(
                offset: Offset(i * 30.0, 0),
                child: SizedBox(
                    height: 10.h,
                    width: Adaptive.w(20),
                    child: _buildAvatar(e['imageUrl'], radius: 30)),
              ),
            ),
          )
              .values
              .toList(),
        ],
      ),
    );
  }

  CircleAvatar _buildAvatar(String image, {double radius = 80}) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: radius,
      child: CircleAvatar(
        radius: radius - 2,
        backgroundImage: AssetImage(image),
      ),
    );
  }

  Widget _factureNonPaye(
      String title, {
        required montant,
        required icon,
      }) {
    return Container(
      width: Adaptive.w(30),
      height: 14.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(spacing_standard),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: KColorGris.withOpacity(1.5.sp),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 6.h,
                child: Icon(icon, size: 24.sp, color: KcolorPrimary),
                padding: EdgeInsets.all(spacing_standard),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: spacing_standard),
                child: text(title,
                    fontSize: textSizeNormal,
                    fontWeight: FontWeight.bold,
                    isLongText: true),
              )
            ],
          ),
          Container(
            width: Adaptive.w(30),
            height: 4.h,
            decoration: BoxDecoration(
                color: KcolorPrimary,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(spacing_standard),
                    bottomLeft: Radius.circular(spacing_standard))),
            child: text(
              "\$$montant",
              fontSize: textSizeLarge,
              textColor: KColorWhite,
              isCentered: true,
            ),
          )
        ],
      ),
    );
  }

  Widget facture_recente(
      {required double amount,
        required String dueDate,
        required String history}) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.sp),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              KcolorPrimary, // Couleur de départ
              KcolorPrimaryPall, // Couleur de fin
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(25.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Montant à Payer: \$${amount.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 20.sp,
                  color: KColorWhite,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 0.5.h),
            Text(
              'Date d\'Échéance: ${dueDate}',
              style: TextStyle(fontSize: 17.sp, color: KColorSecondary),
            ),
            SizedBox(height: 2.h),
            Text(
              'Historique: ${history}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
  void _copyText(String text) {
    FlutterClipboard.copy(text).then((value) {
      _showSnackBar();
    });
  }


  void _showSnackBar() {
    const snack =
    SnackBar(content: Text("Text copied"), duration: Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
