// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/visit/review_ad.dart';
import 'package:adventuresclub/models/getReviews/location_review_model.dart';
import 'package:adventuresclub/models/getReviews/review_user_data_model.dart';
import 'package:adventuresclub/models/reviews/location_reviews_model.dart';
import 'package:adventuresclub/models/visit/get_visit_model.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:map_launcher/map_launcher.dart' as ml;
import 'package:map_launcher/src/models.dart' as mt;

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
  static double ln = 0;
  static double lt = 0;
  double myLat = 0;
  double myLng = 0;
  double locationLat = 0;
  double locationLng = 0;

  void goToReAd() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return ReviewAd(widget.vm!.id.toString());
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
    getmyLocation();
    locationConvert(widget.vm!.lat, widget.vm!.lng);
    lt = double.tryParse(widget.vm!.lat) ?? 0;
    ln = double.tryParse(widget.vm!.lng) ?? 0;
  }

  void locationConvert(String lat, String lng) {
    double latitude = double.tryParse(lat) ?? 0;
    double longitude = double.tryParse(lng) ?? 0;
    setState(() {
      locationLat = latitude;
      locationLng = longitude;
    });
  }

  void getmyLocation() async {
    String locationData = await Constants.getLocation();
    List<String> location = locationData.split(':');
    myLat = double.tryParse(location[0]) ?? 0;
    myLng = double.tryParse(location[1]) ?? 0;
  }

  // void selected(BuildContext context) async {
  //   setState(() {
  //     loading = true;
  //   });
  //   try {
  //     String locationData = await Constants.getLocation();
  //     List<String> location = locationData.split(':');
  //     myLat = double.tryParse(location[0]) ?? 0;
  //     myLng = double.tryParse(location[1]) ?? 0;
  //     final url =
  //         'https://www.google.com/maps/dir/?api=1&origin=$myLat,$myLng&destination=$lt,$ln';
  //     await launchUrl(Uri.parse(url));
  //     setState(() {
  //       loading = false;
  //     });
  //   } catch (e) {
  //     log(e.toString());
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

  void selected(BuildContext context) async {
    setState(() {
      loading = true;
    });
    try {
      String locationData = await Constants.getLocation();
      List<String> location = locationData.split(':');
      myLat = double.tryParse(location[0]) ?? 0;
      myLng = double.tryParse(location[1]) ?? 0;
/*
      final url =
          "https://www.google.com/maps/dir/?api=1&origin=$myLat,$myLng&destination=$lt,$ln&key=${Constants.googleMapsApi}";
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
      */
      if (await ml.MapLauncher.isMapAvailable(mt.MapType.google) == true) {
        await ml.MapLauncher.showDirections(
          mapType: mt.MapType.google,
          destination: ml.Coords(lt, ln),
          origin: ml.Coords(myLat, myLng),
          extraParams: {
            "key": Constants.googleMapsApi,
          },
        );
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      log(e.toString());
      setState(() {
        loading = false;
      });
    }
  }

  void getLocationReviews() async {
    setState(() {
      loading = true;
    });
    List<LocationReviewModel> reviewModelList = [];
    ReviewUserDataModel reviewUserModelList = ReviewUserDataModel("", "", "");
    String id = widget.vm!.id.toString();
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/get_location_reviews"),
          body: {
            'location_id': id,
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
                u['profile_image'] ?? "", u['name'] ?? "", u['country'] ?? "");
            reviewUserModelList = reviewUser;
          });
        }
        int count = int.tryParse(reviewsList['count'].toString()) ?? 0;
        LocationReviewModel rm = LocationReviewModel(
          element['location_id'] ?? "",
          element['user_id'] ?? "",
          element['rating'] ?? "",
          element['rating_description'] ?? "",
          reviewUserModelList,
          count,
        );
        reviewModelList.add(rm);
        LocationReviewsModel lm =
            LocationReviewsModel(avgReviews, reviewModelList);
        reviewList.add(lm);
      });
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      loading = false;
    });
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
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 350,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(
                "${"https://adventuresclub.net/adventureClub/public/uploads/"}${widget.vm!.destinationImage}",
              ),
              fit: BoxFit.cover,
            )),
          ),
          // Image(
          //   image:
          // ),
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
                // Row(
                //   children: [
                //     const Image(
                //       image: ExactAssetImage(
                //         'images/pin.png',
                //       ),
                //       height: 14,
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     MyText(
                //       text: widget.vm!
                //           .destinationAdd, //'20 Skillman Ave, Brooklyn, NY 11211',
                //       color: greyColor,
                //       weight: FontWeight.bold,
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 5,
                // ),
                // Row(
                //   children: [
                //     const Icon(
                //       Icons.phone,
                //       color: Colors.red,
                //       size: 14,
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     MyText(
                //       text: widget.vm!.destMobile, //'+1 718-610-2000',
                //       color: greyColor,
                //       weight: FontWeight.bold,
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 5,
                // ),
                // Row(
                //   children: [
                //     const Image(
                //       image: ExactAssetImage('images/forma.png'),
                //       height: 14,
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     MyText(
                //         text: widget.vm!.destWeb, //'www.kingscoimperial.com',
                //         color: Colors.blue,
                //         weight: FontWeight.bold),
                //   ],
                // ),
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
                                    bottom: 8.0, left: 8, top: 10),
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
      //),
      bottomNavigationBar: GestureDetector(
        onTap: () => selected(context),
        child: Card(
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
                  text:
                      "${Constants.getDistance(myLat, myLng, locationLat, locationLng).toStringAsFixed(2)} mi",
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
      ),
    );
  }
}
