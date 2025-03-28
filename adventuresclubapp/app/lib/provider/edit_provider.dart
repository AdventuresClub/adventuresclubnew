import 'package:flutter/material.dart';

class EditProvider with ChangeNotifier {
  bool edit = false;
  String appLink = '';

  void setAppLink(String link) {
    debugPrint(link);
    appLink = link.replaceAll("https://adventuresclub.net", "");
    notifyListeners();
  }
  void clearAppLink() {
    appLink = '';
  }

  void changeStatus(bool status) {
    edit = status;
    notifyListeners();
  }
}
