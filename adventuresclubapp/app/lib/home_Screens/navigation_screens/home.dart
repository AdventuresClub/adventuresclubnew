// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:convert';
import 'package:app/constants.dart';
import 'package:app/external_pdfs_view.dart';
import 'package:app/models/banners/banners_model.dart';
import 'package:app/models/home_services/home_services_model.dart';
import 'package:app/models/home_services/services_model.dart';
import 'package:app/provider/navigation_index_provider.dart';
import 'package:app/provider/services_provider.dart';
import 'package:app/widgets/Lists/home_lists/service_List.dart';
import 'package:app/widgets/home_widgets/new_filter.dart';
import 'package:app/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BannersModel> bannersList = [];
  bool loading = false;
  List<String> banners = [];
  bool all = true;
  bool land = true;
  bool water = true;
  bool sky = true;
  bool transport = true;
  bool accomodation = true;
  bool training = true;
  List<ServicesModel> allServices = [];
  List<HomeServicesModel> gAllServices = [];
  Map mapChatNotification = {};

  @override
  void initState() {
    super.initState();
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        //   getBanners();
        getServicesList();
        getChatNotification();
      });
    }
  }

  Future getChatNotification() async {
    getNotificatioNumber();
    var response = await http.get(
        Uri.parse("${Constants.baseUrl}/unreadchatcount/${Constants.userId}"));
    if (response.statusCode == 200) {
      mapChatNotification = json.decode(response.body);
      dynamic result = mapChatNotification['unread'];
      if (mounted) {
        setState(() {
          Constants.chatCount = result.toString();
        });
      }
      print(result);
      print(Constants.chatCount);
    }
  }

  void getNotificatioNumber() {
    Provider.of<NavigationIndexProvider>(context, listen: false)
        .getNotificationBadge();
  }

  void getBanners() async {
    // setState(() {
    //   loading = true;
    // });
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/banners"), body: {
        'country_id': Constants.countryId.toString(), //"1",
      });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = decodedResponse['data'];
      result.forEach((element) {
        int serviceId = int.tryParse(element['service_id'].toString()) ?? 0;
        int countryId = int.tryParse(element['country_id'].toString()) ?? 0;
        int discountAmount =
            int.tryParse(element['discount_amount'].toString()) ?? 0;
        int status = int.tryParse(element['status'].toString()) ?? 0;
        BannersModel bm = BannersModel(
          serviceId,
          countryId,
          element['name'].toString() ?? "",
          element['start_date'].toString() ?? "",
          element['end_date'].toString() ?? "",
          element['discount_type'].toString() ?? "",
          discountAmount,
          element['banner'].toString() ?? "",
          status,
          element['created_at'].toString() ?? "",
          element['updated_at'].toString() ?? "",
          element['deleted_at'].toString() ?? "",
        );
        bannersList.add(bm);
      });
      bannersList.forEach((element) {
        banners.add(element.banner);
      });
      // setState(() {
      //   loading = false;
      // });
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  void getServicesList() {
    Provider.of<ServicesProvider>(context, listen: false).getServicesList();
  }

  void launchURL() async {
    // String url = 'https://adventuresclub.net/partnership/partnership.pdf';
    String url = 'https://firebasestorage.googleapis.com/v0/b/globallogistics-94538.appspot.com/o/terms%20and%20condtion%20new%20pdf.pdf?alt=media&token=8f5f0022-fef7-4dda-971c-b38b7cb93a7a.pdf';
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return ExternalPdfsView(url: url);
    }));
    // final uri = Uri.parse(url);
    // if (await canLaunchUrl(uri)) {
    //   await launchUrl(uri, mode: LaunchMode.externalApplication);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  @override
  Widget build(BuildContext context) {
    //allServices = Provider.of<ServicesProvider>(context).allAccomodation;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: PopScope(
        canPop: false,
        // onWillPop: () async {
        //   return false;
        // },
        child: SafeArea(
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
              child: Column(
                children: [
                  NewFilterPage(),
                  // ElevatedButton(
                  //   onPressed:
                  // ),
                  ElevatedButton(
                      onPressed: launchURL,
                      child: MyText(
                        text: "test",
                        color: blackColor,
                      )),
                  // TextButton(
                  //   onPressed: () {
                  //     debugPrint("HTTPS://adventuresclub.net/services/${5}");
                  //     context.push("/newDetails/123");
                  //   },
                  //   child: Text("AppLink Test"),
                  // ),
                  // SizedBox(
                  //   height: 35,
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // SizedBox(
                  //   height: 130,
                  //   child: TopList(),
                  // ),
                  Expanded(child: ServiceList()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
