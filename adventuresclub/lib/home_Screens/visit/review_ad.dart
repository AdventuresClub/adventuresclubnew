// ignore_for_file: avoid_print

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/multiline_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

class ReviewAd extends StatefulWidget {
  final String id;
  const ReviewAd(this.id, {super.key});

  @override
  State<ReviewAd> createState() => _ReviewAdState();
}

class _ReviewAdState extends State<ReviewAd> {
  TextEditingController descriptionController = TextEditingController();
  double visitRating = 0;

  void review() async {
    if (visitRating > 0) {
      if (descriptionController.text.length >= 10) {
        try {
          var response = await http.post(
              Uri.parse("${Constants.baseUrl}/api/v1/add_review_location"),
              body: {
                'user_id': Constants.userId.toString(),
                'location_id': widget.id,
                'rating': visitRating.toString(),
                'rating_description': descriptionController.text.trim(),
              });
          if (response.statusCode == 200) {
            message("Review Added Successfully");
            home();
          }
          print(response.statusCode);
          print(response.body);
          print(response.headers);
        } catch (e) {
          print(e.toString());
        }
      } else {
        message("Description must be atleast 10 Characters");
      }
    } else {
      message("Ratings cannot be zero");
    }
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void home() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const BottomNavigation();
    }));
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
          text: 'reviewAdventure',
          color: bluishColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: 'How was your experience there',
                      color: blackColor,
                      size: 18,
                      weight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: blackColor.withOpacity(0.2))),
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    child: Center(
                      child: RatingBar.builder(
                        unratedColor: greyColor1,
                        initialRating: 0,
                        itemSize: 32,
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
                          setState(() {
                            visitRating = rating;
                          });
                          print(visitRating);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MultiLineField(
                      'Description', 5, whiteColor, descriptionController),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ButtonIconLess(
                'Submit', bluishColor, whiteColor, 1.8, 16, 18, review),
          ],
        ),
      ),
    );
  }
}
