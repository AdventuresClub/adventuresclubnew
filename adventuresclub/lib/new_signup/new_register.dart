// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, avoid_function_literals_in_foreach_calls, unused_element

import 'dart:async';
import 'dart:convert';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/settings/provicy_policy.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:adventuresclub/models/get_country.dart';
import 'package:adventuresclub/sign_up/sign_in.dart';
import 'package:adventuresclub/sign_up/terms_condition.dart';
import 'package:adventuresclub/temp_google_map.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/text_fields.dart';
import 'package:adventuresclub/widgets/text_fields/tf_with_suffix_icon.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewRegister extends StatefulWidget {
  final String mobileNumber;
  final String mobileCode;
  final int userId;
  const NewRegister(
      {super.key,
      required this.mobileNumber,
      required this.mobileCode,
      required this.userId});

  @override
  State<NewRegister> createState() => _NewRegisterState();
}

class _NewRegisterState extends State<NewRegister> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  bool loading = false;
  String selectedCountry = '';
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

  @override
  void initState() {
    super.initState();
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
    getCountryId(selectedCountry);
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
                "https://adventuresclub.net/adventureClub/api/v1/register"),
            body: {
              "name": userNameController.text,
              "email": emailController.text,
              "nationality": "",
              "password": passController.text,
              "now_in": currentLocationId.toString(),
              "mobile": widget.mobileNumber,
              "health_conditions": "",
              "height": "",
              "weight": "",
              "mobile_code": widget.mobileCode,
              "user_id": widget.userId.toString(),
              "dob": formattedDate.toString(),
              "country_id": countryId.toString(),
              "device_id": "1",
              "nationality_id": "",
            });
        if (response.statusCode == 200) {
          prefs.setString("name", userNameController.text);
          prefs.setInt("countryId", countryId);
          prefs.setInt("userId", widget.userId);
          prefs.setString("email", emailController.text.trim());
          prefs.setString("password", passController.text.trim());
          prefs.setString("country", widget.mobileCode);
          prefs.setString("countryFlag", flag);
          prefs.setString("phoneNumber", widget.mobileNumber);
          prefs.setString("userRole", "3");
          parseData(
              userNameController.text,
              countryId,
              widget.userId,
              emailController.text,
              passController.text,
              widget.mobileCode,
              flag,
              widget.mobileNumber);
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
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
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
      setState(() {
        _currentAddress =
            ' ${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        selectedCountry = place.country!;
      });
      //  getCountryId(selectedCountry);
    }).catchError((e) {
      debugPrint(e);
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
    getCountries(userCountryId);
  }

  Future getCountries(String cId) async {
    countryId = int.tryParse(cId) ?? 0;
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
        countriesList.add(gc);
      });
    }
    countriesList.forEach((element) {
      if (element.id == countryId) {
        getC(element.country, element.flag);
      }
    });
  }

  void getC(String country, String countryflag) {
    setState(
      () {
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
                  fit: BoxFit.cover),
            ),
            child: loading
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: whiteColor,
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                              text: ' Profile Creation',
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
                        TextFields('Username', userNameController, 17,
                            whiteColor, true),
                        const SizedBox(height: 20),
                        TextFields(
                            'Email', emailController, 17, whiteColor, true),
                        const SizedBox(height: 20),
                        TFWithSiffixIcon('Password', Icons.visibility_off,
                            passController, true),
                        const SizedBox(height: 20),
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
                                style: TextStyle(
                                    color: blackColor.withOpacity(0.6)),
                              ),
                              trailing: Icon(
                                Icons.calendar_today,
                                color: blackColor.withOpacity(0.6),
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 20),
                        // GestureDetector(
                        //   child: Container(
                        //     padding: const EdgeInsets.symmetric(vertical: 0),
                        //     width: MediaQuery.of(context).size.width / 1,
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         color: whiteColor),
                        //     child: ListTile(
                        //       contentPadding: const EdgeInsets.symmetric(
                        //           vertical: 0, horizontal: 10),
                        //       leading: Text(
                        //         selectedCountry,
                        //         style: TextStyle(
                        //             color: blackColor.withOpacity(0.6)),
                        //       ),
                        //       trailing: GestureDetector(
                        //         onTap: _getCurrentPosition,
                        //         child: Icon(
                        //           Icons.pin_drop,
                        //           color: blackColor.withOpacity(0.6),
                        //           size: 20,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
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
                        const SizedBox(height: 40),
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
                                          color: whiteColor,
                                          fontFamily: 'Raleway')),
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
}
