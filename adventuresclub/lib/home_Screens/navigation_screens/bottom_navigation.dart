// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls
import 'dart:convert';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/account.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/home.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/planned.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/visit.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/requests.dart';
import 'package:adventuresclub/provider/services_provider.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/update_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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

  @override
  void initState() {
    super.initState();
    // index = context.read<ServicesProvider>().homeIndex;
    getNotificationBadge();
    Constants.getFilter();
    getVersion();
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

  void showPicker() async {
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
                            text: "Update Available",
                            weight: FontWeight.w600,
                          ),
                          trailing: const Icon(Icons.chevron_right_rounded),
                        ),
                        Button(
                            "update".tr(),
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
                        const Divider()
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
    int index = Provider.of<ServicesProvider>(context).homeIndex;
    return Scaffold(
      body: getBody(index),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: index,
        onTap: (i) {
          print(i);
          Provider.of<ServicesProvider>(context, listen: false).setHomeIndex(i);
          // setState(() {
          //   index = i;
          // });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/home.png',
              height: 25,
              width: 25,
            ),
            label: 'home'.tr(),
            //  ),
            activeIcon: Image.asset(
              'images/home.png',
              height: 25,
              width: 25,
              color: greenishColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/calender.png',
              height: 25,
              width: 25,
            ),

            label: 'planned'.tr(),
            //  ),
            activeIcon: Image.asset(
              'images/calender.png',
              height: 25,
              width: 25,
              color: greenishColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Stack(clipBehavior: Clip.none, children: [
              Image.asset(
                'images/compass.png',
                height: 25,
                width: 25,
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
                  height: 25,
                  width: 25,
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
              height: 25,
              width: 25,
            ),
            label: 'attractions'.tr(),
            //  ),
            activeIcon: Image.asset(
              'images/worldwide.png',
              height: 25,
              width: 25,
              color: greenishColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Stack(clipBehavior: Clip.none, children: [
              Image.asset(
                'images/account.png',
                height: 25,
                width: 25,
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
                height: 25,
                width: 25,
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
