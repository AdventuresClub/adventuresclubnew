// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, avoid_function_literals_in_foreach_calls, unused_element

import 'dart:async';
import 'dart:convert';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/settings/provicy_policy.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:adventuresclub/models/get_country.dart';
import 'package:adventuresclub/sign_up/sign_in.dart';
import 'package:adventuresclub/sign_up/terms_condition.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/loading_widget.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/text_fields.dart';
import 'package:adventuresclub/widgets/text_fields/tf_with_suffix_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/phone_text_field.dart';

class NewRegister extends StatefulWidget {
  // final String mobileNumber;
  // final String mobileCode;
  // final int userId;
  const NewRegister({
    super.key,
    // required this.mobileNumber,
    // required this.mobileCode,
    // required this.userId,
  });

  @override
  State<NewRegister> createState() => _NewRegisterState();
}

class _NewRegisterState extends State<NewRegister> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  bool loading = false;
  String selectedCountry = 'Now In';
  bool termsValue = false;
  var formattedDate;
  String getCode = '';
  DateTime? pickedDate;
  int countryId = 0;
  int currentLocationId = 0;
  String userCountryId = "";
  int userID = 0;
  String flag = "";
  String userRole = "";
  double lat = 0.0, lng = 0.0;
  Completer<GoogleMapController> controller = Completer();
  String currentLocation = "";
  List<Marker> markers = [];
  String? _currentAddress;
  Position? _currentPosition;
  Map mapCountry = {};
  List<GetCountryModel> countriesList = [];
  String mobileNumber = "";
  String countryCode = "+1";
  String selectedLanguage = "";
  List<GetCountryModel> filteredServices = [];
  List<GetCountryModel> countriesList1 = [];
  String language = "";
  String userCountry = "";

  @override
  void initState() {
    super.initState();
    getCountries();
    _getCurrentPosition();
    formattedDate = 'DOB';
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
    userNameController.dispose();
    dobController.dispose();
    searchController.dispose();
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

  void register() async {
    SharedPreferences prefs = await Constants.getPrefs();
    try {
      if (!termsValue) {
        message("Please Agree with terms & Conditions");
        return;
      }
      if (userNameController.text.isEmpty) {
        message("Please Enter Username");
        return;
      }
      if (emailController.text.isEmpty) {
        message("Please Enter Email");
        return;
      }
      if (passController.text.isEmpty) {
        message("Please Enter Password");
        return;
      }
      if (formattedDate != null) {
        var response = await http.post(
            Uri.parse(
                "https://adventuresclub.net/adventureClub/api/v1/register_new"),
            body: {
              "language_id": "1",
              "name": userNameController.text,
              "email": emailController.text,
              "password": passController.text,
              "mobile": mobileNumber, //widget.mobileNumber,
              "country_id": countryId.toString(),
            });
        var decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map;
        if (response.statusCode == 200) {
          setState(() {
            userID = decodedResponse['data']['id'];
          });
          prefs.setString("name", userNameController.text);
          prefs.setInt("countryId", countryId);
          prefs.setInt("userId", userID //widget.userId
              );
          prefs.setString("email", emailController.text.trim());
          prefs.setString("password", passController.text.trim());
          prefs.setString(
            "country", countryCode,
            //widget.mobileCode,
          );
          prefs.setString("countryFlag", flag);
          prefs.setString(
            "phoneNumber", mobileNumber, //widget.mobileNumber,
          );
          prefs.setString("userRole", "3");
          parseData(
            userNameController.text,
            countryId,
            userID,
            //widget.userId,
            emailController.text,
            passController.text,
            countryCode,
            //widget.mobileCode,
            flag,
            "",
            //widget.mobileNumber,
          );
          Constants.country = selectedCountry;
          goToHome();
        } else {
          dynamic body = jsonDecode(response.body);
          message(body['message'].toString());
        }
      } else {
        message("Please Enter DOB");
      }
    } catch (e) {
      print(e);
    }
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
    if (show == true) {
      setState(() {
        selectedCountry = country;
      });
    } else {
      setState(() {
        currentLocation = country;
        currentLocationId = id;
      });
    }
  }

  void getMyLocation() async {
    if (!loading) {
      setState(() {
        loading = true;
      });
      String locationData = await Constants.getLocation();
      List<String> location = locationData.split(':');
      lat = double.tryParse(location[0]) ?? 0;
      lng = double.tryParse(location[1]) ?? 0;
      final CameraPosition _myPosition = CameraPosition(
        target: LatLng(lat, lng),
        zoom: 19.151926040649414,
      );
      final GoogleMapController _controller = await controller.future;
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(_myPosition),
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        lat,
        lng,
      );
      if (placemarks.isNotEmpty) {
        bool found = false;
        for (Placemark placeMark in placemarks) {
          if (!found && placeMark.locality != '' && placeMark.country != '') {
            var myLoc = placeMark.street! +
                ', ' +
                placeMark.locality! +
                ", " +
                placeMark.country.toString();
            List<Marker> tempMarkers = [];
            tempMarkers.add(
              Marker(
                markerId: const MarkerId("myLoc"),
                position: LatLng(lat, lng),
                infoWindow: InfoWindow(
                  snippet: myLoc,
                  title: myLoc,
                ),
              ),
            );
            // var tMarkers = await SharedPreferencesConstant.createMarkers(
            //   tempMarkers,
            //   placemarks[0].locality.toString(),
            //   placemarks[0].country.toString(),
            // );
            setState(() {
              selectedCountry = myLoc;
              markers = tempMarkers;
              loading = false;
            });
            found = true;
          }
        }
      } else {
        message(
          'Unable to find your location please try again later!',
        );
        setState(() {
          loading = false;
        });
      }
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    setState(() {
      loading = true;
    });
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      //setState(() =>
      _currentPosition = position;
      //);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      //setState(() {
      _currentAddress =
          ' ${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      userCountry = place.country!.toUpperCase();
      //});
      checkCountry();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void checkCountry() {
    filteredServices.forEach((element) {
      if (element.country == userCountry) {
        getC(element.country, element.id, element.flag, element.code, false);
        //setState(() {
        selectedCountry == element.country;
        countryCode == element.code;
        //});
      } else {
        if (element.country == "OMAN") {
          getC(element.country, element.id, element.flag, element.code, false);
          //setState(() {
          selectedCountry == element.country;
          countryCode == element.code;
          // });
        }
      }
    });
    setState(() {
      loading = false;
    });
  }

  void getCountryId(String country) {
    String c = country.toLowerCase();
    if (c == "pakistan") {
      setState(() {
        userCountryId = "15";
      });
    } else if (c == "oman") {
      setState(() {
        userCountryId = "14";
      });
    } else {
      setState(() {
        userCountryId = "14";
      });
    }
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
      // setState(() {
      filteredServices = countriesList1;
      // });
    }
  }

  void getC(
      String country, int id, String countryflag, String cCode, bool check) {
    if (check) {
      Navigator.of(context).pop();
    }
    setState(
      () {
        selectedCountry = country;
        countryId = id;
        flag = countryflag;
        countryCode = cCode;
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

  void getData(String phoneNumber, String code) {
    mobileNumber = phoneNumber;
    countryCode = code;
  }

  void changeLanguage(String lang) {
    if (lang == "English") {
      context.setLocale(const Locale('en', 'US'));
      setState(() {
        language = "english";
      });
    } else if (lang == "Arabic") {
      context.setLocale(const Locale('ar', 'SA'));
      setState(() {
        language = "arabic";
      });
    }
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
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    blackColor.withOpacity(0.6), BlendMode.darken),
                image: const ExactAssetImage('images/registrationpic.png'),
                fit: BoxFit.cover),
          ),
          child: loading
              ? const LoadingWidget()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                    text: 'profileCreation'
                                        .tr(), //'Profile Creation',
                                    weight: FontWeight.w600,
                                    color: whiteColor,
                                    size: 24,
                                    fontFamily: 'Raleway'),
                                // Row(
                                //   children: [
                                //     GestureDetector(
                                //       onTap: () => changeLanguage("Arabic"),
                                //       child: const Image(
                                //         image: ExactAssetImage(
                                //             'images/ksa_flag.png'),
                                //         height: 60,
                                //         width: 60,
                                //       ),
                                //     ),
                                //     const SizedBox(
                                //       width: 10,
                                //     ),
                                //     GestureDetector(
                                //       onTap: () => changeLanguage("English"),
                                //       child: const Image(
                                //         image: ExactAssetImage(
                                //             'images/great_britain.jpg'),
                                //         height: 60,
                                //         width: 60,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // PopupMenuButton<String>(
                                //   child: Padding(
                                //     padding: const EdgeInsets.symmetric(
                                //         horizontal: 8.0),
                                //     child: language.isEmpty
                                //         ? const Icon(
                                //             Icons.language_rounded,
                                //             color: whiteColor,
                                //             size: 50,
                                //           )
                                //         : language == "english"
                                //             ? const Image(
                                //                 image: ExactAssetImage(
                                //                     'images/great_britain.jpg'),
                                //                 height: 60,
                                //                 width: 40,
                                //               )
                                //             : const Image(
                                //                 image: ExactAssetImage(
                                //                     'images/ksa_flag.png'),
                                //                 height: 60,
                                //                 width: 40,
                                //               ),
                                //   ),
                                //   onSelected: (String item) {
                                //     setState(() {
                                //       selectedLanguage = item;
                                //     });
                                //     changeLanguage(item);
                                //   },
                                //   itemBuilder: (BuildContext context) =>
                                //       <PopupMenuEntry<String>>[
                                //     const PopupMenuItem<String>(
                                //       value: "English",
                                //       child: Row(
                                //         children: [
                                //           Image(
                                //             image: ExactAssetImage(
                                //                 'images/great_britain.jpg'),
                                //             height: 40,
                                //             width: 20,
                                //           ),
                                //           SizedBox(
                                //             width: 5,
                                //           ),
                                //           Text('English'),
                                //         ],
                                //       ),
                                //     ),
                                //     const PopupMenuItem<String>(
                                //       value: "Arabic",
                                //       child: Row(
                                //         children: [
                                //           Image(
                                //             image: ExactAssetImage(
                                //                 'images/ksa_flag.png'),
                                //             height: 40,
                                //             width: 20,
                                //           ),
                                //           SizedBox(
                                //             width: 5,
                                //           ),
                                //           Text('Arabic'),
                                //         ],
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                            //const SizedBox(height: 20),
                            Image.asset(
                              'images/whiteLogo.png',
                              height: 200,
                              width: 320,
                            ),
                            //const SizedBox(height: 10),
                            TextFields("userName".tr(), userNameController, 17,
                                whiteColor, true),
                            const SizedBox(height: 10),
                            TextFields('email'.tr(), emailController, 17,
                                whiteColor, true),
                            const SizedBox(height: 10),
                            TFWithSiffixIcon('password'.tr(),
                                Icons.visibility_off, passController, true),
                            const SizedBox(
                              height: 10,
                            ),
                            PhoneTextField(getData, countryCode),
                            const SizedBox(
                              height: 10,
                            ),
                            pickCountry(context, selectedCountry, true, true),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                    activeColor: bluishColor,
                                    side: const BorderSide(
                                        color: greyColor3, width: 2),
                                    value: termsValue,
                                    onChanged: ((bool? value) {
                                      return setState(() {
                                        termsValue = value!;
                                      });
                                    })),
                                Expanded(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "iHaveRead"
                                                .tr(), //'I have read   ',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: whiteColor,
                                                fontFamily: 'Raleway')),
                                        TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              terms();
                                            },
                                          text: "termsAndConditions"
                                              .tr(), //'Terms & Conditions',
                                          style: const TextStyle(
                                              fontSize: 13,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.w500,
                                              color: whiteColor,
                                              fontFamily: 'Raleway'),
                                        ),
                                        const TextSpan(
                                          text: ' & ',
                                          style: TextStyle(
                                              fontSize: 14,
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
                                          text: "privacyPolicy"
                                              .tr(), //'Privacy policy',
                                          style: const TextStyle(
                                              fontSize: 13,
                                              decoration:
                                                  TextDecoration.underline,
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
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Button(
                                "register".tr(),
                                //'Register',
                                greenishColor,
                                greenishColor,
                                whiteColor,
                                20,
                                register,
                                Icons.add,
                                whiteColor,
                                false,
                                1.3,
                                'Raleway',
                                FontWeight.w600,
                                16),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: goToSignIn,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "alreadyHaveAnAccount ?"
                                              .tr(), //'Already have an account ?',
                                          style: const TextStyle(
                                              color: whiteColor,
                                              fontFamily: 'Raleway',
                                              fontSize: 16)),
                                      TextSpan(
                                        text: "signIn".tr(), //'Sign In',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: whiteColor,
                                            fontFamily: 'Raleway'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        )
                      ],
                    ),
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
                          ? const Row(children: [
                              Text(
                                "Select the country you are now in",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: 'Raleway-Black'),
                              )
                            ])
                          : const Row(children: [
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
                                getC(
                                    filteredServices[index].country,
                                    filteredServices[index].id,
                                    filteredServices[index].flag,
                                    filteredServices[index].code,
                                    true);
                                // addCountry(
                                //   filteredServices[index].country,
                                //   show,
                                //   filteredServices[index].id,
                                // );
                              },
                            );
                          }),
                        ),
                      ),
                      const Text(
                        "Request to add country from contact us menu after making a registration",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: redColor,
                            fontFamily: 'Raleway-Black'),
                      ),
                      const SizedBox(
                        height: 20,
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
                size: 16,
                weight: FontWeight.w500,
              )
            : MyText(
                text: currentLocation,
                color: blackColor.withOpacity(0.6),
                size: 16,
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
}
