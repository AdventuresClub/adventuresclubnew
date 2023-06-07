// ignore_for_file: avoid_print

import 'package:adventuresclub/constants.dart';
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
  List<GetClientRequestModel> gRM = [];

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
    gRM = widget.rm;
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

  void selected(BuildContext context, int serviceId, int bookingUser) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
              "https://adventuresclub.net/adventureClub/newchat/${Constants.userId}/$serviceId/$bookingUser");
          // "https://adventuresclub.net/adventureClub/newreceiverchat/${providerId}/${serviceId}/${Constants.userId}");
        },
      ),
    );
  }

  // boooking id
  // provider id

  void decline(
      String userId, String bookingId, String providerId, int index) async {
    GetClientRequestModel gR = gRM.elementAt(index);
    setState(() {
      gRM.removeAt(index);
    });
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
      if (response.statusCode != 200) {
        setState(() {
          gRM.insert(index, gR);
        });
      } else {
        message("Cancelled Successfully");
      }
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  void accept(String userId, String bookingId, int index) async {
    GetClientRequestModel gR = gRM.elementAt(index);
    setState(() {
      gRM.removeAt(index);
    });
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
      if (response.statusCode != 200) {
        setState(() {
          gRM.insert(index, gR);
        });
      } else {
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

  String calculateAge(String d) {
    DateTime birthdate = DateTime.parse(d);
    final now = DateTime.now();
    var age = now.year - birthdate.year;
    if (now.month < birthdate.month ||
        (now.month == birthdate.month && now.day < birthdate.day)) {
      age--;
    }
    return '$age years old';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 00),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: gRM.length,
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
                      text: gRM[index].region, //'Location Name',
                      color: blackColor,
                      size: 12,
                      weight: FontWeight.w700,
                    ),
                    Row(
                      children: [
                        MyText(
                          text:
                              "Booked On : ", //'Booked on : 25 Sep, 2020 | 10:30',
                          color: bluishColor,
                          weight: FontWeight.w800,
                          fontFamily: 'Roboto',
                          size: 12,
                        ),
                        MyText(
                          text: gRM[index]
                              .bookedOn, //'Booked on : 25 Sep, 2020 | 10:30',
                          color: bluishColor,
                          weight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          size: 12,
                        ),
                      ],
                    )
                  ],
                ),
                const Divider(),

                ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          //ExactAssetImage('images/airrides.png'),
                          NetworkImage(
                              "${'https://adventuresclub.net/adventureClub/public/uploads/'}${gRM[index].sm[index].thumbnail}"),
                    ),
                    title: Column(
                      children: [
                        Row(
                          children: [
                            MyText(
                              text: widget
                                  .rm[index].adventureName, //'Wadi Hawar',
                              color: blackColor,
                              weight: FontWeight.bold,
                              size: 18,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyText(
                              text: 'Booking ID : ',
                              color: blackColor,
                              weight: FontWeight.w500,
                              size: 12,
                              height: 1.6,
                            ),
                            MyText(
                              text: gRM[index].bookingId,
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
                              text: 'UserName : ',
                              color: blackColor,
                              weight: FontWeight.w500,
                              size: 12,
                              height: 1.6,
                            ),
                            MyText(
                              text: gRM[index].customer,
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
                              text: 'Nationality: ',
                              color: blackColor,
                              weight: FontWeight.w500,
                              size: 12,
                              height: 1.6,
                            ),
                            MyText(
                              text: gRM[index].nationality,
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
                              text: 'How Old: ',
                              color: blackColor,
                              weight: FontWeight.w500,
                              size: 12,
                              height: 1.6,
                            ),
                            MyText(
                              text: calculateAge(gRM[index].dob),
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
                              text: 'Service Date: ',
                              color: blackColor,
                              weight: FontWeight.w500,
                              size: 12,
                              height: 1.6,
                            ),
                            MyText(
                              text: gRM[index].serviceDate,
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
                              text: 'Registrations: ',
                              color: blackColor,
                              weight: FontWeight.w500,
                              size: 12,
                              height: 1.6,
                            ),
                            MyText(
                              text: "${gRM[index].adult}"
                                  " "
                                  "${"Adult"}"
                                  ", "
                                  "${gRM[index].kids}"
                                  " "
                                  "${"Youngsters"}",
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
                              text: 'Unit Cost: ',
                              color: blackColor,
                              weight: FontWeight.w500,
                              size: 12,
                              height: 1.6,
                            ),
                            MyText(
                              text: gRM[index].unitCost,
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
                              text: 'Total Cost: ',
                              color: blackColor,
                              weight: FontWeight.w500,
                              size: 12,
                              height: 1.6,
                            ),
                            MyText(
                              text: gRM[index].totalCost,
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
                              text: 'Payable Cost: ',
                              color: blackColor,
                              weight: FontWeight.w500,
                              size: 12,
                              height: 1.6,
                            ),
                            MyText(
                              text: gRM[index].totalCost,
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
                              text: 'Payment Channel: ',
                              color: blackColor,
                              weight: FontWeight.w500,
                              size: 12,
                              height: 1.6,
                            ),
                            MyText(
                              text: gRM[index].paymentStatus,
                              color: greyColor,
                              weight: FontWeight.w400,
                              size: 12,
                            ),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     MyText(
                        //       text: 'Health Condition: ',
                        //       color: blackColor,
                        //       weight: FontWeight.w500,
                        //       size: 12,
                        //       height: 1.6,
                        //     ),
                        //     MyText(
                        //       text: gRM[index].healthCondition,
                        //       color: greyColor,
                        //       weight: FontWeight.w400,
                        //       size: 12,
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 2,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Health Condition: ',
                            style: const TextStyle(
                              color: blackColor,
                              fontSize: 13,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: gRM[index].healthCondition,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: blackColor,
                                    fontWeight: FontWeight.w300,
                                  )),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyText(
                              text: 'Height: ',
                              color: blackColor,
                              weight: FontWeight.w500,
                              size: 12,
                              height: 1.6,
                            ),
                            MyText(
                              text: gRM[index].height,
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
                              text: 'Weight: ',
                              color: blackColor,
                              weight: FontWeight.w500,
                              size: 12,
                              height: 1.6,
                            ),
                            MyText(
                              text: gRM[index].weight,
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
                              text: 'Client Message: ',
                              color: blackColor,
                              weight: FontWeight.w500,
                              size: 12,
                              height: 1.6,
                            ),
                            MyText(
                              text: gRM[index].message,
                              color: greyColor,
                              weight: FontWeight.w400,
                              size: 12,
                            ),
                          ],
                        ),
                      ],
                    )),

                // ListView(
                //   // direction: Axis.vertical,
                //   //crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                // Row(
                //   children: [
                //     // CircleAvatar(
                //     //   radius: 25,
                //     //   backgroundImage:
                //     //       //ExactAssetImage('images/airrides.png'),
                //     //       NetworkImage(
                //     //           "${'https://adventuresclub.net/adventureClub/public/uploads/'}${widget.rm[index].sm[index].thumbnail}"),
                //     // ),
                //     // const SizedBox(
                //     //   width: 20,
                //     // ),
                //   ],
                // ),
                const SizedBox(
                  height: 10,
                ),

                //   ],
                // ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 21,
                      width: MediaQuery.of(context).size.width / 3.8,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: blueColor1),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => selected(context, gRM[index].serviceId,
                              gRM[index].bookingUser),
                          child: const Center(
                            child: Text(
                              'Chat Client',
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      // color: bluishColor,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 21,
                      width: MediaQuery.of(context).size.width / 3.8,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: darkGreen),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => accept(
                            gRM[index].bookingUser.toString(),
                            gRM[index].bookingId.toString(),
                            index,
                            //gRM[index].providerId
                          ),
                          child: const Center(
                            child: Text(
                              'Accept',
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      // color: bluishColor,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 21,
                      width: MediaQuery.of(context).size.width / 3.8,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: darkRed),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => decline(
                            gRM[index].bookingUser.toString(),
                            gRM[index].bookingId.toString(),
                            gRM[index].ownerId.toString(),
                            //widget.rm[index].providerId
                            index,
                          ),
                          child: const Center(
                            child: Text(
                              'Decline',
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      // color: bluishColor,
                    ),
                    // SquareButton(
                    //     'Accept', darkGreen, whiteColor, 3.7, 21, 12, abc),
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
