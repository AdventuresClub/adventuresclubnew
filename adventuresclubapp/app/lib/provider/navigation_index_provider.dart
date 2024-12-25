import 'dart:convert';

import 'package:app/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NavigationIndexProvider with ChangeNotifier {
  int homeIndex = 0;
  int notifications = 0;
  int clientRequests = 0;
  int myservice = 0;
  int totalBookings = 0;
  int totalAccount = 0;
  int unreadCount = 0;
  int serviceCount = 0;

  void setHomeIndex(int i) {
    homeIndex = i;
    notifyListeners();
  }

  void getUnreadCount(String serviceId) async {
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/groupchatcount"), body: {
        'service_id': serviceId, //"27",
      });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = decodedResponse['data'];
      for (var element in result) {
        serviceCount = convertToInt(element['totalUnReadChat'].toString());
      }

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getCounterChat(String userId) async {
    try {
      var response = await http.post(
          Uri.parse("${Constants.baseUrl}/api/v1/countrecievechatcount"),
          body: {
            'reciver_id': userId, //"27",
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = decodedResponse['data'];
      for (var element in result) {
        unreadCount = convertToInt(element['countrecievechatcount'].toString());
      }

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
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
      for (var element in result) {
        //setState(() {
        Constants.totalNotication =
            convertToInt(element['total_notification'] ?? "");
        totalAccount = convertToInt(element['resultAccount'] ?? "");
        Constants.resultService = convertToInt(element['resultService'] ?? "");
        Constants.resultRequest = convertToInt(element['resultRequest'] ?? "");
        clientRequests = convertToInt(element['client_request'] ?? "");
        totalBookings = convertToInt(element['totalbooking'] ?? "");
        //  });
      }
      notifications = Constants.totalNotication; //Constants.resultAccount;
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
