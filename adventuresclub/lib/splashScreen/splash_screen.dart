import 'dart:async';
import 'package:adventuresclub/check_profile.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const CheckProfile() //ChooseLanguage(),
              ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage('images/logo.png'), fit: BoxFit.cover),
          ),
          width: MediaQuery.of(context).size.width / 1.6,
          height: MediaQuery.of(context).size.height / 4.6,
        ),
      ),
    );
  }
}
