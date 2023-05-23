// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, avoid_function_literals_in_foreach_calls, unused_element

import 'dart:convert';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/settings/provicy_policy.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:adventuresclub/models/get_country.dart';
import 'package:adventuresclub/models/health_condition_model.dart';
import 'package:adventuresclub/models/weightnheight_model.dart';
import 'package:adventuresclub/sign_up/sign_in.dart';
import 'package:adventuresclub/sign_up/terms_condition.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/text_fields.dart';
import 'package:adventuresclub/widgets/text_fields/tf_with_suffix_icon.dart';
import 'package:country_picker/country_picker.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController inController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController nootpController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<bool> healthValue = [];
  List<WnHModel> weightList = [];
  List<WnHModel> heightList = [];
  String phoneNumber = "";
  String countryCode = "+1";
  bool cont = false;
  String vID = '';
  bool loading = false;
  String getCountry = '';
  String country = '';
  List<bool> value = [false, false, false, false, false, false];
  bool valuea = false;
  bool termsValue = false;
  var formattedDate;
  final countryPicker = const FlCountryCodePicker();
  TextEditingController heightController = TextEditingController();
  int ft = 0;
  int inches = 0;
  String cm = '';
  String getCode = '';
  DateTime? pickedDate;
  Map<String, String> countriesList = {"": ""};
  String selectedCountry = "Nationality";
  String currentLocation = "I am in";
  String contactCountry = "";
  dynamic ccCode;
  int countryId = 0;
  int nationalityId = 0;
  int currentLocationId = 0;
  var getWeight = 'Weight';
  var getheight = 'Height';
  var getGender = 'Male';
  int userID = 0;
  List<GetCountryModel> countriesList1 = [];
  Map mapCountry = {};
  Map userRegistration = {};
  String healthC = "";
  List<HealthConditionModel> healthList = [];
  String flag = "";
  String userRole = "";
  List<GetCountryModel> filteredServices = [];

  @override
  void initState() {
    super.initState();
    formattedDate = 'DOB';
    getCountries();
  }

  @override
  void dispose() {
    super.dispose();
    inController.dispose();
    nationalityController.dispose();
    locationController.dispose();
    emailController.dispose();
    passController.dispose();
    otpController.dispose();
    userNameController.dispose();
    dobController.dispose();
    nootpController.dispose();
    weightController.dispose();
    numController.dispose();
  }

  List genderText = ['Male', 'Female', 'Other'];

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

  void goToHome() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const BottomNavigation();
        },
      ),
    );
  }

  void goToSignIn() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const SignIn();
        },
      ),
    );
  }

  Future getCountries() async {
    getHealth();
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
      setState(() {
        filteredServices = countriesList1;
      });
    }
  }

  void searchServices(String x, BuildContext context) {
    if (x.isNotEmpty) {
      filteredServices = countriesList1
          .where((element) => element.country.toLowerCase().contains(x))
          .toList();
      //log(filteredServices.length.toString());
    } else {
      filteredServices = countriesList1;
    }
    setState(() {});
  }

  Future getWeightNHeight() async {
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/get_heights_weights"));
    if (response.statusCode == 200) {
      mapCountry = json.decode(response.body);
      dynamic result = mapCountry['data'];
      List<dynamic> height = result['heights'];
      height.forEach((h) {
        int id = int.tryParse(h['Id'].toString()) ?? 0;
        WnHModel heightModel = WnHModel(
          id,
          h['heightName'].toString() ?? "",
          h['image'].toString() ?? "",
          h['deleted_at'].toString() ?? "",
          h['created_at'].toString() ?? "",
          h['updated_at'].toString() ?? "",
        );
        heightList.add(heightModel);
      });
      List<dynamic> weight = result['weights'];
      weight.forEach((w) {
        int id = int.tryParse(w['Id'].toString()) ?? 0;
        WnHModel weightModel = WnHModel(
          id,
          w['weightName'].toString() ?? "",
          w['image'].toString() ?? "",
          w['deleted_at'].toString() ?? "",
          w['created_at'].toString() ?? "",
          w['updated_at'].toString() ?? "",
        );
        weightList.add(weightModel);
      });
    }
  }

  Future getHealth() async {
    getWeightNHeight();
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/get_healths"));
    if (response.statusCode == 200) {
      mapCountry = json.decode(response.body);
      List<dynamic> result = mapCountry['data'];
      result.forEach((element) {
        HealthConditionModel hc =
            HealthConditionModel(element['id'], element['name']);
        healthList.add(hc);
      });
    }
    getHealthValues();
  }

  void getHealthValues() {
    healthList.forEach((element) {
      healthValue.add(false);
    });
  }

  void health() {
    List<HealthConditionModel> f = [];
    for (int i = 0; i < healthValue.length; i++) {
      if (healthValue[i]) {
        f.add(healthList[i]);
      }
    }
    healthParse(f);
  }

  void healthParse(List<HealthConditionModel> am) async {
    List<int> a = [];
    am.forEach((element) {
      a.add(element.id);
    });
    // String resultString = id.join(",");
    setState(() {
      healthC = a.join(",");
    });
    print(healthC);
  }

  void getOtp() async {
    enterOTP();
    try {
      var response = await http.post(
          Uri.parse("https://adventuresclub.net/adventureClub/api/v1/get_otp"),
          body: {
            'mobile_code': ccCode.toString(), //ccCode.toString(),
            'mobile': numController.text,
            'forgot_password': "0",
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      setState(() {
        userID = decodedResponse['data']['user_id'];
      });
      print(response.statusCode);
      print(userID);
    } catch (e) {
      print(e.toString());
    }
  }

  void verifyOtp() async {
    Navigator.of(context).pop();
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/verify_otp"),
          body: {
            'user_id': userID.toString(),
            'otp': otpController.text,
            'forgot_password': "0"
          });
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
    otpController.clear();
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

  void showMessage(String message) {}

  void register() async {
    health();
    SharedPreferences prefs = await Constants.getPrefs();
    try {
      if (termsValue) {
        if (userNameController.text.isNotEmpty) {
          if (emailController.text.isNotEmpty) {
            if (passController.text.isNotEmpty) {
              if (nationalityId > 0) {
                if (currentLocationId > 0) {
                  if (numController.text.isNotEmpty) {
                    if (formattedDate != null) {
                      if (genderText.isNotEmpty) {
                        if (healthList.isNotEmpty) {
                          if (getheight.isNotEmpty && getWeight.isNotEmpty) {
                            var response = await http.post(
                                Uri.parse(
                                    "https://adventuresclub.net/adventureClub/api/v1/register"),
                                body: {
                                  "name": userNameController.text,
                                  "email": emailController
                                      .text, //"hamza@gmail.com", //emailController.text,
                                  "nationality": nationalityId
                                      .toString(), //nationalityController.text,
                                  "password": passController
                                      .text, //"Upendra@321", //passController.text,
                                  "now_in": currentLocationId
                                      .toString(), //currentLocationId.toString(), //currentLocation,
                                  "mobile": numController
                                      .text, //"3344374923", //"3214181273",
                                  // numController.text,
                                  "health_conditions": healthC,
                                  //"8,2,6", //healthC.toString(),
                                  "height": getheight,
                                  "weight": getWeight,
                                  "mobile_code": ccCode.toString(),
                                  "user_id": userID.toString(), //"27",
                                  "dob": formattedDate
                                      .toString(), //dobController.text, //"1993-10-30", //dobController.text,
                                  "country_id":
                                      currentLocationId.toString(), //"2",
                                  "device_id": "1",
                                  "nationality_id": countryId.toString(),
                                  //"gender": genderText, //"5",
                                });
                            // print(response.statusCode);
                            if (response.statusCode == 200) {
                              prefs.setString("name", userNameController.text);
                              prefs.setInt("countryId", countryId);
                              prefs.setInt("userId", userID);
                              prefs.setString("email", emailController.text);
                              prefs.setString("password", passController.text);
                              prefs.setString("country", countryCode);
                              prefs.setString("countryFlag", flag);
                              prefs.setString(
                                  "phoneNumber", numController.text);
                              prefs.setString("userRole", "3");
                              parseData(
                                  userNameController.text,
                                  countryId,
                                  userID,
                                  emailController.text,
                                  passController.text,
                                  countryCode,
                                  flag,
                                  numController.text);
                              goToHome();
                            } else {
                              dynamic body = jsonDecode(response.body);
                              message(body['message'].toString());
                            }
                          } else {
                            message("Please Select Height & Weight");
                          }
                        } else {
                          message("Please Select Your Health Condition");
                        }
                      } else {
                        message("Please Select Your Gender");
                      }
                    } else {
                      message("Please Enter DOB");
                    }
                  } else {
                    message("Please Enter your phone");
                  }
                } else {
                  message("Please Select Your Location");
                }
              } else {
                message("Please Select Nationality");
              }
            } else {
              message("Please Enter Password");
            }
          } else {
            message("Please Enter Email");
          }
        } else {
          message("Please Enter Username");
        }
//        print(response.body);
      } else {
        message("Please Agree with terms & Conditions");
      }
    } catch (e) {
      print(e);
    }
    //  if (response.statusCode == 200) {
    // userRegistration = json.decode(response.body);
    // List<dynamic> result = userRegistration['data'];
    // result.forEach((element) {
    //   userNameController.text = element['name'];
    //   emailController.text = element['email'];
    //   nationalityController.text = element['nationality'];
    //   passController.text = element['password'];
    //   currentLocation = element['now_in'];
    //   numController.text = element['mobile'];
    //   healthC = element['health_conditions'];
    //   heightController.text = element['height'];
    //   getWeight = element['weight'];
    //   ccCode = element['mobile_code'];
    // });
    //getGender = result['']
    // }
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void parseData(String name, int countryId, int id, String email, String pass,
      String countryCode, String countryFlag, String phoneNum) {
    setState(() {
      Constants.userId = id;
      Constants.name = name;
      Constants.countryId = countryId;
      Constants.emailId = email;
      Constants.password = pass;
      Constants.country = countryCode;
      Constants.countryFlag = countryFlag;
      Constants.phone = phoneNum;
    });
  }

  void addCountry(String country, bool show, int id) {
    Navigator.of(context).pop();
    if (show == true) {
      setState(() {
        selectedCountry = country;
        nationalityId = id;
      });
    } else {
      setState(() {
        currentLocation = country;
        currentLocationId = id;
      });
    }
  }

  void getC(String country, dynamic code, int id, String countryflag) {
    Navigator.of(context).pop();
    setState(
      () {
        countryCode = country;
        ccCode = code;
        countryId = id;
        flag = countryflag;
      },
    );
  }

  void terms() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const TermsConditions();
        },
      ),
    );
  }

  void goToPrivacy() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const PrivacyPolicy();
        },
      ),
    );
  }

  abc() {}
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
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        blackColor.withOpacity(0.6), BlendMode.darken),
                    image: const ExactAssetImage('images/registrationpic.png'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                        text: ' Registration',
                        weight: FontWeight.w600,
                        color: whiteColor,
                        size: 24,
                        fontFamily: 'Raleway'),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'images/whitelogo.png',
                    height: 140,
                    width: 320,
                  ),
                  const SizedBox(height: 20),
                  // GestureDetector(
                  //     onTap: getCountries,
                  //     child: const Text(
                  //       "Test",
                  //       style: TextStyle(color: whiteColor),
                  //     )),
                  TextFields(
                      'Username', userNameController, 17, whiteColor, true),
                  const SizedBox(height: 20),
                  TextFields('Email', emailController, 17, whiteColor, true),
                  const SizedBox(height: 20),
                  TFWithSiffixIcon(
                      'Password', Icons.visibility_off, passController, true),
                  const SizedBox(height: 20),
                  pickCountry(context, selectedCountry, true, false),
                  const SizedBox(height: 20),
                  // now i am in
                  pickCountry(context, currentLocation, false, true),
                  const SizedBox(
                    height: 20,
                  ),
                  phoneNumberField(context),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      width: MediaQuery.of(context).size.width / 1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: whiteColor),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        leading: Text(
                          formattedDate.toString(),
                          style: TextStyle(color: blackColor.withOpacity(0.6)),
                        ),
                        trailing: Icon(
                          Icons.calendar_today,
                          color: blackColor.withOpacity(0.6),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  pickGender(context, 'Gender'),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: MyText(
                              text: 'Health Condition',
                              weight: FontWeight.bold,
                              color: blackColor.withOpacity(0.5),
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 5),
                          child: GridView.count(
                            padding: const EdgeInsets.only(top: 0, bottom: 10),
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            mainAxisSpacing: 0,
                            childAspectRatio: 5.5,
                            crossAxisSpacing: 2,
                            crossAxisCount: 2,
                            children: List.generate(
                              healthList.length, // widget.profileURL.length,
                              (index) {
                                return Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: SizedBox(
                                        width: 15,
                                        child: Transform.scale(
                                          scale: 1.2,
                                          child: Checkbox(
                                              activeColor: whiteColor,
                                              checkColor: bluishColor,
                                              hoverColor: bluishColor,
                                              focusColor: bluishColor,
                                              value: healthValue[index],
                                              onChanged: (bool? value1) {
                                                setState(() {
                                                  healthValue[index] = value1!;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: MyText(
                                          text:
                                              healthList[index].healthCondition,
                                          color: blackColor.withOpacity(0.6),
                                          weight: FontWeight.w700,
                                          size: 13,
                                          fontFamily: 'Raleway'),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: pickingWeight(context, 'Weight in Kg'),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.4,
                          child: pickingHeight(context, 'Height in CM')),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          activeColor: bluishColor,
                          side: const BorderSide(color: greyColor3, width: 2),
                          value: termsValue,
                          onChanged: ((bool? value) {
                            return setState(() {
                              termsValue = value!;
                            });
                          })),
                      // Row(
                      //   children: [
                      //     MyText(
                      //       text: 'I have read ',
                      //       size: 12,
                      //     ),
                      //     GestureDetector(
                      //       onTap: terms,
                      //       child: MyText(
                      //         text: 'Terms & Conditions',
                      //         size: 14,
                      //       ),
                      //     ),
                      //     MyText(
                      //       text: ' & ',
                      //       size: 14,
                      //     ),
                      //     GestureDetector(
                      //       onTap: goToPrivacy,
                      //       child: MyText(
                      //         text: ' Privacy policy',
                      //         size: 14,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                  text: 'I have read ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: whiteColor,
                                      fontFamily: 'Raleway')),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    terms();
                                  },
                                text: 'Terms & Conditions',
                                style: const TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w500,
                                    color: whiteColor,
                                    fontFamily: 'Raleway'),
                              ),
                              const TextSpan(
                                text: ' & ',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: whiteColor,
                                    fontFamily: 'Raleway'),
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    goToPrivacy();
                                  },
                                // onEnter: (event) => goToPrivacy,
                                text: 'Privacy policy',
                                style: const TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w500,
                                    color: whiteColor,
                                    fontFamily: 'Raleway'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Button(
                      'Register',
                      greenishColor,
                      greenishColor,
                      whiteColor,
                      18,
                      register,
                      Icons.add,
                      whiteColor,
                      false,
                      1.3,
                      'Raleway',
                      FontWeight.w600,
                      16),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: goToSignIn,
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Already have an account ?',
                                style: TextStyle(
                                    color: whiteColor, fontFamily: 'Raleway')),
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor,
                                  fontFamily: 'Raleway'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget phoneNumberField(context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        tileColor: whiteColor,
        selectedTileColor: whiteColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        leading: Container(
          height: 42,
          width: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: whiteColor,
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
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Row(children: const [
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
                                                      .shortName
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
                                                  "${"https://adventuresclub.net/adventureClub/public/"}${countriesList1[index].flag}",
                                                  height: 25,
                                                  width: 40,
                                                )
                                              : null,
                                          title: Text(
                                            filteredServices[index].shortName,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 4.0),
                      margin: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: ccCode != null
                          ? Text(ccCode,
                              style: const TextStyle(color: Colors.black))
                          : const Text(
                              "+1",
                              style: TextStyle(color: Colors.black),
                            ),
                    ),
                  ),
                  // CountryCodePicker(
                  //       showFlagMain: false,
                  //       showFlagDialog: true,
                  //       hideSearch: false,
                  //       padding: EdgeInsets.zero,
                  //       dialogSize:  Size(
                  //         MediaQuery.of(context).size.width/1.2,MediaQuery.of(context).size.height/1.1
                  //       ),
                  //       barrierColor: blackColor.withOpacity(0.1),
                  //       onChanged: (cc) {
                  //         setState(() {
                  //           countryCode = cc.dialCode!;
                  //         });
                  //       },
                  //       showFlag: false,
                  //       searchStyle: const TextStyle(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w500,
                  //         color: greyColor,
                  //       ),
                  //       textStyle: const TextStyle(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w500,
                  //         color: greyColor,
                  //       ),
                  //       // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  //       initialSelection: 'US',
                  //       // ignore: prefer_const_literals_to_create_immutables
                  //       favorite: ['+1', 'US'],
                  //       // optional. Shows only country name and flag
                  //       showCountryOnly: false,
                  //       // optional. Shows only country name and flag when popup is closed.
                  //       showOnlyCountryWhenClosed: false,
                  //       // optional. aligns the flag and the Text left
                  //       alignLeft: false,

                  //     ),
                  Container(
                    color: blackColor.withOpacity(0.6),
                    height: 37,
                    width: 1,
                  )
                ],
              ),
            ],
          ),
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: TextFormField(
            controller: numController,
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
              fillColor: whiteColor,
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
        ),
        trailing: GestureDetector(
          onTap: getOtp,
          child: SizedBox(
            height: 40,
            child: MyText(
              text: 'Send OTP',
              weight: FontWeight.bold,
              color: bluishColor,
              size: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget pickCountry(context, String countryName, bool show, bool nowIn) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(8)),
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
                      nowIn
                          ? Row(children: const [
                              Text(
                                "Select the country you are now in",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: 'Raleway-Black'),
                              )
                            ])
                          : Row(children: const [
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
                            color: blackColor.withOpacity(0.5),
                          ),
                        ),
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            child: nowIn
                                ? TextField(
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        filteredServices = countriesList1
                                            .where((element) => element.country
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
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: greyColor.withOpacity(0.2)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: greyColor.withOpacity(0.2)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: greyColor.withOpacity(0.2)),
                                      ),
                                    ),
                                  )
                                : TextField(
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        filteredServices = countriesList1
                                            .where((element) => element
                                                .shortName
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
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: greyColor.withOpacity(0.2)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: greyColor.withOpacity(0.2)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: greyColor.withOpacity(0.2)),
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
                                      "${"https://adventuresclub.net/adventureClub/public/"}${filteredServices[index].flag}",
                                      height: 25,
                                      width: 40,
                                    )
                                  : null,
                              title: nowIn
                                  ? Text(filteredServices[index].country)
                                  : Text(filteredServices[index].shortName),
                              onTap: () {
                                addCountry(
                                  filteredServices[index].country,
                                  show,
                                  filteredServices[index].id,
                                );
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
        tileColor: whiteColor,
        selectedTileColor: whiteColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: show == true
            ? MyText(
                text: selectedCountry,
                color: blackColor.withOpacity(0.6),
                size: 14,
                weight: FontWeight.w500,
              )
            : MyText(
                text: currentLocation,
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

  Widget pickCountry1(context, String countryName) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        onTap: () => showCountryPicker(
          context: context,
          countryListTheme: CountryListThemeData(
            flagSize: 25,
            backgroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
            bottomSheetHeight: 500, // Optional. Country list modal height
            //Optional. Sets the border radius for the bottomsheet.
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            //Optional. Styles the search field.
            inputDecoration: InputDecoration(
              labelText: countryName,
              hintText: countryName,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xFF8C98A8).withOpacity(0.2),
                ),
              ),
            ),
          ),
          onSelect: (Country country) {
            return setState(
              () {
                countryName ==
                    country.displayName; // country.displayName.toString();
              },
            );
          },
        ),
        tileColor: whiteColor,
        selectedTileColor: whiteColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: MyText(
          text: countryName,
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
          color: whiteColor, borderRadius: BorderRadius.circular(8)),
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
                                            ft = (index + 1);
                                            heightController.text =
                                                "$ft' $inches\"";
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
          tileColor: whiteColor,
          selectedTileColor: whiteColor,
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

  Widget pickingWeight(context, String genderName) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.4,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(8)),
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
                                text: 'Weight in Kg',
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
                              Stack(children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  child: CupertinoPicker(
                                    itemExtent: 82.0,
                                    diameterRatio: 22,
                                    backgroundColor: whiteColor,
                                    onSelectedItemChanged: (int index) {
                                      //print(index + 1);
                                      setState(() {
                                        getWeight =
                                            weightList[index].heightName;
                                        // getWeight == null
                                        //     ? cont = false
                                        //     : cont = true;
                                        // ft = (index + 1);
                                        // heightController.text =
                                        //     "$ft' $inches\"";
                                      });
                                    },
                                    selectionOverlay:
                                        const CupertinoPickerDefaultSelectionOverlay(
                                      background: transparentColor,
                                    ),
                                    children: List.generate(weightList.length,
                                        (index) {
                                      return Center(
                                        child: MyText(
                                            text: weightList[index].heightName,
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
                                        MediaQuery.of(context).size.width / 1.2,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color:
                                                    blackColor.withOpacity(0.7),
                                                width: 1.5),
                                            bottom: BorderSide(
                                                color:
                                                    blackColor.withOpacity(0.7),
                                                width: 1.5))),
                                  ),
                                )
                              ]),
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
        tileColor: whiteColor,
        selectedTileColor: whiteColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: MyText(
          text: getWeight.toString(),
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

  Widget pickingHeight(context, String genderName) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.4,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(8)),
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
                                  text: 'Height in cm',
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
                                          // print(index + 1);
                                          getheight =
                                              heightList[index].heightName;
                                          getheight == null
                                              ? cont = false
                                              : cont = true;
                                          setState(() {
                                            ft = (index + 1);
                                            heightController.text =
                                                "$ft' $inches\"";
                                          });
                                        },
                                        selectionOverlay:
                                            const CupertinoPickerDefaultSelectionOverlay(
                                          background: transparentColor,
                                        ),
                                        children: List.generate(
                                            heightList.length, (index) {
                                          return Center(
                                            child: MyText(
                                                text: heightList[index]
                                                    .heightName,
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
          tileColor: whiteColor,
          selectedTileColor: whiteColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          title: MyText(
            text: getheight,
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
