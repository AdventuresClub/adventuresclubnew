// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/about.dart';
import 'package:adventuresclub/home_Screens/details.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/provider/services_provider.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/services_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceList extends StatefulWidget {
  final String type;
  const ServiceList(this.type, {super.key});

  @override
  State<ServiceList> createState() => ServiceListState();
}

class ServiceListState extends State<ServiceList> {
  Map getServicesMap = {};
  bool loading = false;
  String id = "1";
  // List<ServicesModel> gAccomodationSModel = [];
  // List<ServicesModel> gTransportSModel = [];
  // List<ServicesModel> gSkyServicesModel = [];
  // List<ServicesModel> gWaterServicesModel = [];
  // List<ServicesModel> gLandServicesModel = [];
  // List<HomeServicesModel> accomodation = [];
  // List<HomeServicesModel> transport = [];
  // List<HomeServicesModel> sky = [];
  // List<HomeServicesModel> water = [];
  // List<HomeServicesModel> land = [];
  List<ServicesModel> gm = [];

  void goToDetails(ServicesModel gm) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return Details(gm: gm);
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

  double convert(String rating) {
    double result = double.parse(rating);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == "Accomodation") {
      gm = Provider.of<ServicesProvider>(context).allAccomodation;
    } else if (widget.type == "Transport") {
      gm = Provider.of<ServicesProvider>(context).allTransport;
    } else if (widget.type == "Sky") {
      gm = Provider.of<ServicesProvider>(context).allSky;
    } else if (widget.type == "Water") {
      gm = Provider.of<ServicesProvider>(context).allWater;
    } else if (widget.type == "Land") {
      gm = Provider.of<ServicesProvider>(context).allLand;
    }
    return loading
        ? Center(
            child: Column(
              children: const [
                Text("Loading ....."),
                SizedBox(
                  height: 10,
                ),
                CircularProgressIndicator()
              ],
            ),
          )
        : gm.isEmpty
            ? Center(
                child: MyText(
                  text: "No Accomodation Adventure Right now",
                  color: blackColor,
                  weight: FontWeight.w500,
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: gm.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => goToDetails(gm[index]),
                    child: ServicesCard(gm[index]),
                    // child: Card(
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8)),
                    //   elevation: 2,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(top: 4.0, left: 4, right: 4),
                    //     child: Column(
                    //       children: [
                    //         Stack(
                    //           children: [
                    //             Container(
                    //               width: MediaQuery.of(context).size.width / 2.3,
                    //               height: 100,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(8),
                    //                 image: DecorationImage(
                    //                     // colorFilter: ColorFilter.mode(
                    //                     //     Colors.black.withOpacity(0.1),
                    //                     //     BlendMode.darken),
                    //                     // image: ExactAssetImage(
                    //                     //   'images/overseas.png',
                    //                     // ),
                    //                     image: NetworkImage(
                    //                       "${"https://adventuresclub.net/adventureClub/public/uploads/"}${gm[index].images[index].imageUrl}",
                    //                     ),
                    //                     fit: BoxFit.cover),
                    //               ),
                    //             ),
                    //             const Positioned(
                    //               bottom: 5,
                    //               right: 5,
                    //               child: CircleAvatar(
                    //                 radius: 12,
                    //                 backgroundColor: transparentColor,
                    //                 child: Image(
                    //                   image: ExactAssetImage(
                    //                     'images/heart.png',
                    //                   ),
                    //                   height: 14,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         const SizedBox(height: 5),
                    //         SizedBox(
                    //           width: MediaQuery.of(context).size.width / 2.3,
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             // crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Expanded(
                    //                 child: Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   mainAxisAlignment: MainAxisAlignment.start,
                    //                   children: [
                    //                     MyText(
                    //                       text: gm[index].adventureName,
                    //                       maxLines: 1,
                    //                       color: blackColor,
                    //                       size: 14,
                    //                       weight: FontWeight.bold,
                    //                       fontFamily: 'Roboto',
                    //                       height: 1.3,
                    //                     ),
                    //                     MyText(
                    //                       text: gm[index].geoLocation,
                    //                       overFlow: TextOverflow.clip,
                    //                       maxLines: 1,
                    //                       //text: 'Dhufar',
                    //                       color: greyColor2,
                    //                       size: 11,
                    //                       height: 1.3,
                    //                     ),
                    //                     MyText(
                    //                       text: gm[index].serviceLevel,
                    //                       //text: 'Advanced',
                    //                       color: blackTypeColor3,
                    //                       size: 10,
                    //                       height: 1.3,
                    //                     ),
                    //                     Row(
                    //                       children: [
                    //                         MyText(
                    //                           text: gm[index].am[0].aimedName,
                    //                           color: redColor,
                    //                           size: 10,
                    //                           height: 1.3,
                    //                         ),
                    //                         const SizedBox(width: 10),
                    //                         // MyText(
                    //                         //   text: gm[index]
                    //                         //       .aimedFor[index]
                    //                         //       .aimedName,
                    //                         //   color: redColor,
                    //                         //   size: 10,
                    //                         //   height: 1.3,
                    //                         // ),
                    //                       ],
                    //                     ),
                    //                     // Row(
                    //                     //   children: [
                    //                     //     MyText(
                    //                     //       text: 'Mixed...',
                    //                     //       color: redColor,
                    //                     //       size: 10,
                    //                     //       height: 1.3,
                    //                     //     ),
                    //                     //     const SizedBox(width: 5),
                    //                     //     MyText(
                    //                     //       text: 'Girls',
                    //                     //       color: redColor,
                    //                     //       size: 10,
                    //                     //       height: 1.3,
                    //                     //     ),
                    //                     //   ],
                    //                     // ),
                    //                   ],
                    //                 ),
                    //               ),
                    //               const SizedBox(height: 5),
                    //               Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.end,
                    //                 mainAxisAlignment: MainAxisAlignment.start,
                    //                 children: [
                    //                   const SizedBox(height: 2),
                    //                   Align(
                    //                     alignment: Alignment.centerRight,
                    //                     child: RatingBar.builder(
                    //                       initialRating: convert(gm[index].stars),
                    //                       itemSize: 10,
                    //                       //minRating: 1,
                    //                       direction: Axis.horizontal,
                    //                       allowHalfRating: true,
                    //                       itemCount: 5,
                    //                       itemPadding: const EdgeInsets.symmetric(
                    //                           horizontal: 1.0),
                    //                       itemBuilder: (context, _) => const Icon(
                    //                         Icons.star,
                    //                         color: Colors.amber,
                    //                         size: 12,
                    //                       ),
                    //                       onRatingUpdate: (rating) {
                    //                         print(rating);
                    //                       },
                    //                     ),
                    //                   ),
                    //                   const SizedBox(height: 2),
                    //                   MyText(
                    //                     text: 'Earn ${gm[index].points} points',
                    //                     color: blueTextColor,
                    //                     size: 10,
                    //                     height: 1.3,
                    //                   ),
                    //                   MyText(
                    //                     text: '',
                    //                     color: blueTextColor,
                    //                     size: 10,
                    //                     height: 1.3,
                    //                   ),
                    //                   MyText(
                    //                     text: "${gm[index].costExc} "
                    //                         "${gm[index].currency}",
                    //                     //text: 'OMR 20.00',
                    //                     color: blackTypeColor3,
                    //                     size: 10,
                    //                     height: 1.3,
                    //                   ),
                    //                   const SizedBox(height: 2),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //         Image(
                    //           image: const ExactAssetImage(
                    //             'images/line.png',
                    //           ),
                    //           width: MediaQuery.of(context).size.width / 2.4,
                    //         ),
                    //         const SizedBox(
                    //           height: 3,
                    //         ),
                    //         SizedBox(
                    //           width: MediaQuery.of(context).size.width / 2.3,
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(2.0),
                    //             child: GestureDetector(
                    //               onTap: goToProvider,
                    //               child: Row(
                    //                 mainAxisAlignment: MainAxisAlignment.start,
                    //                 crossAxisAlignment: CrossAxisAlignment.center,
                    //                 children: [
                    //                   CircleAvatar(
                    //                     radius: 10,
                    //                     backgroundColor: transparentColor,
                    //                     child: Image(
                    //                       height: 70,
                    //                       width: 60,
                    //                       image: NetworkImage(gm[index].pProfile),
                    //                       //ExactAssetImage('images/avatar.png'),
                    //                       fit: BoxFit.cover,
                    //                     ),
                    //                   ),
                    //                   const SizedBox(width: 2),
                    //                   //   MyText(text: 'Provided By AdventuresClub',color:blackColor,fontStyle: FontStyle.italic,size: 10,),
                    //                   Text.rich(
                    //                     TextSpan(
                    //                       children: [
                    //                         const TextSpan(
                    //                             text: "Provided By ",
                    //                             style: TextStyle(
                    //                               color: greyColor3,
                    //                               fontSize: 10,
                    //                             )),
                    //                         TextSpan(
                    //                           text: gm[index].pName,
                    //                           //text: 'AdventuresClub',
                    //                           style: const TextStyle(
                    //                               fontWeight: FontWeight.bold,
                    //                               color: blackTypeColor4,
                    //                               fontSize: 11,
                    //                               fontFamily: "Roboto"),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  );
                },
              );
  }
}