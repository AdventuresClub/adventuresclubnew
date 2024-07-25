// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:adventuresclub/choose_language.dart';
import 'package:adventuresclub/models/get_country.dart';
import 'package:adventuresclub/models/profile_models/profile_become_partner.dart';
import 'package:adventuresclub/models/user_profile_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class CheckProfile extends StatefulWidget {
  const CheckProfile({super.key});

  @override
  CheckProfileState createState() => CheckProfileState();
}

class CheckProfileState extends State<CheckProfile> {
  bool userExist = false;
  Map mapCountry = {};
  String deviceType = "";
  String deviceId = "";
  String token = "";
  Map<String, dynamic> deviceData = <String, dynamic>{};
  List<GetCountryModel> countriesList1 = [];
  ProfileBecomePartner pbp = ProfileBecomePartner(0, 0, "", "", "", "", "", "",
      "", "", 0, 0, "", "", "", "", "", "", "", 0, "", "", "", "", "", "");
  UserProfileModel profile = UserProfileModel(
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      "",
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      "",
      "",
      "",
      "",
      ProfileBecomePartner(0, 0, "", "", "", "", "", "", "", "", 0, 0, "", "",
          "", "", "", "", "", 0, "", "", "", "", "", ""));

  @override
  void initState() {
    super.initState();
    //  getDeviceID();
    registerFCM();
  }

  Future<void> registerFCM() async {
    await FirebaseMessaging.instance.requestPermission();
    final fcmToken = await FirebaseMessaging.instance.getToken(
        vapidKey:
            "BEr0HbHx_pAg1PMPbqHuA2g0hQrHtbvsM5cNfxMThTHvnvcH01-Z8MnBo-qyDR0LvRPi2fvb_3WVWf4T2rlLOhg");
    if (fcmToken != null) {
      setFCMToken(fcmToken);
      token = fcmToken;
    }
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
      } else if (Platform.isIOS) {
        //deviceData = readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        //deviceId = deviceData['id'];
        deviceType = "2";
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    debugPrint("done");
    login();
  }

  Map<String, dynamic> readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'id': build.id,
      'model': build.model,
      'product': build.product,
      'serialNumber': build.serialNumber,
    };
  }

  Map<String, dynamic> readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'model': data.model,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  void goToNavigation() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) {
          return const BottomNavigation();
        },
      ),
      (route) => false,
    );
  }

  void home() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) {
          return const BottomNavigation();
        },
      ),
      (route) => false,
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

  void parseData(String name, int countryId, int id, String email, String pass,
      String userRole) {
    if (mounted) {
      setState(() {
        Constants.userId = id;
        Constants.name = name;
        Constants.countryId = countryId;
        Constants.emailId = email;
        Constants.password = pass;
        Constants.userRole = userRole;
      });
    }
  }

  void cId(int id) async {
    SharedPreferences prefs = await Constants.getPrefs();
    countriesList1.forEach((element) {
      if (id == element.id) {
        if (mounted) {
          setState(() {
            Constants.countryFlag = element.flag;
            Constants.country = element.country;
          });
        }
      }
    });
    prefs.setString("country", Constants.country);
    prefs.setString("countryFlag", Constants.countryFlag);
  }

  void checkProfile() async {
    // SharedPreferences prefs = await Constants.getPrefs();
    // int userId = prefs.getInt("userId") ?? 0;
    // int countryId = prefs.getInt("countryId") ?? 0;
    // String name = prefs.getString("name") ?? "";
    // String email = prefs.getString("email") ?? "";
    // String password = prefs.getString("password") ?? "";
    // String country = prefs.getString("country") ?? "";
    // String countryFlag = prefs.getString("countryFlag") ?? "";
    // String userRole = prefs.getString("userRole") ?? "";
    // if (userId != 0) {
    //   // parseData(name, countryId, userId, email, password, country, countryFlag,
    //   //     userRole);
    //   Constants.getProfile();
    //   //prefs.setString("name", )
    //   goToNavigation();
    // } else {
    //   start();
    // }
  }

  void login() async {
    getCountries();
    SharedPreferences prefs = await Constants.getPrefs();
    String pass = prefs.getString("password") ?? "";
    String e = prefs.getString("email") ?? "";
    var response =
        await http.post(Uri.parse("${Constants.baseUrl}/api/v1/login"), body: {
      'email': e,
      'password': pass,
      'device_id': token, //deviceId, //"0",,
      'device_type': deviceType
    });
//     email:badaralsahi
// password:87654321
// device_id:hamza
// device_type:2
    if (response.statusCode == 200) {
      // getDeviceID();
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      dynamic userData = decodedResponse['data'];
      int userLoginId = int.tryParse(userData['id'].toString()) ?? 0;
      int countryId = int.tryParse(userData['country_id'].toString()) ?? 0;
      int languageId = int.tryParse(userData['language_id'].toString()) ?? 0;
      int currencyId = int.tryParse(userData['currency_id'].toString()) ?? 0;
      int addedFrom = int.tryParse(userData['added_from'].toString()) ?? 0;
      dynamic partnerInfo = decodedResponse['data']["become_partner"];
      if (partnerInfo != null) {
        int id = int.tryParse(partnerInfo['id'].toString()) ?? 0;
        int userId = int.tryParse(partnerInfo['user_id'].toString()) ?? 0;
        int debitCard = int.tryParse(partnerInfo['debit_card'].toString()) ?? 0;
        int visaCard = int.tryParse(partnerInfo['visa_card'].toString()) ?? 0;
        int packagesId =
            int.tryParse(partnerInfo['packages_id'].toString()) ?? 0;
        ProfileBecomePartner bp = ProfileBecomePartner(
          id,
          userId,
          partnerInfo['company_name'] ?? "",
          partnerInfo['address'] ?? "",
          partnerInfo['location'] ?? "",
          partnerInfo['description'] ?? "",
          partnerInfo['license'] ?? "",
          partnerInfo['cr_name'] ?? "",
          partnerInfo['cr_number'] ?? "",
          partnerInfo['cr_copy'] ?? "",
          debitCard,
          visaCard,
          partnerInfo['payon_arrival'] ?? "",
          partnerInfo['paypal'] ?? "",
          partnerInfo['bankname'] ?? "",
          partnerInfo['account_holdername'] ?? "",
          partnerInfo['account_number'] ?? "",
          partnerInfo['is_online'] ?? "",
          partnerInfo['is_approved'] ?? "",
          packagesId,
          partnerInfo['start_date'] ?? "",
          partnerInfo['end_date'] ?? "",
          partnerInfo['is_wiretransfer'] ?? "",
          partnerInfo['is_free_used'] ?? "",
          partnerInfo['created_at'] ?? "",
          partnerInfo['updated_at'] ?? "",
        );
        pbp = bp;
      }
      UserProfileModel up = UserProfileModel(
          userLoginId,
          userData['users_role'] ?? "",
          userData['profile_image'] ?? "",
          userData['name'] ?? "",
          userData['height'] ?? "",
          userData['weight'] ?? "",
          userData['email'] ?? "",
          countryId,
          userData['region_id'] ?? "",
          userData['city_id'] ?? "",
          userData['now_in'] ?? "",
          userData['mobile'] ?? "",
          userData['mobile_verified_at'] ?? "",
          userData['dob'] ?? "",
          userData['gender'] ?? "",
          languageId,
          userData['nationality_id'] ?? "",
          currencyId,
          userData['app_notification'] ?? "",
          userData['points'] ?? "",
          userData['health_conditions'] ?? "",
          userData['health_conditions_id'] ?? "",
          userData['email_verified_at'] ?? "",
          userData['mobile_code'] ?? "",
          userData['status'] ?? "",
          addedFrom,
          userData['created_at'] ?? "",
          userData['updated_at'] ?? "",
          userData['deleted_at'] ?? "",
          userData['device_id'] ?? "",
          pbp);
      Constants.profile = up;
      Constants.userRole = up.userRole;
      prefs.setString("userRole", up.userRole);
      prefs.setInt("userId", up.id);
      prefs.setInt("countryId", up.countryId);
      prefs.setString("name", up.name);
      // prefs.setString("email", Constants.emailId);
      // prefs.setString("password", Constants.password);
      cId(up.countryId);
      parseData(up.name, up.countryId, up.id, up.email, pass, up.userRole);
      profile = up;
      Constants.profile = profile;
      Constants.userRole = up.userRole;
      //Constants.userRole = "3";
      goToNavigation();
    } else {
      if (response.statusCode != 422) {
        dynamic body = jsonDecode(response.body);
        // error = decodedError['data']['name'];
        Constants.showMessage(context, body['message'].toString());
        home();
      } else {
        home();
      }
    }
    print(response.statusCode);
    print(response.body);
    print(response.headers);
  }

  Future getCountries() async {
    var response =
        await http.get(Uri.parse("${Constants.baseUrl}/api/v1/get_countries"));
    if (response.statusCode == 200) {
      mapCountry = json.decode(response.body);
      List<dynamic> result = mapCountry['data'];
      result.forEach((element) {
        GetCountryModel gc = GetCountryModel(
          element['country'] ?? "",
          element['short_name'] ?? "",
          element['flag'] ?? "",
          element['code'] ?? "",
          element['id'] ?? "",
          element['currency'] ?? "",
        );
        countriesList1.add(gc);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: Colors.purple),
            const SizedBox(height: 20),
            Text(
              "loadingProfile".tr(),
              style: const TextStyle(color: Colors.purple),
            ),
          ],
        ),
      ),
    );
  }
}
