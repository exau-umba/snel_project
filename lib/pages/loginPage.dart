import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:snel_project/utils/Routes.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Bienvenu", style: TextStyle(
                fontSize: 25.sp
              ),),Text("Nous sommes content de vous révoir encore !"),
              SizedBox(height: 30.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                  ),
                  controller: emailController,
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    filled: true,
                    border: OutlineInputBorder(
                    ),
                    fillColor: Colors.white,
                  ),
                  controller: password,
                ),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)
                ),
                onPressed: () {
                  if(emailController.text.isEmpty || password.text.isEmpty){
                    SnackBar(content: Text("Veillez mettre le mot de passe ou email"));
                  }
                  Navigator.pushNamedAndRemoveUntil(context, Routes.dashboard, (route) => false);
                },
                child: Text('Se connecter', style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
