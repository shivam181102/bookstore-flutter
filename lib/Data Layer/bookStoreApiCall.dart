import 'dart:convert';

import 'package:bookstore/global/models/bookModel.dart';
import 'package:http/http.dart' as http;

class Bookstoreapicall {
  final String _baseURL = 'https://bookstore.incubation.bridgelabz.com';

  Future getAllBooks() async {
    String url = "$_baseURL/bookstore_user/get/book";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonbookdata = json.decode(response.body) as Map<String, dynamic>;
       
        return await convertJsonToBookmodel(jsonbookdata['result']);
      }
    } catch (e) {
      print(e);
    }
  }

  List<Bookmodel> convertJsonToBookmodel(List data) {
    List<Bookmodel> bookdata = [];
    for (var element in data) {
      Bookmodel book = Bookmodel(
          description: element['description'],
          id: element['_id'],
          admin_user_id: element['admin_user_id'],
          author: element['author'],
          bookName: element['bookName'],
          discountPrice: element['discountPrice'],
          price: element['price'],
          quantity: element['quantity']);
      bookdata.add(book);
    }
    return bookdata;
  }
}
