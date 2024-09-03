import 'package:bookstore/global/common/AppbarComp.dart';
import 'package:bookstore/global/common/ColorPalet.dart';
import 'package:bookstore/global/common/button.dart';
import 'package:flutter/material.dart';

class Orderplaced extends StatelessWidget {
  const Orderplaced({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Appbarcomp(),
      body: Container(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(alignment: AlignmentDirectional.center,children: [
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Image.asset('assets/pngwing.com.png', height: 300,width: 300,),
                 ),
                 Positioned( child: Container( width: double.infinity, color: Colors.white,child: const Center(child: Text('Order Placed Succesfully', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),))))
              ],),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('hurry!!! your order is confirmed, the order id is #123456 save the order id for further communication..', textAlign: TextAlign.center, style: TextStyle(fontSize: 17,color: Colors.grey[600]),),
              ),
              ButtonComp(title: "Continue Shopping", buttonAction: (){
                Navigator.pushNamedAndRemoveUntil(context, 'mainpage', (route) => false,);
              })
          
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 120,
        padding: EdgeInsets.only(top: 10),
        color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Row(children: [
                        Icon(Icons.mail, color: brown,),
                        SizedBox(width: 10,),
                        Text('admin@bookstore.com')
                      ],),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:  8.0),
                        child: SizedBox(height: 20, child: VerticalDivider(thickness: 2,width: 2,)),
                      ),
                       Row(children: [
                        Icon(Icons.phone, color: brown,),
                        SizedBox(width: 10,),
                        Text('+91 9876543210')
                      ],),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(children: [
                        Icon(Icons.pin_drop, color: brown,),
                        SizedBox(width: 10,),
                        Text('Bridgelabz, Malhotra Chembher, Govandi - 400 007')
                      ],),
                ],
              ),
            ),
          Container(color: Colors.black, width: double.maxFinite, child: Center(child: Text("Copyright @ 2020, Bookstore Pvt. Ltd. All Rights Reserved", style: TextStyle(color: Colors.white),),),)
          ],
        ),
      ),
    );
  }
}