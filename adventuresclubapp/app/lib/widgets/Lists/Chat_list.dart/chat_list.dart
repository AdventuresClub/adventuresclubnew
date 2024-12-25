// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:app/constants.dart';
import 'package:app/models/notifications/notifications_list_model.dart';
import 'package:app/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:app/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  bool loading = false;
  Map mapChat = {};
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
    //getChats();
    selected();
  }

  void selected() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return ShowChat('${Constants.baseUrl}/grouplist/3');
    }));
  }

  void launchURL() async {
    String url = '${Constants.baseUrl}/grouplist/3';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  // void getChats() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   try {
  //     var response = await http.get(
  //       Uri.parse("${Constants.baseUrl}/grouplist/2"),
  //     );
  //     if (response.statusCode == 200) {
  //       mapChat = json.decode(response.body);
  //       List<dynamic> result = mapChat['data'];
  //       result.forEach((element) {});
  //     }
  //     // any browser internal browser ... back button and header will be from the application

  //     setState(() {
  //       loading = false;
  //     });
  //     print(response.statusCode);
  //     print(response.body);
  //     print(response.headers);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

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
              );
            },
          );
  }
}
