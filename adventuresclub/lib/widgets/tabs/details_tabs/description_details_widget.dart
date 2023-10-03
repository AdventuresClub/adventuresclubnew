// ignore_for_file: avoid_print

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/reviews.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DescriptionDetailsWidget extends StatelessWidget {
  final List<String> text1;
  final List<String> text4;
  final List<String> text5;
  final List<String> text6;
  final double stars;
  final String reviewedBy;
  final String id;
  final ServicesModel gm;
  const DescriptionDetailsWidget(this.text1, this.text4, this.text5, this.text6,
      this.stars, this.reviewedBy, this.id, this.gm,
      {super.key});

  void goToReviews(BuildContext context, String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return Reviews(id);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Text(widget.text1[0]),
                RichText(
                  text: TextSpan(
                    text: text1[0].tr(),
                    style: const TextStyle(
                        color: greyColor2, fontSize: 14, height: 1.5),
                    children: [
                      TextSpan(
                          text: text4[0].tr(),
                          style: const TextStyle(
                              fontSize: 13,
                              // fontWeight: FontWeight.w300,
                              color: blackColor,
                              height: 1.5)),
                    ],
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => goToReviews(context, id),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: RatingBar.builder(
                          initialRating: stars,
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
                            color: Colors.amber,
                            size: 13,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        child: MyText(
                          text: "$stars ${" "} ($reviewedBy ${"Reviews)"} ",
                          color: yellowcolor,
                          weight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: text1[1],
                    style: const TextStyle(
                        color: greyColor2, fontSize: 14, height: 1.5),
                    children: [
                      TextSpan(
                          text: text4[1].tr(),
                          style: const TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.w300,
                              color: blackColor,
                              height: 1.5)),
                    ],
                  ),
                ),
                //Spacer(),
                RichText(
                  text: TextSpan(
                    text: text5[0].tr(),
                    style: const TextStyle(
                      color: greyColor2,
                      fontSize: 14,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: text6[0].tr(),
                          style: const TextStyle(
                              fontSize: 14, color: blackColor, height: 1.5)),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: text1[2].tr(),
                    style: const TextStyle(
                        color: greyColor2, fontSize: 13, height: 1.5),
                    children: [
                      TextSpan(
                          text: text4[2].tr(),
                          style: const TextStyle(
                              fontSize: 13,
                              // fontWeight: FontWeight.w300,
                              color: blackColor,
                              height: 1.5)),
                    ],
                  ),
                ),
                //Spacer(),
                RichText(
                  text: TextSpan(
                    text: text5[1].tr(),
                    style: const TextStyle(
                      color: greyColor2,
                      fontSize: 13,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: text6[1].tr(),
                          style: const TextStyle(
                              fontSize: 13, color: blackColor, height: 1.5)),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: text1[3].tr(),
                    style: const TextStyle(
                        color: greyColor2, fontSize: 13, height: 1.5),
                    children: [
                      TextSpan(
                        text: text4[3].tr(),
                        style: const TextStyle(
                            fontSize: 13,
                            // fontWeight: FontWeight.w300,
                            color: blackColor,
                            height: 1.5),
                      ),
                      TextSpan(
                        text: ", ${gm.remainingSeats} seat left",
                        style: const TextStyle(
                            fontSize: 13,
                            // fontWeight: FontWeight.w300,
                            color: redColor,
                            height: 1.5),
                      ),
                    ],
                  ),
                ),
                //Spacer(),
                RichText(
                  text: TextSpan(
                    text: text5[2].tr(),
                    style: const TextStyle(
                      color: greyColor2,
                      fontSize: 13,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: text6[2].tr(),
                          style: const TextStyle(
                              fontSize: 13, color: blackColor, height: 1.5)),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: text1[4].tr(),
                    style: const TextStyle(
                        color: greyColor2, fontSize: 13, height: 1.5),
                    children: [
                      TextSpan(
                          text: text4[4].tr(),
                          style: const TextStyle(
                              fontSize: 13,
                              // fontWeight: FontWeight.w300,
                              color: blackColor,
                              height: 1.5)),
                    ],
                  ),
                ),
                //Spacer(),
                RichText(
                  text: TextSpan(
                    text: text5[3].tr(),
                    style: const TextStyle(
                      color: greyColor2,
                      fontSize: 13,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: text6[3].tr(),
                          style: const TextStyle(
                              fontSize: 13, color: blackColor, height: 1.5)),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: text1[5].tr(),
                    style: const TextStyle(
                        color: greyColor2, fontSize: 13, height: 1.5),
                    children: [
                      TextSpan(
                          text: text4[5].tr(),
                          style: const TextStyle(
                              fontSize: 13,
                              // fontWeight: FontWeight.w300,
                              color: blackColor,
                              height: 1.5)),
                    ],
                  ),
                ),
                if (gm.sPlan == 2)
                  RichText(
                    text: TextSpan(
                      text: "End Date : ",
                      style: const TextStyle(
                        color: greyColor2,
                        fontSize: 14,
                        height: 1.5,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: text6[4].tr(),
                            style: const TextStyle(
                                fontSize: 14, color: blackColor, height: 1.5)),
                      ],
                    ),
                  ),
              ],
            ),
            //Spacer(),
          ],
          // List.generate(
          //   widget.text1.length,
          //   (index) {
          //     return RichText(
          //       text: TextSpan(
          //         text:
          //             // country
          //             widget.text1[index],
          //         style: const TextStyle(
          //             color: greyColor2, fontSize: 14, height: 1.5),
          //         children: <TextSpan>[
          //           TextSpan(
          //               //text: widget.gm.country,
          //               text: widget.text4[index],
          //               style: const TextStyle(
          //                   fontSize: 14,
          //                   // fontWeight: FontWeight.w300,
          //                   color: blackColor,
          //                   height: 1.5)),
          //         ],
          //       ),
          //     );
          //   },
          // ),
          // Expanded(
          //   // flex: 7,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children:
          //   ),
          // ),
          // Expanded(
          //   //flex: 7,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     children: [
          //       Wrap(
          //         alignment: WrapAlignment.end,
          //         crossAxisAlignment: WrapCrossAlignment.end,
          //         direction: Axis.vertical,
          //         children: List.generate(widget.text5.length, (index) {
          //           return widget.text1[index] == 'Country  :'
          //               ? GestureDetector(
          //                   onTap: () => goToReviews(widget.id),
          //                   child: Column(
          //                     children: [
          //                       Align(
          //                         alignment: Alignment.bottomLeft,
          //                         child: RatingBar.builder(
          //                           initialRating: widget.stars,
          //                           ignoreGestures: true,
          //                           itemSize: 15,
          //                           minRating: 0,
          //                           direction: Axis.horizontal,
          //                           allowHalfRating: true,
          //                           itemCount: 5,
          //                           itemPadding: const EdgeInsets.symmetric(
          //                               horizontal: 1.0),
          //                           itemBuilder: (context, _) => const Icon(
          //                             Icons.star,
          //                             color: Colors.amber,
          //                             size: 14,
          //                           ),
          //                           onRatingUpdate: (rating) {
          //                             print(rating);
          //                           },
          //                         ),
          //                       ),
          //                       const SizedBox(
          //                         height: 5,
          //                       ),
          //                       Align(
          //                         child: MyText(
          //                           text:
          //                               "${widget.stars} ${" "} (${widget.reviewedBy} ${"Reviews)"} ",
          //                           color: yellowcolor,
          //                           weight: FontWeight.bold,
          //                         ),
          //                       )
          //                     ],
          //                   ),
          //                 )
          //               : RichText(
          //                   text: TextSpan(
          //                     text: widget.text5[index],
          //                     style: const TextStyle(
          //                       color: greyColor2,
          //                       fontSize: 14,
          //                       height: 1.5,
          //                     ),
          //                     children: <TextSpan>[
          //                       TextSpan(
          //                           text: widget.text6[index],
          //                           style: const TextStyle(
          //                               fontSize: 14,
          //                               color: blackColor,
          //                               height: 1.5)),
          //                     ],
          //                   ),
          //                 );
          //         }),
          //       ),
          //     ],
          //   ),
          // ),
          // ],
        ),
      ),
    );
  }
}
