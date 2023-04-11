// ignore_for_file: avoid_print

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/my_adventures.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../models/getClientRequest/get_client_request_model.dart';

class ClientRequestList extends StatefulWidget {
  final List<GetClientRequestModel> rm;
  const ClientRequestList(this.rm, {super.key});

  @override
  State<ClientRequestList> createState() => _ClientRequestListState();
}

class _ClientRequestListState extends State<ClientRequestList> {
  abc() {}

  void goToMyAd() {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (_) {
    //       return const MyAdventures();
    //     },
    //   ),
    // );
  }

  @override
  void initState() {
    super.initState();
    // text2.insert(0, widget.rm[index].bookingId)
  }

  List text = [
    'Booking ID:',
    'UserName:',
    'Nationality:',
    'How Old:',
    'Service Date:',
    'Registrations:',
    'Unit Cost:',
    'Total Cost:',
    'Payable cost variance:',
    'Payment Channel:',
    'Health Con.:',
    'Height & Weight:',
    'Client Msg:'
  ];
  List text2 = [
    '#948579484:',
    'Paul Molive',
    'Indian:',
    '30 Years',
    '30 Sep, 2020',
    '2 Adults, 3 Youngsters',
    '\$ 400.50',
    'CMR 40.00',
    '\$ 1500.50',
    'Wire Transfer',
    'Back bone issue.',
    '5ft 2″ (62″) | 60 Kg.',
    'printing & typesetting industry.'
  ];

  void selected(BuildContext context, int serviceId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
              "https://adventuresclub.net/adventureClub/newreceiverchat/${Constants.userId}/${serviceId}/3");
        },
      ),
    );
  }

  // boooking id
  // provider id

  void decline(String userId, String bookingId, String providerId) async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/booking_accept"),
          body: {
            "booking_id": bookingId,
            'user_id': userId, //"3", //Constants.userId, //"27",
            'status': "3",
            // 'id': "2",
          });
      // setState(() {
      //   favourite = true;
      // });
      if (response.statusCode == 200) {
        cancel();
        message("Cancelled Successfully");
      }
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  void accept(
    String userId,
    String bookingId,
  ) async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/booking_accept"),
          body: {
            "booking_id": bookingId,
            'user_id': userId, //"3", //Constants.userId, //"27",
            'status': "1",
            // 'id': "2",
          });
      // setState(() {
      //   favourite = true;
      // });
      if (response.statusCode == 200) {
        cancel();
        message("Accepted Successfully");
      }
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 00),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: widget.rm.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: widget.rm[index].region, //'Location Name',
                      color: blackColor,
                      size: 12,
                      weight: FontWeight.w700,
                    ),
                    MyText(
                      text: widget.rm[index]
                          .bookedOn, //'Booked on : 25 Sep, 2020 | 10:30',
                      color: bluishColor,
                      weight: FontWeight.w500,
                      fontFamily: 'Roboto',
                      size: 12,
                    )
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: ExactAssetImage('images/airrides.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text:
                                widget.rm[index].adventureName, //'Wadi Hawar',
                            color: blackColor,
                            weight: FontWeight.bold,
                          ),
                          Wrap(direction: Axis.vertical, children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  text: 'Booking ID : ',
                                  color: blackColor,
                                  weight: FontWeight.w500,
                                  size: 12,
                                  height: 1.6,
                                ),
                                MyText(
                                  text: widget.rm[index].bookingId,
                                  color: greyColor,
                                  weight: FontWeight.w400,
                                  size: 12,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  text: 'UserName :',
                                  color: blackColor,
                                  weight: FontWeight.w500,
                                  size: 12,
                                  height: 1.6,
                                ),
                                MyText(
                                  text: widget.rm[index].customer,
                                  color: greyColor,
                                  weight: FontWeight.w400,
                                  size: 12,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  text: 'Nationality:',
                                  color: blackColor,
                                  weight: FontWeight.w500,
                                  size: 12,
                                  height: 1.6,
                                ),
                                MyText(
                                  text: widget.rm[index].nationality,
                                  color: greyColor,
                                  weight: FontWeight.w400,
                                  size: 12,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  text: 'How Old:',
                                  color: blackColor,
                                  weight: FontWeight.w500,
                                  size: 12,
                                  height: 1.6,
                                ),
                                MyText(
                                  text: widget.rm[index].dob,
                                  color: greyColor,
                                  weight: FontWeight.w400,
                                  size: 12,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  text: 'Service Date:',
                                  color: blackColor,
                                  weight: FontWeight.w500,
                                  size: 12,
                                  height: 1.6,
                                ),
                                MyText(
                                  text: widget.rm[index].startDate,
                                  color: greyColor,
                                  weight: FontWeight.w400,
                                  size: 12,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  text: 'Registrations:',
                                  color: blackColor,
                                  weight: FontWeight.w500,
                                  size: 12,
                                  height: 1.6,
                                ),
                                MyText(
                                  text: widget.rm[index].adult,
                                  color: greyColor,
                                  weight: FontWeight.w400,
                                  size: 12,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  text: 'Unit Cost:',
                                  color: blackColor,
                                  weight: FontWeight.w500,
                                  size: 12,
                                  height: 1.6,
                                ),
                                MyText(
                                  text: widget.rm[index].unitCost,
                                  color: greyColor,
                                  weight: FontWeight.w400,
                                  size: 12,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  text: 'Total Cost:',
                                  color: blackColor,
                                  weight: FontWeight.w500,
                                  size: 12,
                                  height: 1.6,
                                ),
                                MyText(
                                  text: widget.rm[index].totalCost,
                                  color: greyColor,
                                  weight: FontWeight.w400,
                                  size: 12,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  text: 'Payable Cost:',
                                  color: blackColor,
                                  weight: FontWeight.w500,
                                  size: 12,
                                  height: 1.6,
                                ),
                                MyText(
                                  text: widget.rm[index].totalCost,
                                  color: greyColor,
                                  weight: FontWeight.w400,
                                  size: 12,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  text: 'Payment Channel',
                                  color: blackColor,
                                  weight: FontWeight.w500,
                                  size: 12,
                                  height: 1.6,
                                ),
                                MyText(
                                  text: widget.rm[index].paymentStatus,
                                  color: greyColor,
                                  weight: FontWeight.w400,
                                  size: 12,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  text: 'Health Condition:',
                                  color: blackColor,
                                  weight: FontWeight.w500,
                                  size: 12,
                                  height: 1.6,
                                ),
                                MyText(
                                  text: widget.rm[index].healthCondition,
                                  color: greyColor,
                                  weight: FontWeight.w400,
                                  size: 12,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  text: 'Height',
                                  color: blackColor,
                                  weight: FontWeight.w500,
                                  size: 12,
                                  height: 1.6,
                                ),
                                MyText(
                                  text: widget.rm[index].height,
                                  color: greyColor,
                                  weight: FontWeight.w400,
                                  size: 12,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  text: 'Weight',
                                  color: blackColor,
                                  weight: FontWeight.w500,
                                  size: 12,
                                  height: 1.6,
                                ),
                                MyText(
                                  text: widget.rm[index].weight,
                                  color: greyColor,
                                  weight: FontWeight.w400,
                                  size: 12,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  text: 'Client Message',
                                  color: blackColor,
                                  weight: FontWeight.w500,
                                  size: 12,
                                  height: 1.6,
                                ),
                                MyText(
                                  text: widget.rm[index].message,
                                  color: greyColor,
                                  weight: FontWeight.w400,
                                  size: 12,
                                ),
                              ],
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => selected(
                        context,
                        widget.rm[index].serviceId,
                        //widget.rm[index].providerId
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 21,
                        width: MediaQuery.of(context).size.width / 3.8,
                        decoration: const BoxDecoration(
                          color: blueColor1,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Chat Client',
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
                    GestureDetector(
                      onTap: () => accept(
                        widget.rm[index].bookingUser.toString(),
                        widget.rm[index].bookingId.toString(),
                        //widget.rm[index].providerId
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 21,
                        width: MediaQuery.of(context).size.width / 3.8,
                        decoration: const BoxDecoration(
                          color: darkGreen,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Accept',
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
                    //     'Accept', darkGreen, whiteColor, 3.7, 21, 12, abc),
                    GestureDetector(
                      onTap: () => decline(
                          widget.rm[index].bookingUser.toString(),
                          widget.rm[index].bookingId.toString(),
                          widget.rm[index].ownerId.toString()
                          //widget.rm[index].providerId
                          ),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 21,
                        width: MediaQuery.of(context).size.width / 3.8,
                        decoration: const BoxDecoration(
                          color: darkRed,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Decline',
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
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
