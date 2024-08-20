import 'dart:convert';

import 'package:http/http.dart' as http;

class Bookstoreapicall {
  final String baseURL = 'https://bookstore.incubation.bridgelabz.com';

  Future getAllBooks() async{
    String url = "$baseURL/bookstore_user/get/book";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonbookdata = json.decode(response.body) as Map<String, dynamic>;
        
      }
    } catch (e) {
      print(e);
    }
  }
}