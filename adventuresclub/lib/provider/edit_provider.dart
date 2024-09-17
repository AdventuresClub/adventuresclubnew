import 'package:flutter/material.dart';

class EditProvider with ChangeNotifier {
  bool edit = false;

  void changeStatus(bool status) {
    edit = status;
    notifyListeners();
  }
}
