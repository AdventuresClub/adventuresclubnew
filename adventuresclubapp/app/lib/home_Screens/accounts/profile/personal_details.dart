// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:app/constants.dart';
import 'package:app/models/get_country.dart';
import 'package:app/models/profile_models/profile_become_partner.dart';
import 'package:app/models/user_profile_model.dart';
import 'package:app/provider/navigation_index_provider.dart';
import 'package:app/widgets/buttons/button.dart';
import 'package:app/widgets/loading_widget.dart';
import 'package:app/widgets/my_text.dart';
import 'package:app/widgets/text_fields/text_fields.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../sign_up/sign_in.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  ProfileBecomePartner pbp = ProfileBecomePartner(0, 0, "", "", "", "", "", "",
      "", "", 0, 0, "", "", "", "", "", "", "", 0, "", "", "", "", "", "");
  bool loading = false;
  String name = "";
  String email = "";
  String phone = "";
  String gender = "";
  //String nationalityId = "";
  String phoneNumber = "";
  String selectedCountry = "Nationality";
  String selectedNationality = "";
  List<String> genderText = ['Male', 'Female'];
  String selectedGender = "";
  List<GetCountryModel> filteredServices = [];
  List<GetCountryModel> countriesList1 = [];
  dynamic ccCode;
  DateTime? pickedDate;
  var getGender = 'Male';
  Map mapCountry = {};
  bool cont = false;
  var formattedDate;
  int nationalityId = 0;
  @override
  void initState() {
    super.initState();
    login();
    //  getCountries();
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
      'device_id': Constants.token, //deviceId, //"0",,
      'device_type': Constants.deviceType,
    });
    setState(() {
      loading = true;
    });
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
          nationality: userData['nationality'] ?? "",
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
      nameController.text = Constants.profile.name;
      phoneController.text = Constants.profile.mobile;
      emailController.text = Constants.profile.email;
      Constants.userRole = up.userRole;
      prefs.setString("userRole", up.userRole);
      prefs.setInt("userId", up.id);
      prefs.setInt("countryId", up.countryId);
      prefs.setString("name", up.name);
      ccCode = Constants.profile.mobileCode;
      name = Constants.profile.name;
      phone = Constants.profile.mobileCode;
      email = Constants.profile.email;
      formattedDate = Constants.dob;
      selectedGender = Constants.profile.gender;
      selectedCountry = Constants.nationality;
      //getNationality
      if (Constants.profile.nationality != null) {
        Constants.nationality = Constants.profile.nationality!;
      } else {
        //    getNationality(Constants.nationalityId);
      }

      // prefs.setString("email", Constants.emailId);
      // prefs.setString("password", Constants.password);
      //Constants.profile = profile;
      Constants.userRole = up.userRole;
      //Constants.userRole = "3";
    }
    setState(() {
      loading = false;
    });
  }

  void getData() {
    nameController.text = Constants.profile.name;
    phoneController.text = Constants.profile.mobile;
    emailController.text = Constants.profile.email;
    setState(() {});
  }

  //   ${Constants.baseUrl}/api/v1/update_profile
// user_id:2
// name:fgfd
// mobile_code:+91
// email:mmm@yopmail.com

  void editProfile() async {
    if (nameController.text.isNotEmpty) {
      if (phoneController.text.isNotEmpty) {
        if (emailController.text.isNotEmpty) {
          try {
            var response = await http.post(
                Uri.parse("${Constants.baseUrl}/api/v1/update_profile"),
                body: {
                  'user_id': Constants.userId.toString(), //ccCode.toString(),
                  'name': nameController.text.trim(),
                  'mobile_code': ccCode, //Constants.profile.mobileCode,
                  "mobile": phoneController.text.trim(),
                  'email': emailController.text.trim(),
                  "dob": formattedDate.toString(),
                  "nationality": nationalityId.toString(),
                  "gender": selectedGender,
                });
            if (response.statusCode == 200) {
              SharedPreferences prefs = await Constants.getPrefs();
              prefs.setString("name", nameController.text.trim());
              prefs.setString("email", emailController.text.trim());
              Constants.emailId = nameController.text.trim();
              Constants.name = nameController.text.trim();
              Constants.getProfile();
              message("Information Updated");
            } else {
              dynamic body = jsonDecode(response.body);
              // error = decodedError['data']['name'];
              message(body['message'].toString());
            }
          } catch (e) {
            print(e.toString());
          }
        } else {
          message("Please Enter Your Email Address");
        }
      } else {
        message("Please Enter Your Phone");
      }
    } else {
      message("Please Enter Name");
    }
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void verifyOtp() async {
    Navigator.of(context).pop();
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/verify/otp"), body: {
        'user_id': Constants.userId.toString(),
        'mobile_code': ccCode.toString(),
        'mobile': phoneController.text.trim(),
        //"3353414905", //"3214181273", //phoneController.text.trim(),
        'otp': otpController.text.trim(), //"9567", //otpController.text.trim(),
      });
      if (response.statusCode == 200) {
        SharedPreferences prefs = await Constants.getPrefs();
        prefs.setString("phone", phoneController.text.trim());
        Constants.phone = phoneController.text.trim();
        message("Number Verified");
      }
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
    otpController.clear();
  }

  void confirmOtp() async {
    enterOTP();
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/get_otp"), body: {
        'mobile_code': ccCode.toString(), //ccCode.toString(),
        'mobile': phoneController.text,
        'forgot_password': "0",
      });
      if (response.statusCode == 200) {}
    } catch (e) {
      print(e.toString());
    }
  }

  // void getOtp() async {
  //   int phone = int.parse(phoneController.text);
  //   enterOTP();
  //   var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //           "${Constants.baseUrl}Dev/api/v1/update/number"));
  //   request.fields.addAll({
  //     'user_id': Constants.userId,
  //     'mobile_code': ccCode.toString(),
  //     'mobile': phone,
  //   });
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

  void getOtp() async {
    int phone = int.parse(phoneController.text);
    print(phone);
    print(ccCode.toString());
    print(Constants.userId);
    enterOTP();
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/update/number"), body: {
        'user_id': Constants.userId.toString(),
        'mobile_code': ccCode.toString(),
        'mobile': phoneController.text.trim(),
        //"3353414905", //"3214181273", //phoneController.text.trim(),
      });
      if (response.statusCode == 200) {
        message("Number Updated Successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void showConfirmation(String title, String message) async {
    showDialog(
        context: context,
        builder: (ctx) => SimpleDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: MyText(
                text: title.tr(),
                size: 18,
                weight: FontWeight.bold,
                color: blackColor,
              ),
              children: [
                const SizedBox(
                  height: 10,
                ),
                //Text("data"),
                Text(
                  message.tr(),
                  textAlign: TextAlign.center,
                ),
                // text:
                //     "After approval you'll be notified and have to buy your subscription package",
                // size: 18,
                // weight: FontWeight.w500,
                // color: blackColor.withOpacity(0.6),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: MyText(
                        text: "no".tr(),
                        color: blackColor,
                        weight: FontWeight.bold,
                      ),
                    ),
                    MaterialButton(
                      onPressed: logout,
                      child: MyText(
                        text: "yes".tr(),
                        color: blackColor,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                //BottomButton(bgColor: blueButtonColor, onTap: homePage)
              ],
            ));
  }

  void changeIndex() {
    Provider.of<NavigationIndexProvider>(context, listen: false).homeIndex = 0;
  }

  void logout() {
    Constants.clear();
    changeIndex();
    print(Constants.userId);
    while (context.canPop()) {
      context.pop();
    }
    context.pushReplacement('/signIn');

    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(
    //     builder: (_) {
    //       return const SignIn();
    //     },
    //   ),
    //   (route) => false,
    // );
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
                          verifyOtp, //goToHome,
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
      },
    );
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
        );
        countriesList1.add(gc);
      });
      if (mounted) {
        setState(() {
          filteredServices = countriesList1;
        });
      }
    }
  }

  void getC(String country, dynamic code, int id, String countryflag) {
    Navigator.of(context).pop();
    setState(
      () {
        // countryCode = country;
        ccCode = code;
        // countryId = id;
        // flag = countryflag;
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    final DateTime tenYearsAgo =
        currentDate.subtract(const Duration(days: 365 * 10));
    pickedDate = await showDatePicker(
        context: context,
        initialDate: tenYearsAgo,
        firstDate: DateTime(DateTime.now().day - 1),
        lastDate: tenYearsAgo);
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        var date = DateTime.parse(pickedDate.toString());
        String m = date.month < 10 ? "0${date.month}" : "${date.month}";
        String d = date.day < 10 ? "0${date.day}" : "${date.day}";
        formattedDate = "${date.year}-$m-$d";
        currentDate = pickedDate!;
      });
    }
  }

  String getNationality(String id) {
    int i = int.tryParse(id) ?? 0;
    String nationality = "";
    for (var element in countriesList1) {
      if (element.id == i) {
        Constants.nationality = element.country;
      }
    }
    return nationality;
  }

  void addCountry(String country, int id, String nationality) {
    Navigator.of(context).pop();
    setState(() {
      selectedCountry = nationality;
      nationalityId = id;
      selectedNationality = nationality;
      Constants.nationality = nationality;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingWidget()
        : SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                  child: Column(
                    children: [
                      TextFields(
                        name,
                        nameController,
                        15,
                        greyProfileColor,
                        true,
                        editBorder: true,
                      ),
                      // Divider(
                      //   indent: 4,
                      //   endIndent: 4,
                      //   color: greyColor.withOpacity(0.5),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      phoneNumberField(context),
                      // TextField(
                      //   inputFormatters: [NoSpaceFormatter()],
                      //   keyboardType: TextInputType.name,
                      //   controller: phoneController,
                      //   style: const TextStyle(
                      //     decoration: TextDecoration.none,
                      //   ),
                      //   onChanged: (val) {
                      //     final trimVal = val.trim();
                      //     if (val != trimVal) {
                      //       setState(() {
                      //         phoneController.text = trimVal;
                      //         phoneController.selection = TextSelection.fromPosition(
                      //             TextPosition(offset: trimVal.length));
                      //       });
                      //     }
                      //   },
                      //   decoration: InputDecoration(
                      //     suffixText: "Send OTP",
                      //     suffixStyle: const TextStyle(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.bold,
                      //         color: blackColor),
                      //     contentPadding: const EdgeInsets.symmetric(
                      //         vertical: 15, horizontal: 15),
                      //     hintText: phone,
                      //     hintStyle: TextStyle(
                      //         color: blackColor.withOpacity(
                      //           0.6,
                      //         ),
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 14,
                      //         fontFamily: 'Raleway'),
                      //     hintMaxLines: 1,
                      //     isDense: true,
                      //     filled: true,
                      //     fillColor: greyProfileColor,
                      //     border: OutlineInputBorder(
                      //       borderRadius:
                      //           const BorderRadius.all(Radius.circular(10.0)),
                      //       borderSide:
                      //           BorderSide(color: blackColor.withOpacity(0.0)),
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderRadius:
                      //           const BorderRadius.all(Radius.circular(10.0)),
                      //       borderSide:
                      //           BorderSide(color: blackColor.withOpacity(0.0)),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: const BorderRadius.all(Radius.circular(10)),
                      //       borderSide: BorderSide(
                      //         color: blackColor.withOpacity(0.0),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Divider(
                      //   indent: 4,
                      //   endIndent: 4,
                      //   color: greyColor.withOpacity(0.5),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFields(
                        email,
                        emailController,
                        15,
                        greyProfileColor,
                        true,
                        editBorder: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          width: MediaQuery.of(context).size.width / 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kPrimaryColor,
                            border: Border.all(
                              color: blackColor.withOpacity(0.2),
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            leading: Text(
                              formattedDate.toString(),
                              style: TextStyle(
                                  color: blackColor.withOpacity(0.6),
                                  fontSize: 14),
                            ),
                            trailing: Icon(
                              Icons.calendar_today,
                              color: blackColor.withOpacity(0.6),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      // Divider(
                      //   indent: 4,
                      //   endIndent: 4,
                      //   color: greyColor.withOpacity(0.5),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          // if (Constants.nationality != "null")
                          //   Expanded(
                          //       child: Container(
                          //           height: 57,
                          //           decoration: BoxDecoration(
                          //               //color: whiteColor,
                          //               border: Border.all(
                          //                   color: blackColor.withOpacity(0.2)),
                          //               borderRadius:
                          //                   BorderRadius.circular(12)),
                          //           child: Center(
                          //               child: Text(Constants.nationality)))),
                          // const SizedBox(
                          //   width: 5,
                          // ),
                          Expanded(
                              child:
                                  pickCountry(context, selectedCountry, false)),
                        ],
                      ),
                      // Divider(
                      //   indent: 4,
                      //   endIndent: 4,
                      //   color: greyColor.withOpacity(0.5),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          //pickGender(context, 'Gender'),
                          // if (Constants.gender != "null")
                          //   Expanded(
                          //       child: Container(
                          //           height: 57,
                          //           decoration: BoxDecoration(
                          //               //color: whiteColor,
                          //               border: Border.all(
                          //                   color: blackColor.withOpacity(0.2)),
                          //               borderRadius:
                          //                   BorderRadius.circular(12)),
                          //           child:
                          //               Center(child: Text(Constants.gender)))),
                          // const SizedBox(
                          //   width: 5,
                          // ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  //color: whiteColor,
                                  border: Border.all(
                                      color: blackColor.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(12)),
                              child: ExpansionTile(
                                title: Text(selectedGender.isNotEmpty
                                    ? selectedGender
                                    : 'gender'.tr()),
                                children: [
                                  for (int i = 0; i < genderText.length; i++)
                                    CheckboxListTile(
                                      dense: true,
                                      visualDensity: VisualDensity.compact,
                                      value: selectedGender == genderText[i],
                                      checkboxShape:
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12))),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGender = genderText[i];

                                          if (value == true) {
                                          } else {}
                                        });
                                      },
                                      title: Text(
                                        genderText[i].tr(),
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  //   },
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // ListTile(
                      //   leading: const Icon(
                      //     Icons.delete_forever,
                      //     color: redColor,
                      //   ),
                      //   title: MyText(
                      //     text: "Delete Account",
                      //     color: blackColor,
                      //     size: 14,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 30,
                      ),
                      Button(
                          'save'.tr(),
                          greenishColor,
                          greenishColor,
                          whiteColor,
                          18,
                          editProfile,
                          Icons.add,
                          whiteColor,
                          false,
                          1.3,
                          'Raleway',
                          FontWeight.w600,
                          16),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 16,
                        width: MediaQuery.of(context).size.width / 1.3,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: redColor,
                            width: 2.0,
                          ),
                          color: redColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(28)),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => showConfirmation(
                                "deleteAccount", "wantToDelete"),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "deleteAccount".tr(),
                                      style: const TextStyle(
                                          color: whiteColor,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.8,
                                          fontSize: 16),
                                    ),
                                    // SizedBox(width: 3),
                                    // Icon(
                                    //   Icons.delete,
                                    //   color: whiteColor,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Button(
                      //     'Delete Account',
                      //     redColor,
                      //     redColor,
                      //     whiteColor,
                      //     18,
                      //     showConfirmation,
                      //     Icons.add,
                      //     whiteColor,
                      //     false,
                      //     1.3,
                      //     'Raleway',
                      //     FontWeight.w600,
                      //     16),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget phoneNumberField(context) {
    return Container(
      decoration: BoxDecoration(
          color: greyProfileColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: blackColor.withOpacity(0.2))),
      child: ListTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        tileColor: greyProfileColor,
        selectedTileColor: greyProfileColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        leading: Container(
          height: 37,
          width: 80,
          decoration: const BoxDecoration(
            color: greyProfileColor,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 24.0, horizontal: 10),
                              child: Column(
                                children: [
                                  const Row(children: [
                                    Text(
                                      "Select your active phone country code",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: 'Raleway-Black'),
                                    )
                                  ]),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: blackColor.withOpacity(0.5),
                                      ),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        child: TextField(
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              filteredServices = countriesList1
                                                  .where((element) => element
                                                      .country
                                                      .toLowerCase()
                                                      .contains(value))
                                                  .toList();
                                              //log(filteredServices.length.toString());
                                            } else {
                                              filteredServices = countriesList1;
                                            }
                                            setState(() {});
                                          },
                                          controller: searchController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 8),
                                            hintText: 'Country',
                                            filled: true,
                                            fillColor: lightGreyColor,
                                            suffixIcon: GestureDetector(
                                              //onTap: openMap,
                                              child: const Icon(Icons.search),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  color: greyColor
                                                      .withOpacity(0.2)),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  color: greyColor
                                                      .withOpacity(0.2)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  color: greyColor
                                                      .withOpacity(0.2)),
                                            ),
                                          ),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: filteredServices.length,
                                      itemBuilder: ((context, index) {
                                        return ListTile(
                                          leading: searchController.text.isEmpty
                                              ? Image.network(
                                                  "${"${Constants.baseUrl}/public/"}${countriesList1[index].flag}",
                                                  height: 25,
                                                  width: 40,
                                                )
                                              : null,
                                          title: Text(
                                            filteredServices[index].country,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: blackColor,
                                                fontFamily: 'Raleway'),
                                          ),
                                          trailing: Text(
                                            filteredServices[index].code,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: blackColor,
                                                fontFamily: 'Raleway'),
                                          ),
                                          onTap: () {
                                            getC(
                                                filteredServices[index].country,
                                                filteredServices[index].code,
                                                filteredServices[index].id,
                                                filteredServices[index].flag);
                                          },
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                        },
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: const BoxDecoration(
                        color: greyProfileColor,
                      ),
                      child: ccCode != null
                          ? Text(ccCode,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14))
                          : const Text(
                              "code",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                    ),
                  ),
                  Container(
                    color: blackColor.withOpacity(0.6),
                    height: 37,
                    width: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
        title: TextFormField(
          controller: phoneController,
          cursorColor: kSecondaryColor,
          keyboardType: TextInputType.phone,
          onChanged: (phone) {
            setState(() {
              phone.length > 9 ? cont = true : cont = false;
              phoneNumber = phone;
            });
          },
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            //color: const Color(0xffABAEB9).withOpacity(0.40),
          ),
          decoration: InputDecoration(
            alignLabelWithHint: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 15,
            ),
            filled: true,
            fillColor: greyProfileColor,
            hintText: 'Phone Number',
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: blackColor.withOpacity(0.6),
            ),
            // suffixIcon: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Image.asset(
            //       mobileIcon,
            //       height: 24,
            //     ),
            //   ],
            // ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
        trailing: GestureDetector(
          onTap: getOtp,
          child: SizedBox(
            height: 20,
            child: MyText(
              text: 'sendOtp'.tr(),
              weight: FontWeight.bold,
              color: bluishColor,
              size: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget pickCountry(context, String countryName, bool show) {
    return Container(
      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: blackColor.withOpacity(0.2))),
      child: ListTile(
        onTap: () => showModalBottomSheet(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(children: [
                        Text(
                          "Select Your Nationality",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Raleway-Black'),
                        )
                      ]),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: kPrimaryColor,
                          ),
                        ),
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            child: TextField(
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  filteredServices = countriesList1
                                      .where((element) => element.shortName
                                          .toLowerCase()
                                          .contains(value))
                                      .toList();
                                  //log(filteredServices.length.toString());
                                } else {
                                  filteredServices = countriesList1;
                                }
                                setState(() {});
                              },
                              controller: searchController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                hintText: 'Country',
                                filled: true,
                                fillColor: kPrimaryColor,
                                suffixIcon: GestureDetector(
                                  //onTap: openMap,
                                  child: const Icon(Icons.search),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: kPrimaryColor),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: kPrimaryColor),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: kPrimaryColor),
                                ),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredServices.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              leading: searchController.text.isEmpty
                                  ? Image.network(
                                      "${"${Constants.baseUrl}/public/"}${filteredServices[index].flag}",
                                      height: 25,
                                      width: 40,
                                    )
                                  : null,
                              title: Text(filteredServices[index].shortName),
                              onTap: () {
                                addCountry(
                                    filteredServices[index].country,
                                    filteredServices[index].id,
                                    filteredServices[index].shortName);
                              },
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              });
            }),
        tileColor: kPrimaryColor,
        selectedTileColor: kPrimaryColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: MyText(
          text: selectedCountry,
          color: blackColor.withOpacity(0.6),
          size: 14,
          weight: FontWeight.w500,
        ),
        trailing: const Image(
          image: ExactAssetImage('images/ic_drop_down.png'),
          height: 16,
          width: 16,
        ),
      ),
    );
  }

  Widget pickGender(context, String genderName) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: blackColor.withOpacity(0.2))),
      child: ListTile(
          onTap: () => showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                    child: Container(
                      height: 300,
                      color: whiteColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                  text: 'Gender',
                                  weight: FontWeight.bold,
                                  color: blackColor,
                                  size: 20,
                                  fontFamily: 'Raleway'),
                            ),
                          ),
                          Container(
                            height: 200,
                            color: whiteColor,
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      child: CupertinoPicker(
                                        itemExtent: 82.0,
                                        diameterRatio: 22,
                                        backgroundColor: whiteColor,
                                        onSelectedItemChanged: (int index) {
                                          print(index + 1);
                                          getGender = genderText[index];
                                          getGender == null
                                              ? cont = false
                                              : cont = true;
                                          setState(() {
                                            // ft = (index + 1);
                                            // heightController.text =
                                            //     "$ft' $inches\"";
                                          });
                                        },
                                        selectionOverlay:
                                            const CupertinoPickerDefaultSelectionOverlay(
                                          background: transparentColor,
                                        ),
                                        children: List.generate(3, (index) {
                                          return Center(
                                            child: MyText(
                                                text: genderText[index],
                                                size: 14,
                                                color: blackTypeColor4),
                                          );
                                        }),
                                      ),
                                    ),
                                    Positioned(
                                      top: 70,
                                      child: Container(
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: blackColor
                                                        .withOpacity(0.7),
                                                    width: 1.5),
                                                bottom: BorderSide(
                                                    color: blackColor
                                                        .withOpacity(0.7),
                                                    width: 1.5))),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: MyText(
                                    text: 'Cancel',
                                    color: bluishColor,
                                  )),
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: MyText(
                                    text: 'Ok',
                                    color: bluishColor,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ));
              }),
          tileColor: kPrimaryColor,
          selectedTileColor: kPrimaryColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          title: MyText(
            text: getGender.toString(),
            color: blackColor.withOpacity(0.6),
            size: 14,
            weight: FontWeight.w500,
          ),
          trailing: const Image(
            image: ExactAssetImage('images/ic_drop_down.png'),
            height: 16,
            width: 16,
          )),
    );
  }
}
