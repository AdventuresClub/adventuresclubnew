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
import 'package:adventuresclub/provider/services_provider.dart';
import 'package:adventuresclub/sign_up/sign_in.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
  List tile1 = [
    'images/points.png',
    'images/healthCondition.png',
    'images/notification.png',
    'images/payment.png',
    // 'images/category.png',
    // 'images/packages.png',
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
  String status = "";
  String firstName = "";
  String profileUrl = "";
  String lastName = "";
  ProfileBecomePartner gBp = ProfileBecomePartner(0, 0, "", "", "", "", "", "",
      "", "", 0, 0, "", "", "", "", "", "", "", 0, "", "", "", "", "", "");
  String resultService = "";
  String resultRequest = "";
  String totalNotication = "";
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  // void getNotificationNum() {
  //   Provider.of<ServicesProvider>(context).resultService = resultService;
  //   Provider.of<ServicesProvider>(context).resultRequest = resultRequest;
  //   Provider.of<ServicesProvider>(context).totalNotication = totalNotication;
  // }

  void getProfile() async {
    //  getNotificationNum();
    try {
      var response = await http.post(
          Uri.parse("https://adventuresclub.net/adventureClub/api/v1/login"),
          body: {
            'email': "hamza@gmail.com",
            'password': "Upendra@321",
            'device_id': "0"
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      dynamic partnerInfo = decodedResponse['data']['become_partner'] ?? "";
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

  @override
  Widget build(BuildContext context) {
    resultService = Provider.of<ServicesProvider>(context).resultService;
    resultRequest = Provider.of<ServicesProvider>(context).resultRequest;
    totalNotication = Provider.of<ServicesProvider>(context).totalNotication;
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
              GestureDetector(
                onTap: getProfile,
                child: Container(
                  color: transparentColor,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: firstName, //'Kenneth Gutierrez',
                            color: blackColor,
                            weight: FontWeight.bold,
                            size: 22,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) {
                                return const BecomePartnerNew();
                              }));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  text: 'Already a partner',
                                  size: 16,
                                  fontFamily: 'Raleway',
                                  color: greyColor.withOpacity(0.8),
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
                                    resultService.isNotEmpty
                                        ? Positioned(
                                            bottom: -5,
                                            right: -12,
                                            child: CircleAvatar(
                                              radius: 10,
                                              backgroundColor: redColor,
                                              child: MyText(
                                                text: resultService, //'12',
                                                color: whiteColor,
                                                size: 8,
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
                                color: greyColor.withOpacity(0.9),
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
          Wrap(
            children: List.generate(
              tile1.length,
              (index) {
                return ListTile(
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -3),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  horizontalTitleGap: 1,
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
                      //                    void logout() async {
                      //          Provider.of<CompleteProfileProvider>(context, listen: false).clearAll();
                      //       getprefs!.clear();
                      // }
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return const SignIn();
                      }));
                    }
                  }),
                  leading: Stack(clipBehavior: Clip.none, children: [
                    Image(
                      image: ExactAssetImage(tile1[index]),
                      height: tile1Text[index] == 'My Points' ? 35 : 25,
                      width: 35,
                      color: greyColor.withOpacity(0.9),
                    ),
                    tile1Text[index] == 'Notification'
                        ? Positioned(
                            top: -8,
                            right: -3,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: redColor,
                              child: MyText(
                                text: totalNotication, //'12',
                                color: whiteColor,
                                size: 8,
                              ),
                            ),
                          )
                        : const SizedBox()
                  ]),
                  title: MyText(
                    text: tile1Text[index],
                    color: greyColor.withOpacity(0.9),
                    size: 14,
                    weight: FontWeight.w500,
                  ),
                  trailing: tile1Text[index] == 'Settings'
                      ? SizedBox(
                          width: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                text: 'OMAN',
                                color: greyColor.withOpacity(0.9),
                                weight: FontWeight.w500,
                              ),
                              const Image(
                                image: ExactAssetImage(
                                  'images/maskGroup51.png',
                                ),
                                height: 15,
                              )
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
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
