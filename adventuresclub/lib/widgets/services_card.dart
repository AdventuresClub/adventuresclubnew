// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/about.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/home_services/services_model.dart';

class ServicesCard extends StatefulWidget {
  final ServicesModel gm;
  final bool show;
  final bool? providerShow;
  const ServicesCard(this.gm,
      {this.show = false, this.providerShow = true, super.key});

  @override
  State<ServicesCard> createState() => _ServicesCardState();
}

class _ServicesCardState extends State<ServicesCard> {
  List<String> adventuresPlan = [""];
  List<String> availabilityPlanText = [""];
  String availability = "";
  String aPlan = "";
  DateTime startDate = DateTime.now();
  String st = "";
  double convert(String rating) {
    double result = double.parse(rating);
    return result;
  }

  void goToProvider(
    String id,
    int serviceId,
  ) {
    if (widget.providerShow!) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return About(id: id, sId: serviceId);
          },
        ),
      );
    } else {}
  }

  @override
  void initState() {
    super.initState();
    getSteps();
    if (widget.gm.sPlan == 1) {
      getAvailability();
    }
    if (widget.gm.sPlan == 2) {
      startDate =
          DateTime.tryParse(widget.gm.availability[0].st) ?? DateTime.now();
      String sMonth = DateFormat('MMMM').format(startDate);
      st = "${startDate.day}-$sMonth-${startDate.year}";
    }
  }

  void getSteps() {
    int i = 0;
    widget.gm.am.forEach((element) {
      adventuresPlan.add(element.aimedName);
      if (i < 3) {
        if (i < 3) {
          aPlan += "${element.aimedName.tr()} ${","} ";
        } else {
          aPlan += element.aimedName.tr();
        }
        i++;
      }
    });
    //aPlan = adventuresPlan.join(" ");
  }

  void getAvailability() {
    int i = 0;
    widget.gm.availabilityPlan.forEach((element) {
      availabilityPlanText.add(element.day);
      if (i < 4) {
        //availability += availabilityPlanText.join("| ");
        availability += "${element.day.tr()} ";
        i++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.show
        ? Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 2,
            child: Column(
              children: [
                Stack(
                  children: [
                    widget.gm.images.isEmpty
                        ? Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                  image: AssetImage("images/logo.png"),
                                  fit: BoxFit.fill),
                            ),
                          )
                        : Container(
                            //width: MediaQuery.of(context).size.width / 2.3,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    "${"${Constants.baseUrl}/public/uploads/"}${widget.gm.images[0].imageUrl}",
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                    const Positioned(
                      bottom: 5,
                      right: 5,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: transparentColor,
                        child: Image(
                          image: ExactAssetImage(
                            'images/heart.png',
                          ),
                          height: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyText(
                              text: widget.gm.adventureName,
                              maxLines: 1,
                              color: blackColor,
                              size: 12,
                              weight: FontWeight.bold,
                              fontFamily: 'Roboto',
                              height: 1.3,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.pin_drop_sharp,
                                  size: 14,
                                  color: greyBackgroundColor.withOpacity(0.6),
                                ),
                                // const SizedBox(
                                //   width: 2,
                                // ),
                                Expanded(
                                  child: MyText(
                                    text: widget.gm.sAddress.tr(),
                                    maxLines: 1,
                                    color: blackColor,
                                    size: 10,
                                    weight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            if (widget.gm.status == "0")
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person_add,
                                    color: redColor,
                                    size: 12,
                                  ),
                                  MyText(
                                    //text: "testing",
                                    text: "pendingApproval".tr(),
                                    //text: 'Advanced',
                                    weight: FontWeight.w500,
                                    color: redColor,
                                    size: 10,
                                    height: 1.3,
                                  ),
                                ],
                              ),
                            if (widget.gm.status == "1")
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person_add,
                                    color: greenColor1,
                                    size: 12,
                                  ),
                                  // const SizedBox(
                                  //   width: 2,
                                  // ),
                                  MyText(
                                    //text: "testing",
                                    text: "accepted".tr(),
                                    //text: 'Advanced',
                                    weight: FontWeight.w500,
                                    color: greenColor1,
                                    size: 10,
                                    height: 1.3,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      widget.gm.sPlan == 1
                          ? Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  MyText(
                                      text: availability,
                                      color: blackColor,
                                      size: 10)
                                ],
                              ),
                            )
                          : Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  MyText(text: st, color: blackColor, size: 10)
                                ],
                              ),
                            ),
                      // const SizedBox(height: 5),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     const SizedBox(height: 2),
                      //     Align(
                      //       alignment: Alignment.centerRight,
                      //       child: RatingBar.builder(
                      //         initialRating: convert(widget.gm.stars),
                      //         itemSize: 10,
                      //         //minRating: 1,
                      //         direction: Axis.horizontal,
                      //         allowHalfRating: true,
                      //         itemCount: 5,
                      //         itemPadding:
                      //             const EdgeInsets.symmetric(horizontal: 1.0),
                      //         itemBuilder: (context, _) => const Icon(
                      //           Icons.star,
                      //           color: Colors.amber,
                      //           size: 12,
                      //         ),
                      //         onRatingUpdate: (rating) {
                      //           print(rating);
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Column(
            children: [
              Card(
                color: whiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0, left: 2, right: 2),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          widget.gm.images.isEmpty
                              ? Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: const DecorationImage(
                                        image: AssetImage("images/logo.png"),
                                        fit: BoxFit.fill),
                                  ),
                                )
                              : Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          "${"${Constants.baseUrl}/public/uploads/"}${widget.gm.images[0].imageUrl}",
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                          const Positioned(
                            top: 6,
                            right: 6,
                            child: CircleAvatar(
                              radius: 36,
                              backgroundColor: transparentColor,
                              child: Image(
                                image: ExactAssetImage(
                                  'images/heart.png',
                                ),
                                height: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: MyText(
                                      text: widget.gm.adventureName,
                                      maxLines: 1,
                                      color: blackColor,
                                      size: 16,
                                      weight: FontWeight.bold,
                                      fontFamily: 'Raleway',
                                      height: 1.3,
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: RatingBar.builder(
                                        ignoreGestures: true,
                                        initialRating:
                                            convert(widget.gm.stars.toString()),
                                        itemSize: 18,
                                        minRating:
                                            convert(widget.gm.stars.toString()),
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 1.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 12,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: MyText(
                                      text: widget.gm.region.tr(),
                                      overFlow: TextOverflow.clip,
                                      maxLines: 1,
                                      //text: 'Dhufar',
                                      // weight: FontWeight.w600,
                                      color: blackTypeColor3,
                                      size: 14,
                                      height: 1.3,
                                    ),
                                  ),
                                  MyText(
                                    text: "${widget.gm.costInc} "
                                        " "
                                        "${widget.gm.currency}",
                                    //text: 'OMR 20.00',
                                    weight: FontWeight.bold,
                                    color: blackTypeColor3,
                                    size: 16,
                                    height: 1.3,
                                  ),
                                  // MyText(
                                  //   text:
                                  //       "${'earn'.tr()} ${widget.gm.points} '${'points'.tr()}",
                                  //   color: blueTextColor,
                                  //   size: 10,
                                  //   height: 1.3,
                                  // ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  MyText(
                                    text: widget.gm.serviceLevel.tr(),
                                    //text: 'Advanced',
                                    color: blackTypeColor3,
                                    //  weight: FontWeight.w500,
                                    size: 14,
                                    height: 1.3,
                                  ),
                                  // MyText(
                                  //   text: '',
                                  //   color: blueTextColor,
                                  //   size: 10,
                                  //   height: 1.3,
                                  // ),
                                ],
                              ),
                              // if (widget.gm.am.length == 1)
                              //   const SizedBox(height: 5),
                              // Row(
                              //   children: [
                              //     // Expanded(
                              //     //   child: MyText(
                              //     //     text:
                              //     //         aPlan.tr(), //widget.gm.am[0].aimedName,
                              //     //     color: redColor,
                              //     //     weight: FontWeight.w600,
                              //     //     size: 10,
                              //     //     height: 1.3,
                              //     //   ),
                              //     // ),
                              //     // MyText(
                              //     //   text: "${widget.gm.currency}"
                              //     //       " "
                              //     //       "${widget.gm.costInc} ",
                              //     //   //text: 'OMR 20.00',
                              //     //   weight: FontWeight.w600,
                              //     //   color: blackTypeColor3,
                              //     //   size: 10,
                              //     //   height: 1.3,
                              //     // ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),

                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width / 2.2,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     //crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [

                      //       Expanded(
                      //         flex: 8,
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           //mainAxisAlignment: MainAxisAlignment.start,
                      //           children: [
                      //             MyText(
                      //               text: widget.gm.adventureName,
                      //               maxLines: 1,
                      //               color: blackColor,
                      //               size: 14,
                      //               weight: FontWeight.bold,
                      //               fontFamily: 'Roboto',
                      //               height: 1.3,
                      //             ),
                      //             MyText(
                      //               text: widget.gm.region,
                      //               overFlow: TextOverflow.clip,
                      //               maxLines: 1,
                      //               //text: 'Dhufar',
                      //               weight: FontWeight.w500,
                      //               color: blackTypeColor3,
                      //               size: 11,
                      //               height: 1.3,
                      //             ),
                      //             const SizedBox(height: 1),
                      //             MyText(
                      //               text: widget.gm.serviceLevel,
                      //               //text: 'Advanced',
                      //               color: blackTypeColor3,
                      //               weight: FontWeight.w500,
                      //               size: 10,
                      //               height: 1.3,
                      //             ),
                      //             const SizedBox(height: 2),
                      //             if (widget.gm.am.length == 1)
                      //               const SizedBox(height: 10),
                      //             Row(
                      //               children: [
                      //                 Expanded(
                      //                   child: MyText(
                      //                     text: aPlan, //widget.gm.am[0].aimedName,
                      //                     color: redColor,
                      //                     weight: FontWeight.w600,
                      //                     size: 11,
                      //                     height: 1.3,
                      //                   ),
                      //                 ),
                      //                 //  const SizedBox(width: 0),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       //const SizedBox(height: 5),
                      //       Expanded(
                      //         flex: 6,
                      //         child: Column(
                      //           //crossAxisAlignment: CrossAxisAlignment.end,
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           children: [
                      //             const SizedBox(height: 2),
                      //             Align(
                      //               alignment: Alignment.centerRight,
                      //               child: RatingBar.builder(
                      //                 initialRating: convert(widget.gm.stars),
                      //                 itemSize: 10,
                      //                 //minRating: 1,
                      //                 direction: Axis.horizontal,
                      //                 allowHalfRating: true,
                      //                 itemCount: 5,
                      //                 itemPadding: const EdgeInsets.symmetric(
                      //                     horizontal: 1.0),
                      //                 itemBuilder: (context, _) => const Icon(
                      //                   Icons.star,
                      //                   color: Colors.amber,
                      //                   size: 12,
                      //                 ),
                      //                 onRatingUpdate: (rating) {
                      //                   print(rating);
                      //                 },
                      //               ),
                      //             ),
                      //             const SizedBox(height: 2),
                      //             MyText(
                      //               text: 'Earn ${widget.gm.points} points',
                      //               color: blueTextColor,
                      //               size: 10,
                      //               height: 1.3,
                      //             ),
                      //             MyText(
                      //               text: '',
                      //               color: blueTextColor,
                      //               size: 10,
                      //               height: 1.3,
                      //             ),
                      //             MyText(
                      //               text: "${widget.gm.currency}"
                      //                   " "
                      //                   "${widget.gm.costInc} ",
                      //               //text: 'OMR 20.00',
                      //               weight: FontWeight.w600,
                      //               color: blackTypeColor3,
                      //               size: 10,
                      //               height: 1.3,
                      //             ),
                      //             const SizedBox(height: 2),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      widget.providerShow!
                          ? Image(
                              image: const ExactAssetImage(
                                'images/line.png',
                              ),
                              width: MediaQuery.of(context).size.width / 1.2,
                            )
                          : Container(
                              height: 1,
                            ),
                      const SizedBox(
                        height: 2,
                      ),
                      widget.providerShow!
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: GestureDetector(
                                  onTap: () => goToProvider(
                                      widget.gm.providerId.toString(),
                                      widget.gm.serviceId),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 12,
                                        backgroundImage:
                                            NetworkImage(widget.gm.pProfile),
                                        backgroundColor: transparentColor,
                                      ),
                                      const SizedBox(width: 2),
                                      //   MyText(text: 'Provided By AdventuresClub',color:blackColor,fontStyle: FontStyle.italic,size: 10,),
                                      Expanded(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: "providedBy".tr(),
                                                  style: const TextStyle(
                                                    color: bluishColor,
                                                    fontSize: 14,
                                                  )),
                                              TextSpan(
                                                text: widget.gm.pName,
                                                //text: 'AdventuresClub',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: blackColor,
                                                    fontSize: 14,
                                                    fontFamily: "Raleway"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              height: 1,
                            ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
