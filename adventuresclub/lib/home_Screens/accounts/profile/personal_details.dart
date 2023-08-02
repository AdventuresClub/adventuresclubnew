// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/get_country.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  String name = "";
  String email = "";
  String phone = "";
  String phoneNumber = "";
  List<GetCountryModel> filteredServices = [];
  List<GetCountryModel> countriesList1 = [];
  dynamic ccCode;
  Map mapCountry = {};
  bool cont = false;
  @override
  void initState() {
    super.initState();
    getData();
    getCountries();
  }

  void getData() {
    nameController.text = Constants.profile.name;
    phoneController.text = Constants.profile.mobile;
    emailController.text = Constants.profile.email;
    setState(() {
      name = Constants.profile.name;
      phone = Constants.profile.mobile;
      email = Constants.profile.email;
    });
  }

  //   https://adventuresclub.net/adventureClub/api/v1/update_profile
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
                Uri.parse(
                    "https://adventuresclub.net/adventureClub/api/v1/update_profile"),
                body: {
                  'user_id': Constants.userId.toString(), //ccCode.toString(),
                  'name': nameController.text.trim(),
                  'mobile_code': phoneController.text
                      .trim(), //Constants.profile.mobileCode,
                  'email': emailController.text.trim(),
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
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/verify/otp"),
          body: {
            'user_id': Constants.userId.toString(),
            'mobile_code': ccCode.toString(),
            'mobile': phoneController.text.trim(),
            //"3353414905", //"3214181273", //phoneController.text.trim(),
            'otp': otpController.text
                .trim(), //"9567", //otpController.text.trim(),
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
      var response = await http.post(
          Uri.parse("https://adventuresclub.net/adventureClub/api/v1/get_otp"),
          body: {
            'mobile_code': ccCode.toString(), //ccCode.toString(),
            'mobile': phoneController.text,
            'forgot_password': "0",
          });
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
  //           "https://adventuresclub.net/adventureClubDev/api/v1/update/number"));
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
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/update/number"),
          body: {
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
            child: Column(
              children: [
                TextFields(
                  name,
                  nameController,
                  15,
                  greyProfileColor,
                  true,
                ),
                Divider(
                  indent: 4,
                  endIndent: 4,
                  color: greyColor.withOpacity(0.5),
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
                Divider(
                  indent: 4,
                  endIndent: 4,
                  color: greyColor.withOpacity(0.5),
                ),
                TextFields(email, emailController, 15, greyProfileColor, true),
                Divider(
                  indent: 4,
                  endIndent: 4,
                  color: greyColor.withOpacity(0.5),
                ),
                const SizedBox(
                  height: 30,
                ),
                Button(
                    'Save',
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget phoneNumberField(context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: greyProfileColor, borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        tileColor: greyProfileColor,
        selectedTileColor: greyProfileColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        leading: Container(
          height: 42,
          width: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
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
                              padding: const EdgeInsets.all(12.0),
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
                        color: greyProfileColor,
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
}
