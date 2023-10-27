// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/sign_up/sign_in.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/text_fields/space_text_field.dart';
import '../widgets/text_fields/tf_with_suffix_icon.dart';

class RecoveryPassword extends StatefulWidget {
  final String otpId;
  final String userId;
  final String userName;
  final String type;
  const RecoveryPassword(this.otpId, this.userId, this.userName, this.type,
      {super.key});

  @override
  State<RecoveryPassword> createState() => _RecoveryPasswordState();
}

class _RecoveryPasswordState extends State<RecoveryPassword> {
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void goToSignIn() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const SignIn();
        },
      ),
    );
  }

  void requestSent() async {
    showDialog(
      context: context,
      builder: (ctx) => const SimpleDialog(
        title: Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            "Your password has been reset",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  void forgotPassword() async {
    if (passController.text.isEmpty) {
      message("Please Enter Password");
      return;
    }
    if (confirmPassController.text.isEmpty) {
      message("Please Confirm Password");
      return;
    }
    if (passController.text != confirmPassController.text) {
      message("Password does not match");
      return;
    }
    try {
      var response = await http.post(
          Uri.parse("${Constants.baseUrl}/api/v1/forgot_password"),
          body: {
            'user_id': widget.userId, //"",
            'password': passController.text.trim(),
            // 'password_confirmation': confirmPassController.text.trim(),
            // 'otp_id': widget.otpId, //"0",
          });
      if (response.statusCode == 200) {
        requestSent();
        goToSignIn();
      } else {
        dynamic body = jsonDecode(response.body);
        message(body['message'].toString());
      }
      print(response.statusCode);
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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: kPrimaryColor),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              MyText(text: "Recovery Password"),
              const SizedBox(
                height: 30,
              ),
              const Image(
                image: ExactAssetImage('images/logo.png'),
                height: 150,
              ),
              const SizedBox(
                height: 20,
              ),
              if (widget.type != "username")
                Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: "Now you can Reset your password",
                      weight: FontWeight.bold,
                      color: greyColor,
                      size: 12,
                    )),
              const SizedBox(
                height: 20,
              ),
              widget.type == "username"
                  ? Column(
                      children: [
                        MyText(
                          text: "${"Your Username is : "} ${widget.userName}",
                          color: blackColor,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyText(
                          text: "Please use this User Name to login.",
                          color: blackColor,
                          weight: FontWeight.bold,
                        )
                      ],
                    )
                  : SpaceTextFields(
                      'Password', passController, 17, whiteColor, true),
              const SizedBox(height: 20),
              if (widget.type != "username")
                TFWithSiffixIcon('Confirm Password', Icons.visibility_off,
                    confirmPassController, true),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Button(
                    'Save',
                    greenishColor,
                    greenishColor,
                    whiteColor,
                    18,
                    forgotPassword,
                    Icons.add,
                    whiteColor,
                    false,
                    1.3,
                    'Raleway',
                    FontWeight.w600,
                    16),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: goToSignIn,
                child: const Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Remember?',
                            style: TextStyle(
                                color: blueButtonColor, fontFamily: 'Raleway')),
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: blueButtonColor,
                              fontFamily: 'Raleway'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
