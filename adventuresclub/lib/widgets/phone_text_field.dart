import 'dart:convert';
import 'dart:math';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/get_country.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'buttons/button.dart';
import 'my_text.dart';

class PhoneTextField extends StatefulWidget {
  final Function parseData;
  const PhoneTextField(this.parseData, {super.key});

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  TextEditingController searchController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController numController = TextEditingController();
  List<GetCountryModel> filteredServices = [];
  List<GetCountryModel> countriesList1 = [];
  Map mapCountry = {};
  int userID = 0;
  String countryCode = "+1";
  dynamic ccCode;
  int countryId = 0;
  String flag = "";
  bool cont = false;
  String phoneNumber = "";

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    otpController.dispose();
    numController.dispose();
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
      if (response.statusCode == 200) {
        message("Otp Verified");
        goRegister();
      } else {
        dynamic body = jsonDecode(response.body);
        message(body['message'].toString());
      }
      log(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
    otpController.clear();
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
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
    sendData();
  }

  void sendData() {
    widget.parseData(numController.text, ccCode);
    print(ccCode);
  }

  void getOtp() async {
    if (numController.text.isEmpty) {
      message("Please Enter Your Phone Number");
      return;
    }
    if (ccCode == 0) {
      message("Please Select Country Code");
      return;
    }
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

  void goRegister() {
    // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //   return NewRegister(
    //     mobileNumber: numController.text.trim(),
    //     mobileCode: ccCode,
    //     userId: userID,
    //   );
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                              return StatefulBuilder(
                                  builder: (context, setState) {
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
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                                  filteredServices =
                                                      countriesList1
                                                          .where((element) =>
                                                              element
                                                                  .country
                                                                  .toLowerCase()
                                                                  .contains(
                                                                      value))
                                                          .toList();
                                                  //log(filteredServices.length.toString());
                                                } else {
                                                  filteredServices =
                                                      countriesList1;
                                                }
                                                setState(() {});
                                              },
                                              controller: searchController,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 8),
                                                hintText: 'Country',
                                                filled: true,
                                                fillColor: lightGreyColor,
                                                suffixIcon: GestureDetector(
                                                  //onTap: openMap,
                                                  child:
                                                      const Icon(Icons.search),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                  borderSide: BorderSide(
                                                      color: greyColor
                                                          .withOpacity(0.2)),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                  borderSide: BorderSide(
                                                      color: greyColor
                                                          .withOpacity(0.2)),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
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
                                              leading:
                                                  searchController.text.isEmpty
                                                      ? Image.network(
                                                          "${"https://adventuresclub.net/adventureClub/public/"}${countriesList1[index].flag}",
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
                                                    filteredServices[index]
                                                        .country,
                                                    filteredServices[index]
                                                        .code,
                                                    filteredServices[index].id,
                                                    filteredServices[index]
                                                        .flag);
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
                  sendData();
                },
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                  sendData();
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
                  hintText: "enterPhoneNumber".tr(), //'Enter Phone Number',
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
            // trailing: GestureDetector(
            //   onTap: getOtp,
            //   child: SizedBox(
            //     height: 40,
            //     child: MyText(
            //       text: 'Send OTP',
            //       weight: FontWeight.bold,
            //       color: bluishColor,
            //       size: 14,
            //     ),
            //   ),
            // ),
          ),
        ),
        // const SizedBox(
        //   height: 20,
        // ),
        // Button('Send OTP', greenishColor, greenishColor, whiteColor, 18, getOtp,
        //     Icons.add, whiteColor, false, 2, 'Raleway', FontWeight.w600, 16),
      ],
    );
  }
}
