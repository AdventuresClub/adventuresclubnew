// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/getReviews/get_reviews_model.dart';
import 'package:adventuresclub/models/getReviews/user_data_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import '../../models/getReviews/review_model.dart';

class Reviews extends StatefulWidget {
  final String id;
  const Reviews(this.id, {super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  List<ReviewModel> reviewList = [];
  List<UserDataModel> userList = [];
  List<GetReviews> allReviews = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getReviews();
  }

  void getReviews() async {
    setState(() {
      loading = true;
    });
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/get_reviews"),
          body: {
            'service_id': widget.id, //widget.serviceId,//"1",
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      dynamic services = decodedResponse['data'];
      List<dynamic> rev = services['review'];
      rev.forEach((r) {
        List<dynamic> userD = r['userData'];
        userD.forEach((u) {
          int id = int.tryParse(u['id'].toString()) ?? 0;
          int countryId = int.tryParse(u['country_id'].toString()) ?? 0;
          int regionId = int.tryParse(u['region_id'].toString()) ?? 0;
          int cityId = int.tryParse(u['city_id'].toString()) ?? 0;
          int nowIn = int.tryParse(u['now_in'].toString()) ?? 0;
          UserDataModel ud = UserDataModel(
            id,
            u['users_role'].toString() ?? "",
            u['profile_image'].toString() ?? "",
            u['name'].toString() ?? "",
            u['height'].toString() ?? "",
            u['weight'].toString() ?? "",
            u['email'].toString() ?? "",
            countryId,
            regionId,
            cityId,
            nowIn,
            u['mobile'].toString() ?? "",
            u['dob'].toString() ?? "",
            u['username'].toString() ?? "",
            u['first_name'].toString() ?? "",
            u['last_name'].toString() ?? "",
          );
          userList.add(ud);
        });
        int id = int.tryParse(r['id'].toString()) ?? 0;
        int serviceId = int.tryParse(r['service_id'].toString()) ?? 0;
        int userId = int.tryParse(r['user_id'].toString()) ?? 0;
        int star = int.tryParse(r['star'].toString()) ?? 0;
        int status = int.tryParse(r['status'].toString()) ?? 0;
        int count = int.tryParse(r['count'].toString()) ?? 0;
        ReviewModel rm = ReviewModel(
            id,
            serviceId,
            userId,
            star,
            r['remark'].toString() ?? "",
            status,
            r['created_at'].toString() ?? "",
            r['updated_at'].toString() ?? "",
            userList,
            count);
        reviewList.add(rm);
      });
      int aveRating = int.tryParse(services['average_rating'].toString()) ?? 0;
      GetReviews gm = GetReviews(aveRating, reviewList);
      allReviews.add(gm);
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  double convert(String rating) {
    double result = double.parse(rating);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.5,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset(
            'images/backArrow.png',
            height: 20,
          ),
        ),
        title: MyText(
          text: 'Review',
          color: bluishColor,
          weight: FontWeight.bold,
        ),
      ),
      backgroundColor: greyProfileColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: reviewList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return loading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        MyText(
                          text: "Loading",
                          fontStyle: FontWeight.bold,
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              text: "${'Reviews'} "
                                  " (${reviewList[index].count})",
                              color: greyTextColor,
                              weight: FontWeight.w700,
                              size: 14,
                            ),
                            Row(
                              children: [
                                MyText(
                                  text: "${reviewList[index].star}",
                                  color: greyTextColor,
                                  weight: FontWeight.w700,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  initialRating: convert(
                                      reviewList[index].star.toString()),
                                  itemSize: 15,
                                  minRating: 0,
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
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reviewList[index].um[index].id == 1
                                ? MyText(
                                    text:
                                        "${(reviewList[index].um[index].name)} ${'|'} ${("Oman")}", //"ReviJohn Doe | California | 9days ago",
                                    color: blackTypeColor4,
                                    weight: FontWeight.w600,
                                  )
                                : MyText(
                                    text:
                                        "${(reviewList[index].um[index].name)} ${'|'} ${(reviewList[index].um[index].userName)}", //"ReviJohn Doe | California | 9days ago",
                                    color: blackTypeColor4,
                                    weight: FontWeight.w600,
                                  ),
                            const SizedBox(
                              height: 5,
                            ),
                            RatingBar.builder(
                              ignoreGestures: true,
                              initialRating:
                                  convert(reviewList[index].star.toString()),
                              itemSize: 15,
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
                            const SizedBox(
                              height: 5,
                            ),
                            MyText(
                              text: reviewList[index].remarks,
                              //'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer finibus eros nec ex aliquam iaculis. Donec et magna viverra, gravida lacus eget, posuere dui. Suspendisse convallis condimentum dolor, ',
                              color: blackTypeColor4,
                              size: 12,
                              weight: FontWeight.w600,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Image(
                                    image: ExactAssetImage('images/like.png')),
                                const SizedBox(
                                  width: 10,
                                ),
                                MyText(
                                  text: '0',
                                  color: blackTypeColor4,
                                  size: 10,
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: blackColor.withOpacity(0.3),
                            )
                          ],
                        ),
                      ],
                    );
            }),
      ),
    );
  }
}
