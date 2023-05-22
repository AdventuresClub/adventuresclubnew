// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/reviews.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:adventuresclub/widgets/Lists/my_services_list.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/tabs/my_services_tabs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyServicesAdDetails extends StatefulWidget {
  final ServicesModel sm;
  const MyServicesAdDetails(this.sm, {super.key});

  @override
  State<MyServicesAdDetails> createState() => _MyServicesAdDetailsState();
}

class _MyServicesAdDetailsState extends State<MyServicesAdDetails> {
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
              "https://adventuresclub.net/adventureClub/chatlist/${Constants.userId}/$serviceId/$providerId");
        },
      ),
    );
  }

  void editService(String id, String providerId) async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/edit_service"),
          body: {
            'service_id': id,
            'customer_id': providerId, //ccCode.toString(),
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      print(response.statusCode);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.5,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset(
            'images/backArrow.png',
            height: 20,
          ),
        ),
        title: MyText(
          text: widget.sm.adventureName, //'Hill Climbing',
          color: bluishColor,
          weight: FontWeight.w800,
        ),
        actions: [
          GestureDetector(
            onTap: () =>
                selected(context, widget.sm.serviceId, widget.sm.providerId),
            child: const Icon(
              Icons.message,
              color: bluishColor,
            ),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: Container(
        color: greyShadeColor.withOpacity(0.2),
        child: Column(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5.5,
                child: MyServicesList(widget.sm)),
            //GestureDetector(
            //  onTap: () => goToReviews(widget.sm.serviceId.toString()),
            //child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: widget.sm.adventureName, //'Hill Climbing',
                          color: greyBackgroundColor,
                          size: 16,
                          weight: FontWeight.w600,
                          fontFamily: "Roboto",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => editService(widget.sm.id.toString(),
                                  widget.sm.providerId.toString()),
                              child: const Image(
                                image: ExactAssetImage('images/edit.png'),
                                height: 20,
                                width: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Image(
                              image: ExactAssetImage('images/bin.png'),
                              height: 20,
                              width: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Image(
                          image: ExactAssetImage('images/location-on.png'),
                          color: greyColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        MyText(
                          text: widget.sm.sAddress, //'Muscat Oman',
                          color: greyColor,
                          weight: FontWeight.w500,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: "${widget.sm.currency} "
                                  "${widget.sm.costInc}", //'\$ 100.50',
                              color: blackColor,
                              weight: FontWeight.bold,
                              fontFamily: "Roboto",
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            MyText(
                              text:
                                  "including grears & other taxes", //'\$ 100.50',
                              color: Colors.red[600],
                              weight: FontWeight.w600,
                              fontFamily: "Roboto",
                              size: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: "${widget.sm.currency} "
                                  "${widget.sm.costExc}", //'\$ 100.50',
                              color: blackColor,
                              weight: FontWeight.bold,
                              fontFamily: "Roboto",
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            MyText(
                              text:
                                  "excluding grears & other taxes", //'\$ 100.50',
                              color: Colors.red[600],
                              weight: FontWeight.w600,
                              fontFamily: "Roboto",
                              size: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ],
                ),
              )),
            ),
            // ),
            Expanded(
              child:
                  // DetailsTab(
                  //   widget.sm,
                  //   show: true,
                  // )
                  MyServicesTab(widget.sm),
            )
          ],
        ),
      ),
    );
  }
}
