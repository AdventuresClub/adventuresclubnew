import 'package:flutter/material.dart';

class NavigationIndexProvider with ChangeNotifier {
  int homeIndex = 0;

  void setHomeIndex(int i) {
    homeIndex = i;
    notifyListeners();
  }
}
