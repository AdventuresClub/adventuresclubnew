// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:core';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/become_partner/become_partner_packages.dart';
import 'package:adventuresclub/models/packages_become_partner/bp_excluded_model.dart';
import 'package:adventuresclub/models/packages_become_partner/bp_includes_model.dart';
import 'package:adventuresclub/models/packages_become_partner/packages_become_partner_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import '../../models/notifications/notifications_list_model.dart';

class NotificationsList extends StatefulWidget {
  const NotificationsList({super.key});

  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  List images = [
    'images/notificationpic.png',
    'images/notificationpic.png',
    'images/notificationpic.png',
    'images/notificationpic.png',
    'images/notificationpic.png',
    'images/notificationpic.png',
    'images/notificationpic.png',
    'images/notificationpic.png',
  ];
  List text = [
    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
    'Hill Climbing',
  ];
  List subText = [
    'May 25, 2019 at 12:02 am',
    'May 25, 2019 at 12:02 am',
    'May 25, 2019 at 12:02 am',
    'May 25, 2019 at 12:02 am',
    'May 25, 2019 at 12:02 am',
    'May 25, 2019 at 12:02 am',
    'May 25, 2019 at 12:02 am',
    'May 25, 2019 at 12:02 am',
  ];
  void doNothing(BuildContext context) {}
  bool loading = false;
  List<NotificationsListModel> pNm = [];
  Map getPackages = {};
  List<PackagesBecomePartnerModel> gBp = [];
  List<BpIncludesModel> gIList = [];
  List<BpExcludesModel> gEList = [];

  @override
  void initState() {
    super.initState();
    getNotifications();
    getPackagesApi();
  }

  void getNotifications() async {
    setState(() {
      loading = true;
    });
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/get_notification_list"),
          body: {
            'user_id': "27",
          });
      if (response.statusCode == 200) {
        var decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map;
        List<dynamic> result = decodedResponse['data'];
        result.forEach((element) {
          NotificationsListModel nm = NotificationsListModel(
            int.tryParse(element['id'].toString()) ?? 0,
            int.tryParse(element['sender_id'].toString()) ?? 0,
            int.tryParse(element['user_id'].toString()) ?? 0,
            element['title'].toString() ?? "",
            element['message'].toString() ?? "",
            element['is_approved'].toString() ?? "",
            element['is_read'].toString() ?? "",
            element['notification_type'].toString() ?? "",
            element['created_at'].toString() ?? "",
            element['raed_at'].toString() ?? "",
            element['send_at'].toString() ?? "",
            element['updated_at'].toString() ?? "",
            element['sender_image'].toString() ?? "",
          );
          pNm.add(nm);
        });
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future getPackagesApi() async {
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/get_packages"));
    if (response.statusCode == 200) {
      getPackages = json.decode(response.body);
      List<dynamic> result = getPackages['data'];
      result.forEach((element) {
        List<dynamic> included = element['includes'];
        included.forEach((i) {
          BpIncludesModel iList = BpIncludesModel(
            int.tryParse(i['id'].toString()) ?? 0,
            int.tryParse(i['package_id'].toString()) ?? 0,
            i['title'].toString(),
            int.tryParse(i['detail_type'].toString()) ?? 0,
          );
          gIList.add(iList);
        });
        List<dynamic> excluded = element['Exclude'];
        excluded.forEach((e) {
          BpExcludesModel eList = BpExcludesModel(
            int.tryParse(e['id'].toString()) ?? 0,
            int.tryParse(e['package_id'].toString()) ?? 0,
            e['title'].toString() ?? "",
            e['detail_type'].toString() ?? "",
          );
          gEList.add(eList);
        });
        PackagesBecomePartnerModel pBp = PackagesBecomePartnerModel(
            int.tryParse(element['id'].toString()) ?? 0,
            element['title'].toString() ?? "",
            element['symbol'].toString() ?? "",
            element['duration'].toString() ?? "",
            element['cost'].toString() ?? "",
            int.tryParse(element['days'].toString()) ?? 0,
            int.tryParse(element['status'].toString()) ?? 0,
            element['created_at'].toString() ?? "",
            element['updated_at'].toString() ?? "",
            element['deleted_at'].toString() ?? "",
            gIList,
            gEList);
        gBp.add(pBp);
      });
    }
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
    return loading
        ? Center(
            child: Column(
              children: const [Text("Loading..")],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: pNm.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                //onTap: getPackagesApi,
                child: Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: doNothing,
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.red,
                        icon: Icons.delete,
                        label: '',
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => packagesList(gBp),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: CircleAvatar(
                                backgroundImage:
                                    //ExactAssetImage(images[index]),
                                    NetworkImage(pNm[index].senderImage)),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: MyText(
                              text: pNm[index].title, //text[index],
                              color: blackColor,
                              weight: FontWeight.w500,
                              size: 14,
                            ),
                          ),
                          subtitle: MyText(
                            text: pNm[index].message, //subText[index],
                            color: blackColor.withOpacity(0.6),
                            size: 12,
                          ),
                          // trailing: Column(
                          //   children: [
                          //     CircleAvatar(
                          //       radius: 12,
                          //       backgroundColor: bluishColor,
                          //       child: MyText(
                          //         text: '2',
                          //         color: whiteColor,
                          //         size: 10,
                          //         weight: FontWeight.w500,
                          //       ),
                          //     )
                          //   ],
                          // ),
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        indent: 22,
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }
}
