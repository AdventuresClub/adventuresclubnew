import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/Lists/notifications_list.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
          ),
          centerTitle: true,
        ),
        body: const NotificationsList());
  }
}
