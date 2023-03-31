// ignore_for_file: avoid_print, use_build_context_synchronously, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/forgot_pass/forgot_pass.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:adventuresclub/models/get_country.dart';
import 'package:adventuresclub/models/profile_models/profile_become_partner.dart';
import 'package:adventuresclub/models/user_profile_model.dart';
import 'package:adventuresclub/sign_up/Sign_up.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/space_text_field.dart';
import 'package:adventuresclub/widgets/text_fields/tf_with_suffix_icon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  String error = "";
  int countryId = 0;
  String countryName = "";
  int userId = 0;
  String email = "";
  String password = "";
  Map mapCountry = {};
  List<GetCountryModel> countriesList1 = [];
  ProfileBecomePartner pbp = ProfileBecomePartner(0, 0, "", "", "", "", "", "",
      "", "", 0, 0, "", "", "", "", "", "", "", 0, "", "", "", "", "", "");

  @override
  void initState() {
    super.initState();
    getCountries();
  }

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

  void cId(int id) async {
    SharedPreferences prefs = await Constants.getPrefs();
    countriesList1.forEach((element) {
      if (id == element.id) {
        setState(() {
          Constants.countryFlag = element.flag;
        });
      }
    });
    prefs.setString("countryFlag", Constants.countryFlag);
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

  Future getCountries() async {
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/get_countries"));
    if (response.statusCode == 200) {
      mapCountry = json.decode(response.body);
      List<dynamic> result = mapCountry['data'];
      result.forEach((element) {
        GetCountryModel gc = GetCountryModel(
          element['country'],
          element['flag'],
          element['code'],
          element['id'],
        );
        countriesList1.add(gc);
      });
    }
  }

  void login() async {
    SharedPreferences prefs = await Constants.getPrefs();
    try {
      if (emailController.text.isNotEmpty) {
        if (passController.text.isNotEmpty) {
          var response = await http.post(
              Uri.parse(
                  "https://adventuresclub.net/adventureClub/api/v1/login"),
              body: {
                'email': emailController.text,
                'password': passController.text,
                'device_id': "0",
              });
          if (response.statusCode == 200) {
            var decodedResponse =
                jsonDecode(utf8.decode(response.bodyBytes)) as Map;
            dynamic userData = decodedResponse['data'];
            int userLoginId = int.tryParse(userData['id'].toString()) ?? 0;
            int countryId =
                int.tryParse(userData['country_id'].toString()) ?? 0;
            int languageId =
                int.tryParse(userData['language_id'].toString()) ?? 0;
            int currencyId =
                int.tryParse(userData['currency_id'].toString()) ?? 0;
            int addedFrom =
                int.tryParse(userData['added_from'].toString()) ?? 0;
            dynamic partnerInfo = decodedResponse['data']["become_partner"];
            if (partnerInfo != null) {
              int id = int.tryParse(partnerInfo['id'].toString()) ?? 0;
              int userId = int.tryParse(partnerInfo['user_id'].toString()) ?? 0;
              int debitCard =
                  int.tryParse(partnerInfo['debit_card'].toString()) ?? 0;
              int visaCard =
                  int.tryParse(partnerInfo['visa_card'].toString()) ?? 0;
              int packagesId =
                  int.tryParse(partnerInfo['packages_id'].toString()) ?? 0;
              ProfileBecomePartner bp = ProfileBecomePartner(
                id,
                userId,
                partnerInfo['company_name'].toString() ?? "",
                partnerInfo['address'].toString() ?? "",
                partnerInfo['location'].toString() ?? "",
                partnerInfo['description'].toString() ?? "",
                partnerInfo['license'].toString() ?? "",
                partnerInfo['cr_name'].toString() ?? "",
                partnerInfo['cr_number'].toString() ?? "",
                partnerInfo['cr_copy'].toString() ?? "",
                debitCard,
                visaCard,
                partnerInfo['payon_arrival'].toString() ?? "",
                partnerInfo['paypal'].toString() ?? "",
                partnerInfo['bankname'].toString() ?? "",
                partnerInfo['account_holdername'].toString() ?? "",
                partnerInfo['account_number'].toString() ?? "",
                partnerInfo['is_online'].toString() ?? "",
                partnerInfo['is_approved'].toString() ?? "",
                packagesId,
                partnerInfo['start_date'].toString() ?? "",
                partnerInfo['end_date'].toString() ?? "",
                partnerInfo['is_wiretransfer'].toString() ?? "",
                partnerInfo['is_free_used'].toString() ?? "",
                partnerInfo['created_at'].toString() ?? "",
                partnerInfo['updated_at'].toString() ?? "",
              );
              pbp = bp;
            }
            UserProfileModel up = UserProfileModel(
                userLoginId,
                userData['users_role'].toString() ?? "",
                userData['profile_image'].toString() ?? "",
                userData['name'].toString() ?? "",
                userData['height'].toString() ?? "",
                userData['weight'].toString() ?? "",
                userData['email'].toString() ?? "",
                countryId,
                userData['region_id'].toString() ?? "",
                userData['city_id'].toString() ?? "",
                userData['now_in'].toString() ?? "",
                userData['mobile'].toString() ?? "",
                userData['mobile_verified_at'].toString() ?? "",
                userData['dob'].toString() ?? "",
                userData['gender'].toString() ?? "",
                languageId,
                userData['nationality_id'].toString() ?? "",
                currencyId,
                userData['app_notification'].toString() ?? "",
                userData['points'].toString() ?? "",
                userData['health_conditions'].toString() ?? "",
                userData['health_conditions_id'].toString() ?? "",
                userData['email_verified_at'].toString() ?? "",
                userData['mobile_code'].toString() ?? "",
                userData['status'].toString() ?? "",
                addedFrom,
                userData['created_at'].toString() ?? "",
                userData['updated_at'].toString() ?? "",
                userData['deleted_at'].toString() ?? "",
                userData['device_id'].toString() ?? "",
                pbp);
            Constants.profile = up;
            Constants.userRole = up.userRole;
            prefs.setString("userRole", up.userRole);
            prefs.setInt("userId", up.id);
            prefs.setInt("countryId", up.countryId);
            prefs.setString("name", up.name);
            prefs.setString("email", emailController.text);
            prefs.setString("password", passController.text);
            cId(up.countryId);
            parseData(
                up.name, up.countryId, up.id, up.email, passController.text);
            //Constants.userRole = "3";
            goToNavigation();
          } else {
            dynamic body = jsonDecode(response.body);
            // error = decodedError['data']['name'];
            Constants.showMessage(context, body['message'].toString());
          }
          print(response.statusCode);
          print(response.body);
          print(response.headers);
        } else {
          Constants.showMessage(context, "Please Enter Password");
        }
      } else {
        Constants.showMessage(context, "Please Enter Email");
      }
    } catch (e) {
      /// print(e.toString());
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
      body: SingleChildScrollView(
        child: Container(
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
                SpaceTextFields(
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
