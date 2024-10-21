// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/reviews.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/provider/navigation_index_provider.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:adventuresclub/widgets/Lists/my_services_list.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/services_pdf.dart';
import 'package:adventuresclub/widgets/tabs/edit_my_service.dart';
import 'package:adventuresclub/widgets/tabs/my_services_tabs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MyServicesAdDetails extends StatefulWidget {
  final ServicesModel sm;
  const MyServicesAdDetails(this.sm, {super.key});

  @override
  State<MyServicesAdDetails> createState() => _MyServicesAdDetailsState();
}

class _MyServicesAdDetailsState extends State<MyServicesAdDetails> {
  Map mapChatNotification = {};
  bool allowEdit = false;
  List<File> imageList = [];
  String groupChatCount = "";
  List text = [
    'Hill Climbing',
    'Muscat, Oman',
    '\$ 100.50',
    'Including gears and other taxes',
  ];
  List text1 = [
    '\$ 80.20',
    'Excluding gears and other taxes',
  ];

  @override
  void initState() {
    super.initState();
    getChatNotification();
    getData();
  }

  void getData() {
    Provider.of<NavigationIndexProvider>(context, listen: false)
        .getUnreadCount(widget.sm.serviceId.toString());
  }

  void goToReviews(String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return Reviews(id);
        },
      ),
    );
  }

  void selected(BuildContext context, int serviceId, int providerId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
              "${Constants.baseUrl}/chatlist/${Constants.userId}/$serviceId/$providerId");
        },
      ),
    );
  }

  void editService(String serviceId) async {
    try {
      var response = await http.post(
          Uri.parse("${Constants.baseUrl}/api/v1/check_booking_on_service"),
          body: {
            'user_id': Constants.userId.toString(),
            'service_id': serviceId, //ccCode.toString(),
          });
      if (response.statusCode == 200) {
        if (mounted) {
          // setState(() {
          //   // allowEdit = true;
          //   // context.read<EditProvider>().changeStatus(true);
          // });
          navEdit();
        }
      } else {
        if (mounted) {
          Constants.showMessage(context, response.body);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void navEdit() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return EditMyService(
            gm: widget.sm,
          );
        },
      ),
    );
  }

  void deleteService(String id) async {
    try {
      var response = await http.post(
          Uri.parse("${Constants.baseUrl}/api/v1/services_delete"),
          body: {
            'services_id': id,
          });
      // var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        dynamic body = jsonDecode(response.body);
        // error = decodedError['data']['name'];
        // Constants.showMessage(context, body['message'].toString());
        showdelete(body['message'].toString());
      } else {
        dynamic body = jsonDecode(response.body);
        showdelete(body['message'].toString());
      }
      print(response.statusCode);
    } catch (e) {
      print(e.toString());
    }
  }

  void showConfirmation(String title) async {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: const Text(
                "Are you sure you want to delete this",
                textAlign: TextAlign.center,
              ),
              actions: [
                MaterialButton(
                  onPressed: cancel,
                  child: const Text("No"),
                ),
                MaterialButton(
                  onPressed: () => deleteService(title),
                  child: const Text("Yes"),
                )
              ],
            ));
  }

  void showdelete(String title) {
    Navigator.of(context).pop();
    deleteConfirmation(title);
  }

  void deleteConfirmation(String title) async {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: Text(
                title,
                textAlign: TextAlign.center,
              ),
              actions: [
                MaterialButton(
                  onPressed: cancel,
                  child: const Text("OK"),
                )
              ],
            ));
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  Future getChatNotification() async {
    var response = await http.get(Uri.parse(
        "${Constants.baseUrl}/unreadchatcount/'${Constants.userId}/${widget.sm.serviceId}"));
    if (response.statusCode == 200) {
      mapChatNotification = json.decode(response.body);
      dynamic result = mapChatNotification['unread'];
      setState(() {
        groupChatCount = result.toString();
      });
      print(result);
    }
  }

  void pdfService() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return ServicesPdf(sm: widget.sm);
    }));
  }

  void getImages(List<File> imgList) {
    imageList = imgList;
  }

  @override
  Widget build(BuildContext context) {
    int serviceCount =
        Provider.of<NavigationIndexProvider>(context, listen: true)
            .serviceCount;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.5,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset(
            'images/backArrow.png',
            height: 18,
          ),
        ),
        // title:
        // MyText(
        //   text: widget.sm.adventureName, //'Hill Climbing',
        //   color: bluishColor,
        //   weight: FontWeight.w800,
        //   size: 18,
        // ),
        actions: [
          IconButton(
            onPressed: pdfService,
            icon: const Icon(Icons.picture_as_pdf_sharp),
          ),
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () => editService(widget.sm.id.toString()),
            child: const Image(
              image: ExactAssetImage('images/edit.png'),
              height: 30,
              width: 30,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () => showConfirmation(widget.sm.serviceId.toString()),
            child: const Image(
              image: ExactAssetImage('images/bin.png'),
              height: 30,
              width: 30,
            ),
          ),
          const SizedBox(width: 15),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              GestureDetector(
                onTap: () => selected(
                    context, widget.sm.serviceId, widget.sm.providerId),
                child: const Icon(
                  Icons.message,
                  color: bluishColor,
                  size: 36,
                ),
              ),
              // if (groupChatCount != "0")
              Positioned(
                right: 1,
                bottom: 2,
                child: Container(
                  height: 20,
                  width: 17,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 187, 39, 28),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: MyText(
                      text: serviceCount,
                      color: whiteColor,
                      weight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 15)
        ],
      ),
      body: Container(
        color: greyShadeColor.withOpacity(0.2),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: MyServicesList(
                widget.sm,
                edit: allowEdit,
                sendImages: getImages,
              ),
            ),
            //GestureDetector(
            //  onTap: () => goToReviews(widget.sm.serviceId.toString()),
            //child:
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
            //   child: Card(
            //       child: Padding(
            //     padding: const EdgeInsets.all(12.0),
            //     child: Column(
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             MyText(
            //               text: widget.sm.adventureName, //'Hill Climbing',
            //               color: greyBackgroundColor,
            //               size: 16,
            //               weight: FontWeight.w600,
            //               fontFamily: "Roboto",
            //             ),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.end,
            //               children: [
            //                 // GestureDetector(
            //                 //   onTap: () {},
            //                 //   //=> editService(widget.sm.id.toString(),
            //                 //   //  widget.sm.providerId.toString()),
            //                 //   child: const Image(
            //                 //     image: ExactAssetImage('images/edit.png'),
            //                 //     height: 20,
            //                 //     width: 20,
            //                 //   ),
            //                 // ),
            //                 const SizedBox(
            //                   width: 20,
            //                 ),
            //                 GestureDetector(
            //                   onTap: () => showConfirmation(
            //                       widget.sm.serviceId.toString()),
            //                   child: const Image(
            //                     image: ExactAssetImage('images/bin.png'),
            //                     height: 20,
            //                     width: 20,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //         const SizedBox(
            //           height: 5,
            //         ),
            //         Row(
            //           children: [
            //             const Image(
            //               image: ExactAssetImage('images/location-on.png'),
            //               color: greyColor,
            //             ),
            //             const SizedBox(
            //               width: 5,
            //             ),
            //             MyText(
            //               text: widget.sm.sAddress.tr(), //'Muscat Oman',
            //               color: greyColor,
            //               weight: FontWeight.w500,
            //             )
            //           ],
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 MyText(
            //                   text: "${widget.sm.currency} "
            //                       "${widget.sm.costInc}", //'\$ 100.50',
            //                   color: blackColor,
            //                   weight: FontWeight.bold,
            //                   fontFamily: "Roboto",
            //                 ),
            //                 const SizedBox(
            //                   height: 2,
            //                 ),
            //                 MyText(
            //                   text: "includingGears".tr(), //'\$ 100.50',
            //                   color: Colors.red[600],
            //                   weight: FontWeight.w600,
            //                   fontFamily: "Roboto",
            //                   size: 10,
            //                 ),
            //               ],
            //             ),
            //             const SizedBox(
            //               width: 10,
            //             ),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 MyText(
            //                   text: "${widget.sm.currency} "
            //                       "${widget.sm.costExc}", //'\$ 100.50',
            //                   color: blackColor,
            //                   weight: FontWeight.bold,
            //                   fontFamily: "Roboto",
            //                 ),
            //                 const SizedBox(
            //                   height: 2,
            //                 ),
            //                 MyText(
            //                   text: "excludingGears".tr(), //'\$ 100.50',
            //                   color: Colors.red[600],
            //                   weight: FontWeight.w600,
            //                   fontFamily: "Roboto",
            //                   size: 10,
            //                 ),
            //               ],
            //             ),
            //             // const SizedBox(
            //             //   width: 10,
            //             // )
            //           ],
            //         ),
            //       ],
            //     ),
            //   )),
            // ),
            // ),
            Expanded(
              child:
                  // DetailsTab(
                  //   widget.sm,
                  //   show: true,
                  // )
                  MyServicesTab(
                widget.sm,
                edit: allowEdit,
              ),
            )
          ],
        ),
      ),
    );
  }
}
