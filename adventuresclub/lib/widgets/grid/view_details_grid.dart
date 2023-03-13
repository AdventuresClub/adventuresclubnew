// ignore_for_file: unused_local_variable

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/about.dart';
import 'package:adventuresclub/home_Screens/details.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ViewDetailsGrid extends StatefulWidget {
  final List<ServicesModel> gm;
  const ViewDetailsGrid(this.gm, {super.key});

  @override
  State<ViewDetailsGrid> createState() => _ViewDetailsGridState();
}

class _ViewDetailsGridState extends State<ViewDetailsGrid> {
  void goToDetails() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const Details();
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
  void goToProvider() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const About();
        },
      ),
    );
  }

  double convert(String rating) {
    double result = double.parse(rating);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 10.75;
    final double itemWidth = MediaQuery.of(context).size.width / 3.5;
    return GridView.count(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      mainAxisSpacing: 0.2,
      childAspectRatio: 0.84,
      crossAxisSpacing: 0.2,
      crossAxisCount: 2,
      children: List.generate(
        widget.gm.length, // widget.profileURL.length,
        (index) {
          return GestureDetector(
            onTap: goToDetails,
            child: Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0, left: 4, right: 4),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  // colorFilter: ColorFilter.mode(
                                  //     Colors.black.withOpacity(0.1),
                                  //     BlendMode.darken),
                                  image:
                                      //  ExactAssetImage(
                                      //   'images/overseas.png',
                                      // ),
                                      NetworkImage(
                                    "${"https://adventuresclub.net/adventureClub/public/uploads/"}${widget.gm[index].images[index].imageUrl}",
                                  ),
                                  fit: BoxFit.cover),
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
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: widget.gm[index].adventureName,
                                    maxLines: 1,
                                    color: blackColor,
                                    size: 14,
                                    weight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    height: 1.3,
                                  ),
                                  MyText(
                                    text: widget.gm[index].geoLocation,
                                    overFlow: TextOverflow.clip,
                                    maxLines: 1,
                                    //text: 'Dhufar',
                                    color: greyColor2,
                                    size: 11,
                                    height: 1.3,
                                  ),
                                  MyText(
                                    text: widget.gm[index].serviceLevel,
                                    //text: 'Advanced',
                                    color: blackTypeColor3,
                                    size: 10,
                                    height: 1.3,
                                  ),
                                  Row(
                                    children: [
                                      MyText(
                                        text: widget.gm[index].am[0].aimedName,
                                        color: redColor,
                                        size: 10,
                                        height: 1.3,
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                ],
                              ),
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
                                    initialRating:
                                        convert(widget.gm[index].stars),
                                    itemSize: 10,
                                    //minRating: 1,
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
                                  text:
                                      'Earn ${widget.gm[index].points} points',
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
                                  text: "${widget.gm[index].costExc} "
                                      "${widget.gm[index].currency}",
                                  //text: 'OMR 20.00',
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
                      const SizedBox(
                        height: 3,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: GestureDetector(
                            onTap: goToProvider,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: transparentColor,
                                  child: Image(
                                    height: 70,
                                    width: 60,
                                    image:
                                        NetworkImage(widget.gm[index].pProfile),
                                    //ExactAssetImage('images/avatar.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                //   MyText(text: 'Provided By AdventuresClub',color:blackColor,fontStyle: FontStyle.italic,size: 10,),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                          text: "Provided By ",
                                          style: TextStyle(
                                            color: greyColor3,
                                            fontSize: 10,
                                          )),
                                      TextSpan(
                                        text: widget.gm[index].pName,
                                        //text: 'AdventuresClub',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: blackTypeColor4,
                                            fontSize: 11,
                                            fontFamily: "Roboto"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
