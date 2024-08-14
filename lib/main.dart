import 'package:bookstore/Pages/loginpage.dart';
import 'package:bookstore/Pages/onboarding.dart';
import 'package:bookstore/Pages/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      initialRoute:'onBoard' ,
      title: 'Book Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 132, 105, 144)),
        useMaterial3: true,
      ),
      
      routes: {
        'onBoard':(context)=> Onboarding(),
        'login':(context)=> Loginpage(),
        'register':(context)=> Registerpage()
      },
    );
  }
}

