// ignore_for_file: avoid_print

import 'package:app/constants.dart';
import 'package:app/widgets/buttons/button_icon_less.dart';
import 'package:app/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TourPackagesList extends StatefulWidget {
  const TourPackagesList({super.key});

  @override
  State<TourPackagesList> createState() => _TourPackagesListState();
}

class _TourPackagesListState extends State<TourPackagesList> {
  abc() {}
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: 7,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
            //   onTap: goToBookingDetails,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Card(
                child: Column(children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.darken),
                                image: const ExactAssetImage(
                                  'images/Wadi-Hawar.png',
                                ),
                                fit: BoxFit.cover)),
                      ),
                      const Positioned(
                          bottom: -15,
                          right: 10,
                          child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.red,
                              child: Icon(Icons.favorite))),
                      Positioned(
                          bottom: -160,
                          left: MediaQuery.of(context).size.width / 3.9,
                          child: ButtonIconLess('View Tour Details',
                              bluishColor, whiteColor, 2.5, 17, 14, abc)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              text: 'Wadi Haver',
                              color: blackColor,
                              size: 16,
                              weight: FontWeight.w500,
                            ),
                            const SizedBox(width: 20),
                            RatingBar.builder(
                              initialRating: 3,
                              itemSize: 12,
                              minRating: 1,
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
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              text: '20,000',
                              color: greyColor,
                              size: 16,
                              weight: FontWeight.w500,
                            ),
                            const SizedBox(width: 45),
                            MyText(
                              text: 'Earn 200 points',
                              color: Colors.blue,
                              size: 9,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(
                    indent: 4,
                    endIndent: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      const CircleAvatar(
                          backgroundColor: transparentColor,
                          child: Image(
                            image: ExactAssetImage('images/avatar.png'),
                            fit: BoxFit.cover,
                          )),
                      const SizedBox(width: 10),
                      MyText(
                        text: 'Provide By Alexander',
                        color: blackColor,
                        fontStyle: FontStyle.italic,
                        size: 12,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ]),
              ),
            ),
          );
        });
  }
}
