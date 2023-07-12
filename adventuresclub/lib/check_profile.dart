// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, use_build_context_synchronously

import 'dart:convert';

import 'package:adventuresclub/choose_language.dart';
import 'package:adventuresclub/models/get_country.dart';
import 'package:adventuresclub/models/profile_models/profile_become_partner.dart';
import 'package:adventuresclub/models/user_profile_model.dart';
import 'package:adventuresclub/sign_up/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:http/http.dart' as http;

class CheckProfile extends StatefulWidget {
  const CheckProfile({Key? key}) : super(key: key);

  @override
  CheckProfileState createState() => CheckProfileState();
}

class CheckProfileState extends State<CheckProfile> {
  bool userExist = false;
  Map mapCountry = {};
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
    login();
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
          return const SignIn();
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
    setState(() {
      Constants.userId = id;
      Constants.name = name;
      Constants.countryId = countryId;
      Constants.emailId = email;
      Constants.password = pass;
      Constants.userRole = userRole;
    });
  }

  void cId(int id) async {
    SharedPreferences prefs = await Constants.getPrefs();
    countriesList1.forEach((element) {
      if (id == element.id) {
        setState(() {
          Constants.countryFlag = element.flag;
          Constants.country = element.country;
        });
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
    var response = await http.post(
        Uri.parse("https://adventuresclub.net/adventureClub/api/v1/login"),
        body: {
          'email': e,
          'password': pass,
          'device_id': "0",
        });
    if (response.statusCode == 200) {
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
      dynamic body = jsonDecode(response.body);
      // error = decodedError['data']['name'];
      Constants.showMessage(context, body['message'].toString());
      home();
    }
    print(response.statusCode);
    print(response.body);
    print(response.headers);
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
          element['short_name'],
          element['flag'],
          element['code'],
          element['id'],
        );
        countriesList1.add(gc);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
