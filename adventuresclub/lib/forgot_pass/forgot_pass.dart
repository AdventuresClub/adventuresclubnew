// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:convert';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/forgot_pass/recovery_password.dart';
import 'package:adventuresclub/sign_up/sign_in.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/get_country.dart';
import '../widgets/buttons/button.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController numController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  List<GetCountryModel> countriesList1 = [];
  bool cont = false;
  Map mapCountry = {};
  String vID = '';
  String phoneNumber = "";
  String countryCode = "+1";
  bool loading = false;
  String getCountry = '';
  String country = '';
  dynamic ccCode;
  int countryId = 0;
  String flag = "";
  int userID = 0;

  @override
  void initState() {
    super.initState();
    getCountries();
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

  void goToSignIn() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const SignIn();
        },
      ),
    );
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

  void forgetPage(String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return RecoveryPassword(id);
        },
      ),
    );
  }

  void verifyOtp() async {
    Navigator.of(context).pop();
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/verify_otp"),
          body: {
            'user_id': Constants.userId.toString(),
            'otp': otpController.text.trim,
            'forgot_password': "0"
          });
      if (response.statusCode == 200) {
        forgetPage(otpController.text.trim());
        message("OTP Verfied");
      } else {
        dynamic body = jsonDecode(response.body);
        message(body['message'].toString());
      }
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
    otpController.clear();
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
      if (response.statusCode == 200) {
        setState(() {
          userID = decodedResponse['data']['user_id'];
        });
        dynamic body = jsonDecode(response.body);
        message(body['message'].toString());
        print(response.statusCode);
        print(userID);
      } else {
        dynamic body = jsonDecode(response.body);
        message(body['message'].toString());
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Align(
              alignment: Alignment.centerLeft,
              child: MyText(
                text: 'Forgot Password',
                weight: FontWeight.w600,
                color: bluishColor,
                size: 20,
              )),
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
          Align(
              alignment: Alignment.centerLeft,
              child: MyText(
                text:
                    "By sending an OTP we'll verify that you are real, so please select an option.",
                weight: FontWeight.bold,
                color: greyColor,
                size: 12,
              )),
          const SizedBox(
            height: 20,
          ),
          phoneNumberField(context),
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
                      text: "Got Remember? ",
                      style: TextStyle(color: greyColor),
                    ),
                    TextSpan(
                      text: 'Sign In',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: bluishColor),
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
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                const Row(children: [
                                  Text(
                                    "Select Your Country",
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
                                        horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "'Country',",
                                          style: TextStyle(
                                            color: blackColor.withOpacity(0.6),
                                          ),
                                        ),
                                        Text(
                                          "'Code' ",
                                          style: TextStyle(
                                            color: blackColor.withOpacity(0.6),
                                          ),
                                        ),
                                        Text(
                                          " or ",
                                          style: TextStyle(
                                            color: blackColor.withOpacity(0.6),
                                          ),
                                        ),
                                        Text(
                                          " 'Dial Code'",
                                          style: TextStyle(
                                            color: blackColor.withOpacity(0.6),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 100,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.search,
                                              color:
                                                  blackColor.withOpacity(0.5),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: countriesList1.length,
                                    itemBuilder: ((context, index) {
                                      return ListTile(
                                        leading: Image.network(
                                          "${"https://adventuresclub.net/adventureClub/public/"}${countriesList1[index].flag}",
                                          height: 25,
                                          width: 40,
                                        ),
                                        title: Text(
                                          countriesList1[index].country,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: blackColor,
                                              fontFamily: 'Raleway'),
                                        ),
                                        trailing: Text(
                                          countriesList1[index].code,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: blackColor,
                                              fontFamily: 'Raleway'),
                                        ),
                                        onTap: () {
                                          getC(
                                              countriesList1[index].country,
                                              countriesList1[index].code,
                                              countriesList1[index].id,
                                              countriesList1[index].flag);
                                          // addCountry(
                                          //   countriesList1[index].country,
                                          // );
                                        },
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          );
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

  Widget pickCountry(context, String countryName) {
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
                textStyle:
                    const TextStyle(fontSize: 16, color: Colors.blueGrey),
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
                return setState(() {
                  countryName ==
                      country.displayName; // country.displayName.toString();
                });
              }),
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
          )),
    );
  }
}
