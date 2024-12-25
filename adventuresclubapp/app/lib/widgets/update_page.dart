import 'dart:io';

import 'package:app/constants.dart';
import 'package:app/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'my_text.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    void launchURL() async {
      const iOSUrl = "https://apps.apple.com/app/adventures-club/id1668119170";
      const androidUrl =
          "https://play.google.com/store/apps/details?id=com.universalskills.adventuresclub";
      if (Platform.isAndroid) {
        const url = androidUrl;
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch $url';
        }
      } else {
        const url = iOSUrl;
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch $url';
        }
      }
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
                onPressed: launchURL,
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenishColor, // Background color
                ),
                child: MyText(text: "update".tr()))
          ]),
        ),
      ),
    );
  }
}
