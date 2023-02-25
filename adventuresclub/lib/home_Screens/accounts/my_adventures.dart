import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/multiline_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyAdventures extends StatefulWidget {
  const MyAdventures({super.key});

  @override
  State<MyAdventures> createState() => _MyAdventuresState();
}

class _MyAdventuresState extends State<MyAdventures> {
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
          text: 'My Adventures',
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
                  Container(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            child: Image(
                              image: ExactAssetImage('images/Ellipse.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(
                                    text: 'Lorem Ipsum',
                                    weight: FontWeight.w700,
                                    color: blackColor,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  MyText(
                                    text: '20 May - 25 May',
                                    weight: FontWeight.w400,
                                    color: greyColor,
                                    size: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              MyText(
                                text:
                                    'Lorem ipsum dolor sit amet,\nconsetetur sadipscing elitr,\nsed diam nonumy eirmod',
                                weight: FontWeight.w400,
                                color: greyColor,
                                size: 14,
                              ),
                            ],
                          ),
                        ],
                      )),
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
