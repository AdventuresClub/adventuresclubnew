import 'package:app/constants.dart';
import 'package:app/home_Screens/accounts/about.dart';
import 'package:app/home_Screens/accounts/my_services.dart';
import 'package:app/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RecentlyAdded extends StatefulWidget {
  const RecentlyAdded({super.key});

  @override
  State<RecentlyAdded> createState() => _RecentlyAddedState();
}

class _RecentlyAddedState extends State<RecentlyAdded> {
  goToMyServices() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const MyServices();
    }));
  }

  void goToProvider() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const About();
        },
      ),
    );
  }

  List activityHeading = [
    'Cycling',
    'Summit Hike',
    'Kit Surfing',
    'Paramotor...',
    'Scuba diving',
    'Sky diving',
    'Highline ad...',
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: 7,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: goToMyServices,
            child: Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0, left: 0, right: 0),
                  child: Column(children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0, right: 4, left: 4),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.4,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.2),
                                        BlendMode.darken),
                                    image: const ExactAssetImage(
                                      'images/overseas.png',
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        const Positioned(
                            bottom: 5,
                            right: 5,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: transparentColor,
                              child: Image(
                                image: ExactAssetImage(
                                  'images/heart.png',
                                ),
                                height: 14,
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MyText(
                                text: activityHeading[index],
                                color: blackColor,
                                size: 12,
                                fontFamily: 'Roboto',
                                weight: FontWeight.bold,
                                height: 1.3,
                              ),
                              MyText(
                                text: 'Dhufar',
                                color: greyColor3,
                                size: 10,
                                height: 1.3,
                              ),
                              MyText(
                                text: 'Advanced',
                                color: blackTypeColor3,
                                size: 10,
                                height: 1.3,
                              ),
                              Row(
                                children: [
                                  MyText(
                                    text: 'Gents',
                                    color: redColor,
                                    size: 10,
                                    height: 1.3,
                                  ),
                                  const SizedBox(width: 10),
                                  MyText(
                                    text: 'Ladies',
                                    color: redColor,
                                    size: 10,
                                    height: 1.3,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  MyText(
                                    text: 'Mixed...',
                                    color: redColor,
                                    size: 10,
                                    height: 1.3,
                                  ),
                                  const SizedBox(width: 5),
                                  MyText(
                                    text: 'Girls',
                                    color: redColor,
                                    size: 10,
                                    height: 1.3,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 2),
                              Align(
                                alignment: Alignment.centerRight,
                                child: RatingBar.builder(
                                  initialRating: 4,
                                  itemSize: 10,
                                  minRating: 1,
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
                              ),
                              const SizedBox(height: 2),
                              MyText(
                                text: 'Earn 0 points',
                                color: blueTextColor,
                                size: 10,
                                height: 1.3,
                              ),
                              MyText(
                                text: '',
                                color: blueTextColor,
                                size: 10,
                                height: 1.3,
                              ),
                              MyText(
                                text: 'OMR 20.00',
                                color: blackTypeColor3,
                                size: 10,
                                height: 1.3,
                              ),
                              const SizedBox(height: 2),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Image(
                      image: const ExactAssetImage(
                        'images/line.png',
                      ),
                      width: MediaQuery.of(context).size.width / 2.4,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.4,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                          onTap: goToProvider,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                  radius: 10,
                                  backgroundColor: transparentColor,
                                  child: Image(
                                    image: ExactAssetImage('images/avatar.png'),
                                    fit: BoxFit.cover,
                                  )),
                              SizedBox(width: 2),

                              //   MyText(text: 'Provided By AdventuresClub',color:blackColor,fontStyle: FontStyle.italic,size: 10,),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "Provided By ",
                                        style: TextStyle(
                                          color: greyColor,
                                          fontSize: 8,
                                        )),
                                    TextSpan(
                                      text: 'AdventuresClub',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: blackTypeColor4,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          );
        });
  }
}
