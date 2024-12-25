import 'package:app/constants.dart';
import 'package:app/widgets/buttons/button.dart';
import 'package:app/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InviteFriends extends StatefulWidget {
  const InviteFriends({super.key});

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

void launchURL() async {
  const url = 'https://adventuresclub.net/';
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

class _InviteFriendsState extends State<InviteFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.5,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset(
            'images/backArrow.png',
            height: 20,
          ),
        ),
        title: MyText(
          text: 'inviteFriends'.tr(),
          color: bluishColor,
          weight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                    image: ExactAssetImage('images/pngtree.png'),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Button(
                "invite",
                bluishColor,
                bluishColor,
                whiteColor,
                16,
                launchURL,
                Icons.deblur,
                bluishColor,
                false,
                3,
                "Roboto",
                FontWeight.w500,
                14),
            const SizedBox(
              height: 50,
            ),
            // ButtonIconLess(
            //     'Earn More', bluishColor, whiteColor, 1.8, 16, 16, abc),
          ],
        ),
      ),
    );
  }
}
