// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls
import 'dart:async';
import 'dart:convert';
import 'package:app/constants.dart';
import 'package:app/home_Screens/navigation_screens/account.dart';
import 'package:app/home_Screens/navigation_screens/home.dart';
import 'package:app/home_Screens/navigation_screens/planned.dart';
import 'package:app/home_Screens/navigation_screens/visit.dart';
import 'package:app/home_Screens/navigation_screens/requests.dart';
import 'package:app/new_signup/new_register.dart';
import 'package:app/provider/edit_provider.dart';
import 'package:app/provider/navigation_index_provider.dart';
import 'package:app/sign_up/sign_in.dart';
import 'package:app/widgets/loading_widget.dart';
import 'package:app/widgets/my_text.dart';
import 'package:app/widgets/update_page.dart';
import 'package:app_links/app_links.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/get_country.dart';

class BottomNavigation extends StatefulWidget {
  final Widget child;
  const BottomNavigation({super.key, required this.child});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  //int index = 0;
  String userId = "";

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
  List<String> languageList = ["English", "Arabic"];
  List<String> languageImage = [
    'images/great_britain.png',
    'images/ksa_flag.png'
  ];
  String language = "";

  @override
  void initState() {
    super.initState();
    if (Constants.userId == 0) {
      getCountries();
    } else {
      getNotificatioNumber();
    }

    // index = context.read<ServicesProvider>().homeIndex;
    Constants.getFilter();
    getVersion();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checkAppLink(String link) {
    if (link.isNotEmpty) {
      context.read<EditProvider>().clearAppLink();
      Timer(Duration(seconds: 3), () {
        context.push(link);
      });
    }
  }

  void getNotificatioNumber() {
    // Provider.of<NavigationIndexProvider>(context, listen: false)
    //     .getNotificationBadge();
    Provider.of<NavigationIndexProvider>(context, listen: false)
        .getCounterChat(Constants.userId.toString());
  }

  Future getCountries() async {
    var response =
        await http.get(Uri.parse("${Constants.baseUrl}/api/v1/get_countries"));
    if (response.statusCode == 200) {
      setState(() {
        loading = true;
      });
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
      showSelectLanguage();
      //   _getCurrentPosition();
    }
  }

  void addCountry(String country, int id, String flag, String countryCurrency,
      context) async {
    // clearAll();
    Navigator.of(context).pop();
    // updateCountryId(id);
    SharedPreferences prefs = await Constants.getPrefs();
    prefs.setInt("countryId", id);
    prefs.setString("country", country);
    prefs.setString("countryFlag", flag);
    setState(() {
      Constants.countryId = id;
      Constants.country = country;
      userCountry = country;
      Constants.countryFlag = flag;
      Constants.countryCurrency = countryCurrency;
    });
    Constants.getFilter();
    checkCountry();
    // homePage();
  }

  void showSelectLanguage() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => PopScope(
                child: SimpleDialog(
              contentPadding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: const Icon(
                Icons.translate,
                size: 80,
                color: bluishColor,
              ),
              children: [
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: MyText(
                    text: "Select Preferred Language",
                    size: 18,
                    weight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                for (int i = 0; i < languageList.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Card(
                      child: ListTile(
                        onTap: () => changeLanguage(languageList[i]),
                        leading: Image(
                          image: ExactAssetImage(languageImage[i]),
                          height: 40,
                          width: 60,
                        ),
                        title: Text(
                          languageList[i],
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )));
  }

  void changeLanguage(String lang) {
    Navigator.of(context).pop();
    if (lang == "English") {
      context.setLocale(const Locale('en', 'US'));
      Constants.language = "en";
    } else if (lang == "Arabic") {
      context.setLocale(const Locale('ar', 'SA'));
      Constants.language = "ar";
    }
    showConfirmation();
  }

  void showConfirmation() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => PopScope(
              canPop: false,
              child: SimpleDialog(
                contentPadding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: const Icon(
                  Icons.notifications,
                  size: 80,
                  color: bluishColor,
                ),
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: MyText(
                      text: "selectYourCountry".tr(),
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
                      leading: CachedNetworkImage(
                        width: 40,
                        height: 25,
                        imageUrl:
                            "${"${Constants.baseUrl}/public/"}${countriesList1[index].flag}",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          size: 25,
                        ),
                      ),
                      // leading: Image.network(
                      //   "${"${Constants.baseUrl}/public/"}${countriesList1[index].flag}",
                      //   height: 25,
                      //   width: 40,
                      // ),
                      title: Text(countriesList1[index].country.tr()),
                      onTap: () {
                        addCountry(
                            filteredServices[index].country,
                            filteredServices[index].id,
                            filteredServices[index].flag,
                            filteredServices[index].currency,
                            ctx);
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
              ),
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
    //countriesList1.forEach((element) {
    for (int i = 0; i < countriesList1.length; i++) {
      if (countriesList1[i].country == userCountry) {
        getC(countriesList1[i].country, countriesList1[i].id,
            countriesList1[i].flag, countriesList1[i].code, false);
        //setState(() {
        selectedCountry == countriesList1[i].country;
        countryCode == countriesList1[i].code;
        Constants.country = selectedCountry;
        Constants.countryFlag = countriesList1[i].flag;
        Constants.countryId = countriesList1[i].id;
        Constants.countryCurrency = countriesList1[i].currency;
      }
      // else {
      //   countriesList1[i].country == "OMAN";
      //   getC(countriesList1[i].country, countriesList1[i].id,
      //       countriesList1[i].flag, countriesList1[i].code, false);
      //   //setState(() {
      //   selectedCountry == countriesList1[i].country;
      //   countryCode == countriesList1[i].code;
      //   Constants.country = selectedCountry;
      //   Constants.countryFlag = countriesList1[i].flag;
      //   Constants.countryId = countriesList1[i].id;
      //   Constants.countryCurrency = countriesList1[i].currency;
      // }
    }
    // for (GetCountryModel country in countriesList1) {
    //   if (country.country == userCountry) {

    //     return; // Break the loop once the country is found
    //   } else {
    //     if (country.country != userCountry) {
    //       if (country.country == "OMAN") {

    //       }
    //       // });
    //     }
    //     // Navigator.of(context).pop();
    //   }
    // }
    // Navigator.of(context).pop();
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
        //selectedCountry
        userCountry = country;
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
    context.push('/signIn');
    // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //   return const SignIn();
    // }));
  }

  void navRegister() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const NewRegister();
    }));
  }

  @override
  Widget build(BuildContext context) {
    int index = Provider.of<NavigationIndexProvider>(context).homeIndex;
    int totalBooking =
        Provider.of<NavigationIndexProvider>(context, listen: true)
            .totalBookings;
    int account = Provider.of<NavigationIndexProvider>(context, listen: true)
        .totalAccount;
    String appLink = context.watch<EditProvider>().appLink;
    if (appLink.isNotEmpty) {
      checkAppLink(appLink);
    }
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
                        text: totalBooking,
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
                totalBooking > 0
                    ? Positioned(
                        top: -5,
                        right: -12,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: redColor,
                          child: MyText(
                            text: totalBooking.toString(),
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
              account > 0
                  ? Positioned(
                      top: -5,
                      right: -6,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: redColor,
                        child: MyText(
                          text: account, //'12',
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
                        text: account, //'12',
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
