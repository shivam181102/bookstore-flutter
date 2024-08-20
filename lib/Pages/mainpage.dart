import 'dart:async';

import 'package:bookstore/global/common/ColorPalet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  OutlineInputBorder borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.grey, width: 1));
  List<String> bookTypes = [
    "Novel",
    "Self-love",
    "Science",
    "Romance",
    "Historic"
  ];
  int _selected = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer.periodic(Duration(seconds: 5), (time){
    //   setState(() {
    //     skeleton = !skeleton;
    //   });
    // });
  }

  bool skeleton = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // Navigation bar color
      statusBarColor: Colors.white, // Status bar color
      statusBarIconBrightness: Brightness.dark, // Status bar icons color
      systemNavigationBarIconBrightness:
          Brightness.dark, // Navigation bar icons color
    ));
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset("assets/logo-dark.png", height: 25),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Bookstore",
              style: TextStyle(
                  color: brown, fontSize: 25, fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              size: 30,
              color: brown,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.favorite_outline,
              size: 30,
              color: brown,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 30,
              color: brown,
            ),
          )
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [Icon(Icons.home), Text("Home")],
            ),
            Column(
              children: [Icon(Icons.heart_broken), Text("Saved")],
            ),
            Column(
              children: [Icon(Icons.settings_outlined), Text("Setting")],
            ),
            Column(
              children: [Icon(Icons.account_circle), Text("Profile")],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Books",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              margin: const EdgeInsets.only(bottom: 20),
              height: 30,
              child: ListView.separated(
                itemCount: bookTypes.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selected = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: _selected == index
                          ? BoxDecoration(
                              color: const Color.fromARGB(139, 158, 158, 158),
                              borderRadius: BorderRadius.circular(20),
                            )
                          : null,
                      child: Center(
                        child: Text(
                          bookTypes[index],
                          style: TextStyle(
                              fontSize: 17,
                              color: _selected == index
                                  ? Colors.black
                                  : Colors.grey,
                              fontWeight:
                                  _selected == index ? FontWeight.bold : null),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  width: 30,
                ),
              ),
            ),
            Skeletonizer(
              enabled: skeleton,
              enableSwitchAnimation: true,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.6),
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: Image.asset(
                            "assets/bookCoverPage.jpg",
                            height: 140,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(10),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Shreemnta Yogi",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text("By Ranjit Desai",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10)),
                              Row(
                                children: [
                                  Text(
                                    "Rs. 1500",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text("Rs. 2000",
                                      style: TextStyle(
                                          fontSize: 10,
                                          decoration:
                                              TextDecoration.lineThrough)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey,width: 0.5),
                                        borderRadius: BorderRadius.circular(5)),
                                    width: 35,
                                    height: 35,
                                    child: Icon(
                                      Icons.favorite_outline,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: brown,
                                        border: Border.all(color: brown),
                                        borderRadius: BorderRadius.circular(5)),
                                    width: 95,
                                    height: 35,
                                    child: Center(child: Text("ADD TO BAG", style: TextStyle(color: Colors.white, fontSize: 12),),)
                                  ),

                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
