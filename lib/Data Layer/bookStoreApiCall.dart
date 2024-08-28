import 'dart:convert';
import 'dart:developer';

import 'package:bookstore/Providers/CartStateProvider.dart';
import 'package:bookstore/global/models/CartbookModel.dart';
import 'package:bookstore/global/models/bookModel.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bookstoreapicall {
  final String _baseURL = 'https://bookstore.incubation.bridgelabz.com';

  Future getAllBooks() async {
    String url = "$_baseURL/bookstore_user/get/book";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonbookdata = json.decode(response.body) as Map<String, dynamic>;
        List<Bookmodel> modellist = [];
        for (var element in jsonbookdata['result']) {
         modellist.add(convertJsonToBookmodel(element));
        }
       
        return modellist;
      }
    } catch (e) {
      print(e);
    }
  }
  Future<bool> CartitemQuantity(String id , int quantity) async {
    String url = "$_baseURL/bookstore_user/cart_item_quantity/$id";
    try {
      SharedPreferences _sp = await SharedPreferences.getInstance();
      String? apiToken =  _sp.getString('accessToken');
      final response = await http.put(Uri.parse(url), body: {"quantityToBuy": "$quantity"}, headers: {'x-access-token': '$apiToken'});
       print(".................. ${response.body}");
      if (response.statusCode == 200) {
        
       
        return true;
      }
    } catch (e) {
      print(e);
    }
      return false;
  }
  Future<bool> EditAddress(String addressType , String fullAddress,String city,String state) async {
    String url = "$_baseURL/bookstore_user/edit_user";
    try {
      SharedPreferences _sp = await SharedPreferences.getInstance();
      String? apiToken =  _sp.getString('accessToken');
      final response = await http.put(Uri.parse(url), body: {"addressType": addressType,'fullAddress':fullAddress,'city':city,'state':state    }, headers: {'x-access-token': '$apiToken'});
      
      if (response.statusCode == 200) {
        
        return true;
      }
    } catch (e) {
      print(e);
    }
      return false;
  }
  Future<bool> RemoveFromCart(String id ) async {
    String url = "$_baseURL/bookstore_user/remove_cart_item/$id";
    try {
      SharedPreferences _sp = await SharedPreferences.getInstance();
      String? apiToken =  _sp.getString('accessToken');
      final response = await http.delete(Uri.parse(url), headers: {'x-access-token': '$apiToken'});
       print(".................. ${response.body}");
      if (response.statusCode == 200) {
        
       
        return true;
      }
    } catch (e) {
      print(e);
    }
      return false;
  }
  Future<bool> AddtoCart(String id ) async {
    String url = "$_baseURL/bookstore_user/add_cart_item/$id";
    try {
      SharedPreferences _sp = await SharedPreferences.getInstance();
      String? apiToken =  _sp.getString('accessToken');
      final response = await http.post(Uri.parse(url), headers: {'x-access-token': '$apiToken'});
       print(".................. ${response.body}");
      if (response.statusCode == 200) {
       
        return true;
      }
    } catch (e) {
      print(e);
    }
      return false;
  }
  Future<bool> PlaceOrder(List data ) async {
    String url = "$_baseURL/bookstore_user/add/order";
    try {
      SharedPreferences _sp = await SharedPreferences.getInstance();
      String? apiToken =  _sp.getString('accessToken');
       final jsondata = await json.encode({'orders': data});
      final response = await http.post(Uri.parse(url),body: jsondata, headers: {'Content-Type': 'application/json','x-access-token': '$apiToken'});
    
      if (response.statusCode == 200) {
       
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
      return false;
  }
  Future<bool> AddtoWishlist(String id ) async {
    String url = "$_baseURL/bookstore_user/add_wish_list/$id";
    try {
      SharedPreferences _sp = await SharedPreferences.getInstance();
      String? apiToken =  _sp.getString('accessToken');
      final response = await http.post(Uri.parse(url), headers: {'x-access-token': '$apiToken'});
       print(".................. ${response.body}");
      if (response.statusCode == 200) {
       
        return true;
      }
    } catch (e) {
      print(e);
    }
      return false;
  }
  Future<bool> RemoveFromWishlist(String id ) async {
    String url = "$_baseURL/bookstore_user/remove_wishlist_item/$id";
    try {
      SharedPreferences _sp = await SharedPreferences.getInstance();
      String? apiToken =  _sp.getString('accessToken');
      final response = await http.delete(Uri.parse(url), headers: {'x-access-token': '$apiToken'});
       print(".................. ${response.body}");
      if (response.statusCode == 200) {
       
        return true;
      }
    } catch (e) {
      print(e);
    }
      return false;
  }
  Future getCartBooks() async {
    String url = "$_baseURL/bookstore_user/get_cart_items";
    try {
      SharedPreferences _sp = await SharedPreferences.getInstance();
      String? apiToken =  _sp.getString('accessToken');
      final response = await http.get(Uri.parse(url), headers: {'x-access-token': '$apiToken','Content-Type': 'application/json',});
    

      if (response.statusCode == 200) {
        final jsonbookdata = await json.decode(response.body) as Map<String, dynamic>;
        List<Cartbookmodel> Cartbook = [];
        for (var element in jsonbookdata['result']) {
          Cartbook.add(convertJsonToCartbookmodel(element));
        }

       return Cartbook;
        
      }
    } catch (e) {
      print("error $e");
    }
  }
  Future getWishlistBooks() async {
    String url = "$_baseURL/bookstore_user/get_wishlist_items";
    try {
      SharedPreferences _sp = await SharedPreferences.getInstance();
      String? apiToken =  _sp.getString('accessToken');
      final response = await http.get(Uri.parse(url), headers: {'x-access-token': '$apiToken','Content-Type': 'application/json',});
    
      if (response.statusCode == 200) {
        final jsonbookdata = await json.decode(response.body) as Map<String, dynamic>;
        List<Bookmodel> Cartbook = [];
        for (var element in jsonbookdata['result']) {
        
          Cartbook.add(convertJsonToBookmodel(element['product_id'], wishlist: true));
        }
       return Cartbook;
        
      }
    } catch (e) {
      print("error $e");
    }
  }
  Cartbookmodel convertJsonToCartbookmodel(Map data){
    final product = convertJsonToBookmodel(data['product_id']);
    return Cartbookmodel(Uemail: data['user_id']['email'], Uname: data['user_id']['fullName'], id: data['_id'], phone: data['user_id']['phone'], product:product , quantityToBuy: data['quantityToBuy'], Address: data['user_id']['address']);
  }

  Bookmodel convertJsonToBookmodel(Map element, {bool wishlist = false}) {
    
      Bookmodel book = Bookmodel(
          description: element['description'],
          id: element['_id'],
          admin_user_id: element['admin_user_id'],
          author: element['author'],
          wishlist: wishlist,
          bookName: element['bookName'],
          discountPrice: element['discountPrice'],
          price: element['price'],
          quantity: element['quantity']);
      
    return book;
  }
}
  

  
