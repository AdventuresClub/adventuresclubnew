import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/client_requests.dart';
import 'package:adventuresclub/home_Screens/accounts/my_services.dart';
import 'package:adventuresclub/home_Screens/payment_methods/payment_methods.dart';
import 'package:adventuresclub/models/requests/upcoming_Requests_Model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/buttons/square_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/services/service_image_model.dart';

class RequestsList extends StatefulWidget {
  const RequestsList({super.key});

  @override
  State<RequestsList> createState() => _RequestsListState();
}

class _RequestsListState extends State<RequestsList> {
  Map Ulist = {};
  String userID = "27";
  List<ServiceImageModel> gSim = [];
  List<UpcomingRequestsModel> uRequestList = [];
  @override
  initState() {
    super.initState();
    getList();
  }

  Future getList() async {
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/get_requests?user_id=27&type=0"));
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

  void goToMakePayments() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const PaymentMethods();
    }));
  }

  void goTo() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const ClientsRequests();
    }));
  }

  void goTo_() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const MyServices();
    }));
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
  @override
  Widget build(BuildContext context) {
    return uRequestList.isEmpty
        ? Center(
            child: Column(
              children: const [Text("There is no upcoming adventure yet")],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 00),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: uRequestList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: 'Location Name',
                            color: blackColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MyText(
                                text: 'Confirmed',
                                color: Colors.orange,
                                weight: FontWeight.bold,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Image(
                                image: ExactAssetImage(
                                  'images/bin.png',
                                ),
                                color: Colors.orange,
                                height: 20,
                              ),
                            ],
                          )
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: greyColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 26,
                            backgroundImage:
                                ExactAssetImage('images/airrides.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Booking Number",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Activity Name",
                                          color: blackColor,
                                          weight: FontWeight.w500,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                        MyText(
                                          text:
                                              uRequestList[index].adventureName,
                                          color: greyColor,
                                          weight: FontWeight.w400,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Provider Name",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Booking Date",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Activity Date",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Registrations",
                                          color: blackColor,
                                          weight: FontWeight.w500,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                        MyText(
                                          text:
                                              uRequestList[index].registration,
                                          color: greyColor,
                                          weight: FontWeight.w400,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Unit Cost",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Total Cost",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Payable Cost",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Payment Channel",
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
                                  ],
                                  // List.generate(
                                  //   text.length,
                                  //   (index) {
                                  //     return

                                  //   },
                                  // ),
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
                          SquareButton('View Details', bluishColor, whiteColor,
                              3.7, 21, 12, goTo),
                          SquareButton('Cancel Requests', redColor, whiteColor,
                              3.7, 21, 12, goTo_),
                          SquareButton('Make Payment', greenColor1, whiteColor,
                              3.7, 21, 12, goToMakePayments),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
  }
}
