import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../data/dataBrut.dart';
import '../../../../utils/Routes.dart';
import '../../../../utils/components/components.dart';
import '../../../../utils/components/formField.dart';
import '../../../../utils/components/payment_card.dart';
import '../../../../utils/constate.dart';
import '../ajout_compte_snel/ajout_compte_snel_bloc.dart';

class EnergyConversionForm extends StatefulWidget {
  @override
  _EnergyConversionFormState createState() => _EnergyConversionFormState();
}

class _EnergyConversionFormState extends State<EnergyConversionForm> {
  @override
  void initState() {
    super.initState();
    context.read<AjoutCompteSnelBloc>().add(GetAccountSnel());
  }

  final _formKey = GlobalKey<FormState>();
  //TextEditingController _selectedAccount = TextEditingController();
  String? _selectedAccount;
  String? _selectedType;
  String? _selectedCurrency;
  double? _inputValue;
  double? _convertedValue;

  List<DropdownMenuItem<String>> _accountOptions = [
    DropdownMenuItem(value: 'Compte 1', child: Text('Compte 1')),
    DropdownMenuItem(value: 'Compte 2', child: Text('Compte 2')),
  ];

  List<DropdownMenuItem<String>> _typeOptions = [
    DropdownMenuItem(value: 'kWh', child: Text('kWh')),
    DropdownMenuItem(value: 'money', child: Text('Argent')),
  ];

  List<DropdownMenuItem<String>> _currencyOptions = [
    DropdownMenuItem(value: 'USD', child: Text('USD')),
    DropdownMenuItem(value: 'FC', child: Text('FC')),
  ];

  double _convertToMoney(double kWh) {
    return kWh * 0.12; // Example conversion rate for kWh to USD
  }

  double _convertToKWh(double money, String currency) {
    double rate = currency == 'USD' ? 0.12 : 120.0; // Example rates
    return money / rate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            text('Abonnement', textColor: KColorWhite, fontSize: textSizeLarge),
        centerTitle: true,
        iconTheme: IconThemeData(color: KColorWhite),
        backgroundColor: KcolorPrimary,
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      decoration: BoxDecoration(color: KcolorPrimary.withOpacity(1.5.sp)),
      width: Adaptive.w(double.infinity),
      height: double.infinity.h,
      padding: EdgeInsets.all(20.sp),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              BlocBuilder<AjoutCompteSnelBloc, AjoutCompteSnelState>(
                builder: (context, state) {
                  if (state is AccountSnelLoaded) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: spacing_standard,
                          right: spacing_standard,
                          left: spacing_standard),
                      child: formFieldSelect(
                        context,
                        prefixIcon: Icons.add_home_work_rounded,
                        'Choisir un compte',
                        validator: (value) {
                          if (value == null) {
                            return "Compte Required";
                          }
                          return null;
                        },
                        options: state.accounts
                            .map(
                              (e) => DropdownMenuItem(
                                  value: e.label, child: Text("${e.label}")),
                            )
                            .toList(),
                        selectedOption: _selectedAccount,
                        onChanged: (value) =>
                            setState(() => _selectedAccount = value),
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(
                        top: spacing_standard,
                        right: spacing_standard,
                        left: spacing_standard),
                    child: formField(
                      context,
                      readOnly: true,
                      prefixIcon: Icons.close,
                      'Pas de compte trouvé',
                      keyboardType: TextInputType.number,
                      onSaved: (value) =>
                          _inputValue = double.tryParse(value ?? ''),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: spacing_standard,
                    right: spacing_standard,
                    left: spacing_standard),
                child: formFieldSelect(
                  context,
                  prefixIcon: Icons.swap_horiz,
                  validator: (value) {
                    if (value == null) {
                      return "Type Required";
                    }
                    return null;
                  },
                  'Choisir le type',
                  options: _typeOptions,
                  selectedOption: _selectedType,
                  onChanged: (value) => setState(() => _selectedType = value),
                ),
              ),
              if (_selectedType == 'money')
                Padding(
                  padding: EdgeInsets.only(
                      top: spacing_standard,
                      right: spacing_standard,
                      left: spacing_standard),
                  child: formFieldSelect(
                    prefixIcon: Icons.attach_money,
                    context,
                    'Choisir la devise',
                    validator: (value) {
                      if (value == null) {
                        return "Devise Required";
                      }
                      return null;
                    },
                    options: _currencyOptions,
                    selectedOption: _selectedCurrency,
                    onChanged: (value) =>
                        setState(() => _selectedCurrency = value),
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(
                    top: spacing_standard,
                    right: spacing_standard,
                    left: spacing_standard),
                child: formField(
                  context,
                  prefixIcon: Icons.input,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Valeur Required";
                    }
                    return null;
                  },
                  'Entrer la valeur',
                  keyboardType: TextInputType.number,
                  onSaved: (value) =>
                      _inputValue = double.tryParse(value ?? ''),
                ),
              ),
              SizedBox(
                width: Adaptive.w(double.infinity),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: spacing_standard,
                      right: spacing_standard,
                      left: spacing_standard),
                  child: MaterialButton(
                    padding: EdgeInsets.only(
                        top: spacing_standard,
                        bottom: spacing_standard,
                        left: spacing_standard,
                        right: spacing_standard),
                    child: Text("Convertir",
                        style: TextStyle(color: KcolorPrimary)),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: KcolorPrimary),
                      borderRadius: new BorderRadius.circular(spacing_standard),
                    ),
                    color: KColorWhite,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          _convertedValue = _selectedType == 'kWh'
                              ? _convertToMoney(_inputValue!)
                              : _convertToKWh(_inputValue!, _selectedCurrency!);
                        });
                      }
                    },
                  ),
                ),
              ),
              if (_convertedValue != null)
                Padding(
                  padding: EdgeInsets.all(spacing_standard),
                  child: text(
                    'Valeur convertie: ${_convertedValue?.toInt()} ${_selectedType == 'money' ? 'kWh' : 'USD'} ',
                  ),
                ),
              SizedBox(
                width: Adaptive.w(double.infinity),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: spacing_standard,
                      right: spacing_standard,
                      left: spacing_standard),
                  child: MaterialButton(
                    padding: EdgeInsets.only(
                        top: spacing_standard,
                        bottom: spacing_standard,
                        left: spacing_standard,
                        right: spacing_standard),
                    child: Text("Payer", style: TextStyle(color: KColorWhite)),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            new BorderRadius.circular(spacing_standard)),
                    color: KcolorPrimary,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_convertedValue != null) {
                          mCanauxPaiementBottomSheet(context);
                        }

                          //mCornerBottomSheet(context);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  mCornerBottomSheet(BuildContext aContext) {
    showModalBottomSheet(
        context: aContext,
        backgroundColor: KColorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (builder) {
          return Container(
            height: 20.h,
            padding: EdgeInsets.all(spacing_standard),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                text("Choix de mode paiement",
                    fontSize: 18.sp,
                    textColor: t12_text_color_primary,
                    fontWeight: FontWeight.bold,
                    isCentered: true),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: spacing_standard,
                          right: spacing_standard,
                          left: spacing_standard),
                      child: SizedBox(
                        width: Adaptive.w(35),
                        child: MaterialButton(
                          padding: EdgeInsets.only(
                              top: spacing_standard,
                              bottom: spacing_standard,
                              left: spacing_standard,
                              right: spacing_standard),
                          child: Text("Mobile money",
                              style: TextStyle(color: KColorWhite)),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  new BorderRadius.circular(spacing_standard)),
                          color: KcolorPrimary,
                          onPressed: () {
                            Navigator.pop(aContext);
                            //mCanauxPaiementBottomSheet(context);
                            Navigator.pushNamed(context, Routes.modePayment, arguments: {
                              "banque":false,
                              "paie":false,
                              "facture":_convertedValue?.toInt()
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: spacing_standard,
                          right: spacing_standard,
                          left: spacing_standard),
                      child: SizedBox(
                        width: Adaptive.w(35),
                        child: MaterialButton(
                          padding: EdgeInsets.only(
                              top: spacing_standard,
                              bottom: spacing_standard,
                              left: spacing_standard,
                              right: spacing_standard),
                          child: Text("Banque",
                              style: TextStyle(color: KColorWhite)),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  new BorderRadius.circular(spacing_standard)),
                          color: KcolorPrimary,
                          onPressed: () {
                            Navigator.pop(aContext);
                            Navigator.pushNamed(context, Routes.modePayment,
                                arguments: {
                                  "banque": true,
                                  "paie": false,
                                  "facture": _convertedValue?.toInt()
                                });
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  mCanauxPaiementBottomSheet(BuildContext aContext) {
    showModalBottomSheet(
        context: aContext,
        //isScrollControlled: true,
        showDragHandle: true,
        enableDrag: true,
        isDismissible: true,
        backgroundColor: KColorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (context){
          return Column(
            children: [
              text("Canaux de paiments enregistrés",
                  fontSize: 18.sp,
                  textColor: t12_text_color_primary,
                  fontWeight: FontWeight.bold,
                  isCentered: true),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: spacing_standard),
                child: Divider(),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // number of items in each row
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
                        Navigator.pop(aContext);
                        if(_selectedType=='money'){
                            _selectedCurrency=='USD'? mCanalSelectedBottomSheet(context, urlCanal: item['imageUrl'], nameCanal: item['name'], montant: '$_inputValue', kwh: '$_convertedValue', currency: 'USD'):
                            mCanalSelectedBottomSheet(context, urlCanal: item['imageUrl'], nameCanal: item['name'], montant: '$_inputValue', kwh: '$_convertedValue', currency: 'FC');
                        } else{
                          mCanalSelectedBottomSheet(context, urlCanal: item['imageUrl'], nameCanal: item['name'], montant: '$_convertedValue', kwh: '$_inputValue', currency: 'USD');

                        }


                        /*Navigator.pushNamed(context, Routes.formPayment,
                            arguments: {
                              "paie":false,
                              "item":item
                            });*/
                        print('Card tapped: ${item['mobile_money']}');
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }
        );
  }

  mCanalSelectedBottomSheet(BuildContext aContext, {
    required String urlCanal,montant,kwh, nameCanal, currency
  }) {
    showModalBottomSheet(
        context: aContext,
        //isScrollControlled: true,
        showDragHandle: true,
        //enableDrag: true,
        //isDismissible: true,
        backgroundColor: KColorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (builder){
          return Padding(
            padding: EdgeInsets.only(bottom: spacing_standard,),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: KColorGris),
                          borderRadius: BorderRadius.circular(15.sp),
                          color: KColorWhite
                      ),
                      //width: Adaptive.w(spacing_standard),
                      margin: EdgeInsets.all(10.sp),
                      child: Padding(
                        padding: EdgeInsets.all(spacing_standard),
                        child: Image.asset(
                          urlCanal,
                          height: 4.h, // Hauteur de l'image
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    text(nameCanal??'',
                        fontSize: 18.sp,
                        textColor: t12_text_color_primary,
                        fontWeight: FontWeight.bold,
                        isCentered: true),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spacing_standard),
                  child: Divider(),
                ),
                text("$montant $currency",
                    fontSize: 25.sp,
                    textColor: t12_text_color_primary,
                    fontWeight: FontWeight.bold,
                    isCentered: true),
                text("$kwh Kwh", fontSize: textSizeLarge),
                SizedBox(
                  width: Adaptive.w(35),
                  child: MaterialButton(
                    padding: EdgeInsets.only(
                        top: spacing_standard,
                        bottom: spacing_standard,
                        left: spacing_standard,
                        right: spacing_standard),
                    child: Text("Valider",
                        style: TextStyle(color: KColorWhite)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(spacing_standard)),
                    color: KcolorPrimary,
                    onPressed: () {
                      Navigator.pop(context);
                      showConfirmationDialog(context,
                          title: 'Confirmation',
                          content: 'Voulez-vous effectuer cce paiment ?',
                      );
                      //showSuccesDialog(context);
                    },
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
