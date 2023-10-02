import 'dart:io';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'my_text.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    void selected(BuildContext context) {
      if (Platform.isAndroid) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return const ShowChat(
                "https://play.google.com/store/apps/details?id=com.universalskills.adventuresclub",
                appbar: false,
              );
            },
          ),
        );
      } else {}
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.notifications_active,
              size: 60,
              color: greenishColor,
            ),
            const SizedBox(
              height: 10,
            ),
            MyText(
              text: "Update Available",
              weight: FontWeight.w600,
              size: 18,
              color: blackColor,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () => selected(context),
                style: ElevatedButton.styleFrom(
                  primary: greenishColor, // Background color
                ),
                child: MyText(text: "update".tr()))
          ]),
        ),
      ),
    );
  }
}
