// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:adventuresclub/home_Screens/payment_methods/payment_methods.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../models/getParticipants/get_participants_model.dart';
import 'Chat_list.dart/show_chat.dart';

class ParticipantsList extends StatefulWidget {
  final List<GetParticipantsModel> gm;
  const ParticipantsList(this.gm, {super.key});

  @override
  State<ParticipantsList> createState() => _ParticipantsListState();
}

class _ParticipantsListState extends State<ParticipantsList> {
  bool value = false;
  List<String> customers = [];
  List<String> nationality = [];
  //DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    //final age = now.year - birthdate.year;
  }

  List text = [
    'User Name :',
    'Nationality :',
    'How Old :',
    'Service Date :',
    'Registrations :',
    'Unit Cost :',
    'Total Cost :',
    'Payment Channel :',
    'Health Con. :',
    'Height & Weight :'
  ];
  List text2 = [
    // 'Lillian Burt',
    // 'Indian',
    // '30 Years',
    // '30 Sep, 2020',
    // '2 Adults, 3 Youngsters',
    // '\$ 400.50',
    // '\$ 1500.50',
    // 'Wire Transfer',
    // 'Back bone issue.',
    // '5ft 2″ (62″) | 60 Kg.',
    // ''
  ];

  void selected(BuildContext context, int serviceId, int providerId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
              "https://adventuresclub.net/adventureClub/newreceiverchat/${Constants.userId}/$serviceId/$providerId");
        },
      ),
    );
  }

  List<String> title = [
    "Booking Id : ",
    "How Old : ",
    "Nationality : ",
    "Booked On : ",
    "Service Date : ",
    "Registration : ",
    "Unit Cost : ",
    "Total Cost : ",
    "Payable Cost : ",
    "Weight : ",
    "Height : ",
  ];

  List<String> titleValue = [];

  //// https://adventuresclub.net/adventureClub/newchat/3/2/6 //provider = 3 , service = 2 , member/userId = 6

  void showConfirmation(String id) async {
    showDialog(
        context: context,
        builder: (ctx) => SimpleDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: MyText(
                text: "Alert",
                weight: FontWeight.bold,
                color: blackColor,
              ),
              children: [
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: MyText(
                    text: "Are you sure you want to delete?",
                    size: 16,
                    weight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
                // text:
                //     "After approval you'll be notified and have to buy your subscription package",
                // size: 18,
                // weight: FontWeight.w500,
                // color: blackColor.withOpacity(0.6),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: homePage,
                      child: MyText(
                        text: "No",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => delete(id),
                      child: MyText(
                        text: "Yes",
                      ),
                    ),
                  ],
                )
                //BottomButton(bgColor: blueButtonColor, onTap: homePage)
              ],
            ));
  }

  void rateUser() async {
    showDialog(
        context: context,
        builder: (ctx) => SimpleDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: MyText(
                text: "User Attended",
                weight: FontWeight.bold,
                color: blackColor,
              ),
              children: [
                // text:
                //     "After approval you'll be notified and have to buy your subscription package",
                // size: 18,
                // weight: FontWeight.w500,
                // color: blackColor.withOpacity(0.6),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: homePage,
                      child: MyText(
                        text: "No",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: ratedUser,
                      child: MyText(
                        text: "Yes",
                      ),
                    ),
                  ],
                )
                //BottomButton(bgColor: blueButtonColor, onTap: homePage)
              ],
            ));
  }

  void ratedUser() {
    Navigator.of(context).pop();
    message("Success");
  }

  //https://adventuresclub.net/adventureClub/api/v1/booking_accept

  void delete(String id) async {
    Navigator.of(context).pop();
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/booking_accept"),
          body: {
            'booking_id': id,
            'status': "5",
            'user_id': Constants.userId.toString(),
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        message("Deleted Successfully");
        homePage();
      }
      print(response.statusCode);
    } catch (e) {
      print(e.toString());
    }
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void homePage() {
    Navigator.of(context).pop();
  }

  void cancel() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const BottomNavigation();
    }));
  }

  // void convert(String d) {
  //   DateTime dob = DateTime.parse(d);
  //   calculateAge(dob);
  // }

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

  final birthdate = DateTime(1990, 5, 15);
  // final ageString = calculateAge(birthdate);

  @override
  Widget build(BuildContext context) {
    return widget.gm.isEmpty
        ? Center(
            child: MyText(
              text: "No Participants Yet",
              color: blackColor,
              weight: FontWeight.bold,
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 00),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: widget.gm.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, left: 10, right: 10, bottom: 15),
                  child: Wrap(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.spaceBetween,
                    //crossAxisAlignment: WrapCrossAlignment.,
                    children: [
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        // \mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MyText(
                            text: widget.gm[index].region, //'Location Name',
                            color: blackColor,
                            weight: FontWeight.bold,
                          ),
                          // const SizedBox(
                          //   width: 20,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(left: 180.0),
                            child: Row(
                              children: [
                                if (widget.gm[index].status == "0")
                                  MyText(
                                    text: "Paid", //'Confirmed',
                                    color: redColor,
                                    weight: FontWeight.bold,
                                  ),
                                if (widget.gm[index].status == "1")
                                  MyText(
                                    text: "Accepted", //'Confirmed',
                                    color: greenColor1,
                                    weight: FontWeight.bold,
                                  ),
                                if (widget.gm[index].status == "2")
                                  MyText(
                                    text: "Requested", //'Confirmed',
                                    color: greenColor1,
                                    weight: FontWeight.bold,
                                  ),
                                if (widget.gm[index].status == "3")
                                  MyText(
                                    text: "Declined", //'Confirmed',
                                    color: redColor,
                                    weight: FontWeight.bold,
                                  ),
                                if (widget.gm[index].status == "4")
                                  MyText(
                                    text: "Completed", //'Confirmed',
                                    color: greenColor1,
                                    weight: FontWeight.bold,
                                  ),
                                if (widget.gm[index].status == "5")
                                  MyText(
                                    text: "Dropped", //'Confirmed',
                                    color: redColor,
                                    weight: FontWeight.bold,
                                  ),
                                if (widget.gm[index].status == "6")
                                  MyText(
                                    text: "Confirm", //'Confirmed',
                                    color: greenColor1,
                                    weight: FontWeight.bold,
                                  ),
                                if (widget.gm[index].status == "7")
                                  MyText(
                                    text: "UnPaid", //'Confirmed',
                                    color: greenColor1,
                                    weight: FontWeight.bold,
                                  ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () => showConfirmation(
                                      widget.gm[index].serviceId.toString()),
                                  child: const Icon(
                                    Icons.delete_forever_outlined,
                                    color: redColor,
                                    size: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: blackColor.withOpacity(0.4),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 28,
                            backgroundImage:
                                ExactAssetImage('images/airrides.png'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: widget.gm[index].adventureName,
                                    color: blackColor,
                                    weight: FontWeight.w700,
                                    size: 14,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: 'Booking Id : ',
                                    color: blackColor,
                                    weight: FontWeight.w700,
                                    size: 14,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: widget.gm[index].bookingId,
                                    color: greyTextColor,
                                    weight: FontWeight.w400,
                                    size: 12,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: 'How Old : ',
                                    color: blackColor,
                                    weight: FontWeight.w700,
                                    size: 14,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: calculateAge(widget.gm[index].dob),
                                    color: greyTextColor,
                                    weight: FontWeight.w400,
                                    size: 12,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: 'Nationality : ',
                                    color: blackColor,
                                    weight: FontWeight.w700,
                                    size: 14,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: widget.gm[index].nationality,
                                    color: greyTextColor,
                                    weight: FontWeight.w400,
                                    size: 12,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: 'Booked On : ',
                                    color: blackColor,
                                    weight: FontWeight.w700,
                                    size: 14,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: widget.gm[index].bookedOn,
                                    color: greyTextColor,
                                    weight: FontWeight.w400,
                                    size: 12,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: 'Service Date : ',
                                    color: blackColor,
                                    weight: FontWeight.w700,
                                    size: 14,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: widget.gm[index].serviceDate,
                                    color: greyTextColor,
                                    weight: FontWeight.w400,
                                    size: 12,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: 'Registrations : ',
                                    color: blackColor,
                                    weight: FontWeight.w700,
                                    size: 14,
                                    height: 1.8,
                                  ),
                                  if (widget.gm[index].adult != 0)
                                    MyText(
                                      text: "${widget.gm[index].adult} "
                                          " ${"Adult"}"
                                          ",  "
                                          "${widget.gm[index].kids} "
                                          " ${"Youngsters"}",
                                      color: greyTextColor,
                                      weight: FontWeight.w400,
                                      size: 12,
                                      height: 1.8,
                                    ),
                                  if (widget.gm[index].kids != 0)
                                    MyText(
                                      text: "${widget.gm[index].kids} "
                                          " ${"Kids"}",
                                      color: greyTextColor,
                                      weight: FontWeight.w400,
                                      size: 12,
                                      height: 1.8,
                                    ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: 'Unit Cost : ',
                                    color: blackColor,
                                    weight: FontWeight.w700,
                                    size: 14,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    overFlow: TextOverflow.ellipsis,
                                    text: "${widget.gm[index].unitCost} "
                                        "  ${widget.gm[index].currency}",
                                    color: greyTextColor,
                                    weight: FontWeight.w400,
                                    size: 12,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: 'Total Cost : ',
                                    color: blackColor,
                                    weight: FontWeight.w700,
                                    size: 14,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: "${widget.gm[index].totalCost} "
                                        "  ${widget.gm[index].currency}",
                                    color: greyTextColor,
                                    weight: FontWeight.w400,
                                    size: 12,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: 'Payable Cost : ',
                                    color: blackColor,
                                    weight: FontWeight.w700,
                                    size: 14,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: "${widget.gm[index].totalCost} "
                                        "  ${widget.gm[index].currency}",
                                    color: greyTextColor,
                                    weight: FontWeight.w400,
                                    size: 12,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: 'Weight : ',
                                    color: blackColor,
                                    weight: FontWeight.w700,
                                    size: 14,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: "${widget.gm[index].weight} ",
                                    color: greyTextColor,
                                    weight: FontWeight.w400,
                                    size: 12,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: 'Health : ',
                                    color: blackColor,
                                    weight: FontWeight.w700,
                                    size: 14,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    overFlow: TextOverflow.clip,
                                    text:
                                        "${widget.gm[index].healthConditions} ",
                                    color: greyTextColor,
                                    weight: FontWeight.w400,
                                    size: 12,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: 'Height : ',
                                    color: blackColor,
                                    weight: FontWeight.w700,
                                    size: 14,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    overFlow: TextOverflow.clip,
                                    text: "${widget.gm[index].height} ",
                                    color: greyTextColor,
                                    weight: FontWeight.w400,
                                    size: 12,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: 'Client Message : ',
                                    color: blackColor,
                                    weight: FontWeight.w700,
                                    size: 14,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    overFlow: TextOverflow.clip,
                                    text: "${widget.gm[index].message} ",
                                    color: greyTextColor,
                                    weight: FontWeight.w400,
                                    size: 12,
                                    height: 1.8,
                                  ),
                                ],
                              )
                              //   ],
                              // ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => selected(
                                context,
                                widget.gm[index].serviceId,
                                widget.gm[index].providerId),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 21,
                              width: MediaQuery.of(context).size.width / 3.8,
                              decoration: const BoxDecoration(
                                color: blueColor1,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 120.0),
                            child: GestureDetector(
                              onTap: rateUser,
                              child: Container(
                                height: MediaQuery.of(context).size.height / 21,
                                width: MediaQuery.of(context).size.width / 3.8,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 92, 11, 106),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Rate User',
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
                          ),
                          // SquareButton('Chat Client', blueButtonColor, whiteColor,
                          //     3.1, 21, 13, abc),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
  }
}
