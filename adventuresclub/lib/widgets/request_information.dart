import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/getClientRequest/get_client_request_model.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:adventuresclub/widgets/circle_image_avatar.dart';
import 'package:adventuresclub/widgets/my_text.dart';
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
              "https://adventuresclub.net/adventureClub/newchat/${Constants.userId}/$serviceId/$bookingUser");
          // "https://adventuresclub.net/adventureClub/newreceiverchat/${providerId}/${serviceId}/${Constants.userId}");
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
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: widget.gRM.region, //'Location Name',
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
                leading: CircleImageAvatar(widget.gRM.sm),
                // leading: CircleAvatar(
                //   radius: 25,
                //   backgroundImage:
                //       //ExactAssetImage('images/airrides.png'),
                //       NetworkImage(
                //           "${'https://adventuresclub.net/adventureClub/public/uploads/'}${gRM[0].sm.imageUrl}"),
                // ),
                title: Column(
                  children: [
                    Row(
                      children: [
                        MyText(
                          text: widget.gRM.adventureName, //'Wadi Hawar',
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
                          text: widget.gRM.bookingId,
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
                          text: widget.gRM.customer,
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
                          text: widget.gRM.nationality,
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
                          text: calculateAge(widget.gRM.dob),
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
                          text: widget.gRM.serviceDate,
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
                          text: "${widget.gRM.adult}"
                              " "
                              "${"Adult"}"
                              ", "
                              "${widget.gRM.kids}"
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
                          text: widget.gRM.unitCost,
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
                          text: widget.gRM.totalCost,
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
                          text: widget.gRM.totalCost,
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
                          text: widget.gRM.paymentStatus,
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
                    //       text: gRM.healthCondition,
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
                              text: widget.gRM.healthCondition,
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
                          text: widget.gRM.height,
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
                          text: widget.gRM.weight,
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
                          text: widget.gRM.message,
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
                      onTap: () => selected(context, widget.gRM.serviceId,
                          widget.gRM.bookingUser),
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
                      onTap: () => widget.accept(
                        widget.gRM.bookingUser.toString(),
                        widget.gRM.bookingId.toString(),
                        widget.index,
                        //gRM.providerId
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
                      onTap: () => widget.decline(
                        widget.gRM.bookingUser.toString(),
                        widget.gRM.bookingId.toString(),
                        widget.gRM.ownerId.toString(),
                        //widget.rm[index].providerId
                        widget.index,
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
    ;
  }
}
