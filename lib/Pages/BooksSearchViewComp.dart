import 'package:bookstore/Data%20Layer/bookStoreApiCall.dart';
import 'package:bookstore/Pages/BooksGridViewComp.dart';
import 'package:bookstore/global/common/AppbarComp.dart';
import 'package:bookstore/global/common/ColorPalet.dart';
import 'package:bookstore/global/models/bookModel.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Bookssearchviewcomp extends StatefulWidget {
  String result;

   Bookssearchviewcomp({super.key, required this.result});

  @override
  State<Bookssearchviewcomp> createState() => _BookssearchviewcompState();
}

class _BookssearchviewcompState extends State<Bookssearchviewcomp> {
  bool errorOccured = false;
Bookstoreapicall _bookstoreapicall = Bookstoreapicall();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbarcomp(),
      body: ListView(
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, 'mainpage', (route) => false,);
                }, icon: const Icon(Icons.arrow_back)),
                Text(
                  "(Showing result for) ",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.result,
                  style: const TextStyle(
                      color: Colors.black,
                 fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            FutureBuilder(
                future: _bookstoreapicall.getAllBooks(),
                builder: (context, snapshot) {
                  

                  if (snapshot.hasData && snapshot.data != null) {
                    errorOccured = false;
                   List<Bookmodel> data = snapshot.data.where((Bookmodel item)=> item.bookName.toLowerCase().contains(widget.result.toLowerCase())).toList();
                   
                   if (data.length == 0) {
                     return Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            color: brown,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                   }
                    return Booksgridviewcomp(
                      booksdata: data,
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    errorOccured = false;

                    return Skeletonizer(
                        enabled: true,
                        enableSwitchAnimation: true,
                        child: Booksgridviewcomp(
                          booksdata: [],
                        ));
                  } else if (snapshot.data?.length == 0) {
                    return Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            color: brown,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  errorOccured = true;
                  return Container(
                      height: 400,
                      child: Center(
                          child: Text(
                        "Some thing went wrong",
                        style: TextStyle(
                            color: brown,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )));
                },
              )
        ],
      ),
    );
  }
}