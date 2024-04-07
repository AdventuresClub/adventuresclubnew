import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/getParticipants/get_participants_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ParticipantsContainer extends StatefulWidget {
  final GetParticipantsModel gm;
  final Function delete;
  final Function selected;
  final Function rateUser;
  final int index;
  const ParticipantsContainer(
      this.gm, this.selected, this.delete, this.rateUser, this.index,
      {super.key});

  @override
  State<ParticipantsContainer> createState() => _ParticipantsContainerState();
}

class _ParticipantsContainerState extends State<ParticipantsContainer> {
  void homePage() {
    Navigator.of(context).pop();
  }

  void showConfirmation(
      String bookingId, String bookingUser, int index, String serviceId) async {
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
                        color: redColor,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => widget.delete(
                          bookingId, bookingUser, index, serviceId),
                      child: MyText(
                        text: "Yes",
                        color: blackColor,
                      ),
                    ),
                  ],
                )
                //BottomButton(bgColor: blueButtonColor, onTap: homePage)
              ],
            ));
  }

  String calculateAge(String d) {
    if (d.isEmpty) {
      d = widget.gm.bookedOn;
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

  String separateWords(String input) {
    List<String> words = input.split(',');

    words = words.map((word) => word.tr()).toList();

    return words.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15.0, left: 10, right: 10, bottom: 15),
        child: Column(
          // direction: Axis.vertical,
          // alignment: WrapAlignment.spaceBetween,
          //crossAxisAlignment: WrapCrossAlignment.,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage:
                      //ExactAssetImage('images/airrides.png'),
                      NetworkImage(
                          "${'${Constants.baseUrl}/public/'}${widget.gm.providerProfile}"),
                ),
                Row(
                  children: [
                    if (widget.gm.status == "0")
                      MyText(
                        text: "requested".tr(), //'Confirmed',
                        color: blueColor1,
                        weight: FontWeight.bold,
                      ),
                    if (widget.gm.status == "1")
                      MyText(
                        text: "accepted".tr(), //'Confirmed',
                        color: orangeColor,
                        weight: FontWeight.bold,
                      ),
                    if (widget.gm.status == "2")
                      MyText(
                        text: "paid".tr(), //'Confirmed',
                        color: greenColor1,
                        weight: FontWeight.bold,
                      ),
                    if (widget.gm.status == "3")
                      MyText(
                        text: "declined".tr(), //'Confirmed',
                        color: redColor,
                        weight: FontWeight.bold,
                      ),
                    if (widget.gm.status == "4")
                      MyText(
                        text: "completed".tr(), //'Confirmed',
                        color: greenColor1,
                        weight: FontWeight.bold,
                      ),
                    if (widget.gm.status == "5")
                      MyText(
                        text: "dropped".tr(), //'Confirmed',
                        color: redColor,
                        weight: FontWeight.bold,
                      ),
                    if (widget.gm.status == "6")
                      MyText(
                        text: "confirm".tr(), //'Confirmed',
                        color: greenColor1,
                        weight: FontWeight.bold,
                      ),
                    if (widget.gm.status == "7")
                      MyText(
                        text: "unpaid".tr(), //'Confirmed',
                        color: greenColor1,
                        weight: FontWeight.bold,
                      ),
                    if (widget.gm.status == "8")
                      MyText(
                        text: "payOnArrival".tr(), //'Confirmed',
                        color: greenColor1,
                        weight: FontWeight.bold,
                      ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => showConfirmation(
                          widget.gm.bookingId.toString(),
                          widget.gm.bookingUser.toString(),
                          widget.index,
                          widget.gm.serviceId.toString()),
                      child: const Icon(
                        Icons.delete_forever_outlined,
                        color: redColor,
                        size: 24,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 2,
              color: blackColor.withOpacity(0.4),
            ),
            ListTile(
              // leading:
              //     const CircleAvatar(
              //   radius: 28,
              //   backgroundImage:
              //       ExactAssetImage('images/airrides.png'),
              // ),
              // NetworkImage(
              //     "${'${Constants.baseUrl}/public/uploads/'}${gm.sm.imageUrl}")),,
              title: SizedBox(
                width: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'bookingId'.tr(),
                        style: const TextStyle(
                            color: bluishColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Raleway"),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.gm.bookingId.toString(),
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Raleway"),
                          ),
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     MyText(
                    //       text: widget.gm.adventureName,
                    //       color: blackColor,
                    //       weight: FontWeight.w700,
                    //       size: 14,
                    //       height: 1.8,
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Region'.tr(),
                        style: const TextStyle(
                            color: bluishColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Raleway"),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.gm.region.tr(),
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Raleway"),
                          ),
                        ],
                      ),
                    ),
                    // MyText(
                    //   text: widget.gm.region, //'Location Name',
                    //   color: blackColor,
                    //   weight: FontWeight.bold,
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'userName'.tr(),
                        style: const TextStyle(
                            color: bluishColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Raleway"),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.gm.customer,
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Raleway"),
                          ),
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
                            fontWeight: FontWeight.bold,
                            fontFamily: "Raleway"),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.gm.dob.isNotEmpty
                                ? calculateAge(widget.gm.dob)
                                : "Null",
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Raleway"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'nationality'.tr(),
                        style: const TextStyle(
                            color: bluishColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Raleway"),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.gm.nationality.tr(),
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Raleway"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'bookedOn'.tr(),
                        style: const TextStyle(
                            color: bluishColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Raleway"),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.gm.bookedOn,
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Raleway"),
                          ),
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
                            fontWeight: FontWeight.bold,
                            fontFamily: "Raleway"),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.gm.serviceDate,
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Raleway"),
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
                            fontWeight: FontWeight.bold,
                            fontFamily: "Raleway"),
                        children: <TextSpan>[
                          TextSpan(
                            text: "${widget.gm.adult} "
                                " ${"Adults".tr()}"
                                ",  "
                                "${widget.gm.kids} "
                                " ${"Youngsters".tr()}",
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Raleway"),
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
                            fontWeight: FontWeight.bold,
                            fontFamily: "Raleway"),
                        children: <TextSpan>[
                          TextSpan(
                            text: "${widget.gm.unitCost} "
                                "  ${widget.gm.currency.tr()}",
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Raleway"),
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
                            fontWeight: FontWeight.bold,
                            fontFamily: "Raleway"),
                        children: <TextSpan>[
                          TextSpan(
                            text: "${widget.gm.totalCost} "
                                "  ${widget.gm.currency.tr()}",
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Raleway"),
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
                            fontWeight: FontWeight.bold,
                            fontFamily: "Raleway"),
                        children: <TextSpan>[
                          TextSpan(
                            text: "${widget.gm.totalCost} "
                                "  ${widget.gm.currency.tr()}",
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Raleway"),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'healthCondition'.tr(),
                        style: const TextStyle(
                            color: bluishColor,
                            fontSize: 14,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.gm.healthConditions.isNotEmpty
                                ? "${separateWords(widget.gm.healthConditions.tr())} "
                                : "",
                            style: const TextStyle(
                              fontSize: 14,
                              wordSpacing: 1,
                              fontFamily: 'Raleway',
                              color: blackColor,
                              fontWeight: FontWeight.w400,
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
                        text: 'weight'.tr(),
                        style: const TextStyle(
                            color: bluishColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Raleway"),
                        children: <TextSpan>[
                          TextSpan(
                            text: "${widget.gm.weight.tr()} ",
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Raleway"),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'height'.tr(),
                        style: const TextStyle(
                            color: bluishColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Raleway"),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.gm.height.isNotEmpty
                                ? "${widget.gm.height} "
                                : "",
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Raleway"),
                          ),
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
                            fontWeight: FontWeight.bold,
                            fontFamily: "Raleway"),
                        children: <TextSpan>[
                          TextSpan(
                            text: "${widget.gm.message} ",
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Raleway"),
                          ),
                        ],
                      ),
                    ),

                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      onTap: () => widget.selected(
                          context, widget.gm.serviceId, widget.gm.bookingUser),
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
                    color: Color.fromARGB(255, 92, 11, 106),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => widget.rateUser,
                      child: Center(
                        child: Text(
                          'rateUser'.tr(),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
