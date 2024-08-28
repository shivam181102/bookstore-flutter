import 'package:bookstore/Data%20Layer/bookStoreApiCall.dart';
import 'package:bookstore/Providers/bookcountProvider.dart';
import 'package:bookstore/global/common/ColorPalet.dart';
import 'package:bookstore/global/models/bookModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Booksgridviewcomp extends StatefulWidget {
  List<Bookmodel> booksdata;
   Booksgridviewcomp({super.key, required this.booksdata});

  @override
  State<Booksgridviewcomp> createState() => _BooksgridviewcompState();
}

class _BooksgridviewcompState extends State<Booksgridviewcomp> {
  Bookstoreapicall _bookapi = Bookstoreapicall();
  @override
  void initState() {
    // TODO: implement initState
    final _bookcount = Provider.of<Bookcountprovider>(context, listen: false); 
    // _bookcount.setcount(widget.booksdata.length);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  int booklen = widget.booksdata.length;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.booksdata.isEmpty?6: booklen,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.6),
      itemBuilder: (context, index) {
        Bookmodel? book = booklen != 0? widget.booksdata[index]: null;
        return Card(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  aboutBook(booklen!=0? book:null);
                },
                child: Container(
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
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booklen!=0? book!.bookName:"Null",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis)),
                    Text(booklen!=0?book!.author:"Null",
                        style: TextStyle(
                            color: Colors.grey, fontSize: 10)),
                    Row(
                      children: [
                        Text(
                          "Rs. ${booklen!=0?book!.discountPrice:null}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text("Rs. ${booklen!=0? book!.price:null}",
                            style: TextStyle(
                                fontSize: 10,
                                decoration:
                                    TextDecoration.lineThrough)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async{
                            bool stat = false;
                            if (booklen!=0 && book!.wishlist == false) {
                               stat = await _bookapi.AddtoWishlist(book.id);
                            }else{
                               stat = await _bookapi.RemoveFromWishlist(book!.id);
                            }
                            if (stat) {
                              setState(() {
                                widget.booksdata.remove(book);
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: booklen!=0 && book!.wishlist? brown: Colors.grey,width: 0.5),
                                borderRadius: BorderRadius.circular(5)),
                            width: 35,
                            height: 35,
                            child:booklen!=0 && book!.wishlist? Icon(Icons.favorite , color: brown,) :Icon(
                              Icons.favorite_outline,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async{
                            bool stat = await _bookapi.AddtoCart(book!.id);
                            if (booklen!=0 && book!.wishlist == true) {
                              await _bookapi.RemoveFromCart(book!.id);
                            setState(() {
                              widget.booksdata.remove(book);
                            });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: brown,
                                border: Border.all(color: brown),
                                borderRadius: BorderRadius.circular(5)),
                            width: 95,
                            height: 35,
                            child: Center(child: Text("ADD TO BAG", style: TextStyle(color: Colors.white, fontSize: 12),),)
                          ),
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
    );
         
  }
  Future aboutBook([Bookmodel? bookmodel]){
    return showModalBottomSheet(context: context, builder: (context) =>Container(
        height: 250,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/bookCoverPage.jpg",
                    height: 100,
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(bookmodel!.bookName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Text(bookmodel!.author, style: TextStyle(color: Colors.grey),)
                  ],)
                ],
              ), 
              SizedBox(height: 20,),
              Divider(height: 2, thickness: 1,color: Colors.grey,),
              SizedBox(height: 20,),
              Text(bookmodel.description, style: TextStyle(color: Colors.grey),)

            ],
          ),
        )),);
  }
}