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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int index = 0;
  String userId = "";
  String totalNotication = "";
  String resultAccount = "";
  String resultService = "";
  String resultRequest = "";

  Widget getBody() {
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

  void getServicesList() {
    Provider.of<ServicesProvider>(context, listen: false).getServicesList();
  }

  @override
  void initState() {
    super.initState();
    getServicesList();
    getNotificationBadge();
    Constants.getFilter();
    // if (Constants.partnerRequest) {
    //   setState(() {
    //     Constants.partnerRequest == false;
    //   });
    //   Constants.getProfile();
    // }
  }

  void getNotificationBadge() async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/get_notification_list_budge"),
          body: {
            'user_id': Constants.userId.toString(), //"27",
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = decodedResponse['data'];
      result.forEach((element) {
        setState(() {
          totalNotication = element['total_notification'].toString() ?? "";
          resultAccount = element['resultAccount'].toString() ?? "";
          resultService = element['resultService'].toString() ?? "";
          resultRequest = element['resultRequest'].toString() ?? "";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/home.png',
              height: 25,
              width: 25,
            ),
            label: 'Home',
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

            label: 'Planned',
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
            label: 'Requests',

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
                    : Container(),
              ],
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/worldwide.png',
              height: 25,
              width: 25,
            ),
            label: 'Visit',
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
                      right: -12,
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
                  : Container(),
            ]),
            label: 'Account',
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
