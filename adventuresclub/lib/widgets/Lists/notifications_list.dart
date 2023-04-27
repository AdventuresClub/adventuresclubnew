// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:core';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/become_partner/become_partner_packages.dart';
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
  List<PackagesBecomePartnerModel> packageList = [];

  @override
  void initState() {
    super.initState();
    getNotifications();
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
            'user_id': Constants.userId.toString(), //"27",
          });
      if (response.statusCode == 200) {
        var decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map;
        List<dynamic> result = decodedResponse['data'];
        result.forEach((element) {
          if (element['title'] != "Login") {
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
          } else {}
        });
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteNotification(String id) async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/delete_notification"),
          body: {
            "notification_id": id, //ccCode.toString(),
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        cancel();
      }
      print(response.statusCode);
    } catch (e) {
      print(e.toString());
    }
  }

  void cancel() {
    message("Notification has been deleted successfully");
    Navigator.of(context).pop();
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
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
          return const BecomePartnerPackages();
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
                        onPressed: (context) =>
                            deleteNotification(pNm[index].id.toString()),
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.red,
                        icon: Icons.delete,
                        label: '',
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      if (pNm[index].title == "Your request has been approved")
                        GestureDetector(
                          onTap: getList, //() => packagesList(gBp),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: CircleAvatar(
                                  backgroundImage:
                                      //ExactAssetImage(images[index]),
                                      NetworkImage(pNm[index].senderImage)),
                            ),
                            title: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: MyText(
                                text: pNm[index].title, //text[index],
                                color: blackColor,
                                weight: FontWeight.w700,
                                size: 14,
                              ),
                            ),
                            subtitle: MyText(
                              text: pNm[index].message, //subText[index],
                              color: blackColor.withOpacity(0.6),
                              weight: FontWeight.w500,
                              size: 13,
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
                      if (pNm[index].title != "Your request has been approved")
                        GestureDetector(
                          onTap: () {},
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: CircleAvatar(
                                  backgroundImage:
                                      //ExactAssetImage(images[index]),
                                      NetworkImage(pNm[index].senderImage)),
                            ),
                            title: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: MyText(
                                text: pNm[index].title, //text[index],
                                color: blackColor,
                                weight: FontWeight.w700,
                                size: 14,
                              ),
                            ),
                            subtitle: MyText(
                              text: pNm[index].message, //subText[index],
                              color: blackColor.withOpacity(0.6),
                              weight: FontWeight.w500,
                              size: 13,
                            ),
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
