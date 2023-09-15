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
import 'package:adventuresclub/models/profile_models/profile_become_partner.dart';
import 'package:adventuresclub/models/user_profile_model.dart';
import 'package:adventuresclub/sign_up/sign_in.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/packages_become_partner/packages_become_partner_model.dart';
import '../../provider/services_provider.dart';
import '../become_partner/become_partner_packages.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List images = [
    'images/heart.png',
    'images/notification.png',
    'images/points.png'
  ];
  List partnerImages = [
    'images/heart.png',
    'images/newservice.png',
    'images/newrequest.png'
  ];
  List text = ["favorite".tr(), 'My Services', 'Client Requests'];
  List userText = ["favorite".tr(), 'Notification', 'My Points'];
  List tile1 = [
    'images/points.png',
    'images/healthCondition.png',
    'images/notification.png',
    'images/payment.png',
    'images/gear.png',
    'images/envelope.png',
    'images/about.png',
    'images/phone.png',
    'images/logout.png',
    'images/notification.png',
  ];
  List tile1Text = [
    'myPoints'.tr(),
    "healthCondition".tr(),
    "notification".tr(),
    "serviceQuality".tr(),
    "settings".tr(),
    "inviteFriends".tr(),
    "aboutUs".tr(),
    "contactUs".tr(),
    "logOut".tr(),
    "deleteAccount".tr(),
  ];
  List userListText = [
    'Health Condition',
    'Settings',
    'Invite Friends',
    'About us',
    'Service & Quality Standards',
    'Contact us',
    "logOut".tr(),
    //'Log out',
  ];
  List userListIcon = [
    'images/healthCondition.png',
    'images/gear.png',
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
    //Constants.getProfile();
    convert();
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
    setState(() {
      loading = true;
    });
    SharedPreferences prefs = await Constants.getPrefs();
    try {
      var response = await http.post(
          Uri.parse("https://adventuresclub.net/adventureClub/api/v1/login"),
          body: {
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
          partnerInfo['company_name'].toString() ?? "",
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
      setState(() {
        loading = false;
      });
      convert();
    } catch (e) {
      print(e.toString());
    }
  }

  void convert() {
    if (profile.userRole == "2" && profile.bp.endDate != "null") {
      setState(() {
        loading = true;
      });
      if (profile.bp.endDate.isNotEmpty) {
        DateTime dt = DateTime.parse(profile.bp.endDate);
        if (today.year > dt.year) {
          setState(() {
            loading = false;
            expired = true;
            Constants.expired = true;
          });
        } else if (today.year == dt.year && today.month > dt.month) {
          setState(() {
            loading = false;
            expired = true;
            Constants.expired = true;
          });
        } else if (today.year == dt.year &&
            today.month == dt.month &&
            today.day > dt.day) {
          setState(() {
            loading = false;
            expired = true;
            Constants.expired = true;
          });
        } else {
          loading = false;
          expired = false;
          Constants.expired = false;
        }
      }
      setState(() {
        loading = false;
      });
    }
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
                text: title,
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
                  message,
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
                        text: "No",
                        color: blackColor,
                        weight: FontWeight.bold,
                      ),
                    ),
                    MaterialButton(
                      onPressed: logout,
                      child: MyText(
                        text: "Yes",
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
    Provider.of<ServicesProvider>(context, listen: false).homeIndex = 0;
  }

  void logout() {
    Constants.clear();
    changeIndex();
    print(Constants.userId);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) {
          return const SignIn();
        },
      ),
      (route) => false,
    );
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
    cancel();
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.1),
        body: loading
            ? Center(
                child: MyText(
                text: "Loading...",
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  loading
                                      ? const Text("Loading")
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
                                                    text: 'Become A partner',
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
                                                "${'https://adventuresclub.net/adventureClub/public/'}${profile.profileImage}"),
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
                                    borderRadius: BorderRadius.circular(12)),
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
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) {
                                                        return const Favorite();
                                                      },
                                                    ),
                                                  );
                                                }
                                                if (userText[i] ==
                                                    'Notification') {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) {
                                                        return const Notifications();
                                                      },
                                                    ),
                                                  );
                                                }
                                                if (userText[i] ==
                                                    'myPoints'.tr()) {
                                                  Navigator.of(context).push(
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
                                                          child: CircleAvatar(
                                                            radius: 10,
                                                            backgroundColor:
                                                                redColor,
                                                            child: MyText(
                                                              text: Constants
                                                                  .resultService
                                                                  .toString(), //'12',
                                                              color: whiteColor,
                                                              weight: FontWeight
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
                                              color: greyColor.withOpacity(1),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  loading
                                      ? const Text("Loading")
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
                                                    text: 'Become A partner',
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
                                                "${'https://adventuresclub.net/adventureClub/public/'}${profile.profileImage}"),
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
                                    borderRadius: BorderRadius.circular(12)),
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
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) {
                                                        return const Favorite();
                                                      },
                                                    ),
                                                  );
                                                }
                                                if (userText[i] ==
                                                    'Notification') {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) {
                                                        return const Notifications();
                                                      },
                                                    ),
                                                  );
                                                }
                                                if (userText[i] ==
                                                    'My Points') {
                                                  Navigator.of(context).push(
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
                                                          child: CircleAvatar(
                                                            radius: 10,
                                                            backgroundColor:
                                                                redColor,
                                                            child: MyText(
                                                              text: Constants
                                                                  .resultService
                                                                  .toString(), //'12',
                                                              color: whiteColor,
                                                              weight: FontWeight
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
                                              color: greyColor.withOpacity(1),
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
                            GestureDetector(
                              //  onTap: getProfile,
                              child: Container(
                                color: transparentColor,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    loading
                                        ? const Text("Loading")
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
                                                      text: 'Become A partner',
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
                                                  "${'https://adventuresclub.net/adventureClub/public/'}${profile.profileImage}"),
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
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
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
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) {
                                                        return const Favorite();
                                                      },
                                                    ),
                                                  );
                                                }
                                                if (userText[i] ==
                                                    'Notification') {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) {
                                                        return const Notifications();
                                                      },
                                                    ),
                                                  );
                                                }
                                                if (userText[i] ==
                                                    'My Points') {
                                                  Navigator.of(context).push(
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
                                                          child: CircleAvatar(
                                                            radius: 10,
                                                            backgroundColor:
                                                                redColor,
                                                            child: MyText(
                                                              text: Constants
                                                                  .resultService
                                                                  .toString(), //'12',
                                                              color: whiteColor,
                                                              weight: FontWeight
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
                                              color: greyColor.withOpacity(1),
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
                              GestureDetector(
                                // onTap: getProfile,
                                child: Container(
                                  color: transparentColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      loading
                                          ? const Text("Loading")
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
                                                  onTap: ex,
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
                                                            'Your Subscription expired',
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
                                                    "${'https://adventuresclub.net/adventureClub/public/'}${profile.profileImage}"),
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
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
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
                                                      "favorite".tr()) {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (_) {
                                                          return const Favorite();
                                                        },
                                                      ),
                                                    );
                                                  }
                                                  if (text[i] ==
                                                      'My Services') {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (_) {
                                                          return const MyServices();
                                                        },
                                                      ),
                                                    );
                                                  }
                                                  if (text[i] ==
                                                      'Client Requests') {
                                                    Navigator.of(context).push(
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
                                                                'Client Requests'
                                                        ? Positioned(
                                                            bottom: -5,
                                                            right: -12,
                                                            child: CircleAvatar(
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
                                                                'My Services'
                                                        ? Positioned(
                                                            bottom: -5,
                                                            right: -12,
                                                            child: CircleAvatar(
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
                                                color: greyColor.withOpacity(1),
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
                            GestureDetector(
                              // onTap: getProfile,
                              child: Container(
                                color: transparentColor,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    loading
                                        ? const Text("Loading")
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
                                                      text: 'Already a partner',
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
                                                    "${"Renew before "}${profile.bp.endDate.substring(0, 11)}${"to avoid interruption"}", //'Kenneth Gutierrez',
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
                                                  "${'https://adventuresclub.net/adventureClub/public/'}${profile.profileImage}"),
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
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
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
                                                    "favorite".tr()) {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) {
                                                        return const Favorite();
                                                      },
                                                    ),
                                                  );
                                                }
                                                if (text[i] == 'My Services') {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) {
                                                        return const MyServices();
                                                      },
                                                    ),
                                                  );
                                                }
                                                if (text[i] ==
                                                    'Client Requests') {
                                                  Navigator.of(context).push(
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
                                                  Constants.resultRequest > 0 &&
                                                          text[i] ==
                                                              'Client Requests'
                                                      ? Positioned(
                                                          bottom: -5,
                                                          right: -12,
                                                          child: CircleAvatar(
                                                            radius: 10,
                                                            backgroundColor:
                                                                redColor,
                                                            child: MyText(
                                                              text: Constants
                                                                  .resultRequest
                                                                  .toString(), //'12',
                                                              color: whiteColor,
                                                              weight: FontWeight
                                                                  .bold,
                                                              size: 9,
                                                            ),
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                  Constants.resultService > 0 &&
                                                          text[i] ==
                                                              'My Services'
                                                      ? Positioned(
                                                          bottom: -5,
                                                          right: -12,
                                                          child: CircleAvatar(
                                                            radius: 10,
                                                            backgroundColor:
                                                                redColor,
                                                            child: MyText(
                                                              text: Constants
                                                                  .resultService
                                                                  .toString(), //'12',
                                                              color: whiteColor,
                                                              weight: FontWeight
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
                                              color: greyColor.withOpacity(1),
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
                              if (tile1Text[index] == 'My Points') {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return const MyPoints();
                                }));
                              }
                              if (tile1Text[index] == 'Health Condition') {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return const HealthCondition();
                                }));
                              }
                              if (tile1Text[index] == 'Notification') {
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
                              if (tile1Text[index] == 'Settings') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return const Settings();
                                    },
                                  ),
                                );
                              }
                              if (tile1Text[index] == 'Invite Friends') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return const InviteFriends();
                                    },
                                  ),
                                );
                              }
                              if (tile1Text[index] == 'About us') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return const AboutUs();
                                    },
                                  ),
                                );
                              }
                              if (tile1Text[index] == 'Contact us') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return const ContactUs();
                                      //const MyServicesAdDetails();
                                    },
                                  ),
                                );
                              }
                              if (tile1Text[index] == 'Log out') {
                                showConfirmation("Log out",
                                    "Are you sure you want to log out?");
                              }
                              if (tile1Text[index] == "Delete Account") {
                                showConfirmation("Delete Account",
                                    "Are you sure you want to Delete your account?");
                              }
                            }),
                            leading: Stack(clipBehavior: Clip.none, children: [
                              Image(
                                image: ExactAssetImage(tile1[index]),
                                height:
                                    tile1Text[index] == 'My Points' ? 35 : 25,
                                width: 35,
                                color: greyColor.withOpacity(1),
                              ),
                              tile1Text[index] == 'Notification'
                                  ? Positioned(
                                      top: -8,
                                      right: -3,
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: redColor,
                                        child: MyText(
                                          text:
                                              Constants.totalNotication, //'12',
                                          color: whiteColor,
                                          weight: FontWeight.bold,
                                          size: 9,
                                        ),
                                      ),
                                    )
                                  : const SizedBox()
                            ]),
                            title: MyText(
                              text: tile1Text[index],
                              color: greyColor.withOpacity(1),
                              size: 15,
                              weight: FontWeight.w700,
                            ),
                            trailing: tile1Text[index] == 'Settings'
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
                                          "${"https://adventuresclub.net/adventureClub/public/"}${Constants.countryFlag}",
                                          height: 15,
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                  )
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
                        userListText.length,
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
                              if (userListText[index] == 'Health Condition') {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return const HealthCondition();
                                }));
                              }
                              if (userListText[index] == 'Settings') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return const Settings();
                                    },
                                  ),
                                );
                              }
                              if (userListText[index] == 'Invite Friends') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return const InviteFriends();
                                    },
                                  ),
                                );
                              }
                              if (userListText[index] == 'About us') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return const AboutUs();
                                    },
                                  ),
                                );
                              }
                              if (userListText[index] == 'Contact us') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return const ContactUs();
                                      //const MyServicesAdDetails();
                                    },
                                  ),
                                );
                              }
                              if (userListText[index] == "logOut".tr()) {
                                logout();
                              }
                            }),
                            leading: Stack(clipBehavior: Clip.none, children: [
                              Image(
                                height: 30,
                                width: 30,
                                image: ExactAssetImage(userListIcon[index]),
                              ),
                            ]),
                            title: MyText(
                              text: userListText[index],
                              color: greyColor.withOpacity(1),
                              size: 15,
                              weight: FontWeight.w700,
                            ),
                          );
                        },
                      ),
                    ),
                  PopupMenuButton<String>(
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.language_rounded,
                        color: whiteColor,
                        size: 60,
                      ),
                    ),
                    onSelected: (String item) {
                      setState(() {
                        selectedLanguage = item;
                      });
                      changeLanguage(item);
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: "English",
                        child: Text('English'),
                      ),
                      const PopupMenuItem<String>(
                        value: "Arabic",
                        child: Text('Arabic'),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: logout,
                    child: Center(
                      child: Container(
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 20, 69, 22),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: MyText(
                            text: "App Version : 2.0",
                            color: whiteColor,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
      ),
    );
  }
}
