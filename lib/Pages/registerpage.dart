import 'package:bookstore/Data%20Layer/SignInSignUp.dart';
import 'package:bookstore/global/common/InputTextFieldComp.dart';
import 'package:bookstore/global/common/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController _phoneControl = TextEditingController();
  TextEditingController _passwordControl = TextEditingController();
  TextEditingController _nameControl = TextEditingController();
  TextEditingController _emailControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor:Colors.white,  // Navigation bar color
      statusBarColor: Colors.white, // Status bar color
      statusBarIconBrightness: Brightness.dark,  // Status bar icons color
      systemNavigationBarIconBrightness: Brightness.dark, // Navigation bar icons color
    ));
    Signinsignup _signinsugnup = Signinsignup();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 84,),
            Image.asset('assets/logo-dark.png', width: 124,height: 115,),
            SizedBox(height: 40,),
            Column(
              children: [
                Inputtextfieldcomp(hintText: "Full Name",controller: _nameControl,),
                Inputtextfieldcomp(hintText: "Email",controller: _emailControl,),
                Inputtextfieldcomp(hintText: "Password",controller: _passwordControl, password: true,),
                Inputtextfieldcomp(hintText: "Phone",controller: _phoneControl,),
              ],
            ),
            SizedBox(height: 40,),
            Column(
              children: [
                ButtonComp(
                    title: 'Create Account',
                    buttonAction: () {
                      _signinsugnup.signUp(_nameControl.text, _emailControl.text, _passwordControl.text, _phoneControl.text );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, 'login');
                      },
                      child: Text(
                        'Login here',
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
      ),
    );
  
  }
}