import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../utils/Routes.dart';
import '../../../../utils/components/components.dart';
import '../../../../utils/components/formField.dart';
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
        title: text('Abonnement',
            textColor: KColorWhite, fontSize: textSizeLarge),
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
                  if(state is AccountSnelLoaded){
                    return Padding(
                      padding: EdgeInsets.only(
                          top: spacing_standard,
                          right: spacing_standard,
                          left: spacing_standard),
                      child: formFieldSelect(
                        context,
                        prefixIcon: Icons.add_home_work_rounded,
                        'Choisir un compte',
                        options: state.accounts.map((e) => DropdownMenuItem(value: e.label, child: Text("${e.label}")),).toList(),
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
                    'Valeur convertie: ${_convertedValue?.toInt()} ${_selectedType == 'money'? 'kWh': 'USD'} ',
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
                      if(_convertedValue!=null)
                      mCornerBottomSheet(context);
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
                text(
                    "Choix de mode paiement",
                    fontSize: 18.sp,
                    textColor: t12_text_color_primary,
                    fontWeight: FontWeight.bold,
                    isCentered: true
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: spacing_standard, right: spacing_standard, left: spacing_standard ),
                      child: SizedBox(
                        width: Adaptive.w(35),
                        child: MaterialButton(
                          padding: EdgeInsets.only(
                              top: spacing_standard,
                              bottom: spacing_standard,
                              left: spacing_standard,
                              right: spacing_standard),
                          child: Text("Mobile money", style: TextStyle(color: KColorWhite)),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(spacing_standard)),
                          color: KcolorPrimary,
                          onPressed: () {
                            Navigator.pop(aContext);
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
                      padding: EdgeInsets.only(top: spacing_standard, right: spacing_standard, left: spacing_standard ),
                      child: SizedBox(
                        width: Adaptive.w(35),
                        child: MaterialButton(
                          padding: EdgeInsets.only(
                              top: spacing_standard,
                              bottom: spacing_standard,
                              left: spacing_standard,
                              right: spacing_standard),
                          child: Text("Banque", style: TextStyle(color: KColorWhite)),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(spacing_standard)),
                          color: KcolorPrimary,
                          onPressed: () {
                            Navigator.pop(aContext);
                            Navigator.pushNamed(context, Routes.modePayment, arguments: {
                              "banque":true,
                              "paie":false,
                              "facture":_convertedValue?.toInt()
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
}
