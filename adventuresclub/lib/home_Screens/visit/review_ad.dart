import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/multiline_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewAd extends StatefulWidget {
  const ReviewAd({super.key});

  @override
  State<ReviewAd> createState() => _ReviewAdState();
}

class _ReviewAdState extends State<ReviewAd> {
  TextEditingController controller = TextEditingController();
  abc() {}
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
          text: 'Review Adventures',
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
                        initialRating: 3,
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
                          print(rating);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MultiLineField('Description', 5, whiteColor, controller),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ButtonIconLess('Submit', bluishColor, whiteColor, 1.8, 16, 18, abc),
          ],
        ),
      ),
    );
  }
}
