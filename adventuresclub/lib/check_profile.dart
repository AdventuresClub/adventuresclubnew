// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, use_build_context_synchronously

import 'package:adventuresclub/choose_language.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'home_Screens/navigation_screens/bottom_navigation.dart';

class CheckProfile extends StatefulWidget {
  const CheckProfile({Key? key}) : super(key: key);

  @override
  CheckProfileState createState() => CheckProfileState();
}

class CheckProfileState extends State<CheckProfile> {
  @override
  void initState() {
    super.initState();
    checkProfile();
  }

  void goToNavigation() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const BottomNavigation();
        },
      ),
    );
  }

  void start() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const ChooseLanguage();
        },
      ),
    );
  }

  void parseData(
      String name, int countryId, int id, String email, String pass) {
    setState(() {
      Constants.userId = id;
      Constants.name = name;
      Constants.countryId = countryId;
      Constants.emailId = email;
      Constants.password = pass;
    });
  }

  void checkProfile() async {
    SharedPreferences prefs = await Constants.getPrefs();
    int userId = prefs.getInt("userId") ?? 0;
    int countryId = prefs.getInt("countryId") ?? 0;
    String name = prefs.getString("name") ?? "";
    String email = prefs.getString("email") ?? "";
    String password = prefs.getString("password") ?? "";
    if (userId != 0) {
      parseData(name, countryId, userId, email, password);
      //prefs.setString("name", )
      goToNavigation();
    } else {
      start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(color: Colors.purple),
            SizedBox(height: 20),
            Text(
              "Loading Profile ...",
              style: TextStyle(color: Colors.purple),
            ),
          ],
        ),
      ),
    );
  }
}
