import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphic/graphic.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:snel_project/features/authentication/compte_snel/ajout_compte_snel/ajout_compte_snel_bloc.dart';
import 'package:snel_project/features/single_facture/facture/facture_bloc.dart';
import 'package:snel_project/utils/Routes.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:graphic/graphic.dart' as graphic;
import 'package:snel_project/utils/components/formField.dart';
import '../data/dataBrut.dart';
import '../utils/components/components.dart';
import '../utils/constate.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    context.read<AjoutCompteSnelBloc>().add(GetAccountSnel());
    context.read<FactureBloc>().add(FetchFactures());
    super.initState();
  }

  final PageController _pageController = PageController();

  /*int _consumption = 0;
  int _remainingSubscription = 0; // Montant de l'abonnement restant
  Timer? _timer;
  bool _isPopupShown = false;
  bool _isPopupShownE = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 10), (_) {
      if (!_isPopupShown && _remainingSubscription > 20) {
        _showPopup();
      } else if (!_isPopupShownE && _remainingSubscription == 0) {
        _showPopupE();
      }
    });
  }

  void _showPopup() {
    _isPopupShown = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      // Empêche de fermer le popup en cliquant à l'extérieur
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('Vous avez consomé 20 kWh'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _isPopupShown = false;
                Navigator.of(context).pop();
                _increaseConsumption();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  void _showPopupE() {
    _isPopupShownE = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      // Empêche de fermer le popup en cliquant à l'extérieur
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('Votre abonnement est épuisé'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _increaseConsumption() async {
    setState(() {
      _consumption += 20;
      _remainingSubscription -= 20;
    });
  }*/
bool isDialOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: KcolorPrimary,
          title:
              text("Tableau de bord", textColor: KColorWhite, fontSize: 20.sp),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
                onPressed: ()=> Navigator.pushNamed(context, Routes.abonnement),
                icon: Icon(Icons.subscriptions, color: Colors.white))
          ],
        ),
        //backgroundColor: KcolorPrimary,
        floatingActionButton : SpeedDial(
          backgroundColor: KcolorPrimary,
          animatedIconTheme: IconThemeData(color: KColorWhite),
          animatedIcon: AnimatedIcons.menu_close,
          overlayOpacity: 2.5.sp,
          children: [
            SpeedDialChild(
              child: Icon(Icons.add_home_work_rounded, color: KcolorPrimary,),
              label: 'Ajouter un compte snel',
              onTap: () => Navigator.pushNamed(context, Routes.addAccountSnel),
            ),
            SpeedDialChild(
              child: Icon(Icons.subscriptions, color: KcolorPrimary,),
              label: 'Abonnement',
              onTap: () => Navigator.pushNamed(context, Routes.add_abonnement),
            ),
          ],
        ),
        /*floatingActionButton: FloatingActionButton(
          backgroundColor: KcolorPrimary,
          foregroundColor: KColorWhite,
          onPressed: () async {
            Navigator.pushNamed(context, Routes.addAccountSnel);
            /*final result = await Navigator.pushNamed(context, Routes.Subscription);
            if (result != null && result is int) {
              setState(() {
                _remainingSubscription = result;
              });
            }*/
          },
          child: Icon(Icons.add),
        ),*/
        body: AnimatedContainer(
          duration: Duration(milliseconds: 300),
            color: isDialOpen ? Colors.grey[200] : Colors.white,
          child: RefreshIndicator(
              onRefresh: () async {
                await context
                    .watch()<AjoutCompteSnelBloc>()
                    .add(GetAccountSnel());
                Duration(seconds: 2);
              },
              child: _body()),
        ));
  }

  Widget _body() {
    context.read<AjoutCompteSnelBloc>().add(GetAccountSnel());
    return BlocBuilder<AjoutCompteSnelBloc, AjoutCompteSnelState>(
      builder: (context, state) {
        if (state is AccountSnelLoaded) {
          final account = state.accounts;
          return account.isEmpty
              ? Center(child: Text("Aucun compte snel trouvé"))
              : PageView(
                  reverse: false,
                  controller: _pageController,
                  pageSnapping: true,
                  scrollDirection: Axis.horizontal,
                  children: account
                      .asMap()
                      .entries
                      .map((e) => InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.single_compte, arguments: e.value.toJson());
                            },
                            child: Card(
                              color: KColorWhite,
                              elevation: 4,
                              child: Padding(
                                padding: EdgeInsets.all(15.sp),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      text(
                                        "${e.value.label}",
                                        fontSize: textSizeLarge,
                                        textColor: t12_text_color_primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      formField(context, "Search",
                                          prefixIcon: Icons.search_outlined),
                                      SizedBox(height: 2.h),
                                      facture_recente(
                                          amount: 75.50,
                                          dueDate: '2024-10-15',
                                          history: 'Paiement le 2024-09-10'),
                                      SizedBox(height: 2.h),
                                      Container(
                                        //margin: EdgeInsets.only(top: 10.sp),
                                        width: Adaptive.w(90),
                                        height: 30.h,
                                        child: Chart(
                                          rebuild: true,
                                          data: [
                                            {'mois': 'Janv', 'sold': 75},
                                            {'mois': 'Fév', 'sold': 50},
                                            {'mois': 'Mars', 'sold': 65},
                                            {'mois': 'Avril', 'sold': 20},
                                            {'mois': 'Mai', 'sold': 30},
                                            {'mois': 'Juin', 'sold': 34},
                                            {'mois': 'Juil', 'sold': 65},
                                            {'mois': 'Aôut', 'sold': 36},
                                            {'mois': 'Sept', 'sold': 18},
                                            {'mois': 'Oct', 'sold': 32},
                                            {'mois': 'Nov', 'sold': 45},
                                            {'mois': 'Déc', 'sold': 15},
                                          ],
                                          variables: {
                                            'mois': Variable(
                                              accessor: (Map map) =>
                                                  map['mois'] as String,
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
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    children: [
                                                      _factureNonPaye(
                                                          "5 Factures non payés",
                                                          montant: 450,
                                                          icon: Icons.article_rounded),
                                                      _factureNonPaye("Recentes",
                                                          montant: 10,
                                                          icon: Icons.article_outlined),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                    child: ListView.separated(
                                                      itemCount: state.factures.length,
                                                      shrinkWrap: true,
                                                      itemBuilder: (context, index) {
                                                        var items = state.factures[index];
                                                        return InkWell(
                                                          onTap: (){
                                                            Navigator.pushNamed(context, Routes.single_fature, arguments: items.toJson());
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
                                                                    text(items.numeroFacture, fontSize: textSizeMedium, textColor: t12_text_color_primary),
                                                                    text("\$${items.montant}", fontSize: 18.sp, fontWeight: FontWeight.bold,textColor: t12_text_color_primary),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                  children: [
                                                                    text(items.periode, fontSize: textSizeMedium),
                                                                    Card(
                                                                      color: items.statut==true? KColorSucces: KColorRed,
                                                                      child: Padding(
                                                                        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 8.sp),
                                                                        child: text(items.statut==true?"Payée":"Non payé", fontSize: textSizeNormal, textColor: KColorWhite),
                                                                      ),
                                                                    )
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
                              ),
                            ),
                          ))
                      .toList(),
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
}
