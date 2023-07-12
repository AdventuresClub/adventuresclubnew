// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/participants_container.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../models/getParticipants/get_participants_model.dart';
import 'Chat_list.dart/show_chat.dart';

class ParticipantsList extends StatefulWidget {
  final List<GetParticipantsModel> participantsList;
  const ParticipantsList(this.participantsList, {super.key});

  @override
  State<ParticipantsList> createState() => _ParticipantsListState();
}

class _ParticipantsListState extends State<ParticipantsList> {
  bool value = false;
  List<String> customers = [];
  List<String> nationality = [];
  List<GetParticipantsModel> gm = [];
  //DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    gm = widget.participantsList;
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

  void showConfirmation(String bookingId, String bookingUser, int index) async {
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
                      onPressed: () => delete(bookingId, bookingUser, index),
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

  void delete(String bookingId, String bookingUser, int index) async {
    Navigator.of(context).pop();
    try {
      GetParticipantsModel pm = gm.elementAt(index);
      setState(() {
        gm.removeAt(index);
      });
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/booking_delete"),
          body: {
            'booking_id': bookingId,
            // 'user_id': bookingUser,
            // 'status': "3",
          });
      if (response.statusCode != 200) {
        setState(() {
          gm.insert(index, pm);
        });
      } else {
        message("Deleted Successfully");
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
    return gm.isEmpty
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
            itemCount: gm.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return //Container();
                  ParticipantsContainer(
                      gm[index], selected, delete, rateUser, index);
            });
    // Card(
    //   child: Padding(
    //     padding: const EdgeInsets.only(
    //         top: 15.0, left: 10, right: 10, bottom: 15),
    //     child: Column(
    //       // direction: Axis.vertical,
    //       // alignment: WrapAlignment.spaceBetween,
    //       //crossAxisAlignment: WrapCrossAlignment.,
    //       children: [
    //         // Row(
    //         //   crossAxisAlignment: CrossAxisAlignment.end,
    //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         //   children: [
    //         //     MyText(
    //         //       text: gm[index].region, //'Location Name',
    //         //       color: blackColor,
    //         //       weight: FontWeight.bold,
    //         //     ),
    //         //     Row(
    //         //       children: [
    //         //         if (gm[index].status == "0")
    //         //           MyText(
    //         //             text: "REQUESTED", //'Confirmed',
    //         //             color: blueColor1,
    //         //             weight: FontWeight.bold,
    //         //           ),
    //         //         if (gm[index].status == "1")
    //         //           MyText(
    //         //             text: "ACCEPTED", //'Confirmed',
    //         //             color: orangeColor,
    //         //             weight: FontWeight.bold,
    //         //           ),
    //         //         if (gm[index].status == "2")
    //         //           MyText(
    //         //             text: "PAID", //'Confirmed',
    //         //             color: greenColor1,
    //         //             weight: FontWeight.bold,
    //         //           ),
    //         //         if (gm[index].status == "3")
    //         //           MyText(
    //         //             text: "DECLINED", //'Confirmed',
    //         //             color: redColor,
    //         //             weight: FontWeight.bold,
    //         //           ),
    //         //         if (gm[index].status == "4")
    //         //           MyText(
    //         //             text: "COMPLETED", //'Confirmed',
    //         //             color: greenColor1,
    //         //             weight: FontWeight.bold,
    //         //           ),
    //         //         if (gm[index].status == "5")
    //         //           MyText(
    //         //             text: "DROPPED", //'Confirmed',
    //         //             color: redColor,
    //         //             weight: FontWeight.bold,
    //         //           ),
    //         //         if (gm[index].status == "6")
    //         //           MyText(
    //         //             text: "CONFIRM", //'Confirmed',
    //         //             color: greenColor1,
    //         //             weight: FontWeight.bold,
    //         //           ),
    //         //         if (gm[index].status == "7")
    //         //           MyText(
    //         //             text: "UNPAID", //'Confirmed',
    //         //             color: greenColor1,
    //         //             weight: FontWeight.bold,
    //         //           ),
    //         //         const SizedBox(
    //         //           width: 5,
    //         //         ),
    //         //         GestureDetector(
    //         //           onTap: () => showConfirmation(
    //         //               gm[index].bookingId.toString(),
    //         //               gm[index].bookingUser.toString(),
    //         //               index),
    //         //           child: const Icon(
    //         //             Icons.delete_forever_outlined,
    //         //             color: redColor,
    //         //             size: 20,
    //         //           ),
    //         //         )
    //         //       ],
    //         //     ),
    //         //   ],
    //         // ),
    //         Divider(
    //           thickness: 2,
    //           color: blackColor.withOpacity(0.4),
    //         ),
    //         ListTile(
    //           // leading: SizedBox(
    //           //   width: 60,
    //           //   child: CircleAvatar(
    //           //     radius: 26,
    //           //     backgroundImage:
    //           //         //ExactAssetImage('images/airrides.png'),
    //           //         NetworkImage(
    //           //       "${'https://adventuresclub.net/adventureClub/public/'}${gm[index].providerProfile},",
    //           //     ),
    //           //   ),
    //           // ),
    //           //     const CircleAvatar(
    //           //   radius: 28,
    //           //   backgroundImage:
    //           //       ExactAssetImage('images/airrides.png'),
    //           // ),
    //           // NetworkImage(
    //           //     "${'https://adventuresclub.net/adventureClub/public/uploads/'}${gm[index].sm[index].imageUrl}")),,
    //           title: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   MyText(
    //                     text: gm[index].adventureName,
    //                     color: blackColor,
    //                     weight: FontWeight.w700,
    //                     size: 14,
    //                     height: 1.8,
    //                   ),
    //                 ],
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   MyText(
    //                     text: 'Booking Id : ',
    //                     color: blackColor,
    //                     weight: FontWeight.w700,
    //                     size: 14,
    //                     height: 1.8,
    //                   ),
    //                   MyText(
    //                     text: gm[index].bookingId,
    //                     color: greyTextColor,
    //                     weight: FontWeight.w400,
    //                     size: 12,
    //                     height: 1.8,
    //                   ),
    //                 ],
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   MyText(
    //                     text: 'UserName : ',
    //                     color: blackColor,
    //                     weight: FontWeight.w700,
    //                     size: 14,
    //                     height: 1.8,
    //                   ),
    //                   MyText(
    //                     text: gm[index].customer,
    //                     color: greyTextColor,
    //                     weight: FontWeight.w400,
    //                     size: 12,
    //                     height: 1.8,
    //                   ),
    //                 ],
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   MyText(
    //                     text: 'How Old : ',
    //                     color: blackColor,
    //                     weight: FontWeight.w700,
    //                     size: 14,
    //                     height: 1.8,
    //                   ),
    //                   MyText(
    //                     text: calculateAge(gm[index].dob),
    //                     color: greyTextColor,
    //                     weight: FontWeight.w400,
    //                     size: 12,
    //                     height: 1.8,
    //                   ),
    //                 ],
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   MyText(
    //                     text: 'Nationality : ',
    //                     color: blackColor,
    //                     weight: FontWeight.w700,
    //                     size: 14,
    //                     height: 1.8,
    //                   ),
    //                   MyText(
    //                     text: gm[index].nationality,
    //                     color: greyTextColor,
    //                     weight: FontWeight.w400,
    //                     size: 12,
    //                     height: 1.8,
    //                   ),
    //                 ],
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   MyText(
    //                     text: 'Booked On : ',
    //                     color: blackColor,
    //                     weight: FontWeight.w700,
    //                     size: 14,
    //                     height: 1.8,
    //                   ),
    //                   MyText(
    //                     text: gm[index].bookedOn,
    //                     color: greyTextColor,
    //                     weight: FontWeight.w400,
    //                     size: 12,
    //                     height: 1.8,
    //                   ),
    //                 ],
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   MyText(
    //                     text: 'Service Date : ',
    //                     color: blackColor,
    //                     weight: FontWeight.w700,
    //                     size: 14,
    //                     height: 1.8,
    //                   ),
    //                   MyText(
    //                     text: gm[index].serviceDate,
    //                     color: greyTextColor,
    //                     weight: FontWeight.w400,
    //                     size: 12,
    //                     height: 1.8,
    //                   ),
    //                 ],
    //               ),
    //               const SizedBox(
    //                 height: 4,
    //               ),
    //               RichText(
    //                 text: TextSpan(
    //                   text: 'Registrations : ',
    //                   style: const TextStyle(
    //                       color: blackColor,
    //                       fontSize: 14,
    //                       fontWeight: FontWeight.bold),
    //                   children: <TextSpan>[
    //                     TextSpan(
    //                       text: "${gm[index].adult} "
    //                           " ${"Adult"}"
    //                           ",  "
    //                           "${gm[index].kids} "
    //                           " ${"Youngsters "}",
    //                       style: const TextStyle(
    //                         fontSize: 12,
    //                         color: greyTextColor,
    //                         fontWeight: FontWeight.w400,
    //                       ),
    //                     ),
    //                     // TextSpan(
    //                     //   text: "${gm[index].kids} "
    //                     //       " ${"Kids"}",
    //                     //   style: const TextStyle(
    //                     //     fontSize: 12,
    //                     //     color: greyTextColor,
    //                     //     fontWeight: FontWeight.w400,
    //                     //   ),
    //                     // ),
    //                   ],
    //                 ),
    //               ),
    //               // Row(
    //               //   mainAxisAlignment: MainAxisAlignment.start,
    //               //   children: [
    //               //     MyText(
    //               //       text: 'Registrations : ',
    //               //       color: blackColor,
    //               //       weight: FontWeight.w700,
    //               //       size: 14,
    //               //       height: 1.8,
    //               //     ),
    //               //     if (gm[index].adult != 0)
    //               //       MyText(
    //               //         text: "${gm[index].adult} "
    //               //             " ${"Adult"}"
    //               //             ",  "
    //               //             "${gm[index].kids} "
    //               //             " ${"Youngsters"}",
    //               //         color: greyTextColor,
    //               //         weight: FontWeight.w400,
    //               //         size: 12,
    //               //         height: 1.8,
    //               //       ),
    //               //     if (gm[index].kids != 0)
    //               //       MyText(
    //               //         text: "${gm[index].kids} "
    //               //             " ${"Kids"}",
    //               //         color: greyTextColor,
    //               //         weight: FontWeight.w400,
    //               //         size: 12,
    //               //         height: 1.8,
    //               //       ),
    //               //   ],
    //               // ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   MyText(
    //                     text: 'Unit Cost : ',
    //                     color: blackColor,
    //                     weight: FontWeight.w700,
    //                     size: 14,
    //                     height: 1.8,
    //                   ),
    //                   MyText(
    //                     overFlow: TextOverflow.ellipsis,
    //                     text: "${gm[index].unitCost} "
    //                         "  ${gm[index].currency}",
    //                     color: greyTextColor,
    //                     weight: FontWeight.w400,
    //                     size: 12,
    //                     height: 1.8,
    //                   ),
    //                 ],
    //               ),
    //               Row(
    //                 // mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   MyText(
    //                     text: 'Total Cost : ',
    //                     color: blackColor,
    //                     weight: FontWeight.w700,
    //                     size: 14,
    //                     height: 1.8,
    //                   ),
    //                   MyText(
    //                     text: "${gm[index].totalCost} "
    //                         "  ${gm[index].currency}",
    //                     color: greyTextColor,
    //                     weight: FontWeight.w400,
    //                     size: 12,
    //                     height: 1.8,
    //                   ),
    //                 ],
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   MyText(
    //                     text: 'Payable Cost : ',
    //                     color: blackColor,
    //                     weight: FontWeight.w700,
    //                     size: 14,
    //                     height: 1.8,
    //                   ),
    //                   MyText(
    //                     text: "${gm[index].totalCost} "
    //                         "  ${gm[index].currency}",
    //                     color: greyTextColor,
    //                     weight: FontWeight.w400,
    //                     size: 12,
    //                     height: 1.8,
    //                   ),
    //                 ],
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   MyText(
    //                     text: 'Weight : ',
    //                     color: blackColor,
    //                     weight: FontWeight.w700,
    //                     size: 14,
    //                     height: 1.8,
    //                   ),
    //                   MyText(
    //                     text: "${gm[index].weight} ",
    //                     color: greyTextColor,
    //                     weight: FontWeight.w400,
    //                     size: 12,
    //                     height: 1.8,
    //                   ),
    //                 ],
    //               ),
    //               const SizedBox(
    //                 height: 5,
    //               ),
    //               RichText(
    //                 text: TextSpan(
    //                   text: 'Health : ',
    //                   style: const TextStyle(
    //                       color: blackColor,
    //                       fontSize: 15,
    //                       fontFamily: 'Raleway',
    //                       fontWeight: FontWeight.bold),
    //                   children: <TextSpan>[
    //                     TextSpan(
    //                       text: "${gm[index].healthConditions} ",
    //                       style: const TextStyle(
    //                         fontSize: 13,
    //                         wordSpacing: 1,
    //                         fontFamily: 'Raleway',
    //                         color: greyTextColor,
    //                         fontWeight: FontWeight.w400,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               // const SizedBox(
    //               //   height: 5,
    //               // ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   MyText(
    //                     text: 'Height : ',
    //                     color: blackColor,
    //                     weight: FontWeight.w700,
    //                     size: 14,
    //                     height: 1.8,
    //                   ),
    //                   MyText(
    //                     overFlow: TextOverflow.clip,
    //                     text: "${gm[index].height} ",
    //                     color: greyTextColor,
    //                     weight: FontWeight.w400,
    //                     size: 12,
    //                     height: 1.5,
    //                   ),
    //                 ],
    //               ),
    //               RichText(
    //                 text: TextSpan(
    //                   text: 'Client Message : ',
    //                   style: const TextStyle(
    //                       color: blackColor,
    //                       fontSize: 14,
    //                       fontWeight: FontWeight.bold),
    //                   children: <TextSpan>[
    //                     TextSpan(
    //                       text: "${gm[index].message} ",
    //                       style: const TextStyle(
    //                         fontSize: 12,
    //                         color: greyTextColor,
    //                         fontWeight: FontWeight.w400,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               //   ],
    //               // ),
    //             ],
    //           ),
    //         ),
    //         // Row(
    //         //   mainAxisAlignment: MainAxisAlignment.start,
    //         //   crossAxisAlignment: CrossAxisAlignment.start,
    //         //   children: [

    //         //     const SizedBox(
    //         //       width: 10,
    //         //     ),

    //         //   ],
    //         // ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Container(
    //               height: MediaQuery.of(context).size.height / 21,
    //               width: MediaQuery.of(context).size.width / 3.8,
    //               decoration: const BoxDecoration(
    //                   borderRadius:
    //                       BorderRadius.all(Radius.circular(12)),
    //                   color: blueColor1),
    //               child: Material(
    //                 color: Colors.transparent,
    //                 child: InkWell(
    //                   onTap: () => selected(context,
    //                       gm[index].serviceId, gm[index].bookingUser),
    //                   child: const Center(
    //                     child: Text(
    //                       'Chat Client',
    //                       style: TextStyle(
    //                           color: whiteColor,
    //                           fontSize: 12,
    //                           fontWeight: FontWeight.w700),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               // color: bluishColor,
    //             ),
    //             Container(
    //               height: MediaQuery.of(context).size.height / 21,
    //               width: MediaQuery.of(context).size.width / 3.8,
    //               decoration: const BoxDecoration(
    //                 borderRadius:
    //                     BorderRadius.all(Radius.circular(12)),
    //                 color: Color.fromARGB(255, 92, 11, 106),
    //               ),
    //               child: Material(
    //                 color: Colors.transparent,
    //                 child: InkWell(
    //                   onTap: rateUser,
    //                   child: const Center(
    //                     child: Text(
    //                       'Rate User',
    //                       style: TextStyle(
    //                           color: whiteColor,
    //                           fontSize: 12,
    //                           fontWeight: FontWeight.w700),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               // color: bluishColor,
    //             ),

    //             // GestureDetector(
    //             //   onTap: rateUser,
    //             //   child: Container(
    //             //     height: MediaQuery.of(context).size.height / 21,
    //             //     width: MediaQuery.of(context).size.width / 3.8,
    //             //     decoration: const BoxDecoration(
    //             //       color: Color.fromARGB(255, 92, 11, 106),
    //             //       borderRadius:
    //             //           BorderRadius.all(Radius.circular(8)),
    //             //     ),
    //             //     child: Center(
    //             //       child: Padding(
    //             //         padding: const EdgeInsets.symmetric(
    //             //             horizontal: 0),
    //             //         child: Row(
    //             //           mainAxisAlignment:
    //             //               MainAxisAlignment.center,
    //             //           children: const [
    //             //             Text(
    //             //               'Rate User',
    //             //               style: TextStyle(
    //             //                   color: whiteColor,
    //             //                   fontSize: 12,
    //             //                   fontWeight: FontWeight.w700),
    //             //             ),
    //             //           ],
    //             //         ),
    //             //       ),
    //             //     ),
    //             //   ),
    //             // ),

    //             // SquareButton('Chat Client', blueButtonColor, whiteColor,
    //             //     3.1, 21, 13, abc),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    // });
  }
}
