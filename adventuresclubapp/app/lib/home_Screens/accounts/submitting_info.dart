import 'package:app/constants.dart';
import 'package:app/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:app/widgets/buttons/button_icon_less.dart';
import 'package:app/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubmittingInfo extends StatefulWidget {
  const SubmittingInfo({super.key});

  @override
  State<SubmittingInfo> createState() => _SubmittingInfoState();
}

class _SubmittingInfoState extends State<SubmittingInfo> {
  abc() {}

  void home() {
    // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //   return const BottomNavigation();
    // }));

    context.push('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20),
                child: Column(
                  children: [
                    const Image(
                      image: ExactAssetImage('images/check_circle.png'),
                      height: 50,
                    ),
                    const SizedBox(height: 20),
                    MyText(
                      text: 'Thank you for submitting information',
                      weight: FontWeight.bold,
                      color: blackTypeColor,
                    ),
                    const SizedBox(height: 10),
                    MyText(
                      text:
                          'It will be reviewed and published after it approved',
                      weight: FontWeight.w500,
                      color: greyColor,
                      align: TextAlign.center,
                      size: 12,
                    ),
                    const SizedBox(height: 20),
                    ButtonIconLess('Okay, Got it ', bluishColor, whiteColor,
                        1.9, 15, 20, home)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
