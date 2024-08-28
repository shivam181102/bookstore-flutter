import 'package:flutter/material.dart';

class Bookcountprovider with ChangeNotifier {
  int _count = 10;

  int get count => _count;

  void setcount(int value) {
    _count = value;
    notifyListeners();
  }
}