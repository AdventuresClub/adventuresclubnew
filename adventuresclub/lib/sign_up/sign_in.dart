// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/forgot_pass/forgot_pass.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:adventuresclub/sign_up/Sign_up.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/text_fields.dart';
import 'package:adventuresclub/widgets/text_fields/tf_with_suffix_icon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  List<bool> value = [false, false, false, false, false, false];
  bool valuea = false;
  String name = "";
  int countryId = 0;
  String countryName = "";
  int userId = 0;

  void enterOTP() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width / 1.1,
              child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 0),
                        MyText(
                            text: 'OTP Verification',
                            weight: FontWeight.bold,
                            color: blackColor,
                            size: 20,
                            fontFamily: 'Raleway'),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 6),
                          child: MyText(
                              text:
                                  'We have sent 4 digit OTP through SMS on xxxxxxx8586',
                              align: TextAlign.center,
                              weight: FontWeight.w400,
                              color: Colors.grey,
                              size: 16,
                              fontFamily: 'Raleway'),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          textAlign: TextAlign.center,
                          controller: otpController,
                          decoration: const InputDecoration(
                              hintText: 'Enter 4 Digit Code',
                              hintStyle: TextStyle(color: blackTypeColor4)),
                        ),
                        // TextFields(
                        //     'Enter 4 Digit Code', otpController, 0, whiteColor),
                        const SizedBox(height: 20),
                        MyText(
                            text: 'Resend OTP',
                            align: TextAlign.center,
                            weight: FontWeight.w600,
                            color: greenishColor,
                            size: 18,
                            fontFamily: 'Raleway'),
                        const SizedBox(height: 30),
                        Button(
                            'Confirm',
                            greenishColor,
                            greyColorShade400,
                            whiteColor,
                            16,
                            goToNavigation,
                            Icons.add,
                            whiteColor,
                            false,
                            1.7,
                            'Raleway',
                            FontWeight.w700,
                            16),
                      ],
                    ),
                  )),
            ),
          );
        });
  }

  void parseData(String name, int countryId, int id) {
    Provider.of<CompleteProfileProvider>(context, listen: false).name = name;
    Provider.of<CompleteProfileProvider>(context, listen: false).countryId =
        countryId;
    Provider.of<CompleteProfileProvider>(context, listen: false).id = id;
  }

  void login() async {
    SharedPreferences prefs = await Constants.getPrefs();
    try {
      var response = await http.post(
          Uri.parse("https://adventuresclub.net/adventureClub/api/v1/login"),
          body: {
            'email': emailController.text,
            'password': passController.text,
            'device_id': "0",
          });
      if (response.statusCode == 200) {
        var decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map;
        name = decodedResponse['data']['name'];
        countryId = decodedResponse['data']['country_id'];
        userId = decodedResponse['data']['id'];
        prefs.setString("name", name);
        prefs.setInt("countryId", countryId);
        prefs.setInt("userId", userId);
        parseData(name, countryId, userId);
        goToNavigation();
      }
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
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

  void goToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const SignUp();
        },
      ),
    );
  }

  void goToForgotPass() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const ForgotPass();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    blackColor.withOpacity(0.6), BlendMode.darken),
                image: const ExactAssetImage('images/login.png'),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text: 'Sign In',
                    weight: FontWeight.w600,
                    color: whiteColor,
                    size: 24,
                  )),
              Image.asset(
                'images/whitelogo.png',
                height: 120,
                width: 320,
              ),
              const SizedBox(height: 20),
              TextFields(
                  'Email or Username', emailController, 17, whiteColor, true),
              const SizedBox(height: 20),
              TFWithSiffixIcon(
                  'Password', Icons.visibility_off, passController, true),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Button(
                    'Sign In',
                    greenishColor,
                    greenishColor,
                    whiteColor,
                    18,
                    login,
                    Icons.add,
                    whiteColor,
                    false,
                    1.3,
                    'Raleway',
                    FontWeight.w600,
                    16),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: goToForgotPass,
                child: Align(
                    alignment: Alignment.center,
                    child: MyText(
                      text: 'Forgot Username?',
                      weight: FontWeight.w500,
                      color: whiteColor,
                      size: 14,
                    )),
              ),

              const SizedBox(height: 20),
              GestureDetector(
                onTap: goToForgotPass,
                child: Align(
                    alignment: Alignment.center,
                    child: MyText(
                      text: 'Forgot Password?',
                      weight: FontWeight.w500,
                      color: whiteColor,
                      size: 14,
                    )),
              ),

              //  Align(
              //   alignment: Alignment.bottomCenter,
              //    child: GestureDetector(
              //       onTap: goToSignUp,
              //       child: const Align(
              //         alignment: Alignment.center,
              //         child: Text.rich(
              //         TextSpan(
              //           children: [
              //             TextSpan(text: "Don't have an account? ",style: TextStyle(color:whiteColor)),
              //             TextSpan(
              //         text: 'Register',
              //         style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
              //             ),
              //           ],
              //         ),
              //       ),
              //       ),
              //     ),
              //  ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: transparentColor,
        height: 40,
        child: GestureDetector(
          onTap: goToSignUp,
          child: const Align(
            alignment: Alignment.center,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: whiteColor)),
                  TextSpan(
                    text: 'Register',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: whiteColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
