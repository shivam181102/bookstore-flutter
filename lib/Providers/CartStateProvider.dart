

import 'package:flutter/material.dart';

class Cartstateprovider with ChangeNotifier {
  void statechange(){
    notifyListeners();
  }
}