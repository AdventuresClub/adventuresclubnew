// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/requests/upcoming_Requests_Model.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/multiline_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

class MyAdventures extends StatefulWidget {
  final UpcomingRequestsModel gm;
  const MyAdventures(this.gm, {super.key});

  @override
  State<MyAdventures> createState() => _MyAdventuresState();
}

class _MyAdventuresState extends State<MyAdventures> {
  TextEditingController commentController = TextEditingController();
  double stars = 0;
  abc() {}

  void cancel() {
    message("Review Successfully posted");
    Navigator.of(context).pop();
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void addReview() async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/add_review"),
          body: {
            'user_id': Constants.userId.toString(),
            'service_id': widget.gm.serviceId.toString(),
            "star": stars.toString(),
            'remark': commentController.text,
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        cancel();
      }
      dynamic body = jsonDecode(response.body);
      // error = decodedError['data']['name'];
      Constants.showMessage(context, body['message'].toString());
      print(response.statusCode);
      print(response.body);
      print(response.headers);
      print(decodedResponse['data']['user_id']);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
            text: 'Review Adventures',
            color: bluishColor,
            weight: FontWeight.bold,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12),
          child: ListView(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 36,
                  backgroundImage:
                      //  ExactAssetImage('images/airrides.png'),
                      NetworkImage(
                          "${'https://adventuresclub.net/adventureClub/public/uploads/'}${widget.gm.sImage[0].thumbnail}"),
                ),
                title: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: MyText(
                        text: widget.gm.adventureName,
                        weight: FontWeight.w700,
                        color: blackColor,
                        size: 14,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: MyText(
                        text: "${widget.gm.aDate} " " ${widget.gm.bDate}",
                        weight: FontWeight.w500,
                        color: blackColor,
                        size: 12,
                      ),
                    ),
                  ],
                ),
                subtitle: MyText(
                  text: widget.gm.des,
                  //'Lorem ipsum dolor sit amet,\nconsetetur sadipscing elitr,\nsed diam nonumy eirmod',
                  weight: FontWeight.w400,
                  color: greyColor,
                  size: 14,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: MyText(
                        text: 'How was your experience there',
                        color: blackColor,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      //width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: blackColor.withOpacity(0.2))),
                      padding: const EdgeInsets.symmetric(vertical: 22),
                      child: Center(
                        child: RatingBar.builder(
                          glowColor: Colors.amber,
                          glowRadius: 4,
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
                              stars = rating;
                            });
                            print(rating);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MultiLineField(
                        'Description', 5, whiteColor, commentController),
                    const SizedBox(
                      height: 50,
                    ),
                    ButtonIconLess('Submit', bluishColor, whiteColor, 1.8, 16,
                        18, addReview),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
