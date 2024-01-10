// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:adventuresclub/become_a_partner/become_partner.dart';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/about_us.dart';
import 'package:adventuresclub/home_Screens/accounts/client_requests.dart';
import 'package:adventuresclub/home_Screens/accounts/contact_us.dart';
import 'package:adventuresclub/home_Screens/accounts/favorite.dart';
import 'package:adventuresclub/home_Screens/accounts/my_points.dart';
import 'package:adventuresclub/home_Screens/accounts/my_services.dart';
import 'package:adventuresclub/home_Screens/accounts/notifications.dart';
import 'package:adventuresclub/home_Screens/accounts/profile/profile.dart';
import 'package:adventuresclub/home_Screens/accounts/health_condition.dart';
import 'package:adventuresclub/home_Screens/accounts/settings/settings.dart';
import 'package:adventuresclub/home_Screens/invite_friends.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:adventuresclub/models/profile_models/profile_become_partner.dart';
import 'package:adventuresclub/models/user_profile_model.dart';
import 'package:adventuresclub/provider/navigation_index_provider.dart';
import 'package:adventuresclub/sign_up/sign_in.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/null_user_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/get_country.dart';
import '../../models/packages_become_partner/packages_become_partner_model.dart';
import '../../new_signup/new_register.dart';
import '../../provider/services_provider.dart';
import '../become_partner/become_partner_packages.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  TextEditingController searchController = TextEditingController();
  List<String> images = [
    'images/heart.png',
    'images/notification.png',
    'images/points.png'
  ];
  List<String> partnerImages = [
    'images/heart.png',
    'images/newservice.png',
    'images/newrequest.png'
  ];
  List<String> text = ["favorite", 'myServices', 'clientRequests'];
  List<String> userText = ["favorite", 'Notification', 'My Points'];
  List<String> tile1 = [
    'images/points.png',
    'images/healthCondition.png',
    'images/notification.png',
    'images/about.png',
    'images/notification.png',
    'images/about.png',
    'images/phone.png',
    'images/logout.png',
  ];
  List<String> tile1Text = [
    "myPoints",
    "healthCondition",
    "notification",
    "changeLanguage",
    "addCountry",
    "aboutUs",
    "contactUs",
    "logOut",
  ];
  List<String> userListText = [
    "healthCondition",
    "settings",
    "changeLanguage",
    "addCountry",
    "inviteFriends",
    "aboutUs",
    "serviceQuality",
    "contactUs",
    "logOut",
    //'Log out',
  ];
  List<String> userListIcon = [
    'images/healthCondition.png',
    'images/gear.png',
    'images/about.png',
    'images/notification.png',
    'images/envelope.png',
    'images/about.png',
    'images/payment.png',
    'images/phone.png',
    'images/logout.png',
  ];
  String status = "";
  String firstName = "";
  String profileUrl = "";
  String lastName = "";
  ProfileBecomePartner gBp = ProfileBecomePartner(0, 0, "", "", "", "", "", "",
      "", "", 0, 0, "", "", "", "", "", "", "", 0, "", "", "", "", "", "");
  String resultService = "";
  String resultRequest = "";
  String totalNotication = "";
  bool loading = false;
  bool firstCount = true;
  List<PackagesBecomePartnerModel> packageList = [];
  List<PackagesBecomePartnerModel> subpackageList = [];
  DateTime today = DateTime.now();
  DateTime expiryDate = DateTime.now();
  bool expired = false;
  String selectedCountry = "Country Location";
  List<GetCountryModel> countriesList1 = [];
  List<GetCountryModel> filteredServices = [];
  Map mapCountry = {};
  static ProfileBecomePartner pbp = ProfileBecomePartner(
      0,
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      0,
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
      "",
      "");
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
  String selectedLanguage = "";
  @override
  void initState() {
    super.initState();
    getProfile();
    //  convert();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void requestSent() async {
    //if (widget.gm.sPlan == 1 && text1[index] == "Availability")
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Center(
            child: Text(
              "Your request for became partner is already submitted Please check notification section for approval",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        children: [
          MaterialButton(
              onPressed: cancel, child: MyText(text: "Ok", color: blackColor))
        ],
      ),
    );
  }

  void getProfile() async {
    if (loading) {
      return;
    }
    setState(() {
      loading = true;
    });
    SharedPreferences prefs = await Constants.getPrefs();
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/login"), body: {
        'email': Constants.emailId, //"hamza@gmail.com",
        'password': Constants.password, //"Upendra@321",
        'device_id': "0"
      });
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

      profile = up;
      Constants.userRole = up.userRole;
      prefs.setString("userRole", up.userRole);
      // setState(() {
      //   loading = false;
      // });
      convert();
    } catch (e) {
      print(e.toString());
    }
  }

  void convert() async {
    await getCountries();
    if (profile.userRole == "2" && profile.bp.endDate != "null") {
      // setState(() {
      //   loading = true;
      // });
      if (profile.bp.endDate.isNotEmpty) {
        DateTime dt = DateTime.parse(profile.bp.endDate);
        if (today.year > dt.year) {
          //setState(() {
          //loading = false;
          expired = true;
          Constants.expired = true;
          // });
        } else if (today.year == dt.year && today.month > dt.month) {
          // setState(() {
          // loading = false;
          expired = true;
          Constants.expired = true;
          //});
        } else if (today.year == dt.year &&
            today.month == dt.month &&
            today.day > dt.day) {
          //setState(() {
          // loading = false;
          expired = true;
          Constants.expired = true;
          // });
        } else {
          //loading = false;
          expired = false;
          Constants.expired = false;
        }
      }
    }
    setState(() {
      loading = false;
    });
    print(expired);
    print(Constants.expired);
  }

  void goToProfile(bool expired, String role) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return Profile(expired, role);
        },
      ),
    );
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

  void logout() async {
    await Constants.clear();
    clearData();
    changeIndex();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) {
          return const SignIn();
        },
      ),
      (route) => false,
    );
  }

  void clearData() {
    profile.bp.paypal = "";
    profile.bp.accountHoldername = "";
    profile.bp.accountNumber = "";
    profile.bp.address = "";
    profile.bp.bankName = "";
    profile.bp.ca = "";
    profile.bp.companyName = "";
    profile.bp.crCopy = "";
    profile.bp.crName = "";
    profile.bp.crNumber = "";
    profile.bp.debitCard = 0;
    profile.bp.description = "";
    profile.bp.endDate = "";
    profile.bp.id = 0;
    profile.bp.isApproved = "";
    profile.bp.isFreeUsed = "";
    profile.bp.visaCard = 0;
    profile.bp.userId = 0;
    profile.bp.ua = "";
    profile.bp.packagesId = 0;
    profile.bp.isWiretransfer = "";
  }

  void getList() async {
    await Constants.getPackagesApi();
    setState(() {
      packageList = Constants.gBp;
    });
    //subpackageList = packageList.;
    //packagesList(Constants.gBp);
  }

  void packagesList() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const BecomePartnerPackages();
        },
      ),
    );
  }

  void ex() async {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Text(
                "Alert",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Your Subscription exprired. Please renew to extend the subscription",
                style: TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () => packagesList1(false),
                    child: MyText(
                      text: "Yes",
                      weight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                  MaterialButton(
                    onPressed: cancel,
                    child: MyText(
                      text: "No",
                      weight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void packagesList1(bool s) {
    //cancel();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return BecomePartnerPackages(
            // bp,
            show: s,
          );
        },
      ),
    );
  }

  void changeLanguage(String lang) {
    if (lang == "English") {
      context.setLocale(const Locale('en', 'US'));
    } else if (lang == "Arabic") {
      context.setLocale(const Locale('ar', 'SA'));
    }
  }

  void clearAll() {
    Provider.of<ServicesProvider>(context, listen: false).clearAll();
  }

  void updateCountryId(int id) async {
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/updateCountry"), body: {
        'user_id': Constants.userId.toString(), //ccCode.toString(),
        'country_id': id.toString(),
      });
      print(response.statusCode);
    } catch (e) {
      print(e.toString());
    }
  }

  void addCountry(
      String country, int id, String flag, String countryCurrency) async {
    clearAll();
    Navigator.of(context).pop();
    updateCountryId(id);
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
    homePage();
  }

  void homePage() {
    changeIndex();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const BottomNavigation();
    }));
  }

  Future getCountries() async {
    filteredServices.clear();
    countriesList1.clear();
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
      // if (mounted) {
      // setState(() {
      filteredServices = countriesList1;
      // });
      // }
    }
  }

  void showPicker() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
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
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
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
                          contentPadding: const EdgeInsets.symmetric(
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
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: greyColor.withOpacity(0.2)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: greyColor.withOpacity(0.2)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: greyColor.withOpacity(0.2)),
                          ),
                        ),
                      )),
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
                        title: Text(filteredServices[index].country),
                        onTap: () {
                          addCountry(
                              filteredServices[index].country,
                              filteredServices[index].id,
                              filteredServices[index].flag,
                              filteredServices[index].currency);
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
  }

  void getPopUp() {
    PopupMenuButton<String>(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: Row(
            children: [
              const Icon(Icons.arrow_drop_down),
              MyText(
                text: selectedLanguage,
                color: blackColor,
              ),
            ],
          )),
      onSelected: (String item) {
        setState(() {
          selectedLanguage = item;
        });
        changeLanguage(item);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: "English",
          child: Text('English'),
        ),
        const PopupMenuItem<String>(
          value: "Arabic",
          child: Text('عربي'),
        ),
      ],
    );
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Constants.userId == 0
            ? const NullUserContainer()
            : loading
                ? Center(
                    child: MyText(
                    text: "loading".tr(),
                    weight: FontWeight.bold,
                    size: 16,
                    color: blackColor,
                  ))
                : ListView(
                    children: [
                      const SizedBox(
                        height: 2,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          if (profile.userRole == "3")
                            Column(
                              children: [
                                Container(
                                  color: transparentColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      loading
                                          ? Text("loading".tr())
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                MyText(
                                                  text: profile
                                                      .name, //'Kenneth Gutierrez',
                                                  color: blackColor,
                                                  weight: FontWeight.bold,
                                                  size: 22,
                                                  fontFamily: "Raleway",
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (_) {
                                                      return const BecomePartnerNew();
                                                    }));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      MyText(
                                                        text:
                                                            'Become A partner',
                                                        size: 16,
                                                        //fontFamily: 'Raleway',
                                                        weight: FontWeight.w600,
                                                        color: greyColor
                                                            .withOpacity(1),
                                                      ),
                                                      const Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: bluishColor,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                      profileUrl != null
                                          ? GestureDetector(
                                              onTap: () => goToProfile(
                                                  expired, profile.userRole),
                                              child: CircleAvatar(
                                                radius: 38,
                                                backgroundImage: NetworkImage(
                                                    "${'${Constants.baseUrl}/public/'}${profile.profileImage}"),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () => goToProfile(
                                                  expired, profile.userRole),
                                              child: CircleAvatar(
                                                radius: 38,
                                                backgroundImage:
                                                    NetworkImage(profileUrl),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 10,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          for (int i = 0; i < 3; i++)
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (userText[i] ==
                                                        "favorite") {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (_) {
                                                            return const Favorite();
                                                          },
                                                        ),
                                                      );
                                                    }
                                                    if (userText[i] ==
                                                        'Notification') {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (_) {
                                                            return const Notifications();
                                                          },
                                                        ),
                                                      );
                                                    }
                                                    if (userText[i] ==
                                                        'My Points') {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (_) {
                                                            return const MyPoints();
                                                          },
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Image(
                                                        image: ExactAssetImage(
                                                            images[i]),
                                                        height: 30,
                                                        width: 30,
                                                      ),
                                                      Constants.totalNotication >
                                                                  0 &&
                                                              text[i] ==
                                                                  'Notifications'
                                                          ? Positioned(
                                                              bottom: -5,
                                                              right: -12,
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 10,
                                                                backgroundColor:
                                                                    redColor,
                                                                child: MyText(
                                                                  text: Constants
                                                                      .resultService
                                                                      .toString(), //'12',
                                                                  color:
                                                                      whiteColor,
                                                                  weight:
                                                                      FontWeight
                                                                          .bold,
                                                                  size: 9,
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox()
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                MyText(
                                                  text: userText[i],
                                                  color:
                                                      greyColor.withOpacity(1),
                                                  weight: FontWeight.bold,
                                                )
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (profile.bp.packagesId == 0 &&
                              profile.bp.isApproved == "0" &&
                              profile.userRole == "2")
                            Column(
                              children: [
                                Container(
                                  color: transparentColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      loading
                                          ? Text("loading".tr())
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  profile.name,
                                                  style: const TextStyle(
                                                      fontSize: 22,
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // MyText(
                                                //   text: profile
                                                //       .name, //'Kenneth Gutierrez',
                                                //   color: blackColor,
                                                //   weight: FontWeight.bold,
                                                //   size: 22,
                                                //   fontFamily: "Raleway",
                                                // ),
                                                GestureDetector(
                                                  onTap: requestSent,
                                                  // () {
                                                  //   Navigator.of(context)
                                                  //       .push(MaterialPageRoute(builder: (_) {
                                                  //     return const BecomePartnerNew();
                                                  //   }));
                                                  // },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      MyText(
                                                        text:
                                                            'Become A partner',
                                                        size: 18,
                                                        //fontFamily: 'Raleway',
                                                        weight: FontWeight.w600,
                                                        color: greyColor
                                                            .withOpacity(1),
                                                      ),
                                                      const Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: bluishColor,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                      profileUrl != null
                                          ? GestureDetector(
                                              onTap: () => goToProfile(
                                                  expired, profile.userRole),
                                              child: CircleAvatar(
                                                radius: 38,
                                                backgroundImage: NetworkImage(
                                                    "${'${Constants.baseUrl}/public/'}${profile.profileImage}"),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () => goToProfile(
                                                  expired, profile.userRole),
                                              child: CircleAvatar(
                                                radius: 38,
                                                backgroundImage:
                                                    NetworkImage(profileUrl),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          for (int i = 0; i < 3; i++)
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (userText[i] ==
                                                        "favorite".tr()) {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (_) {
                                                            return const Favorite();
                                                          },
                                                        ),
                                                      );
                                                    }
                                                    if (userText[i] ==
                                                        'notification'.tr()) {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (_) {
                                                            return const Notifications();
                                                          },
                                                        ),
                                                      );
                                                    }
                                                    if (userText[i] ==
                                                        'myPoints'.tr()) {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (_) {
                                                            return const MyPoints();
                                                          },
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Image(
                                                        image: ExactAssetImage(
                                                            images[i]),
                                                        height: 30,
                                                        width: 30,
                                                      ),
                                                      Constants.totalNotication >
                                                                  0 &&
                                                              text[i] ==
                                                                  'notifications'
                                                                      .tr()
                                                          ? Positioned(
                                                              bottom: -5,
                                                              right: -12,
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 10,
                                                                backgroundColor:
                                                                    redColor,
                                                                child: MyText(
                                                                  text: Constants
                                                                      .resultService
                                                                      .toString(), //'12',
                                                                  color:
                                                                      whiteColor,
                                                                  weight:
                                                                      FontWeight
                                                                          .bold,
                                                                  size: 9,
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox()
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                MyText(
                                                  text: userText[i].tr(),
                                                  color:
                                                      greyColor.withOpacity(1),
                                                  weight: FontWeight.bold,
                                                )
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (profile.bp.packagesId == 0 &&
                              profile.bp.isApproved == "1" &&
                              profile.userRole == "2")
                            Column(
                              children: [
                                Container(
                                  color: transparentColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      loading
                                          ? Text("loading".tr())
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  profile.name,
                                                  style: const TextStyle(
                                                      fontSize: 22,
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                GestureDetector(
                                                  onTap: () => packagesList1(
                                                      true), //requestSent,
                                                  // () {
                                                  //   Navigator.of(context)
                                                  //       .push(MaterialPageRoute(builder: (_) {
                                                  //     return const BecomePartnerNew();
                                                  //   }));
                                                  // },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      MyText(
                                                        text:
                                                            'Become A partner',
                                                        size: 18,
                                                        //fontFamily: 'Raleway',
                                                        weight: FontWeight.w600,
                                                        color: greyColor
                                                            .withOpacity(1),
                                                      ),
                                                      const Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: bluishColor,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                      profileUrl.isEmpty
                                          ? GestureDetector(
                                              onTap: () => goToProfile(
                                                  expired, profile.userRole),
                                              child: CircleAvatar(
                                                radius: 38,
                                                backgroundImage: NetworkImage(
                                                    "${'${Constants.baseUrl}/public/'}${profile.profileImage}"),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () => goToProfile(
                                                  expired, profile.userRole),
                                              child: CircleAvatar(
                                                radius: 38,
                                                backgroundImage:
                                                    NetworkImage(profileUrl),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          for (int i = 0; i < 3; i++)
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (userText[i] ==
                                                        "favorite") {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (_) {
                                                            return const Favorite();
                                                          },
                                                        ),
                                                      );
                                                    }
                                                    if (userText[i] ==
                                                        'notification') {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (_) {
                                                            return const Notifications();
                                                          },
                                                        ),
                                                      );
                                                    }
                                                    if (userText[i] ==
                                                        'myPoints') {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (_) {
                                                            return const MyPoints();
                                                          },
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Image(
                                                        image: ExactAssetImage(
                                                            images[i]),
                                                        height: 30,
                                                        width: 30,
                                                      ),
                                                      Constants.totalNotication >
                                                                  0 &&
                                                              text[i] ==
                                                                  'notifications'
                                                          ? Positioned(
                                                              bottom: -5,
                                                              right: -12,
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 10,
                                                                backgroundColor:
                                                                    redColor,
                                                                child: MyText(
                                                                  text: Constants
                                                                      .resultService
                                                                      .toString(), //'12',
                                                                  color:
                                                                      whiteColor,
                                                                  weight:
                                                                      FontWeight
                                                                          .bold,
                                                                  size: 9,
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox()
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                MyText(
                                                  text: userText[i].tr(),
                                                  color:
                                                      greyColor.withOpacity(1),
                                                  weight: FontWeight.bold,
                                                )
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (profile.bp.packagesId > 0 &&
                                  profile.bp.isApproved == "1" &&
                                  profile.userRole == "2"
                              // &&
                              // expired == false
                              )
                            if (expired &&
                                profile.bp.isApproved == "1" &&
                                profile.userRole == "2" &&
                                profile.bp.packagesId > 0)
                              Column(
                                children: [
                                  Container(
                                    color: transparentColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        loading
                                            ? Text("loading".tr())
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    profile.name,
                                                    style: const TextStyle(
                                                        fontSize: 22,
                                                        color: blackColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  GestureDetector(
                                                    onTap: ex,
                                                    // () {
                                                    //   Navigator.of(context)
                                                    //       .push(MaterialPageRoute(builder: (_) {
                                                    //     return const BecomePartnerNew();
                                                    //   }));
                                                    // },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        MyText(
                                                          text:
                                                              'Your Subscription expired',
                                                          size: 18,
                                                          //fontFamily: 'Raleway',
                                                          weight:
                                                              FontWeight.w600,
                                                          color: greyColor
                                                              .withOpacity(1),
                                                        ),
                                                        const Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: bluishColor,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  MyText(
                                                    text:
                                                        "${"Your Plan expired on "}${profile.bp.endDate}",
                                                    //"${" before "}${profile.bp.endDate}", //'Kenneth Gutierrez',
                                                    color: redColor,
                                                    weight: FontWeight.bold,
                                                    size: 14,
                                                    fontFamily: "Raleway",
                                                  ),
                                                ],
                                              ),
                                        profileUrl != null
                                            ? GestureDetector(
                                                onTap: () => goToProfile(
                                                    expired, profile.userRole),
                                                child: CircleAvatar(
                                                  radius: 35,
                                                  backgroundImage: NetworkImage(
                                                      "${'${Constants.baseUrl}/public/'}${profile.profileImage}"),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () => goToProfile(
                                                    expired, profile.userRole),
                                                child: CircleAvatar(
                                                  radius: 35,
                                                  backgroundImage:
                                                      NetworkImage(profileUrl),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Card(
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            for (int i = 0; i < 3; i++)
                                              Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (text[i] ==
                                                          "favorite") {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (_) {
                                                              return const Favorite();
                                                            },
                                                          ),
                                                        );
                                                      }
                                                      if (text[i] ==
                                                          'myServices') {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (_) {
                                                              return const MyServices();
                                                            },
                                                          ),
                                                        );
                                                      }
                                                      if (text[i] ==
                                                          'clientRequests') {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (_) {
                                                              return const ClientsRequests();
                                                            },
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    child: Stack(
                                                      clipBehavior: Clip.none,
                                                      children: [
                                                        Image(
                                                          image:
                                                              ExactAssetImage(
                                                                  partnerImages[
                                                                      i]),
                                                          height: 30,
                                                          width: 30,
                                                        ),
                                                        Constants.resultRequest >
                                                                    0 &&
                                                                text[i] ==
                                                                    'clientRequests'
                                                            ? Positioned(
                                                                bottom: -5,
                                                                right: -12,
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 10,
                                                                  backgroundColor:
                                                                      redColor,
                                                                  child: MyText(
                                                                    text: Constants
                                                                        .resultRequest
                                                                        .toString(), //'12',
                                                                    color:
                                                                        whiteColor,
                                                                    weight:
                                                                        FontWeight
                                                                            .bold,
                                                                    size: 9,
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox(),
                                                        Constants.resultService >
                                                                    0 &&
                                                                text[i] ==
                                                                    'myServices'
                                                            ? Positioned(
                                                                bottom: -5,
                                                                right: -12,
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 10,
                                                                  backgroundColor:
                                                                      redColor,
                                                                  child: MyText(
                                                                    text: Constants
                                                                        .resultService
                                                                        .toString(), //'12',
                                                                    color:
                                                                        whiteColor,
                                                                    weight:
                                                                        FontWeight
                                                                            .bold,
                                                                    size: 9,
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox()
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  MyText(
                                                    text: text[i],
                                                    color: greyColor
                                                        .withOpacity(1),
                                                    weight: FontWeight.bold,
                                                  )
                                                ],
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          if (expired == false &&
                              profile.bp.isApproved == "1" &&
                              profile.userRole == "2" &&
                              profile.bp.packagesId > 0)
                            Column(
                              children: [
                                Container(
                                  color: transparentColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      loading
                                          ? Text("loading".tr())
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                MyText(
                                                  text: Constants.profile
                                                      .name, //'Kenneth Gutierrez',
                                                  color: blackColor,
                                                  weight: FontWeight.bold,
                                                  size: 20,
                                                  fontFamily: "Raleway",
                                                ),
                                                GestureDetector(
                                                  onTap: packagesList,
                                                  // () {
                                                  //   Navigator.of(context)
                                                  //       .push(MaterialPageRoute(builder: (_) {
                                                  //     return const BecomePartnerNew();
                                                  //   }));
                                                  // },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      MyText(
                                                        text: 'alreadyPartner'
                                                            .tr(),
                                                        size: 18,
                                                        //fontFamily: 'Raleway',
                                                        weight: FontWeight.w600,
                                                        color: greyColor
                                                            .withOpacity(1),
                                                      ),
                                                      const Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: bluishColor,
                                                        size: 16,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                MyText(
                                                  text:
                                                      "${"renewBefore".tr()}${profile.bp.endDate.substring(0, 11)}${"toAvoidInterruption".tr()}", //'Kenneth Gutierrez',
                                                  color: redColor,
                                                  weight: FontWeight.bold,
                                                  size: 12,
                                                  fontFamily: "Raleway",
                                                ),
                                              ],
                                            ),
                                      profileUrl != null
                                          ? GestureDetector(
                                              onTap: () => goToProfile(
                                                  expired, profile.userRole),
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundImage: NetworkImage(
                                                    "${'${Constants.baseUrl}/public/'}${profile.profileImage}"),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () => goToProfile(
                                                  expired, profile.userRole),
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundImage:
                                                    NetworkImage(profileUrl),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          for (int i = 0; i < 3; i++)
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (text[i] == "favorite") {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (_) {
                                                            return const Favorite();
                                                          },
                                                        ),
                                                      );
                                                    }
                                                    if (text[i] ==
                                                        'myServices') {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (_) {
                                                            return const MyServices();
                                                          },
                                                        ),
                                                      );
                                                    }
                                                    if (text[i] ==
                                                        'clientRequests') {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (_) {
                                                            return const ClientsRequests();
                                                          },
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Image(
                                                        image: ExactAssetImage(
                                                            partnerImages[i]),
                                                        height: 30,
                                                        width: 30,
                                                      ),
                                                      Constants.resultRequest >
                                                                  0 &&
                                                              text[i] ==
                                                                  'clientRequests'
                                                          ? Positioned(
                                                              bottom: -5,
                                                              right: -12,
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 10,
                                                                backgroundColor:
                                                                    redColor,
                                                                child: MyText(
                                                                  text: Constants
                                                                      .resultRequest
                                                                      .toString(), //'12',
                                                                  color:
                                                                      whiteColor,
                                                                  weight:
                                                                      FontWeight
                                                                          .bold,
                                                                  size: 9,
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      Constants.resultService >
                                                                  0 &&
                                                              text[i] ==
                                                                  'myServices'
                                                          ? Positioned(
                                                              bottom: -5,
                                                              right: -12,
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 10,
                                                                backgroundColor:
                                                                    redColor,
                                                                child: MyText(
                                                                  text: Constants
                                                                      .resultService
                                                                      .toString(), //'12',
                                                                  color:
                                                                      whiteColor,
                                                                  weight:
                                                                      FontWeight
                                                                          .bold,
                                                                  size: 9,
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox()
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                MyText(
                                                  text: text[i],
                                                  color:
                                                      greyColor.withOpacity(1),
                                                  weight: FontWeight.bold,
                                                )
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          // if (Constants.profile.bp.packagesId == 0 &&
                          //     Constants.profile.bp.isApproved == "")
                          //   GestureDetector(
                          //     // onTap: getProfile,
                          //     child: Container(
                          //       color: transparentColor,
                          //       padding: const EdgeInsets.symmetric(horizontal: 15),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           loading
                          //               ? const Text("Loading")
                          //               : Column(
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: [
                          //                     MyText(
                          //                       text: Constants.profile
                          //                           .name, //'Kenneth Gutierrez',
                          //                       color: blackColor,
                          //                       weight: FontWeight.bold,
                          //                       size: 22,
                          //                       fontFamily: "Raleway",
                          //                     ),
                          //                     GestureDetector(
                          //                       onTap: () {
                          //                         Navigator.of(context).push(
                          //                             MaterialPageRoute(builder: (_) {
                          //                           return const BecomePartnerNew();
                          //                         }));
                          //                       },
                          //                       child: Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.start,
                          //                         children: [
                          //                           MyText(
                          //                             text: 'Become A partner',
                          //                             size: 16,
                          //                             //fontFamily: 'Raleway',
                          //                             weight: FontWeight.w600,
                          //                             color: greyColor.withOpacity(1),
                          //                           ),
                          //                           const Icon(
                          //                             Icons.arrow_forward_ios,
                          //                             color: bluishColor,
                          //                           )
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //           profileUrl != null
                          //               ? GestureDetector(
                          //                   onTap: () => goToProfile(
                          //                       expired, Constants.userRole),
                          //                   child: const CircleAvatar(
                          //                     radius: 38,
                          //                     backgroundImage: ExactAssetImage(
                          //                         'images/avatar2.png'),
                          //                   ),
                          //                 )
                          //               : GestureDetector(
                          //                   onTap: () => goToProfile(
                          //                       expired, Constants.userRole),
                          //                   child: CircleAvatar(
                          //                     radius: 38,
                          //                     backgroundImage:
                          //                         NetworkImage(profileUrl),
                          //                   ),
                          //                 ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                        ],
                      ),
                      if (profile.userRole == "2")
                        Wrap(
                          children: List.generate(
                            tile1.length,
                            (index) {
                              return ListTile(
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -3),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                horizontalTitleGap: 2,
                                onTap: (() {
                                  if (tile1Text[index] == 'myPoints') {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (_) {
                                      return const MyPoints();
                                    }));
                                  }
                                  if (tile1Text[index] == 'healthCondition') {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (_) {
                                      return const HealthCondition();
                                    }));
                                  }
                                  if (tile1Text[index] == 'notification') {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (_) {
                                      return const Notifications();
                                    }));
                                  }
                                  //  if(tile1Text[index] == 'Payment'){
                                  //   Navigator.of(context).push(MaterialPageRoute(builder: (_){
                                  //     return const Payment();
                                  //   }));
                                  //  }
                                  //   if(tile1Text[index] == 'Category'){
                                  //   Navigator.of(context).push(MaterialPageRoute(builder: (_){
                                  //     return const AdventureCategory();
                                  //   }));
                                  //  }
                                  //  if(tile1Text[index] == 'Packages'){
                                  //   Navigator.of(context).push(MaterialPageRoute(builder: (_){
                                  //     return const ContactUs();
                                  //   }));
                                  //  }
                                  if (tile1Text[index] == 'settings') {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) {
                                          return const Settings();
                                        },
                                      ),
                                    );
                                  }
                                  // if (tile1Text[index] == 'changeLanguage') {
                                  //   Navigator.of(context).push(
                                  //     MaterialPageRoute(
                                  //       builder: (_) {
                                  //         return const Settings();
                                  //       },
                                  //     ),
                                  //   );
                                  // }
                                  if (tile1Text[index] == 'addCountry') {
                                    showPicker();
                                    // Navigator.of(context).push(Material)
                                    // pickCountry(context, 'countryLocation'.tr());
                                  }
                                  if (tile1Text[index] == 'inviteFriends') {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) {
                                          return const InviteFriends();
                                        },
                                      ),
                                    );
                                  }
                                  if (tile1Text[index] == 'aboutUs') {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (_) {
                                        return const AboutUs();
                                      }),
                                    );
                                  }
                                  if (tile1Text[index] == 'contactUs') {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) {
                                          return const ContactUs();
                                          //const MyServicesAdDetails();
                                        },
                                      ),
                                    );
                                  }
                                  if (tile1Text[index] == 'logOut') {
                                    showConfirmation("logOut", "wantToLogOut");
                                  }
                                  if (tile1Text[index] == "deleteAccount") {
                                    showConfirmation(
                                        "deleteAccount", "wantToDelete");
                                  }
                                }),
                                leading:
                                    Stack(clipBehavior: Clip.none, children: [
                                  Image(
                                    image: ExactAssetImage(tile1[index]),
                                    height: tile1Text[index] == 'myPoints'
                                        ? 35
                                        : 25,
                                    width: 35,
                                    color: greyColor.withOpacity(1),
                                  ),
                                  tile1Text[index] == 'notification'
                                      ? Positioned(
                                          top: -8,
                                          right: -3,
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor: redColor,
                                            child: MyText(
                                              text: Constants
                                                  .totalNotication, //'12',
                                              color: whiteColor,
                                              weight: FontWeight.bold,
                                              size: 9,
                                            ),
                                          ),
                                        )
                                      : const SizedBox()
                                ]),
                                title: Text(
                                  tile1Text[index].tr(),
                                  style: const TextStyle(
                                      color: greyColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                                // MyText(
                                //   text: tile1Text[index],
                                //   color: greyColor.withOpacity(1),
                                //   size: 15,
                                //   weight: FontWeight.w700,
                                // ),
                                trailing: tile1Text[index] ==
                                        'addCountry' //settings
                                    ? SizedBox(
                                        width: Constants.country.length > 11
                                            ? 140
                                            : 100,
                                        //60,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            MyText(
                                              text: Constants.country, //'OMAN',
                                              color: greyColor.withOpacity(0.9),
                                              weight: FontWeight.bold,
                                            ),
                                            Image.network(
                                              "${"${Constants.baseUrl}/public/"}${Constants.countryFlag}",
                                              height: 15,
                                              width: 30,
                                            ),
                                          ],
                                        ),
                                      )
                                    : tile1Text[index] ==
                                            'changeLanguage' //settings
                                        ? Container(
                                            width: 90,
                                            height: 50,
                                            child: PopupMenuButton<String>(
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons
                                                          .arrow_drop_down),
                                                      MyText(
                                                        text: selectedLanguage,
                                                        color: blackColor,
                                                      ),
                                                    ],
                                                  )
                                                  // Icon(
                                                  //   Icons.language_rounded,
                                                  //   color: whiteColor,
                                                  //   size: 60,
                                                  // ),
                                                  ),
                                              onSelected: (String item) {
                                                setState(() {
                                                  selectedLanguage = item;
                                                });
                                                changeLanguage(item);
                                              },
                                              itemBuilder:
                                                  (BuildContext context) =>
                                                      <PopupMenuEntry<String>>[
                                                const PopupMenuItem<String>(
                                                  value: "English",
                                                  child: Text('English'),
                                                ),
                                                const PopupMenuItem<String>(
                                                  value: "Arabic",
                                                  child: Text('عربي'),
                                                ),
                                              ],
                                            ),
                                          )
                                        // IconButton(
                                        //     onPressed: getPopUp,
                                        //     icon: const Icon(Icons.arrow_drop_down))
                                        : const SizedBox(
                                            width: 0,
                                          ),
                              );
                            },
                          ),
                        ),
                      if (profile.userRole == "3")
                        Wrap(
                          children: List.generate(
                            tile1Text.length,
                            (index) {
                              return ListTile(
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -3),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                horizontalTitleGap: 2,
                                onTap: (() {
                                  // if (userListText[index] == 'My Points') {
                                  //   Navigator.of(context)
                                  //       .push(MaterialPageRoute(builder: (_) {
                                  //     return const MyPoints();
                                  //   }));
                                  // }
                                  if (tile1Text[index] == 'healthCondition') {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (_) {
                                      return const HealthCondition();
                                    }));
                                  }
                                  if (tile1Text[index] == 'settings') {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) {
                                          return const Settings();
                                        },
                                      ),
                                    );
                                  }
                                  if (tile1Text[index] == 'addCountry') {
                                    showPicker();
                                  }
                                  if (tile1Text[index] == 'addCountry') {
                                    pickCountry(
                                        context, 'countryLocation'.tr());
                                  }
                                  if (tile1Text[index] == 'inviteFriends') {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) {
                                          return const InviteFriends();
                                        },
                                      ),
                                    );
                                  }
                                  if (tile1Text[index] == 'aboutUs') {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) {
                                          return const AboutUs();
                                        },
                                      ),
                                    );
                                  }
                                  if (tile1Text[index] == 'contactUs') {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) {
                                          return const ContactUs();
                                          //const MyServicesAdDetails();
                                        },
                                      ),
                                    );
                                  }
                                  if (tile1Text[index] == "logOut") {
                                    showConfirmation("logOut", "wantToLogOut");
                                  }
                                }),
                                leading:
                                    Stack(clipBehavior: Clip.none, children: [
                                  Image(
                                    height: 30,
                                    width: 30,
                                    image: ExactAssetImage(userListIcon[index]),
                                  ),
                                ]),
                                title: MyText(
                                  text: tile1Text[index],
                                  color: greyColor.withOpacity(1),
                                  size: 15,
                                  weight: FontWeight.w700,
                                ),
                                trailing: tile1Text[index] ==
                                        'addCountry' //settings
                                    ? SizedBox(
                                        width: Constants.country.length > 11
                                            ? 140
                                            : 100,
                                        //60,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            MyText(
                                              text: Constants.country, //'OMAN',
                                              color: greyColor.withOpacity(0.9),
                                              weight: FontWeight.bold,
                                            ),
                                            Image.network(
                                              "${"${Constants.baseUrl}/public/"}${Constants.countryFlag}",
                                              height: 15,
                                              width: 30,
                                            ),
                                          ],
                                        ),
                                      )
                                    : tile1Text[index] ==
                                            'changeLanguage' //settings
                                        ? Container(
                                            width: 90,
                                            height: 50,
                                            child: PopupMenuButton<String>(
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons
                                                          .arrow_drop_down),
                                                      MyText(
                                                        text: selectedLanguage,
                                                        color: blackColor,
                                                      ),
                                                    ],
                                                  )
                                                  // Icon(
                                                  //   Icons.language_rounded,
                                                  //   color: whiteColor,
                                                  //   size: 60,
                                                  // ),
                                                  ),
                                              onSelected: (String item) {
                                                setState(() {
                                                  selectedLanguage = item;
                                                });
                                                changeLanguage(item);
                                              },
                                              itemBuilder:
                                                  (BuildContext context) =>
                                                      <PopupMenuEntry<String>>[
                                                const PopupMenuItem<String>(
                                                  value: "English",
                                                  child: Text('English'),
                                                ),
                                                const PopupMenuItem<String>(
                                                  value: "Arabic",
                                                  child: Text('عربي'),
                                                ),
                                              ],
                                            ),
                                          )
                                        // IconButton(
                                        //     onPressed: getPopUp,
                                        //     icon: const Icon(Icons.arrow_drop_down))
                                        : const SizedBox(
                                            width: 0,
                                          ),
                              );
                            },
                          ),
                        ),
                      //pickCountry(context, 'countryLocation'.tr()),
                      // GestureDetector(
                      //   //onTap: logout,
                      //   child: Center(
                      //     child: Container(
                      //       height: 40,
                      //       width: 140,
                      //       decoration: BoxDecoration(
                      //           color: const Color.fromARGB(255, 20, 69, 22),
                      //           borderRadius: BorderRadius.circular(12)),
                      //       child: Center(
                      //         child: MyText(
                      //           text: "appVersion".tr(),
                      //           color: whiteColor,
                      //           weight: FontWeight.w600,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 15),
                    ],
                  ),
      ),
    );
  }

  Widget pickCountry(context, String countryName) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
        ),
        child: SizedBox(
          child: ListTile(
            onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: TextField(
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
                                    contentPadding: const EdgeInsets.symmetric(
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
                                  title: Text(filteredServices[index].country),
                                  onTap: () {
                                    addCountry(
                                        filteredServices[index].country,
                                        filteredServices[index].id,
                                        filteredServices[index].flag,
                                        filteredServices[index].currency);
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

            //contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          ),
        ));
  }
}
