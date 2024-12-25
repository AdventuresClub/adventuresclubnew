import 'package:app/constants.dart';
import 'package:app/models/getClientRequest/get_client_request_model.dart';
import 'package:app/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:app/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RequestInformation extends StatefulWidget {
  final Function accept;
  final Function decline;
  final GetClientRequestModel gRM;
  final int index;
  const RequestInformation(this.gRM, this.accept, this.decline, this.index,
      {super.key});

  @override
  State<RequestInformation> createState() => _RequestInformationState();
}

class _RequestInformationState extends State<RequestInformation> {
  void selected(BuildContext context, int serviceId, int bookingUser) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
              "${Constants.baseUrl}/newchat/${Constants.userId}/$serviceId/$bookingUser");
          // "${Constants.baseUrl}/newreceiverchat/${providerId}/${serviceId}/${Constants.userId}");
        },
      ),
    );
  }

  // boooking id
  // provider id

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
    if (d.isEmpty || d == "null") {
      d = widget.gRM.bookedOn;
    }
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      //ExactAssetImage('images/airrides.png'),
                      NetworkImage(
                          "${'${Constants.baseUrl}/public/'}${widget.gRM.profileImage}"),
                ),
                Row(
                  children: [
                    MyText(
                      text:
                          "bookedOn".tr(), //'Booked on : 25 Sep, 2020 | 10:30',
                      color: bluishColor,
                      weight: FontWeight.w800,
                      fontFamily: 'Roboto',
                      size: 12,
                    ),
                    MyText(
                      text: widget
                          .gRM.bookedOn, //'Booked on : 25 Sep, 2020 | 10:30',
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
                //leading: //CircleImageAvatar(widget.gRM.profileImage),
                //leading:
                title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: widget.gRM.adventureName, //'Wadi Hawar',
                  color: bluishColor,
                  weight: FontWeight.bold,
                  size: 18,
                ),
                RichText(
                  text: TextSpan(
                    text: 'bookingId'.tr(),
                    style: const TextStyle(
                        color: bluishColor,
                        fontSize: 14,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.gRM.bookingId.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: blackColor,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Raleway",
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: 'userName'.tr(),
                    style: const TextStyle(
                        color: bluishColor,
                        fontSize: 14,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.gRM.customer,
                          style: const TextStyle(
                            fontSize: 14,
                            color: blackColor,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Raleway",
                          )),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 5,
                // ),
                // RichText(
                //   text: TextSpan(
                //     text: 'Region'.tr(),
                //     style: const TextStyle(
                //         color: bluishColor,
                //         fontSize: 14,
                //         fontFamily: "Raleway",
                //         fontWeight: FontWeight.bold),
                //     children: <TextSpan>[
                //       TextSpan(
                //           text: widget.gRM.region.tr(),
                //           style: const TextStyle(
                //             fontSize: 14,
                //             color: blackColor,
                //             fontWeight: FontWeight.w300,
                //             fontFamily: "Raleway",
                //           )),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: 'nationality'.tr(),
                    style: const TextStyle(
                        color: bluishColor,
                        fontSize: 14,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.gRM.nationality.tr(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: blackColor,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Raleway",
                          )),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: 'HowOld'.tr(),
                    style: const TextStyle(
                        color: bluishColor,
                        fontSize: 14,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      widget.gRM.dob.isNotEmpty
                          ? TextSpan(
                              text: calculateAge(widget.gRM.dob),
                              style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Raleway",
                              ))
                          : const TextSpan(
                              text: " Null ",
                              style: TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Raleway",
                              )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: 'serviceDate'.tr(),
                    style: const TextStyle(
                        color: bluishColor,
                        fontSize: 14,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.gRM.serviceDate,
                        style: const TextStyle(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Raleway",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: 'registrations'.tr(),
                    style: const TextStyle(
                        color: bluishColor,
                        fontSize: 14,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: "${widget.gRM.adult}"
                            " "
                            "${"Adult"}"
                            ", "
                            "${widget.gRM.kids}"
                            " "
                            "${"Youngsters"}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Raleway",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: 'unitCost'.tr(),
                    style: const TextStyle(
                        color: bluishColor,
                        fontSize: 14,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.gRM.unitCost,
                        style: const TextStyle(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Raleway",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: 'totalCost'.tr(),
                    style: const TextStyle(
                        color: bluishColor,
                        fontSize: 14,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.gRM.totalCost,
                        style: const TextStyle(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Raleway",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: 'payableCost'.tr(),
                    style: const TextStyle(
                        color: bluishColor,
                        fontSize: 14,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.gRM.totalCost,
                        style: const TextStyle(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Raleway",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: 'paymentChannel'.tr(),
                    style: const TextStyle(
                        color: bluishColor,
                        fontSize: 14,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.gRM.paymentStatus,
                        style: const TextStyle(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Raleway",
                        ),
                      ),
                    ],
                  ),
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
                //       text: gRM.healthCondition,
                //       color: greyColor,
                //       weight: FontWeight.w400,
                //       size: 12,
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: 'healthCondition'.tr(),
                    style: const TextStyle(
                        color: bluishColor,
                        fontSize: 14,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.gRM.healthCondition,
                          style: const TextStyle(
                            fontSize: 14,
                            color: blackColor,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Raleway",
                          )),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: 'height'.tr(),
                    style: const TextStyle(
                        color: bluishColor,
                        fontSize: 14,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.gRM.height,
                          style: const TextStyle(
                            fontSize: 14,
                            color: blackColor,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Raleway",
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: 'weight'.tr(),
                    style: const TextStyle(
                        color: bluishColor,
                        fontSize: 14,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.gRM.weight,
                          style: const TextStyle(
                            fontSize: 14,
                            color: blackColor,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Raleway",
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: 'clientMessage'.tr(),
                    style: const TextStyle(
                        color: bluishColor,
                        fontSize: 14,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.gRM.message,
                          style: const TextStyle(
                            fontSize: 14,
                            color: blackColor,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Raleway",
                          )),
                    ],
                  ),
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     MyText(
                //       text: 'Client Message: ',
                //       color: blackColor,
                //       weight: FontWeight.w500,
                //       size: 12,
                //       height: 1.6,
                //     ),
                //     MyText(
                //       text: widget.gRM.message,
                //       color: greyColor,
                //       weight: FontWeight.w400,
                //       size: 12,
                //     ),
                //   ],
                // ),
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
            //     //           "${'${Constants.baseUrl}/public/uploads/'}${widget.rm[index].sm[index].thumbnail}"),
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
                      onTap: () => selected(context, widget.gRM.serviceId,
                          widget.gRM.bookingUser),
                      child: Center(
                        child: Text(
                          'chatClient'.tr(),
                          style: const TextStyle(
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
                      onTap: () => widget.accept(
                        widget.gRM.bookingUser.toString(),
                        widget.gRM.bookingId.toString(),
                        widget.index,
                        //gRM.providerId
                      ),
                      child: Center(
                        child: Text(
                          'accept'.tr(),
                          style: const TextStyle(
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
                      onTap: () => widget.decline(
                        widget.gRM.bookingUser.toString(),
                        widget.gRM.bookingId.toString(),
                        widget.gRM.ownerId.toString(),
                        //widget.rm[index].providerId
                        widget.index,
                      ),
                      child: Center(
                        child: Text(
                          'decline'.tr(),
                          style: const TextStyle(
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
  }
}
