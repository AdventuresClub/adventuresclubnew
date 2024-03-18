// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls
import 'dart:convert';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/account.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/home.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/planned.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/visit.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/requests.dart';
import 'package:adventuresclub/new_signup/new_register.dart';
import 'package:adventuresclub/provider/navigation_index_provider.dart';
import 'package:adventuresclub/sign_up/sign_in.dart';
import 'package:adventuresclub/widgets/loading_widget.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/update_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/get_country.dart';
import '../../widgets/buttons/button.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  //int index = 0;
  String userId = "";
  String totalNotication = "";
  String resultAccount = "";
  String resultService = "";
  String resultRequest = "";
  Map mapVersion = {};
  bool loading = false;
  String? _currentAddress;
  Position? _currentPosition;
  String userCountry = "";
  String mobileNumber = "";
  String countryCode = "+1";
  String selectedLanguage = "";
  List<GetCountryModel> filteredServices = [];
  String selectedCountry = 'Now In';
  String flag = "";
  int countryId = 0;
  Map mapCountry = {};
  List<GetCountryModel> countriesList1 = [];

  @override
  void initState() {
    super.initState();
    if (Constants.userId == 0) {
      getCountries();
    }

    // index = context.read<ServicesProvider>().homeIndex;
    getNotificationBadge();
    Constants.getFilter();
    getVersion();
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
      // setState(() {
      filteredServices = countriesList1;
      // });
    }
    if (Constants.userId == 0) {
      showConfirmation();
      //   _getCurrentPosition();
    }
  }

  void addCountry(
      String country, int id, String flag, String countryCurrency) async {
    // clearAll();
    // Navigator.of(context).pop();
    // updateCountryId(id);
    SharedPreferences prefs = await Constants.getPrefs();
    prefs.setInt("countryId", id);
    prefs.setString("country", country);
    prefs.setString("countryFlag", flag);
    setState(() {
      Constants.countryId = id;
      Constants.country = country;
      Constants.countryFlag = flag;
      Constants.countryCurrency = countryCurrency;
    });
    // homePage();
  }

  void showConfirmation() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => SimpleDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: const Icon(
                Icons.check_circle,
                size: 80,
                color: greenColor1,
              ),
              children: [
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: MyText(
                    text: "Select Your Country",
                    size: 18,
                    weight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //ListView.builder(
                //itemCount: filteredServices.length,
                //itemBuilder: ((context, index) {
                //return

                for (int index = 0; index < countriesList1.length; index++)
                  ListTile(
                    leading: Image.network(
                      "${"${Constants.baseUrl}/public/"}${countriesList1[index].flag}",
                      height: 25,
                      width: 40,
                    ),
                    title: Text(countriesList1[index].country),
                    onTap: () {
                      addCountry(
                          filteredServices[index].country,
                          filteredServices[index].id,
                          filteredServices[index].flag,
                          filteredServices[index].currency);
                    },
                  ),
                //}),
                //),
                // ElevatedButton(
                //     onPressed: homePage,
                //     child: MyText(
                //       text: "Continue",
                //     ),),
                //BottomButton(bgColor: blueButtonColor, onTap: homePage)
              ],
            ));
  }

  Future<void> _getCurrentPosition() async {
    setState(() {
      loading = true;
    });
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      setState(() {
        loading = false;
      });
      checkCountry();
      return;
    }
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
        Constants.country = selectedCountry;
        Constants.countryFlag = element.flag;
        Constants.countryId = element.id;
        Constants.countryCurrency = element.currency;
        //});
      } else {
        if (element.country == "OMAN") {
          getC(element.country, element.id, element.flag, element.code, false);
          //setState(() {
          selectedCountry == element.country;
          countryCode == element.code;
          Constants.country = selectedCountry;
          Constants.countryFlag = element.flag;
          Constants.countryId = element.id;
          Constants.countryCurrency = element.currency;
          // });
        }
      }
    });
    setState(() {
      loading = false;
    });
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

  void getVersion() async {
    var response = await http
        .get(Uri.parse("${Constants.baseUrl}/api/v1/get_app_version"));
    if (response.statusCode == 200) {
      mapVersion = json.decode(response.body);
      List<dynamic> result = mapVersion['data'];
      result.forEach((element) {
        Constants.lastestVersion = element['version'] ?? "";
      });
    }
    double lVersion = double.tryParse(Constants.lastestVersion) ?? 0;
    if (Constants.currentVersion < lVersion) {
      navUpdatePage();
    }
  }

  void navUpdatePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) {
          return const UpdatePage();
        },
      ),
    );
  }

  Widget getBody(int index) {
    // int providerIndex = context.read<ServicesProvider>().homeIndex;
    if (index == 0) {
      return const Home();
    } else if (index == 1) {
      return const //PlannedAdventure();
          Planned();
    } else if (index == 2) {
      return const Requests();
    } else if (index == 3) {
      return const Visit();
    } else if (index == 4) {
      return const Account();
    } else {
      return const Center(
        child: Text('Body'),
      );
    }
  }

  void getNotificationBadge() async {
    try {
      var response = await http.post(
          Uri.parse("${Constants.baseUrl}/api/v1/get_notification_list_budge"),
          body: {
            'user_id': Constants.userId.toString(), //"27",
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = decodedResponse['data'];
      result.forEach((element) {
        setState(() {
          totalNotication = element['total_notification'] ?? "";
          resultAccount = element['resultAccount'] ?? "";
          resultService = element['resultService'] ?? "";
          resultRequest = element['resultRequest'] ?? "";
        });
      });
      notificationNumber(
        convertToInt(totalNotication),
        convertToInt(resultAccount),
        convertToInt(resultService),
        convertToInt(resultRequest),
      );

      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  int convertToInt(String s) {
    int t = int.tryParse(s) ?? 0;
    return t;
  }

  double convert(String rating) {
    double result = double.parse(rating);
    return result;
  }

  void notificationNumber(
    int totalN,
    int account,
    int serviceCounter,
    int requestCounter,
  ) {
    Constants.totalNotication = totalN;
    Constants.resultAccount = account;
    Constants.resultService = serviceCounter;
    Constants.resultRequest = requestCounter;
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void navLogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const SignIn();
    }));
  }

  void navRegister() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const NewRegister();
    }));
  }

  void loginPrompt() async {
    await showModalBottomSheet(
      showDragHandle: false,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BottomSheet(
          onClosing: () {},
          builder: (BuildContext context) {
            return Container(
              color: blackColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: cancel,
                              child: const Icon(
                                Icons.cancel_sharp,
                                color: whiteColor,
                              ),
                            )
                          ],
                        ),
                        ListTile(
                          tileColor: Colors.transparent,
                          //onTap: showCamera,
                          leading: const Icon(
                            Icons.notification_important,
                            color: whiteColor,
                          ),
                          title: MyText(
                            text: "You Are Not logged In",
                            weight: FontWeight.w600,
                          ),
                          trailing: const Icon(Icons.chevron_right_rounded),
                        ),
                        Button(
                            "login".tr(),
                            //'Register',
                            greenishColor,
                            greenishColor,
                            whiteColor,
                            20,
                            () {},
                            Icons.add,
                            whiteColor,
                            false,
                            2,
                            'Raleway',
                            FontWeight.w600,
                            18),
                        const Divider(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              color: transparentColor,
                              height: 40,
                              child: GestureDetector(
                                onTap: navRegister,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "dontHaveAnAccount?".tr(),
                                            style: const TextStyle(
                                                color: whiteColor,
                                                fontSize: 16)),
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
                              padding: const EdgeInsets.only(bottom: 40),
                              child: Button(
                                  "register".tr(),
                                  greenishColor,
                                  greenishColor,
                                  whiteColor,
                                  20,
                                  navRegister,
                                  Icons.add,
                                  whiteColor,
                                  false,
                                  2,
                                  'Raleway',
                                  FontWeight.w600,
                                  20),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int index = Provider.of<NavigationIndexProvider>(context).homeIndex;
    return Scaffold(
      body: loading ? const LoadingWidget() : getBody(index),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: index,
        onTap: (i) {
          print(i);
          Provider.of<NavigationIndexProvider>(context, listen: false)
              .setHomeIndex(i);
          // setState(() {
          //   index = i;
          // });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/home.png',
              height: 30,
              width: 30,
            ),
            label: 'home'.tr(),
            //  ),
            activeIcon: Image.asset(
              'images/home.png',
              height: 30,
              width: 30,
              color: greenishColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/calender.png',
              height: 30,
              width: 30,
            ),

            label: 'planned'.tr(),
            //  ),
            activeIcon: Image.asset(
              'images/calender.png',
              height: 30,
              width: 30,
              color: greenishColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Stack(clipBehavior: Clip.none, children: [
              Image.asset(
                'images/compass.png',
                height: 30,
                width: 30,
              ),
              Positioned(
                  top: -5,
                  right: -12,
                  child: CircleAvatar(
                      radius: 10,
                      backgroundColor: redColor,
                      child: MyText(
                        text: resultRequest,
                        color: whiteColor,
                        weight: FontWeight.bold,
                        size: 9,
                      )))
            ]),
            label: 'bookings'.tr(),
            //  ),
            activeIcon: Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  'images/compass.png',
                  height: 30,
                  width: 30,
                  color: greenishColor,
                ),
                Constants.resultRequest > 0
                    ? Positioned(
                        top: -5,
                        right: -12,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: redColor,
                          child: MyText(
                            text: resultRequest.toString(),
                            color: whiteColor,
                            size: 10,
                          ),
                        ),
                      )
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
              ],
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/worldwide.png',
              height: 30,
              width: 30,
            ),
            label: 'attractions'.tr(),
            //  ),
            activeIcon: Image.asset(
              'images/worldwide.png',
              height: 30,
              width: 30,
              color: greenishColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Stack(clipBehavior: Clip.none, children: [
              Image.asset(
                'images/account.png',
                height: 30,
                width: 30,
              ),
              Constants.resultAccount > 0
                  ? Positioned(
                      top: -5,
                      right: -6,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: redColor,
                        child: MyText(
                          text: resultAccount.toString(), //'12',
                          color: whiteColor,
                          weight: FontWeight.bold,
                          size: 9,
                        ),
                      ),
                    )
                  : const SizedBox(
                      width: 0,
                      height: 0,
                    ),
            ]),
            label: 'account'.tr(),
            //  ),
            activeIcon: Stack(clipBehavior: Clip.none, children: [
              Image.asset(
                'images/account.png',
                height: 30,
                width: 30,
                color: greenishColor,
              ),
              Positioned(
                  top: -5,
                  right: -12,
                  child: CircleAvatar(
                      radius: 10,
                      backgroundColor: redColor,
                      child: MyText(
                        text: resultAccount, //'12',
                        color: whiteColor,
                        weight: FontWeight.bold,
                        size: 9,
                      )))
            ]),
          ),
        ],
        backgroundColor: whiteColor,
        selectedItemColor: bluishColor,
        unselectedItemColor: blackColor.withOpacity(0.6),
        selectedLabelStyle: TextStyle(color: blackColor.withOpacity(0.6)),
        showUnselectedLabels: true,
      ),
    );
  }
}
