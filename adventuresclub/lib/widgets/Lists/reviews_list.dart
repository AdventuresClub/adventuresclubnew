// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/getReviews/get_reviews_model.dart';
import 'package:adventuresclub/models/getReviews/review_model.dart';
import 'package:adventuresclub/models/getReviews/user_data_model.dart';

import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

class ReviewsList extends StatefulWidget {
  final String serviceId;
  const ReviewsList(this.serviceId, {super.key});

  @override
  State<ReviewsList> createState() => _ReviewsListState();
}

class _ReviewsListState extends State<ReviewsList> {
  List<ReviewModel> reviewList = [];
  List<UserDataModel> userList = [];
  List<GetReviews> allReviews = [];

  @override
  void initState() {
    super.initState();
    getReviews();
  }

  void getReviews() async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/get_reviews"),
          body: {
            'service_id': "11", //widget.serviceId,//"1",
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

      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  double convert(String rating) {
    double result = double.parse(rating);
    return result;
  }

  abc() {}
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: allReviews.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: "${'Reviews'} " " ${(allReviews[index].rm[0].count)}",
                    color: greyColor.withOpacity(0.7),
                  ),
                  RatingBar.builder(
                    initialRating:
                        convert(allReviews[index].rm[0].star.toString()),
                    itemSize: 12,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
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
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text:
                        "${(allReviews[index].rm[0].um[0].firstName)} ' ' ${(allReviews[index].rm[0].um[0].lastName)}", //"ReviJohn Doe | California | 9days ago",
                    color: blackTypeColor4,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RatingBar.builder(
                    initialRating:
                        convert(allReviews[index].rm[0].star.toString()),
                    itemSize: 12,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 134, 101, 1),
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
                    text: allReviews[index].rm[0].remarks,
                    //'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer finibus eros nec ex aliquam iaculis. Donec et magna viverra, gravida lacus eget, posuere dui. Suspendisse convallis condimentum dolor, ',
                    color: blackTypeColor4,
                    size: 10,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Image(image: ExactAssetImage('images/like.png')),
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
                  const Divider()
                ],
              ),
            ],
          );
        });
  }
}
