import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:snel_project/features/authentication/compte_snel/ajout_compte_snel/ajout_compte_snel_bloc.dart';
import 'package:snel_project/utils/components/formField.dart';
import 'package:snel_project/utils/constate.dart';

class AccountForm extends StatefulWidget {
  @override
  _AccountFormState createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _labelController = TextEditingController();
  TextEditingController _clientIdController = TextEditingController();
  String? _label;
  String? _clientId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KcolorPrimary,
        bottom: PreferredSize(
            preferredSize: Size(Adaptive.w(20), 5.h),
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Text(
                "Ajouter un Compte SNEL",
                style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: KColorWhite),
              ),
            )),
        iconTheme: IconThemeData(color: KColorWhite),
        titleTextStyle: TextStyle(color: KColorWhite),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16.0.sp),
      decoration: BoxDecoration(
        color: KcolorPrimary.withOpacity(1.5.sp)
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: spacing_standard, left: spacing_standard, top: spacing_standard),
              child: formField(
                context,
                prefixIcon: Icons.home_work_outlined,
                'Intitulé (ex. "Maison", "Bureau")',
                controller: _labelController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un intitulé';
                  }
                  return null;
                },
                onSaved: (value) {
                  _labelController.text = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: spacing_standard, left: spacing_standard, right: spacing_standard),
              child: formField(context, "ID Client SNEL",
                  prefixIcon: Icons.perm_identity_outlined,
                  controller: _clientIdController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer l\'ID client';
                    }
                    return null;
                  },
                  onSaved: (value) {
                _clientIdController.text = value;
              }),
            ),
            BlocConsumer<AjoutCompteSnelBloc, AjoutCompteSnelState>(
              listener: (context, state) {
                if (state is AjoutCompteSnelSucces) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                    backgroundColor: KColorSecondary,
                  ));
                } else if (state is AjoutCompteSnelError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                return Container(
                  width: Adaptive.w(100),
                  height: 7.h,
                  child: Padding(
                    padding: EdgeInsets.only(top: spacing_standard, right: spacing_standard, left: spacing_standard ),
                    child: MaterialButton(
                      padding: EdgeInsets.only(top: spacing_standard, bottom: spacing_standard, left: spacing_standard, right: spacing_standard),
                      child: Text("Enregistrer", style: TextStyle(color: KColorWhite)),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(spacing_standard)),
                      color: KcolorPrimary,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          print(
                              "LABEL ${_labelController.text}- IDCLIENT ${_clientIdController.text}");
                          context.read<AjoutCompteSnelBloc>().add(AddAccountSnel(
                              _labelController.text, int.parse(_clientIdController.text) ));
                          Navigator.pop(context);
                        }
                        _labelController.clear();
                        _clientIdController.clear();
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
