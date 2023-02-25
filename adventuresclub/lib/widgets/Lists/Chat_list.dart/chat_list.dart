// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/notifications/notifications_list_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  bool loading = false;
  List images = [
    'images/picture1.png',
    'images/picture1.png',
    'images/picture1.png',
    'images/picture1.png',
    'images/picture1.png',
    'images/picture1.png',
    'images/picture1.png',
    'images/picture1.png',
  ];
  List text = [
    'River Rafting Group',
    'Hill Climbing',
    'River Rafting Group',
    'Hill Climbing',
    'River Rafting Group',
    'Hill Climbing',
    'River Rafting Group',
    'Hill Climbing',
  ];
  List subText = [
    'Be available tomorrow in morning',
    'Be available tomorrow in morning',
    'Be available tomorrow in morning',
    'Be available tomorrow in morning',
    'Be available tomorrow in morning',
    'Be available tomorrow in morning',
    'Be available tomorrow in morning',
    'Be available tomorrow in morning',
  ];
  void doNothing(BuildContext context) {}

  List<NotificationsListModel> pNm = [];
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
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
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
              return Slidable(
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
                      //  onTap: goToAdCategory,
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
                        trailing: Column(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: bluishColor,
                              child: MyText(
                                text: '2',
                                color: whiteColor,
                                size: 10,
                                weight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                      indent: 22,
                    )
                  ],
                ),
              );
            },
          );
  }
}
