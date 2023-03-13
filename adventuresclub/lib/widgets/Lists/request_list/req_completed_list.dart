// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/my_adventures.dart';
import 'package:adventuresclub/models/requests/upcoming_Requests_Model.dart';
import 'package:adventuresclub/models/services/service_image_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/buttons/square_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Chat_list.dart/show_chat.dart';

class ReqCompletedList extends StatefulWidget {
  const ReqCompletedList({super.key});

  @override
  State<ReqCompletedList> createState() => _ReqCompletedListState();
}

class _ReqCompletedListState extends State<ReqCompletedList> {
  Map Ulist = {};
  List<ServiceImageModel> gSim = [];
  List<UpcomingRequestsModel> uRequestList = [];
  Map mapChat = {};

  @override
  initState() {
    super.initState();
    getReqList();
  }

  Future getReqList() async {
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/get_requests?user_id=${Constants.userId}&type=1"));
    try {
      if (response.statusCode == 200) {
        Ulist = json.decode(response.body);
        List<dynamic> result = Ulist['data'];
        result.forEach((element) {
          List<dynamic> image = element['images'];
          image.forEach((i) {
            ServiceImageModel sm = ServiceImageModel(
              int.tryParse(i['id'].toString()) ?? 0,
              int.tryParse(i['service_id'].toString()) ?? 0,
              int.tryParse(i['is_default'].toString()) ?? 0,
              i['image_url'].toString() ?? "",
              i['thumbnail'].toString() ?? "",
            );
            gSim.add(sm);
          });
          String bookingN = element["booking_id"].toString();
          text2[0] = bookingN;
          UpcomingRequestsModel up = UpcomingRequestsModel(
              int.tryParse(bookingN) ?? 0,
              int.tryParse(element["service_id"].toString()) ?? 0,
              int.tryParse(element["provider_id"].toString()) ?? 0,
              int.tryParse(element["service_plan"].toString()) ?? 0,
              element["country"].toString() ?? "",
              element["currency"].toString() ?? "",
              element["region"].toString() ?? "",
              element["adventure_name"].toString() ?? "",
              element["provider_name"].toString() ?? "",
              element["height"].toString() ?? "",
              element["weight"].toString() ?? "",
              element["health_conditions"].toString() ?? "",
              element["booking_date"].toString() ?? "",
              element["activity_date"].toString() ?? "",
              int.tryParse(element["adult"].toString()) ?? 0,
              int.tryParse(element["kids"].toString()) ?? 0,
              element["unit_cost"].toString() ?? "",
              element["total_cost"].toString() ?? "",
              element["discounted_amount"].toString() ?? "",
              element["payment_channel"].toString() ?? "",
              element["status"].toString() ?? "",
              element["payment_status"].toString() ?? "",
              element["points"].toString() ?? "",
              element["description"].toString() ?? "",
              element["registrations"].toString() ?? "",
              gSim);
          uRequestList.add(up);
        });
      }
      setState(() {});
      print(response.statusCode);
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  // void getChats() async {
  //   // setState(() {
  //   //   loading = true;
  //   // });
  //   try {
  //     var response = await http.get(
  //       Uri.parse(
  //           "https://adventuresclub.net/adventureClub/newreceiverchat/3/1/3"),
  //     );
  //     if (response.statusCode == 200) {
  //       mapChat = json.decode(response.body);
  //       List<dynamic> result = mapChat['data'];
  //       result.forEach((element) {});
  //     }
  //     // setState(() {
  //     //   loading = false;
  //     // });
  //     print(response.statusCode);
  //     print(response.body);
  //     print(response.headers);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Future getReqList() async {
  //   var response = await http.get(Uri.parse(
  //       "https://adventuresclub.net/adventureClub/api/v1/get_requests?user_id=27&type=1"));
  //   try {
  //     if (response.statusCode == 200) {
  //       Ulist = json.decode(response.body);
  //       List<dynamic> result = Ulist['data'];
  //       result.forEach((element) {});
  //     }
  //     print(response.statusCode);
  //     print(response.body);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  abc() {}
  void goToMyAd() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const MyAdventures();
        },
      ),
    );
  }

  List text = [
    'Booking Number :',
    'Activity Name :',
    'Provider Name :',
    'Booking Date :',
    'Activity Date :',
    'Registrations :',
    'Unit Cost :',
    'Total Cost :',
    'Payable Cost',
    'Payment Channel :'
  ];
  List text2 = [
    '112',
    'Mr adventure',
    'John Doe',
    '30 Sep, 2020',
    '05 Oct, 2020',
    '2 Adults, 3 Youngsters',
    '\$ 400.50',
    '\$ 1500.50',
    '\$ 1500.50',
    'Debit/Credit Card'
  ];

  void selected(BuildContext context, int serviceId, int providerId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
              "https://adventuresclub.net/adventureClub/newreceiverchat/${Constants.userId}/${serviceId}/${providerId}");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 00),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: uRequestList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: uRequestList[index].region, //'Location Name',
                        color: blackColor,
                      ),
                      MyText(
                        text: 'Confirmed',
                        color: Colors.green,
                        weight: FontWeight.bold,
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          radius: 26,
                          backgroundImage:
                              //ExactAssetImage('images/airrides.png'),
                              NetworkImage(
                                  "${"https://adventuresclub.net/adventureClub/public/"}${uRequestList[index].sImage[0].imageUrl}}")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(direction: Axis.vertical, children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "Booking Number: ",
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: uRequestList[index].BookingId,
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "Activity Name: ",
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: uRequestList[index].adventureName,
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "Provider Name: ",
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: uRequestList[index].pName,
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "Booking Date: ",
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: uRequestList[index].bDate,
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "Activity Date : ",
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: uRequestList[index].aDate,
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "Registrations :",
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: uRequestList[index].registration,
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "Unit Cost : ",
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: uRequestList[index].uCost,
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "Total Cost : ",
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: uRequestList[index].tCost,
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "Payable Cost : ",
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: uRequestList[index].tCost,
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "Payment Channel : ",
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: uRequestList[index].pChanel,
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                            ]

                                //     List.generate(uRequestList.length, (index) {
                                //   return Row(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: [
                                //       MyText(
                                //         text: text[index],
                                //         color: blackColor,
                                //         weight: FontWeight.w500,
                                //         size: 13,
                                //         height: 1.8,
                                //       ),
                                //       MyText(
                                //         text: uRequestList[index].BookingId,
                                //         color: greyColor,
                                //         weight: FontWeight.w400,
                                //         size: 13,
                                //         height: 1.8,
                                //       ),
                                //     ],
                                //   );
                                // }),
                                ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SquareButton('View Details', bluishColor, whiteColor, 3.7,
                          21, 12, abc),
                      SquareButton('Rate Now', yellowcolor, whiteColor, 3.7, 21,
                          12, goToMyAd),
                      GestureDetector(
                        onTap: () => selected(
                            context,
                            uRequestList[index].serviceId,
                            uRequestList[index].providerId),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 21,
                          width: MediaQuery.of(context).size.width / 3.8,
                          decoration: const BoxDecoration(
                            color: blueColor1,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Chat Provider',
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // SquareButton(
                      //     'Chat Provider',
                      //     blueColor1,
                      //     whiteColor,
                      //     3.7,
                      //     21,
                      //     12,
                      //     () => selected(
                      //         context,
                      //         uRequestList[index].serviceId.toString(),
                      //         uRequestList[index].providerId.toString())),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
