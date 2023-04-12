// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/about.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/home_services/services_model.dart';

class ServicesCard extends StatefulWidget {
  final ServicesModel gm;
  final bool show;
  const ServicesCard(this.gm, {this.show = false, super.key});

  @override
  State<ServicesCard> createState() => _ServicesCardState();
}

class _ServicesCardState extends State<ServicesCard> {
  List<String> adventuresPlan = [""];
  String aPlan = "";
  double convert(String rating) {
    double result = double.parse(rating);
    return result;
  }

  void goToProvider(
    String id,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return About(id: id);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getSteps();
  }

  void getSteps() {
    int i = 0;
    widget.gm.am.forEach((element) {
      adventuresPlan.add(element.aimedName);
      if (i < 4) {
        aPlan += "${element.aimedName} ";
        i++;
      }
    });
    //aPlan = adventuresPlan.join(" ");
  }

  @override
  Widget build(BuildContext context) {
    return widget.show
        ? Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 2, right: 2),
              child: Column(
                children: [
                  Stack(
                    children: [
                      widget.gm.images.isEmpty
                          ? Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: const DecorationImage(
                                    image: AssetImage("images/logo.png"),
                                    fit: BoxFit.fill),
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "${"https://adventuresclub.net/adventureClub/public/uploads/"}${widget.gm.images[0].imageUrl}",
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
                                text: widget.gm.adventureName,
                                maxLines: 1,
                                color: blackColor,
                                size: 14,
                                weight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                height: 1.3,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.pin_drop_sharp,
                                    size: 16,
                                    color: greyBackgroundColor.withOpacity(0.6),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  MyText(
                                    text: widget.gm.region,
                                    maxLines: 1,
                                    color: blackColor,
                                    size: 11,
                                    weight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    height: 1.3,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              if (widget.gm.status == "0")
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person_add,
                                      color: redColor,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    MyText(
                                      //text: "testing",
                                      text: "Pending Approval",
                                      //text: 'Advanced',
                                      weight: FontWeight.w700,
                                      color: redColor,
                                      size: 11,
                                      height: 1.3,
                                    ),
                                  ],
                                ),
                              if (widget.gm.status == "1")
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person_add,
                                      color: greenColor1,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    MyText(
                                      //text: "testing",
                                      text: "Accepted",
                                      //text: 'Advanced',
                                      weight: FontWeight.w700,
                                      color: greenColor1,
                                      size: 12,
                                      height: 1.3,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        // const SizedBox(height: 5),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     const SizedBox(height: 2),
                        //     Align(
                        //       alignment: Alignment.centerRight,
                        //       child: RatingBar.builder(
                        //         initialRating: convert(widget.gm.stars),
                        //         itemSize: 10,
                        //         //minRating: 1,
                        //         direction: Axis.horizontal,
                        //         allowHalfRating: true,
                        //         itemCount: 5,
                        //         itemPadding:
                        //             const EdgeInsets.symmetric(horizontal: 1.0),
                        //         itemBuilder: (context, _) => const Icon(
                        //           Icons.star,
                        //           color: Colors.amber,
                        //           size: 12,
                        //         ),
                        //         onRatingUpdate: (rating) {
                        //           print(rating);
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  // Image(
                  //   image: const ExactAssetImage(
                  //     'images/line.png',
                  //   ),
                  //   width: MediaQuery.of(context).size.width / 2.4,
                  // ),
                  // const SizedBox(
                  //   height: 3,
                  // ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width / 2.3,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(2.0),
                  //     child: GestureDetector(
                  //       onTap: () =>
                  //           goToProvider(widget.gm.providerId.toString()),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           CircleAvatar(
                  //             radius: 10,
                  //             backgroundColor: transparentColor,
                  //             child: Image(
                  //               height: 70,
                  //               width: 60,
                  //               image: NetworkImage(widget.gm.pProfile),
                  //               //ExactAssetImage('images/avatar.png'),
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //           const SizedBox(width: 2),
                  //           //   MyText(text: 'Provided By AdventuresClub',color:blackColor,fontStyle: FontStyle.italic,size: 10,),
                  //           Text.rich(
                  //             TextSpan(
                  //               children: [
                  //                 const TextSpan(
                  //                     text: "Provided By ",
                  //                     style: TextStyle(
                  //                       color: greyColor3,
                  //                       fontSize: 10,
                  //                     )),
                  //                 TextSpan(
                  //                   text: widget.gm.pName,
                  //                   //text: 'AdventuresClub',
                  //                   style: const TextStyle(
                  //                       fontWeight: FontWeight.bold,
                  //                       color: blackTypeColor4,
                  //                       fontSize: 11,
                  //                       fontFamily: "Roboto"),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          )
        : Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 2, right: 2),
              child: Column(
                children: [
                  Stack(
                    children: [
                      widget.gm.images.isEmpty
                          ? Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: const DecorationImage(
                                    image: AssetImage("images/logo.png"),
                                    fit: BoxFit.fill),
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "${"https://adventuresclub.net/adventureClub/public/uploads/"}${widget.gm.images[0].imageUrl}",
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
                  const SizedBox(height: 3),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MyText(
                                text: widget.gm.adventureName,
                                maxLines: 1,
                                color: blackColor,
                                size: 14,
                                weight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                height: 1.3,
                              ),
                              MyText(
                                text: widget.gm.region,
                                overFlow: TextOverflow.clip,
                                maxLines: 1,
                                //text: 'Dhufar',
                                weight: FontWeight.w500,
                                color: blackTypeColor3,
                                size: 11,
                                height: 1.3,
                              ),
                              const SizedBox(height: 1),
                              MyText(
                                text: widget.gm.serviceLevel,
                                //text: 'Advanced',
                                color: blackTypeColor3,
                                weight: FontWeight.w500,
                                size: 10,
                                height: 1.3,
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Expanded(
                                    child: MyText(
                                      text: aPlan, //widget.gm.am[0].aimedName,
                                      color: redColor,
                                      weight: FontWeight.w600,
                                      size: 11,
                                      height: 1.3,
                                    ),
                                  ),
                                  //  const SizedBox(width: 0),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //const SizedBox(height: 5),
                        Expanded(
                          flex: 6,
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 2),
                              Align(
                                alignment: Alignment.centerRight,
                                child: RatingBar.builder(
                                  initialRating: convert(widget.gm.stars),
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
                                text: 'Earn ${widget.gm.points} points',
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
                                text: "${widget.gm.currency}"
                                    " "
                                    "${widget.gm.costInc} ",
                                //text: 'OMR 20.00',
                                weight: FontWeight.w600,
                                color: blackTypeColor3,
                                size: 10,
                                height: 1.3,
                              ),
                              const SizedBox(height: 2),
                            ],
                          ),
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
                    height: 2,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: GestureDetector(
                        onTap: () =>
                            goToProvider(widget.gm.providerId.toString()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundImage: NetworkImage(widget.gm.pProfile),
                              backgroundColor: transparentColor,
                            ),
                            const SizedBox(width: 1),
                            //   MyText(text: 'Provided By AdventuresClub',color:blackColor,fontStyle: FontStyle.italic,size: 10,),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                        text: "Provided By ",
                                        style: TextStyle(
                                          color: greyColor3,
                                          fontSize: 10,
                                        )),
                                    TextSpan(
                                      text: widget.gm.pName,
                                      //text: 'AdventuresClub',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: blackTypeColor4,
                                          fontSize: 10,
                                          fontFamily: "Roboto"),
                                    ),
                                  ],
                                ),
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
          );
  }
}