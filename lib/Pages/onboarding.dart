import 'package:bookstore/global/common/ColorPalet.dart';
import 'package:bookstore/global/common/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});
   
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor:brown,  // Navigation bar color
      statusBarColor: brown, // Status bar color
      statusBarIconBrightness: Brightness.light,  // Status bar icons color
      systemNavigationBarIconBrightness: Brightness.light, // Navigation bar icons color
    ));
    return Scaffold(
      backgroundColor: brown,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 181,),
          Image.asset('assets/logo.png'),
          SizedBox(height: 40,),
          Column(
            children: [
              Text("Welcome", style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.w600),),
              Text("Read without limits", style: TextStyle(fontSize: 20, color: Colors.white),),
            ],
          ),
          SizedBox(height: 40,),
          Column(
            children: [
              ButtonComp(title: "Create Account",buttonColorWhite: true,buttonAction: (){ Navigator.popAndPushNamed(context, 'register');}, ),
              ButtonComp(title: "Log In as Guest",buttonAction: (){ Navigator.popAndPushNamed(context, 'login');},),
            ],
          )
        ],
      ),
    );
  }
}