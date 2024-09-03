import 'package:bookstore/Pages/BooksSearchViewComp.dart';
import 'package:bookstore/Pages/OrderPlaced.dart';
import 'package:bookstore/Pages/cartpage.dart';
import 'package:bookstore/Pages/loginpage.dart';
import 'package:bookstore/Pages/mainpage.dart';
import 'package:bookstore/Pages/onboarding.dart';
import 'package:bookstore/Pages/registerpage.dart';
import 'package:bookstore/Pages/searchpage.dart';
import 'package:bookstore/Pages/wishlistpage.dart';
import 'package:bookstore/Providers/CartStateProvider.dart';
import 'package:bookstore/Providers/bookcountProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Bookcountprovider(),),
        ChangeNotifierProvider(create: (context) => Cartstateprovider(),),
      ],
      child: MaterialApp(
        initialRoute:'onBoard' ,
        title: 'Book Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(selectionColor: Colors.grey, selectionHandleColor: Colors.grey),
          colorScheme: ColorScheme.fromSeed(seedColor:  Colors.grey),
          useMaterial3: true,
        ),
        
        routes: {
          'mainpage':(context)=> Mainpage(),
          'onBoard':(context)=> Onboarding(),
          'login':(context)=> Loginpage(),
          'register':(context)=> Registerpage(),
          'cartpage':(context)=> Cartpage(),
          'wishlist':(context)=>Wishlistpage(),
          'search': (context)=> Searchpage(),
          'orderplace': (context)=> Orderplaced(),
          
        },
      ),
    );
  }
}

