import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NavigationIndexProvider with ChangeNotifier {
  int homeIndex = 0;
  int notifications = 0;
  int clientRequests = 0;
  int myservice = 0;

  void setHomeIndex(int i) {
    homeIndex = i;
    notifyListeners();
  }

  void getNotificationBadge() async {
    try {
      var response = await http.post(
          Uri.parse("${Constants.baseUrl}/api/v1/get_notification_list_budge"),
          body: {
            'user_id': Constants.userId.toString(), //"27",
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = decodedResponse['data'];
      result.forEach((element) {
        //setState(() {
        Constants.totalNotication =
            convertToInt(element['total_notification'] ?? "");
        Constants.resultAccount = convertToInt(element['resultAccount'] ?? "");
        Constants.resultService = convertToInt(element['resultService'] ?? "");
        Constants.resultRequest = convertToInt(element['resultRequest'] ?? "");
        clientRequests = convertToInt(element['client_request'] ?? "");
        //  });
      });
      notifications = Constants.resultAccount;
      // notificationNumber(
      //   convertToInt(totalNotication),
      //   convertToInt(resultAccount),
      //   convertToInt(resultService),
      //   convertToInt(resultRequest),
      // );
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  int convertToInt(String s) {
    int t = int.tryParse(s) ?? 0;
    return t;
  }

  void notificationNumber(
    int totalN,
    int account,
    int serviceCounter,
    int requestCounter,
  ) {
    Constants.totalNotication = totalN;
    Constants.resultAccount = account;
    Constants.resultService = serviceCounter;
    Constants.resultRequest = requestCounter;
  }
}
