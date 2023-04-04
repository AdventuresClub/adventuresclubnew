// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/visit/review_ad.dart';
import 'package:adventuresclub/models/getReviews/location_review_model.dart';
import 'package:adventuresclub/models/getReviews/review_user_data_model.dart';
import 'package:adventuresclub/models/getReviews/user_data_model.dart';
import 'package:adventuresclub/models/reviews/location_reviews_model.dart';
import 'package:adventuresclub/models/visit/get_visit_model.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

import '../../models/getReviews/review_model.dart';

class VisitDetails extends StatefulWidget {
  final GetVisitModel? vm;
  const VisitDetails({this.vm, super.key});

  @override
  State<VisitDetails> createState() => _VisitDetailsState();
}

class _VisitDetailsState extends State<VisitDetails> {
  abc() {}
  Map mapVisit = {};
  bool loading = false;
  List<LocationReviewsModel> reviewList = [];

  void goToReAd() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const ReviewAd();
    }));
  }

  double convert(String rating) {
    double result = double.parse(rating);
    return result;
  }

  @override
  void initState() {
    super.initState();
    getLocationReviews();
  }

  void getLocationReviews() async {
    setState(() {
      loading = true;
    });
    List<LocationReviewModel> reviewModelList = [];
    ReviewUserDataModel reviewUserModelList = ReviewUserDataModel("", "", "");
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/get_location_reviews"),
          body: {
            'location_id': widget.vm!.id.toString(),
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      dynamic reviewsList = decodedResponse['data'];
      int avgReviews =
          int.tryParse(reviewsList['avarage_rating'].toString()) ?? 0;
      List<dynamic> revs = reviewsList['review'];
      revs.forEach((element) {
        if (element["userData"] != null) {
          List<dynamic> userD = element['userData'];
          userD.forEach((u) {
            ReviewUserDataModel reviewUser = ReviewUserDataModel(
                u['profile_image'].toString() ?? "",
                u['name'].toString() ?? "",
                u['country'].toString() ?? "");
            reviewUserModelList = reviewUser;
          });
        }
        int count = int.tryParse(reviewsList['count'].toString()) ?? 0;
        LocationReviewModel rm = LocationReviewModel(
          element['location_id'].toString() ?? "",
          element['user_id'].toString() ?? "",
          element['rating'].toString() ?? "",
          element['rating_description'].toString() ?? "",
          reviewUserModelList,
          count,
        );
        reviewModelList.add(rm);
        LocationReviewsModel lm =
            LocationReviewsModel(avgReviews, reviewModelList);
        reviewList.add(lm);
      });
      setState(() {
        loading = false;
      });
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: transparentColor,
        elevation: 1.5,
        centerTitle: true,
        leadingWidth: 100,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: CircleAvatar(
            radius: 12,
            backgroundColor: whiteColor,
            child: Image.asset(
              'images/backArrow.png',
              height: 20,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(
                "${"https://adventuresclub.net/adventureClub/public/uploads/"}${widget.vm!.destinationImage}",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: widget
                            .vm!.destinationName, //'Kings country imperial',
                        weight: FontWeight.bold,
                        color: blackTypeColor,
                      ),
                      const SizedBox(height: 10),
                      Button(
                          'Share your Review',
                          transparentColor,
                          bluishColor,
                          bluishColor,
                          12,
                          goToReAd,
                          Icons.add,
                          whiteColor,
                          false,
                          2.5,
                          'Roboto',
                          FontWeight.w400,
                          19)
                    ],
                  ),
                  MyText(
                    text: widget.vm!.destDes, //'Omani Food : 1.5 mi',
                    color: greyColor,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MyText(
                    text: 'Open - Closed : 10:30',
                    color: greyColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Image(
                        image: ExactAssetImage(
                          'images/pin.png',
                        ),
                        height: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MyText(
                        text: widget.vm!
                            .destinationAdd, //'20 Skillman Ave, Brooklyn, NY 11211',
                        color: greyColor,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        color: Colors.red,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MyText(
                        text: widget.vm!.destMobile, //'+1 718-610-2000',
                        color: greyColor,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Image(
                        image: ExactAssetImage('images/forma.png'),
                        height: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MyText(
                          text: widget.vm!.destWeb, //'www.kingscoimperial.com',
                          color: Colors.blue,
                          weight: FontWeight.bold),
                    ],
                  ),
                  Divider(thickness: 2, color: greyColor.withOpacity(0.2)),
                  const SizedBox(
                    height: 10,
                  ),
                  MyText(
                    text: 'Description',
                    color: greyColor,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyText(
                    text: widget.vm!
                        .destDes, //"Call the crib, same number, same hood. It's all good.",
                    color: blackTypeColor1,
                    weight: FontWeight.w500,
                    size: 12,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(thickness: 2, color: greyColor.withOpacity(0.2)),
                  MyText(
                    text: 'Review',
                    color: greyColor,
                    weight: FontWeight.bold,
                  ),
                  loading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          //flex: 2,
                          height: 300,
                          width: 350,
                          child: ListView.builder(
                              itemCount: reviewList.length,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, left: 8),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          MyText(
                                            text:
                                                "${reviewList[index].review[index].rdm.name}"
                                                " "
                                                "|"
                                                " "
                                                "${reviewList[index].review[index].rdm.country}", //"John Doe | California",
                                            color: blackTypeColor1,
                                            weight: FontWeight.w500,
                                            size: 12,
                                          ),
                                          RatingBar.builder(
                                            initialRating: convert(
                                                reviewList[index]
                                                    .averageRating
                                                    .toString()), //3,
                                            itemSize: 12,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 1.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
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
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: MyText(
                                          text: reviewList[index]
                                              .review[index]
                                              .ratingDescription,
                                          color: blackColor,
                                          weight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Image(
                                            image: ExactAssetImage(
                                              'images/like.png',
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          MyText(
                                            text: reviewList[index]
                                                .review[index]
                                                .count,
                                            color: blackTypeColor1,
                                            weight: FontWeight.w500,
                                            size: 12,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              })),
                        ),

                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // MyText(
                  //   text: "John Doe | California | 9days ago",
                  //   color: blackTypeColor1,
                  //   weight: FontWeight.w500,
                  //   size: 12,
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // RatingBar.builder(
                  //   initialRating: convert(widget.vm!.rS),
                  //   itemSize: 12,
                  //   minRating: 1,
                  //   direction: Axis.horizontal,
                  //   allowHalfRating: true,
                  //   itemCount: 5,
                  //   itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                  //   itemBuilder: (context, _) => const Icon(
                  //     Icons.star,
                  //     color: Colors.amber,
                  //     size: 12,
                  //   ),
                  //   onRatingUpdate: (rating) {
                  //     print(rating);
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // MyText(
                  //   text:
                  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer finibus eros nec ex aliquam iaculis. Donec et magna viverra, gravida lacus eget, posuere dui. Suspendisse convallis condimentum dolor, ",
                  //   color: blackTypeColor1,
                  //   weight: FontWeight.w500,
                  //   size: 12,
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // Row(
                  //   children: [
                  //     const Image(
                  //       image: ExactAssetImage(
                  //         'images/like.png',
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 5,
                  //     ),
                  //     MyText(
                  //       text: "2",
                  //       color: blackTypeColor1,
                  //       weight: FontWeight.w500,
                  //       size: 12,
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // const Divider(),
                  // MyText(
                  //   text: "John Doe | California | 9days ago",
                  //   color: blackTypeColor1,
                  //   weight: FontWeight.w500,
                  //   size: 12,
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // RatingBar.builder(
                  //   initialRating: 3,
                  //   itemSize: 12,
                  //   minRating: 1,
                  //   direction: Axis.horizontal,
                  //   allowHalfRating: true,
                  //   itemCount: 5,
                  //   itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                  //   itemBuilder: (context, _) => const Icon(
                  //     Icons.star,
                  //     color: Colors.amber,
                  //     size: 12,
                  //   ),
                  //   onRatingUpdate: (rating) {
                  //     print(rating);
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // MyText(
                  //   text:
                  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer finibus eros nec ex aliquam iaculis. Donec et magna viverra, gravida lacus eget, posuere dui. Suspendisse convallis condimentum dolor, ",
                  //   color: blackTypeColor1,
                  //   weight: FontWeight.w500,
                  //   size: 12,
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: '1.5 mi',
                weight: FontWeight.bold,
                color: blackTypeColor1,
                size: 18,
              ),
              const CircleAvatar(
                  backgroundColor: whiteColor,
                  child: Image(
                    image: ExactAssetImage('images/icon-location-on.png'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
