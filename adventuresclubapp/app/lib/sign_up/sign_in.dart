// ignore_for_file: avoid_print, use_build_context_synchronously, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:io';

import 'package:app/constants.dart';
import 'package:app/forgot_pass/forgot_pass.dart';
import 'package:app/home_Screens/accounts/about_us.dart';
import 'package:app/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:app/models/get_country.dart';
import 'package:app/models/profile_models/profile_become_partner.dart';
import 'package:app/models/user_profile_model.dart';
import 'package:app/new_signup/new_register.dart';
import 'package:app/widgets/buttons/button.dart';
import 'package:app/widgets/my_text.dart';
import 'package:app/widgets/text_fields/space_text_field.dart';
import 'package:app/widgets/text_fields/tf_with_suffix_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
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
  String deviceId = "";
  String token = "";
  String deviceType = "";
  String deviceData = "";
  List<GetCountryModel> countriesList1 = [];
  ProfileBecomePartner pbp = ProfileBecomePartner(0, 0, "", "", "", "", "", "",
      "", "", 0, 0, "", "", "", "", "", "", "", 0, "", "", "", "", "", "");
  String language = "";

  @override
  void initState() {
    super.initState();
    registerFCM();
  }

  Future<void> registerFCM() async {
    SharedPreferences prefs = await Constants.getPrefs();
    token = prefs.getString("token") ?? "";
    deviceType = prefs.getString("device_type") ?? "";
    await FirebaseMessaging.instance.requestPermission();
    String? fcmToken;

    if (token.isEmpty) {
      if (Platform.isIOS) {
        fcmToken = await FirebaseMessaging.instance.getAPNSToken();
      } else {
        fcmToken = await FirebaseMessaging.instance.getToken(
            vapidKey:
                "BEr0HbHx_pAg1PMPbqHuA2g0hQrHtbvsM5cNfxMThTHvnvcH01-Z8MnBo-qyDR0LvRPi2fvb_3WVWf4T2rlLOhg");
      }
      fcmToken ??= DateTime.now().microsecondsSinceEpoch.toString();
      token = fcmToken;
      prefs.setString("token", token);
      Constants.token = token;
    } else {
      fcmToken = token;
    }
    setFCMToken(fcmToken);
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      setFCMToken(fcmToken);
    }).onError((err) {});
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        Constants.showMessage(
            context, "${notification.title}: ${notification.body}");
        debugPrint('onMessage: ${notification.toString()}');
      }
    });
    getDeviceID();
  }

  void setFCMToken(String fcmToken) async {}

  void getDeviceID() async {
    // final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        //deviceData = readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        //deviceId = deviceData['id'];
        deviceType = "1";
        Constants.deviceType = "1";
      } else if (Platform.isIOS) {
        //deviceData = readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        //deviceId = deviceData['id'];
        deviceType = "2";
        Constants.deviceType = "2";
      }
    } on PlatformException {
      // deviceData = <String, dynamic>{
      //   'Error:': 'Failed to get platform version.'
      // };
    }
    debugPrint("done");
    getCountries();
    login();
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
          Constants.country = element.country;
          Constants.myCountry = element;
        });
      }
    });
    prefs.setString(
      "countryFlag",
      Constants.countryFlag,
    );
    prefs.setString(("country"), Constants.country);
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
    var response =
        await http.get(Uri.parse("${Constants.baseUrl}/api/v1/get_countries"));
    if (response.statusCode == 200) {
      mapCountry = json.decode(response.body);
      List<dynamic> result = mapCountry['data'];
      result.forEach((element) {
        GetCountryModel gc = GetCountryModel(
            element['country'],
            element['short_name'],
            element['flag'],
            element['code'],
            element['id'],
            element['currency'] ?? "",
            maxPrice: element['max_price'] ?? "",
            serviceCount: element['serviceCount'] ?? 0);
        countriesList1.add(gc);
      });
    }
    language = getCurrentLanguage(context);
  }

  void login() async {
    SharedPreferences prefs = await Constants.getPrefs();
    try {
      if (emailController.text.isNotEmpty) {
        if (passController.text.isNotEmpty) {
          var response = await http
              .post(Uri.parse("${Constants.baseUrl}/api/v1/login"), body: {
            'email': emailController.text,
            'password': passController.text,
            'device_id': token, //deviceId, //"0",,
            'device_type': deviceType
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
            prefs.setString("email", up.email);
            prefs.setString("password", passController.text);
            prefs.setString("token", token);
            prefs.setString("device_type", deviceType);
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
        Constants.showMessage(context, "Please Enter User Name");
      }
    } catch (e) {
      /// print(e.toString());
    }
  }

  void goToNavigation() {
    context.replace('/home');
    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(
    //     builder: (_) {
    //       return const BottomNavigation();
    //     },
    //   ),
    //   (route) => false,
    // );
  }

  void goToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const NewRegister(); //NewGetOtp(); //SignUp();
        },
      ),
    );
  }

  void navAboutus() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const AboutUs(); //NewGetOtp(); //SignUp();
        },
      ),
    );
  }

  void goToForgotPass(String t) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ForgotPass(t);
        },
      ),
    );
  }

  void home() {
    context.push('/home');
    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(
    //     builder: (_) {
    //       return const BottomNavigation();
    //     },
    //   ),
    //   (route) => false,
    // );
  }

  void changeLanguage(String lang) {
    if (lang == "en") {
      context.setLocale(const Locale('en', 'US'));
      Constants.language = "en";
    } else if (lang == "ar") {
      context.setLocale(const Locale('ar', 'SA'));
      Constants.language = "ar";
    }
  }

  String getCurrentLanguage(BuildContext context) {
    Locale currentLocale = EasyLocalization.of(context)!.locale;
    return currentLocale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      blackColor.withOpacity(0.75), BlendMode.darken),
                  image: const ExactAssetImage('images/login.png'),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MyText(
                          text: "signIn".tr(), //'Sign In',
                          weight: FontWeight.w600,
                          color: whiteColor,
                          size: 24,
                        ),
                      ),
                      PopupMenuButton<String>(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: language == "en"
                              ? const Image(
                                  image: ExactAssetImage(
                                      'images/great_britain.png'),
                                  height: 80,
                                  width: 60,
                                )
                              : const Image(
                                  image: ExactAssetImage('images/ksa_flag.png'),
                                  height: 80,
                                  width: 60,
                                ),
                        ),
                        onSelected: (String item) {
                          setState(() {
                            language = item;
                          });
                          changeLanguage(item);
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: "en",
                            child: Text('English'),
                          ),
                          const PopupMenuItem<String>(
                            value: "ar",
                            child: Text('Arabic'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Image.asset(
                    'images/blueLogo.png', //'images/whitelogo.png',
                    height: 200,
                    width: 320,
                  ),
                  const SizedBox(height: 10),
                  SpaceTextFields(
                      "username".tr(), emailController, 17, whiteColor, true),
                  const SizedBox(height: 5),
                  TFWithSiffixIcon("password".tr(), Icons.visibility_off,
                      passController, true),
                  //const SizedBox(height: 20),
                  // const SizedBox(height: 5),
                  // GestureDetector(
                  //   onTap: home,
                  //   child: Align(
                  //       alignment: Alignment.center,
                  //       child: MyText(
                  //         text: "Continue As Guest".tr(),
                  //         weight: FontWeight.w500,
                  //         color: whiteColor,
                  //         size: 16,
                  //       )),
                  // ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Button(
                        "signIn".tr(),
                        greenishColor,
                        greenishColor,
                        whiteColor,
                        20,
                        login,
                        Icons.add,
                        whiteColor,
                        false,
                        2,
                        'Raleway',
                        FontWeight.w600,
                        18),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => goToForgotPass("username"),
                    child: Align(
                        alignment: Alignment.center,
                        child: MyText(
                          text: "forgotUserName?".tr(),
                          weight: FontWeight.w500,
                          color: whiteColor,
                          size: 16,
                        )),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => goToForgotPass("password"),
                    child: Align(
                        alignment: Alignment.center,
                        child: MyText(
                          text: "forgotPassword".tr(),
                          weight: FontWeight.w500,
                          color: whiteColor,
                          size: 16,
                        )),
                  ),
                  //const SizedBox(height: 40),

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
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: transparentColor,
              height: 40,
              child: GestureDetector(
                onTap: goToSignUp,
                child: Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: "dontHaveAnAccount?".tr(),
                            style: const TextStyle(
                                color: whiteColor, fontSize: 16)),
                        // TextSpan(
                        //   text: "register".tr(),
                        //   style: const TextStyle(
                        //       fontWeight: FontWeight.bold, color: whiteColor),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Button(
                  "register".tr(),
                  greenishColor,
                  greenishColor,
                  whiteColor,
                  20,
                  goToSignUp,
                  Icons.add,
                  whiteColor,
                  false,
                  2,
                  'Raleway',
                  FontWeight.w600,
                  20),
            ),
            // const SizedBox(
            //   height: 2,
            // ),
            Container(
              color: transparentColor,
              height: 40,
              child: GestureDetector(
                onTap: navAboutus,
                child: Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: "privacyPolicy".tr(),
                            style: const TextStyle(
                                color: whiteColor, fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class SignIn extends StatefulWidget {
//   const SignIn({super.key});

//   @override
//   SignInState createState() => SignInState();
// }

// class SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
//   bool _isAccepting = false;
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: Duration(milliseconds: 200),
//       vsync: this,
//     );
//     _scaleAnimation = Tween<double>(
//       begin: 1.0,
//       end: 0.95,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _acceptOrder() async {
//     setState(() {
//       _isAccepting = true;
//     });

//     // Simulate API call
//     await Future.delayed(Duration(seconds: 2));

//     setState(() {
//       _isAccepting = false;
//     });

//     // Show success message and navigate
//     _showSuccessDialog();
//   }

//   void _rejectOrder() {
//     _showRejectDialog();
//   }

//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           title: Row(
//             children: [
//               Icon(Icons.check_circle, color: Colors.green, size: 30),
//               SizedBox(width: 10),
//               Text('Order Accepted!'),
//             ],
//           ),
//           content: Text('You have successfully accepted this delivery order.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 // Navigate to order tracking screen
//               },
//               child: Text('Continue'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showRejectDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           title: Text('Reject Order'),
//           content: Text('Are you sure you want to reject this order?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pop(); // Go back to previous screen
//               },
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.red,
//               ),
//               child: Text('Reject'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Color(0xFF55ABCB),
//         title: Text(
//           'New Delivery Order',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Order Header Card
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Color(0xFF55ABCB),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 ),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   children: [
//                     Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         'ORDER #WB001',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 15),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.access_time, color: Colors.white, size: 20),
//                         SizedBox(width: 8),
//                         Text(
//                           'Delivery Time: 10:00 PM',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             SizedBox(height: 20),

//             // Order Details Card
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Delivery Details',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[800],
//                         ),
//                       ),
//                       SizedBox(height: 15),

//                       // Location Info
//                       _buildInfoRow(
//                         icon: Icons.location_on,
//                         title: 'Delivery Location',
//                         subtitle: 'Muscat, Bosher',
//                         iconColor: Color(0xFF55ABCB),
//                       ),

//                       SizedBox(height: 15),

//                       // Items Info
//                       _buildInfoRow(
//                         icon: Icons.water_drop,
//                         title: 'Items to Deliver',
//                         subtitle: '3 Water Bottles',
//                         iconColor: Colors.blue,
//                       ),

//                       SizedBox(height: 15),

//                       // Time Info
//                       _buildInfoRow(
//                         icon: Icons.schedule,
//                         title: 'Delivery Time',
//                         subtitle: '10:00 PM Tonight',
//                         iconColor: Colors.orange,
//                       ),

//                       SizedBox(height: 20),

//                       // Payment Info
//                       Container(
//                         width: double.infinity,
//                         padding: EdgeInsets.all(15),
//                         decoration: BoxDecoration(
//                           color: Colors.green[50],
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.green[200]!),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(Icons.payments, color: Colors.green),
//                             SizedBox(width: 10),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Payment',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.green[800],
//                                   ),
//                                 ),
//                                 Text(
//                                   'Cash on Delivery',
//                                   style: TextStyle(
//                                     color: Colors.green[600],
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Spacer(),
//                             Text(
//                               'OMR 5.00',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.green[700],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             SizedBox(height: 20),

//             // Customer Info Card
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Customer Information',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[800],
//                         ),
//                       ),
//                       SizedBox(height: 15),
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             backgroundColor: Color(0xFF55ABCB),
//                             child: Icon(Icons.person, color: Colors.white),
//                           ),
//                           SizedBox(width: 15),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Ahmed Al-Rashid',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 Text(
//                                   '+968 9111 7172',
//                                   style: TextStyle(
//                                     color: Colors.grey[600],
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               // Call customer
//                             },
//                             icon: Icon(Icons.call, color: Color(0xFF55ABCB)),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             SizedBox(height: 30),

//             // Action Buttons
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   // Accept Button
//                   AnimatedBuilder(
//                     animation: _scaleAnimation,
//                     builder: (context, child) {
//                       return Transform.scale(
//                         scale: _scaleAnimation.value,
//                         child: Container(
//                           width: double.infinity,
//                           height: 60,
//                           child: ElevatedButton(
//                             onPressed: _isAccepting ? null : _acceptOrder,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.green,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               elevation: 5,
//                             ),
//                             child: _isAccepting
//                                 ? Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       SizedBox(
//                                         width: 20,
//                                         height: 20,
//                                         child: CircularProgressIndicator(
//                                           color: Colors.white,
//                                           strokeWidth: 2,
//                                         ),
//                                       ),
//                                       SizedBox(width: 10),
//                                       Text(
//                                         'Accepting Order...',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 : Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(Icons.check_circle,
//                                           color: Colors.white),
//                                       SizedBox(width: 10),
//                                       Text(
//                                         'Accept Order',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),

//                   SizedBox(height: 15),

//                   // Reject Button
//                   Container(
//                     width: double.infinity,
//                     height: 60,
//                     child: OutlinedButton(
//                       onPressed: _isAccepting ? null : _rejectOrder,
//                       style: OutlinedButton.styleFrom(
//                         side: BorderSide(color: Colors.red, width: 2),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.cancel, color: Colors.red),
//                           SizedBox(width: 10),
//                           Text(
//                             'Reject Order',
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color iconColor,
//   }) {
//     return Row(
//       children: [
//         Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: iconColor.withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: iconColor, size: 24),
//         ),
//         SizedBox(width: 15),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                   color: Colors.grey[800],
//                 ),
//               ),
//               SizedBox(height: 2),
//               Text(
//                 subtitle,
//                 style: TextStyle(
//                   color: Colors.grey[600],
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
