import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:snel_project/data/models/Facture.dart';
import 'package:snel_project/features/paiement/payment/payment_bloc.dart';
import 'package:snel_project/utils/components/formatter.dart';
import 'package:snel_project/utils/constate.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/components/components.dart';
import '../../../utils/components/formField.dart';

class FormPayment extends StatefulWidget {
  final item;

  const FormPayment({super.key, this.item});

  @override
  State<FormPayment> createState() => _FormPaymentState();
}

class _FormPaymentState extends State<FormPayment> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nomCarteController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController numeroCarteController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController mobilePaymentController = TextEditingController();
  bool passwordVisible = true;
  String selectedCurrency = 'USD'; // Valeur par défaut pour la devise

  //final _formKey = GlobalKey<FormState>();
  String? _nomTitulaire;
  String? _numeroCompte;
  String? _codeBanque;
  String? _codeGuichet;
  String? _bic;
  double? _montant;
  String? _objet;

  // Liste des devises
  final List<String> currencies = [
    'USD',
    'FC',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KcolorPrimary,
        bottom: PreferredSize(
            preferredSize: Size(Adaptive.w(20), 5.h),
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: text(
                  "${widget.item['paie'] || widget.item['banque']==false ? 'Paiement ${widget.item['facture'].numeroFacture}' : "${widget.item['item']['mobile_money'] ? "Ajout mobile money" : "Ajout paiement banque"}"}",
                  fontSize: 20.sp,
                  textColor: KColorWhite),
            )),
        iconTheme: IconThemeData(color: KColorWhite),
        titleTextStyle: TextStyle(color: KColorWhite),
        centerTitle: true,
      ),
      body: widget.item['paie'] ? _body2() : _body(),
    );
  }

  _body2() {
    return Container(
      padding: EdgeInsets.all(spacing_standard),
      height: double.infinity.h,
      decoration: BoxDecoration(
        color: KcolorPrimary.withOpacity(1.5.sp),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: widget.item['banque']
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: spacing_standard,
                          right: spacing_standard,
                          top: spacing_standard),
                      child: formField(
                        context,
                        "Nom",
                        prefixIcon: Icons.perm_identity_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le nom';
                          }
                          return null;
                        },
                        onSaved: (value) => _nomTitulaire = value,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: spacing_standard,
                          right: spacing_standard,
                          top: spacing_standard),
                      child: formField(
                        context,
                        prefixIcon: Icons.account_balance,
                        "Numéro de compte (ou IBAN)",
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le numéro de compte';
                          }
                          return null;
                        },
                        onSaved: (value) => _numeroCompte = value,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: spacing_standard,
                          right: spacing_standard,
                          top: spacing_standard),
                      child: formField(
                        context,
                        prefixIcon: Icons.business,
                        "Code banque",
                        isPassword: true,
                        isPasswordVisible: passwordVisible,
                        suffixIconSelector: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        suffixIcon: passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le code banque';
                          }
                          return null;
                        },
                        onSaved: (value) => _codeBanque = value,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: spacing_standard,
                          right: spacing_standard,
                          top: spacing_standard),
                      child: formField(
                        context,
                        "Code guichet",
                        prefixIcon: Icons.location_on,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le code guichet';
                          }
                          return null;
                        },
                        onSaved: (value) => _codeGuichet = value,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: spacing_standard,
                          right: spacing_standard,
                          top: spacing_standard),
                      child: formField(
                        context,
                        "BIC/SWIFT (pour les virements internationaux)",
                        prefixIcon: Icons.code,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le BIC/SWIFT';
                          }
                          return null;
                        },
                        onSaved: (value) => _bic = value,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: spacing_standard,
                          right: spacing_standard,
                          top: spacing_standard),
                      child: formField(
                        context,
                        readOnly: true,
                        "${widget.item['facture'].montant}",
                        prefixIcon: Icons.monetization_on,
                        keyboardType: TextInputType.number,
                        validator: (value) {},
                        onSaved: (value) => widget.item['facture'].montant =
                            double.tryParse(value!),
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
                          child: Text("Payer",
                              style: TextStyle(color: KColorWhite)),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  new BorderRadius.circular(spacing_standard)),
                          color: KcolorPrimary,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                    )
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: spacing_standard,
                          right: spacing_standard,
                          top: spacing_standard),
                      child: formField(
                        context,
                        readOnly: true,
                        "${widget.item['facture'].montant}",
                        prefixIcon: Icons.monetization_on,
                        keyboardType: TextInputType.number,
                        validator: (value) {},
                        onSaved: (value) => _montant = double.tryParse(value!),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: spacing_standard,
                          right: spacing_standard,
                          top: spacing_standard),
                      child: formField(
                        context,
                        'Numéro',
                        prefixIcon: Icons.phone_android,
                        controller: mobilePaymentController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un numéro de paiement mobile';
                          }
                          return null;
                        },
                      ),
                    ),
                    BlocConsumer<PaymentBloc, PaymentState>(
                      listener: (context, state) {
                        if (state is AjoutCardPaymentsSucces) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.message),
                            backgroundColor: KColorSecondary,
                          ));
                        } else if (state is AjoutCardPaymentsError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)));
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          width: Adaptive.w(100),
                          height: 7.h,
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
                              child: Text("Payer",
                                  style: TextStyle(color: KColorWhite)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(
                                      spacing_standard)),
                              color: KcolorPrimary,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  print(
                                      "LABEL ${numeroCarteController.text}- IDCLIENT ${cvvController.text}");
                                  //context.read<PaymentBloc>().add(AddCardPayment(numero: numeroCarteController.text,nom: nomCarteController.text, date: dateController.text, cvv: cvvController.text, idClient: 1));
                                  Navigator.pop(context);
                                }
                                dateController.clear();
                                cvvController.clear();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  _body() {
    return widget.item['item']["mobile_money"]
        ? Container(
            decoration: BoxDecoration(color: KcolorPrimary.withOpacity(1.5.sp)),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Champ pour le mode de paiement mobile
                  Padding(
                    padding: EdgeInsets.only(
                        left: spacing_standard,
                        right: spacing_standard,
                        top: spacing_standard),
                    child: Row(
                      children: [
                        Expanded(
                          child: formField(
                            context,
                            'Numéro',
                            prefixIcon: Icons.phone_android,
                            controller: mobilePaymentController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer un numéro de paiement mobile';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(3),
                        ),
                        // Sélecteur de devise
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedCurrency,
                            items: currencies.map((String currency) {
                              return DropdownMenuItem<String>(
                                value: currency,
                                child: Text(currency),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCurrency = newValue!;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: "Choisir une devise",
                              isDense: true,
                              filled: true,
                              fillColor: t12_edittext_background,
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.sp)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.sp),
                                  borderSide: BorderSide(
                                    color: KcolorPrimary,
                                  )),
                              prefixIcon: Icon(Icons.monetization_on_outlined),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Veuillez choisir une devise';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<PaymentBloc, PaymentState>(
                    listener: (context, state) {
                      if (state is AjoutCardPaymentsSucces) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.message),
                          backgroundColor: KColorSecondary,
                        ));
                      } else if (state is AjoutCardPaymentsError) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },
                    builder: (context, state) {
                      return Container(
                        width: Adaptive.w(100),
                        height: 7.h,
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
                            child: Text("Enregistrer",
                                style: TextStyle(color: KColorWhite)),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(
                                    spacing_standard)),
                            color: KcolorPrimary,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                print(
                                    "LABEL ${numeroCarteController.text}- IDCLIENT ${cvvController.text}");
                                context.read<PaymentBloc>().add(AddCardPayment(
                                    numero: numeroCarteController.text,
                                    nom: nomCarteController.text,
                                    date: dateController.text,
                                    cvv: cvvController.text,
                                    idClient: 1));
                                Navigator.pop(context);
                              }
                              dateController.clear();
                              cvvController.clear();
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(color: KcolorPrimary.withOpacity(1.5.sp)),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: spacing_standard,
                        left: spacing_standard,
                        top: spacing_standard),
                    child: formField(
                      context,
                      prefixIcon: Icons.payment,
                      'Numéro carte',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CardNumberInputFormatter()
                      ],
                      controller: numeroCarteController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un numéro';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        numeroCarteController.text = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: spacing_standard,
                        left: spacing_standard,
                        right: spacing_standard),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: formField(context, "Date (MM/AA)",
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                DateInputFormatter()
                              ],
                              keyboardType: TextInputType.number,
                              prefixIcon: Icons.date_range_outlined,
                              controller: dateController, validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer la date';
                            }
                            return null;
                          }, onSaved: (value) {
                            dateController.text = value;
                          }),
                        ),
                        SizedBox(
                          width: Adaptive.w(3),
                        ),
                        Expanded(
                          child: formField(context, "CVV",
                              inputFormatters: [CVVInputFormatter()],
                              keyboardType: TextInputType.number,
                              prefixIcon: Icons.password,
                              controller: cvvController, validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer le cvv';
                            }
                            return null;
                          }, onSaved: (value) {
                            cvvController.text = value;
                          }),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: spacing_standard,
                        left: spacing_standard,
                        right: spacing_standard),
                    child: formField(context, "Nom de la carte",
                        prefixIcon: Icons.perm_identity_outlined,
                        controller: nomCarteController, validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le nom de la carte';
                      }
                      return null;
                    }, onSaved: (value) {
                      nomCarteController.text = value;
                    }),
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
                        child: Text("Enregistrer",
                            style: TextStyle(color: KColorWhite)),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                new BorderRadius.circular(spacing_standard)),
                        color: KcolorPrimary,
                        onPressed: () {
                          //Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
