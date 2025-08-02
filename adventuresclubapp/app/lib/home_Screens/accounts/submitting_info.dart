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
        children: [],
      ),
    ));
  }
}
