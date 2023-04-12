// ignore_for_file: avoid_print

import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DescriptionDetailsWidget extends StatelessWidget {
  final List<dynamic> text1;
  final List<dynamic> text4;
  final List<dynamic> text5;
  final List<dynamic> text6;
  final double stars;
  const DescriptionDetailsWidget(
      this.text1, this.text4, this.text5, this.text6, this.stars,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  text1.length,
                  (index) {
                    return RichText(
                      text: TextSpan(
                        text:
                            // country
                            text1[index],
                        style: const TextStyle(
                            color: greyColor2, fontSize: 14, height: 1.5),
                        children: <TextSpan>[
                          TextSpan(
                              //text: widget.gm.country,
                              text: text4[index],
                              style: const TextStyle(
                                  fontSize: 14,
                                  // fontWeight: FontWeight.w300,
                                  color: blackColor,
                                  height: 1.5)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.vertical,
                    children: List.generate(text5.length, (index) {
                      return text1[index] == 'Country  :'
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: RatingBar.builder(
                                initialRating: stars,
                                itemSize: 12,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 12,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            )
                          : RichText(
                              text: TextSpan(
                                text: text5[index],
                                style: const TextStyle(
                                  color: greyColor2,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: text6[index],
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: blackColor,
                                          height: 1.5)),
                                ],
                              ),
                            );
                    }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
