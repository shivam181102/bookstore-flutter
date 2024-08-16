import 'package:bookstore/Data%20Layer/SignInSignUp.dart';
import 'package:bookstore/global/common/InputTextFieldComp.dart';
import 'package:bookstore/global/common/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController _emailControl = TextEditingController();
  TextEditingController _passwordControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // Navigation bar color
      statusBarColor: Colors.white, // Status bar color
      statusBarIconBrightness: Brightness.dark, // Status bar icons color
      systemNavigationBarIconBrightness:
          Brightness.dark, // Navigation bar icons color
    ));

    Signinsignup _signinsugnup = Signinsignup();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          
          Image.asset('assets/logo-dark.png'),
          Column(
            children: [
              Inputtextfieldcomp(hintText: "Email",controller: _emailControl,),
              Inputtextfieldcomp(hintText: "Password",controller: _passwordControl, password: true,),
            ],
          ),
          Column(
            children: [
              ButtonComp(
                  title: 'Login',
                  buttonAction: () {
                    _signinsugnup.signIn(_emailControl.text, _passwordControl.text);
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account yet? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'register');
                    },
                    child: Text(
                      'Sign up here',
                      style:
                          TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
