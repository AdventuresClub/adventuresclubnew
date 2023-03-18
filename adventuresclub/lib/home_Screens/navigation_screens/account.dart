// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:adventuresclub/become_a_partner/become_partner.dart';
import 'package:adventuresclub/complete_profile/complete_profile.dart';
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
import 'package:adventuresclub/models/profile_models/profile_become_partner.dart';
import 'package:adventuresclub/sign_up/sign_in.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/packages_become_partner/packages_become_partner_model.dart';
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
  List text = ['Favorite', 'My Services', 'Client Requests'];
  List userText = ['Favorite', 'Notification', 'My Points'];
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
  ];
  List tile1Text = [
    'My Points',
    'Health Condition',
    'Notification',
    'Service & Quality Standards',
    'Settings',
    'Invite Friends',
    'About us',
    'Contact us',
    'Log out',
  ];
  List userListText = [
    'Health Condition',
    'Settings',
    'Invite Friends',
    'About us',
    'Service & Quality Standards',
    'Contact us',
    'Log out',
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
  List<PackagesBecomePartnerModel> packageList = [];
  @override
  void initState() {
    super.initState();
    //getProfile();
    Constants.getProfile();
  }

  // void getNotificationNum() {
  //   Provider.of<ServicesProvider>(context).resultService = resultService;
  //   Provider.of<ServicesProvider>(context).resultRequest = resultRequest;
  //   Provider.of<ServicesProvider>(context).totalNotication = totalNotication;
  // }

  void getProfile() async {
    setState(() {
      loading = true;
    });
    try {
      var response = await http.post(
          Uri.parse("https://adventuresclub.net/adventureClub/api/v1/login"),
          body: {
            'email': Constants.emailId, //"hamza@gmail.com",
            'password': Constants.password, //"Upendra@321",
            'device_id': "0"
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      dynamic partnerInfo = decodedResponse['data'];
      int id = int.tryParse(partnerInfo['id'].toString()) ?? 0;
      int userId = int.tryParse(partnerInfo['user_id'].toString()) ?? 0;
      int debitCard = int.tryParse(partnerInfo['debit_card'].toString()) ?? 0;
      int visaCard = int.tryParse(partnerInfo['visa_card'].toString()) ?? 0;
      int packagesId = int.tryParse(partnerInfo['packages_id'].toString()) ?? 0;
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
      setState(
        () {
          loading = false;
          gBp = bp;
          //status = decodedResponse['data']['become_partner'] ?? "";
          firstName = decodedResponse['data']['name'] ?? "";
          profileUrl = decodedResponse['data']["profile_image"] ?? "";
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void goToProfile() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const Profile();
        },
      ),
    );
  }

  void logout() {
    Constants.clear();
    print(Constants.userId);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const SignIn();
        },
      ),
    );
  }

  void getList() async {
    await Constants.getPackagesApi();
    setState(() {
      packageList = Constants.gBp;
    });
    packagesList(Constants.gBp);
  }

  void packagesList(List<PackagesBecomePartnerModel> bp) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return BecomePartnerPackages(bp);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      body: ListView(
        children: [
          const SizedBox(
            height: 2,
          ),
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              if (Constants.userRole == "2")
                GestureDetector(
                  onTap: getProfile,
                  child: Container(
                    color: transparentColor,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        loading
                            ? const Text("Loading")
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: Constants
                                        .profile.name, //'Kenneth Gutierrez',
                                    color: blackColor,
                                    weight: FontWeight.bold,
                                    size: 22,
                                    fontFamily: "Raleway",
                                  ),
                                  GestureDetector(
                                    onTap: getList,
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
                                          color: greyColor.withOpacity(1),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: bluishColor,
                                        )
                                      ],
                                    ),
                                  ),
                                  MyText(
                                    text:
                                        "${"Renew before "}${Constants.profile.bp.endDate}", //'Kenneth Gutierrez',
                                    color: redColor,
                                    weight: FontWeight.bold,
                                    size: 16,
                                    fontFamily: "Raleway",
                                  ),
                                ],
                              ),
                        profileUrl != null
                            ? GestureDetector(
                                onTap: goToProfile,
                                child: const CircleAvatar(
                                  radius: 38,
                                  backgroundImage:
                                      ExactAssetImage('images/avatar2.png'),
                                ),
                              )
                            : GestureDetector(
                                onTap: goToProfile,
                                child: CircleAvatar(
                                  radius: 38,
                                  backgroundImage: NetworkImage(profileUrl),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              if (Constants.userRole == "3")
                GestureDetector(
                  onTap: getProfile,
                  child: Container(
                    color: transparentColor,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        loading
                            ? const Text("Loading")
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: Constants
                                        .profile.name, //'Kenneth Gutierrez',
                                    color: blackColor,
                                    weight: FontWeight.bold,
                                    size: 22,
                                    fontFamily: "Raleway",
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (_) {
                                        return const BecomePartnerNew();
                                      }));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: 'Become A partner',
                                          size: 18,
                                          //fontFamily: 'Raleway',
                                          weight: FontWeight.w600,
                                          color: greyColor.withOpacity(1),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: bluishColor,
                                        )
                                      ],
                                    ),
                                  ),
                                  // MyText(
                                  //   text:
                                  //       "${"Renew before "}${Constants.profile.bp.endDate}", //'Kenneth Gutierrez',
                                  //   color: redColor,
                                  //   weight: FontWeight.bold,
                                  //   size: 16,
                                  //   fontFamily: "Raleway",
                                  // ),
                                ],
                              ),
                        profileUrl != null
                            ? GestureDetector(
                                onTap: goToProfile,
                                child: const CircleAvatar(
                                  radius: 38,
                                  backgroundImage:
                                      ExactAssetImage('images/avatar2.png'),
                                ),
                              )
                            : GestureDetector(
                                onTap: goToProfile,
                                child: CircleAvatar(
                                  radius: 38,
                                  backgroundImage: NetworkImage(profileUrl),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              if (Constants.userRole == "2")
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int i = 0; i < 3; i++)
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (text[i] == 'Favorite') {
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
                                    if (text[i] == 'Client Requests') {
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
                                        image: ExactAssetImage(images[i]),
                                        height: 30,
                                        width: 30,
                                      ),
                                      Constants.resultService > 0 &&
                                              text[i] == 'Client Requests'
                                          ? Positioned(
                                              bottom: -5,
                                              right: -12,
                                              child: CircleAvatar(
                                                radius: 10,
                                                backgroundColor: redColor,
                                                child: MyText(
                                                  text: Constants.resultRequest
                                                      .toString(), //'12',
                                                  color: whiteColor,
                                                  weight: FontWeight.bold,
                                                  size: 9,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                      Constants.resultService > 0 &&
                                              text[i] == 'My Services'
                                          ? Positioned(
                                              bottom: -5,
                                              right: -12,
                                              child: CircleAvatar(
                                                radius: 10,
                                                backgroundColor: redColor,
                                                child: MyText(
                                                  text: Constants.resultService
                                                      .toString(), //'12',
                                                  color: whiteColor,
                                                  weight: FontWeight.bold,
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
              if (Constants.userRole == "3")
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int i = 0; i < 3; i++)
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (userText[i] == 'Favorite') {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return const Favorite();
                                          },
                                        ),
                                      );
                                    }
                                    if (userText[i] == 'Notification') {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return const Notifications();
                                          },
                                        ),
                                      );
                                    }
                                    // if (userText[i] == 'Client Requests') {
                                    //   Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //       builder: (_) {
                                    //         return const ClientsRequests();
                                    //       },
                                    //     ),
                                    //   );
                                    // }
                                  },
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Image(
                                        image: ExactAssetImage(images[i]),
                                        height: 30,
                                        width: 30,
                                      ),
                                      Constants.totalNotication > 0 &&
                                              userText[i] == 'Notification'
                                          ? Positioned(
                                              bottom: -5,
                                              right: -12,
                                              child: CircleAvatar(
                                                radius: 10,
                                                backgroundColor: redColor,
                                                child: MyText(
                                                  text: Constants
                                                      .totalNotication
                                                      .toString(), //'12',
                                                  color: whiteColor,
                                                  weight: FontWeight.bold,
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
          if (Constants.userRole == "2")
            Wrap(
              children: List.generate(
                tile1.length,
                (index) {
                  return ListTile(
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -3),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
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
                              return const CompleteProfile();
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
                        logout();
                      }
                    }),
                    leading: Stack(clipBehavior: Clip.none, children: [
                      Image(
                        image: ExactAssetImage(tile1[index]),
                        height: tile1Text[index] == 'My Points' ? 35 : 25,
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
                                  text: Constants.totalNotication, //'12',
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
                            width: Constants.country.length > 11 ? 140 : 100,
                            //60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          if (Constants.userRole == "3")
            Wrap(
              children: List.generate(
                userListText.length,
                (index) {
                  return ListTile(
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -3),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
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
                              return const CompleteProfile();
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
                      if (userListText[index] == 'Log out') {
                        logout();
                      }
                    }),
                    leading: Stack(clipBehavior: Clip.none, children: [
                      Image(
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
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
