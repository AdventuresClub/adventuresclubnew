import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/details.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RecommendedActivity extends StatefulWidget {
  const RecommendedActivity({super.key});

  @override
  State<RecommendedActivity> createState() => _RecommendedActivityState();
}

class _RecommendedActivityState extends State<RecommendedActivity> {
  void goToDetails() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const Details();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: 7,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: goToDetails,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.only(top:4.0,left:4,right: 4),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.darken),
                                image: const ExactAssetImage(
                                  'images/picture1.png',
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const Positioned(
                          bottom: 5,
                          right: 5,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.favorite,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: 'Hill Climbing',
                          color: blackColor,
                          size: 12,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(width: 20),
                        RatingBar.builder(
                          initialRating: 4,
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
                          text: 'Wadi haver',
                          color: blackColor,
                          size: 10,
                        ),
                        const SizedBox(width: 45),
                        MyText(
                          text: 'Earn 200 points',
                          color: Colors.blue,
                          size: 10,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyText(
                          text: 'Medium',
                          color: blackColor,
                          size: 10,
                        ),
                        const SizedBox(width: 80),
                        MyText(
                          text: '2000',
                          color: Colors.blue,
                          size: 10,
                        ),
                      ],
                    ),
                    Divider(
                      indent: 4,
                      endIndent: 4,
                      thickness: 1,
                      color: blackColor.withOpacity(0.2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const CircleAvatar(
                            radius: 12,
                            backgroundColor: transparentColor,
                            child: Image(
                              image: ExactAssetImage('images/avatar.png'),
                              fit: BoxFit.cover,
                            )),
                        //const SizedBox(width: 10),
                        MyText(
                          text: 'Provide By Alexander',
                          color: blackColor,
                          fontStyle: FontStyle.italic,
                          size: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
