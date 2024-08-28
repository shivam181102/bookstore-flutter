import 'dart:developer';

import 'package:bookstore/Data%20Layer/bookStoreApiCall.dart';
import 'package:bookstore/Pages/Addressform.dart';
import 'package:bookstore/Pages/BooksCartListView.dart';
import 'package:bookstore/Providers/CartStateProvider.dart';
import 'package:bookstore/global/common/AppbarComp.dart';
import 'package:bookstore/global/common/ColorPalet.dart';
import 'package:bookstore/global/common/InputTextFieldComp.dart';
import 'package:bookstore/global/common/button.dart';
import 'package:bookstore/global/models/CartbookModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  Bookstoreapicall bookdata = Bookstoreapicall();

  bool errorOccured = true;

  int bookCount = 0;
  @override
  void initState() {
    datafetch();
    // TODO: implement initState
    super.initState();
  }

  double _totalPrice = 0;
  bool loading = false;
  List _cartData = [];
  List _addressData = [];

  int _groupValue = 0;
  Future datafetch() async {
    double totalcost = 0;
    _cartData = await bookdata.getCartBooks();
    _addressData = _cartData.length != 0 ? _cartData[0].Address! : [];
    for (Cartbookmodel element in _cartData) {
      totalcost += (element.quantityToBuy * element.product.discountPrice);
    }
    setState(() {
      _totalPrice = totalcost;
    });

    return _cartData;
  }

  @override
  Widget build(BuildContext context) {
    final _bookcount = Provider.of<Cartstateprovider>(context, listen: true);

    return PopScope(
      onPopInvokedWithResult: (bool didPop, dynamic value) {
        if (didPop) {
          return;
        }
        Navigator.pushNamedAndRemoveUntil(
          context,
          'mainpage',
          (route) => false,
        );
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: Appbarcomp(),
        body: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        'mainpage',
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.arrow_back)),
                const Text(
                  "My Bag",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "(${_cartData.length} items)",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            FutureBuilder(
              future: datafetch(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data?.length != 0) {
                  errorOccured = false;
                  bookCount = snapshot.data.length;

                  return Bookscartlistview(data: snapshot.data);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  errorOccured = false;

                  return Skeletonizer(
                      enabled: true,
                      enableSwitchAnimation: true,
                      child: Bookscartlistview());
                } else if (snapshot.data?.length == 0) {
                  return Container(
                    height: 50,
                    child: const Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            color: brown,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }
                errorOccured = true;
                return Container(
                    height: 400,
                    child: const Center(
                        child: Text(
                      "Some thing went wrong",
                      style: TextStyle(
                          color: brown,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Customer Details',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          IconButton(
                              onPressed: () {
                                AddAddress();
                              },
                              icon: const Icon(Icons.add))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _addressData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(_cartData[0].Uname),
                                        Text(_cartData[0].phone),
                                        Text(
                                            "${_addressData[index]['addressType']}")
                                      ],
                                    ),
                                    Radio(
                                      value: index,
                                      activeColor: brown,
                                      groupValue: _groupValue,
                                      onChanged: (value) {
                                        setState(() {
                                          _groupValue = value!;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(_addressData[index]['fullAddress']),
                                Text(_addressData[index]['city']),
                                Text(_addressData[index]['state']),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Color.fromARGB(113, 0, 0, 0),
                spreadRadius: 0.5,
                blurRadius: 3)
          ]),
          child: BottomAppBar(
            height: 100,
            elevation: 20,
            shadowColor: Colors.black,
            surfaceTintColor: Colors.white,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rs. $_totalPrice",
                      style: TextStyle(
                          color: brown,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    VerticalDivider(
                      width: 1,
                      thickness: 2,
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                        width: 160,
                        child: ButtonComp(
                            title: "Place Order",
                            buttonAction: () async{
                              List<Map> placeorder = [];
                              for (var element in _cartData) {
                                Map data = {
                                  "product_id": element.product.id,
                                  "product_name": element.product.bookName,
                                  "product_quantity": element.quantityToBuy,
                                  "product_price": element.product.discountPrice
                                };
                                placeorder.add(data);
                              }
                              bool stat = await bookdata.PlaceOrder(placeorder);
                              
                              if (stat) {
                                Navigator.popAndPushNamed(context, 'orderplace');
                              }
                              
                              
                            })),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future AddAddress() {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => const Addressform(),
    );
  }
}
