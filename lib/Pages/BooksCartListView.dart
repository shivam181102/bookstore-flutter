import 'package:bookstore/Data%20Layer/bookStoreApiCall.dart';
import 'package:bookstore/Providers/CartStateProvider.dart';
import 'package:bookstore/global/common/ColorPalet.dart';
import 'package:bookstore/global/models/CartbookModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bookscartlistview extends StatefulWidget {
  List? data;
   Bookscartlistview({super.key,  this.data});

  @override
  State<Bookscartlistview> createState() => _BookscartlistviewState();
}

class _BookscartlistviewState extends State<Bookscartlistview> {
  Bookstoreapicall bookapi = Bookstoreapicall();
  @override
  Widget build(BuildContext context) {
  int? cartlen = widget.data?.length;
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cartlen == null ? 3: cartlen,
              itemBuilder: (context, index) {
                Cartbookmodel? bookdata = cartlen ==0?null: widget.data?[index];
                return Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/bookCoverPage.jpg",
                            height: 110,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(bookdata != null? bookdata.product.bookName:"Null",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis)),
                              Text(bookdata != null?bookdata.product.author:"Null",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10)),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Rs. ${bookdata != null?bookdata.product.discountPrice:null}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  Text("Rs. ${bookdata != null?bookdata.product.price:null}",
                                      style: TextStyle(
                                          fontSize: 10,
                                          decoration:
                                              TextDecoration.lineThrough)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () async{
                                      if (bookdata != null) 
                                     {bool stat = await bookapi.CartitemQuantity(bookdata.id, bookdata.quantityToBuy-1);
                                     if (stat) {
                                      //  setState(() {
                                      //    bookdata.quantityToBuy = bookdata.quantityToBuy -1;
                                      //  });
                                      final _bookcount = Provider.of<Cartstateprovider>(context, listen: false); 
                _bookcount.statechange();

                                     }}

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: brown, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      width: 25,
                                      height: 25,
                                      child: Icon(
                                        Icons.remove,
                                        size: 20,
                                        color: brown,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("${bookdata != null?bookdata.quantityToBuy:null}"),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () async{
                                      if (bookdata != null) {
                                        
                                      
                                      bool stat = await bookapi.CartitemQuantity(bookdata.id, bookdata.quantityToBuy+1);
                                     
                                     if (stat) {
                                      //  setState(() {
                                      //    bookdata.quantityToBuy = bookdata.quantityToBuy +1;
                                      //  });
                                      final _bookcount = Provider.of<Cartstateprovider>(context, listen: false); 
                _bookcount.statechange();
                                     }}
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: brown,
                                          border: Border.all(
                                              color: brown, width: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      width: 25,
                                      height: 25,
                                      child: Icon(
                                        Icons.add,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      IconButton(onPressed: () async{
                        if (bookdata != null) {
                          
                        
                        bool stat = await bookapi.RemoveFromCart(bookdata.id);
                        if (stat) {
                        widget.data?.remove(widget.data?[index]);
                          setState(() {
                            
                          });
                        }}
                      }, icon: Icon(Icons.close))
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Divider(
                  height: 2,
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
            ),
          );;
  }
}