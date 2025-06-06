import 'package:app/complete_profile/banner_page.dart';
import 'package:app/constants.dart';
import 'package:app/home_Screens/accounts/reviews.dart';
import 'package:app/provider/edit_provider.dart';
import 'package:app/widgets/edit_icon.dart';
import 'package:app/widgets/my_text.dart';
import 'package:app/widgets/tabs/details_tabs/service_gathering_location.dart';
import 'package:app/widgets/tabs/details_tabs/service_program/service_plans.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../../models/home_services/services_model.dart';

class NewServiceDescription extends StatefulWidget {
  final ServicesModel gm;
  final List<String> text1;
  //final List<String> text4;
  final List<String> text5;
  final List<String> text6;
  final double stars;
  final String reviewedBy;
  final String id;
  final bool? show;
  final Function parseData;
  const NewServiceDescription(
      this.gm,
      this.text1,
      //this.text4,
      this.text5,
      this.text6,
      this.stars,
      this.reviewedBy,
      this.id,
      this.parseData,
      {this.show = false,
      super.key});

  @override
  State<NewServiceDescription> createState() => _NewServiceDescriptionState();
}

class _NewServiceDescriptionState extends State<NewServiceDescription> {
  bool costInc = false;
  bool costExl = false;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String st = "";
  String ed = "";
  String aPlan = "";
  List<String> adventuresPlan = [""];
  String selectedPrice = '';
  bool allowEdit = false;
  // ServicesModel? service;
  @override
  void didUpdateWidget(covariant NewServiceDescription oldWidget) {
    super.didUpdateWidget(oldWidget);
    // service = widget.gm;
    getSteps();
    if (widget.gm.sPlan == 2) {
      startDate =
          DateTime.tryParse(widget.gm.availability[0].st) ?? DateTime.now();
      String sMonth = DateFormat('MMM').format(startDate);
      st = "${startDate.day}-$sMonth-${startDate.year}";
      endDate =
          DateTime.tryParse(widget.gm.availability[0].ed) ?? DateTime.now();
      String eMonth = DateFormat('MMM').format(startDate);
      ed = "${endDate.day}-$eMonth-${endDate.year}";
    }
  }

  // @override
  // void initState() {

  //   super.initState();

  // }

  void goToReviews(BuildContext context, String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return Reviews(id);
        },
      ),
    );
  }

  void getSteps() {
    aPlan = "";
    adventuresPlan.clear();
    for (var element in widget.gm.availabilityPlan) {
      adventuresPlan.add(element.day.tr());
    }
    aPlan = adventuresPlan.join(", ");
  }

  void setStatus(String selectedType) {
    switch (selectedType) {
      case 'inc':
        costInc = true;
        costExl = false;
        selectedPrice = widget.gm.costInc;
        break;
      case 'exl':
        costInc = false;
        costExl = true;
        selectedPrice = widget.gm.costExc;
        break;
      default:
        break;
    }
    setState(() {});
    widget.parseData(costInc, selectedPrice);
  }

  void getData() {}

  @override
  Widget build(BuildContext context) {
    allowEdit = context.watch<EditProvider>().edit;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // EditIcon(tapped: getData),
            // const SizedBox(
            //   height: 20,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.network(
                      "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.serviceCategoryImage}",
                      height: 42,
                      width: 42,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MyText(
                      text: widget.gm.serviceCategory,
                      color: bluishColor,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.network(
                      "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.serviceSectorImage}",
                      height: 42,
                      width: 42,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MyText(
                      text: widget.gm.serviceSector,
                      color: bluishColor,
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.network(
                      "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.serviceTypeImage}",
                      height: 42,
                      width: 42,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MyText(
                      text: widget.gm.serviceType,
                      color: bluishColor,
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.network(
                      "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.serviceLevelImage}",
                      height: 42,
                      width: 42,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MyText(
                      text: widget.gm.serviceLevel,
                      color: bluishColor,
                    )
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyText(
                        text: widget.gm.adventureName,
                        //'River Rafting',
                        weight: FontWeight.bold,
                        color: bluishColor,
                        size: 22,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text:
                          "${widget.gm.country.tr()}, ${widget.gm.region.tr()}"
                              .tr(),
                      //'River Rafting',
                      // weight: FontWeight.bold,
                      color: blackColor,
                      size: 14,
                    ),
                    MyText(
                      text:
                          "${widget.gm.aSeats} ${"seats".tr()} (${widget.gm.remainingSeats} ${"left".tr()})",
                      //'River Rafting',
                      // weight: FontWeight.w600,
                      color: blackColor,
                      size: 14,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => goToReviews(context, widget.id),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: RatingBar.builder(
                              initialRating: widget.stars,
                              ignoreGestures: true,
                              itemSize: 14,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 202, 122, 2),
                                size: 13,
                              ),
                              onRatingUpdate: (rating) {
                                // print(rating);
                              },
                            ),
                          ),
                        ),
                        MyText(
                          text: "(${widget.reviewedBy})",
                          color: const Color.fromARGB(255, 202, 122, 2),
                          size: 14,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        MyText(
                          text: "Reviews",
                          color: const Color.fromARGB(255, 202, 122, 2),
                          //weight: FontWeight.bold,
                          size: 14,
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //   width: 15,
                    // ),
                    MyText(
                      text: "${widget.gm.duration.tr()} ${"Activity".tr()}",
                      //'River Rafting',
                      // weight: FontWeight.w600,
                      color: blackColor,
                      size: 14,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Divider(
                  color: blackColor,
                  thickness: 0.3,
                  //width: 0.5,
                  //height: 55,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  visualDensity: VisualDensity.compact,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0))),
                                  value: costInc,
                                  onChanged: (value) => setStatus("inc"),
                                ),
                                MyText(
                                  text:
                                      "${widget.gm.currency}  ${widget.gm.costInc}",
                                  //'River Rafting',
                                  weight: FontWeight.bold,
                                  color: bluishColor,
                                  size: 18,
                                ),
                              ],
                            ),
                            MyText(
                              text: widget
                                  .gm.incDescription, //"includingGears".tr(),
                              //'River Rafting',
                              //weight: FontWeight.w700,
                              color: redColor,
                              size: 14,
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Divider(
                    //   color: blackColor,
                    //   thickness: 0.4,
                    //   //width: 0.5,
                    //   //height: 55,
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              visualDensity: VisualDensity.compact,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              value: costExl,
                              onChanged: (value) => setStatus("exl"),
                            ),
                            MyText(
                              text:
                                  "${widget.gm.currency}  ${widget.gm.costExc}",
                              //'River Rafting',
                              weight: FontWeight.bold,
                              color: bluishColor,
                              size: 18,
                            ),
                          ],
                        ),
                        MyText(
                          text: widget.gm.excDescription,
                          //'River Rafting',
                          //  weight: FontWeight.w700,
                          color: redColor,
                          size: 14,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                // Divider(
                //   color: blackColor.withOpacity(0.1),
                //   thickness: 1,
                //   //width: 0.5,
                //   //height: 55,
                // ),
                // Divider(
                //thickness: 1,
                // color: blackColor.withOpacity(0.2),
                //),
                if (widget.gm.sPlan == 2)
                  Column(
                    children: [
                      Divider(
                        color: blackColor.withOpacity(0.2),
                        thickness: 1,
                        //width: 0.5,
                        //height: 55,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: "${"${"startDate".tr()} : "} $st",
                            //'River Rafting',
                            //weight: FontWeight.w700,
                            color: blackColor,
                            size: 14,
                          ),
                          MyText(
                            text: "${"endDate".tr()} : $ed",
                            //'River Rafting',
                            //weight: FontWeight.w700,
                            color: blackColor,
                            size: 14,
                          ),
                        ],
                      ),
                      Divider(
                        color: blackColor.withOpacity(0.2),
                        thickness: 1,
                        //width: 0.5,
                        //height: 55,
                      ),
                    ],
                  ),

                if (widget.gm.sPlan == 1)
                  Column(
                    children: [
                      Divider(
                        color: blackColor.withOpacity(0.2),
                        thickness: 1,
                        //width: 0.5,
                        //height: 55,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "${'Availability'} : ".tr(),
                          style: const TextStyle(
                              color: bluishColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                          children: <TextSpan>[
                            TextSpan(
                                text: aPlan,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: blackColor,
                                    fontFamily: 'Raleway')),
                          ],
                        ),
                      ),
                      Divider(
                        color: blackColor.withOpacity(0.2),
                        thickness: 1,
                        //width: 0.5,
                        //height: 55,
                      ),
                    ],
                  ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     MyText(
                //       text: "${"Availability : "} $aPlan",
                //       //'River Rafting',
                //       weight: FontWeight.w700,
                //       color: blackColor,
                //       size: 14,
                //     ),
                //     // MyText(
                //     //   text: aPlan,
                //     //   //'River Rafting',
                //     //   //weight: FontWeight.w700,
                //     //   color: blackColor,
                //     //   size: 14,
                //     // ),
                //   ],
                // ),
                const SizedBox(
                  height: 5,
                ),

                const SizedBox(
                  height: 10,
                ),
                MyText(
                  text: "description".tr(),
                  color: bluishColor,
                  size: 18,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 5,
                ),
                MyText(
                  text: widget.gm.writeInformation,
                  color: blackColor,
                  // weight: FontWeight.w500,
                  size: 14,
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                  color: blackColor.withOpacity(0.2),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyText(
                  text: "activitiesIncludes".tr(),
                  color: bluishColor,
                  size: 18,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 5,
                ),
                Wrap(
                  children: [
                    for (int i = 0; i < widget.gm.activityIncludes.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.activityIncludes[i].image}",
                              height: 42,
                              width: 42,
                            ),
                            const SizedBox(width: 5),
                            MyText(
                              text: widget.gm.activityIncludes[i].activity.tr(),
                              color: blackColor, //greyTextColor,
                              // weight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                  color: blackColor.withOpacity(0.2),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyText(
                  text: "audience".tr(),
                  color: bluishColor,
                  size: 18,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 5,
                ),
                Wrap(
                  children: [
                    for (int i = 0; i < widget.gm.am.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 6),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.am[i].image}",
                              height: 42,
                              width: 42,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            MyText(
                              text: widget.gm.am[i].aimedName,
                              //text: aimedFor[index],
                              color: blackColor,
                              // weight: FontWeight.w700,
                              fontFamily: 'Roboto',
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                  color: blackColor.withOpacity(0.2),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyText(
                  text: "dependency".tr(),
                  color: bluishColor,
                  size: 18,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 5,
                ),
                Wrap(children: [
                  for (int i = 0; i < widget.gm.dependency.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 6),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(
                            "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.dependency[i].name}",
                            height: 42,
                            width: 42,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          MyText(
                            text: widget.gm.dependency[i].dName.tr(),
                            //text: aimedFor[index],
                            color: blackColor,
                            //weight: FontWeight.w700,
                            fontFamily: 'Roboto',
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                ]),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                  color: blackColor.withOpacity(0.2),
                ),
                ServicesPlans(widget.gm.sPlan, widget.gm.programmes),
                Divider(
                  thickness: 1,
                  color: blackColor.withOpacity(0.2),
                ),
                // 3 rd Tab /////////
                // gathering location
                ServiceGatheringLocation(
                  widget.gm.writeInformation,
                  widget.gm.sAddress,
                  widget.gm.region,
                  widget.gm.country,
                  widget.gm.geoLocation,
                  widget.gm.lat,
                  widget.gm.lng,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyText(
                  text: "prerequisites",
                  color: bluishColor,
                  size: 18,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 5,
                ),
                MyText(
                  text: widget.gm.preRequisites,
                  color: blackColor,
                  //weight: FontWeight.w500,
                  size: 14,
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                  color: blackColor.withOpacity(0.2),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyText(
                  text: "minimumRequirements",
                  color: bluishColor,
                  size: 18,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 5,
                ),
                MyText(
                  text: widget.gm.mRequirements,
                  color: blackColor,
                  //weight: FontWeight.w500,
                  size: 14,
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                  color: blackColor.withOpacity(0.2),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyText(
                  text: "termsAndConditions",
                  color: bluishColor,
                  size: 18,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 5,
                ),
                MyText(
                  text: widget.gm.tnc,
                  color: blackColor,
                  //weight: FontWeight.w500,
                  size: 14,
                ),
                const SizedBox(
                  height: 5,
                ),
                Divider(
                  thickness: 1,
                  color: blackColor.withOpacity(0.2),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),

            //   DescriptionComponents('prerequisites', service!.preRequisites),
            // DescriptionComponents('minimumRequirements', widget.gm.mRequirements),
            // DescriptionComponents('termsAndConditions', widget.gm.tnc),
          ],
        ),
      ),
    );
  }
}
