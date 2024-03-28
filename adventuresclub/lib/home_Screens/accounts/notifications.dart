import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/Lists/notifications_list.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool loading = false;

  @override
  void initState() {
    clearNotification();
    super.initState();
  }

  void clearNotification() async {
    try {
      var response = await http.post(
          Uri.parse("${Constants.baseUrl}/api/v1/read_notification"),
          body: {
            'user_id': Constants.userId.toString(),
          });
      if (response.statusCode == 200) {
      } else {
        dynamic body = jsonDecode(response.body);
        message(body['message'].toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: greyProfileColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          iconTheme: const IconThemeData(color: blackColor),
          title: MyText(
            text: 'Notifications',
            color: blackColor,
            weight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        body: const NotificationsList());
  }
}
