import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/reviews.dart';
import 'package:adventuresclub/widgets/info_tile.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/description_activities_widget.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/description_aimedFor_widget.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/description_components.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/description_description.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/description_details_widget.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/description_information_widget.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/service_schedule_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../models/home_services/services_model.dart';

class NewServiceDescription extends StatefulWidget {
  final ServicesModel gm;
  final List<String> text1;
  final List<String> text4;
  final List<String> text5;
  final List<String> text6;
  final double stars;
  final String reviewedBy;
  final String id;
  final bool? show;
  const NewServiceDescription(this.gm, this.text1, this.text4, this.text5,
      this.text6, this.stars, this.reviewedBy, this.id,
      {this.show = false, super.key});

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

  @override
  void initState() {
    super.initState();
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

  void goToReviews(BuildContext context, String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return Reviews(id);
        },
      ),
    );
  }

  void setStatus(String type) {
    if (type == "inc") {
      costInc = !costInc;
    } else {
      costExl = !costExl;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: widget.gm.adventureName,
                  //'River Rafting',
                  weight: FontWeight.bold,
                  color: blackColor,
                  size: 22,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: "${widget.gm.country}, ${widget.gm.region}",
                      //'River Rafting',
                      weight: FontWeight.bold,
                      color: blackColor.withOpacity(0.5),
                      size: 12,
                    ),
                    MyText(
                      text:
                          "${widget.gm.aSeats} Seats (${widget.gm.remainingSeats}  left)",
                      //'River Rafting',
                      weight: FontWeight.w600,
                      color: blackColor,
                      size: 12,
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
                                color: Color.fromARGB(255, 170, 128, 0),
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
                          color: const Color.fromARGB(255, 170, 128, 0),
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        MyText(
                          text: "Reviews",
                          color: const Color.fromARGB(255, 170, 128, 0),
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    MyText(
                      text: "${widget.gm.duration} Activity Duration",
                      //'River Rafting',
                      weight: FontWeight.w600,
                      color: blackColor,
                      size: 12,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              visualDensity: VisualDensity.compact,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              value: costInc,
                              onChanged: (value) => setStatus("inc"),
                            ),
                            MyText(
                              text:
                                  "${widget.gm.currency}  ${widget.gm.costInc}",
                              //'River Rafting',
                              weight: FontWeight.bold,
                              color: blackColor,
                              size: 16,
                            ),
                          ],
                        ),
                        MyText(
                          text: "Including gears & taxes",
                          //'River Rafting',
                          weight: FontWeight.w700,
                          color: redColor,
                          size: 12,
                        ),
                      ],
                    ),
                    Container(
                      color: blackColor,
                      width: 1,
                      height: 45,
                    ),
                    Column(
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
                              color: blackColor,
                              size: 16,
                            ),
                          ],
                        ),
                        MyText(
                          text: "Excluding gears & taxes",
                          //'River Rafting',
                          weight: FontWeight.w700,
                          color: redColor,
                          size: 12,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (widget.gm.sPlan == 2)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: "${"Start Date : "} ${st}",
                        //'River Rafting',
                        weight: FontWeight.w700,
                        color: blackColor,
                        size: 12,
                      ),
                      MyText(
                        text: "${"End Date : "} ${ed}",
                        //'River Rafting',
                        weight: FontWeight.w700,
                        color: blackColor,
                        size: 12,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 5,
                ),
                Divider(
                  thickness: 1,
                  color: blackColor.withOpacity(0.2),
                ),
                const SizedBox(
                  height: 5,
                ),
                MyText(
                  text: "Description",
                  color: blackColor,
                  size: 18,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 5,
                ),
                MyText(
                  text: widget.gm.writeInformation,
                  color: blackColor,
                  weight: FontWeight.w500,
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
                MyText(
                  text: "Activities Included",
                  color: blackColor,
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.activityIncludes[i].image}",
                              height: 32,
                              width: 32,
                            ),
                            const SizedBox(width: 5),
                            MyText(
                              text: widget.gm.activityIncludes[i].activity.tr(),
                              color: blackColor, //greyTextColor,
                              weight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                  ],
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
                MyText(
                  text: "Aimed For",
                  color: blackColor,
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.am[i].image}",
                              height: 32,
                              width: 32,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            MyText(
                              text: widget.gm.am[i].aimedName,
                              //text: aimedFor[index],
                              color: greyColor2,
                              weight: FontWeight.w700,
                              fontFamily: 'Roboto',
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                  ],
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
                MyText(
                  text: "Dependency",
                  color: blackColor,
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(
                            "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.dependency[i].name}",
                            height: 32,
                            width: 32,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          MyText(
                            text: widget.gm.dependency[i].dName.tr(),
                            //text: aimedFor[index],
                            color: greyColor2,
                            weight: FontWeight.w700,
                            fontFamily: 'Roboto',
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                ]),
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
                MyText(
                  text: "prerequisites",
                  color: blackColor,
                  size: 18,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 5,
                ),
                MyText(
                  text: widget.gm.preRequisites,
                  color: blackColor,
                  weight: FontWeight.w500,
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
                MyText(
                  text: "minimumRequirements",
                  color: blackColor,
                  size: 18,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 5,
                ),
                MyText(
                  text: widget.gm.mRequirements,
                  color: blackColor,
                  weight: FontWeight.w500,
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
                MyText(
                  text: "termsAndConditions",
                  color: blackColor,
                  size: 18,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 5,
                ),
                MyText(
                  text: widget.gm.tnc,
                  color: blackColor,
                  weight: FontWeight.w500,
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
          ),

          //   DescriptionComponents('prerequisites', widget.gm.preRequisites),
          // DescriptionComponents('minimumRequirements', widget.gm.mRequirements),
          // DescriptionComponents('termsAndConditions', widget.gm.tnc),
        ],
      ),
    );
  }
}
