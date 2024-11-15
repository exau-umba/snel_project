import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snel_project/utils/components/formField.dart';
import 'package:snel_project/utils/constate.dart';
import '../../../../../utils/components/components.dart';
import 'package:snel_project/utils/Routes.dart';

import '../auth_bloc.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  FocusNode prenomFocus = FocusNode();
  bool passwordVisible = false;
  bool confirmePasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                      color: KcolorPrimary.withOpacity(1.5.sp),
                    ),
                    padding: EdgeInsets.all(spacing_standard),
                    margin: EdgeInsets.all(spacing_standard),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(spacing_standard),
                                child: themeLogo(),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: spacing_standard, right: spacing_standard, left: spacing_standard ),
                                child: formField(
                                    context, "Prénom",
                                    controller: prenomController,
                                    focusNode: prenomFocus,
                                    nextFocus: nameFocus,
                                    validator: (value) {
                                      if(value == null || value.isEmpty){
                                        return "Prénom Required";
                                      }
                                      return null;
                                    },
                                    onSaved: (String? value){
                                      prenomController.text = value??"";
                                      setState(() {});
                                    },
                                    prefixIcon: Icons.perm_identity
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: spacing_standard, right: spacing_standard, left: spacing_standard ),
                                child: formField(
                                    context, "Nom",
                                    controller: nameController,
                                    focusNode: nameFocus,
                                    nextFocus: emailFocus,
                                    validator: (value) {
                                      if(value == null || value.isEmpty){
                                        return "Nom Required";
                                      }
                                      return null;
                                    },
                                    onSaved: (String? value){
                                      nameController.text = value??"";
                                      setState(() {});
                                    },
                                    prefixIcon: Icons.perm_identity
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: spacing_standard, right: spacing_standard, left: spacing_standard ),
                                child: formField(
                                    context, "Email",
                                    controller: emailController,
                                    focusNode: emailFocus,
                                    nextFocus: passwordFocus,
                                    validator: (value) {
                                      if(value == null || value.isEmpty){
                                        return "Email Required";
                                      }
                                      if(!validationEmail(value)){
                                        return "Veilleez entrer un email valide";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (String? value){
                                      emailController.text = value??"";
                                      setState(() {});
                                    },
                                    prefixIcon: Icons.email_outlined
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: spacing_standard, right: spacing_standard, left: spacing_standard ),
                                child: formField(
                                    context, "Mot de passe",
                                    isPassword: true,
                                    isPasswordVisible: passwordVisible,
                                    validator: (value) {
                                      if(value == null || value.isEmpty){
                                        return "Mot de passe Required";
                                      }
                                      return null;
                                    },
                                    suffixIconSelector: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                    suffixIcon: passwordVisible? Icons.visibility_off:Icons.visibility,
                                    controller: password,
                                    focusNode: passwordFocus,
                                    nextFocus: confirmPasswordFocus,
                                    onSaved: (String? value){
                                      password.text = value??"";
                                      setState(() {});
                                    },
                                    prefixIcon: Icons.lock_clock_outlined
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: spacing_standard, right: spacing_standard, left: spacing_standard ),
                                child: formField(
                                    context, "Confirmé mot de passe",
                                    isPassword: true,
                                    isPasswordVisible: confirmePasswordVisible,
                                    validator: (value) {
                                      if(value == null || value.isEmpty){
                                        return "Confirmé mot de passe Required";
                                      }
                                      return null;
                                    },
                                    textInputAction: TextInputAction.done,
                                    suffixIconSelector: () {
                                      setState(() {
                                        confirmePasswordVisible = !confirmePasswordVisible;
                                      });
                                    },
                                    suffixIcon: confirmePasswordVisible? Icons.visibility_off:Icons.visibility,
                                    controller: confirmPassword,
                                    focusNode: confirmPasswordFocus,
                                    onSaved: (String? value){
                                      confirmPassword.text = value??"";
                                      setState(() {});
                                    },
                                    prefixIcon: Icons.lock_clock_outlined
                                ),
                              ),
                              SizedBox(
                                width: Adaptive.w(double.infinity),
                                child: Padding(
                                  padding: EdgeInsets.only(top: spacing_standard, right: spacing_standard, left: spacing_standard ),
                                  child: MaterialButton(
                                    padding: EdgeInsets.only(top: spacing_standard, bottom: spacing_standard, left: spacing_standard, right: spacing_standard),
                                    child: Text("Enregistrer", style: TextStyle(color: KColorWhite)),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(spacing_standard)),
                                    color: KcolorPrimary,
                                    onPressed: () {
                                      if(_formKey.currentState!.validate()){
                                        showLoadingDialog(context, Duration(seconds: 2));
                                        Future.delayed(Duration(seconds: 2),(){
                                          Navigator.pushNamedAndRemoveUntil(context,Routes.home,(route) => false);

                                        });

                                        //SnackBar(content: Text("Veillez mettre le mot de passe ou email"));
                                      }
                                    },
                                  ),
                                ),
                              ),
                              TextButton(onPressed: (){
                                Navigator.pushNamed(context, Routes.login);
                              }, child: text("Déjà un compte? Login", textColor: KcolorPrimary, fontSize: 16.sp))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
