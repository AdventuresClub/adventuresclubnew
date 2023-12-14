// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/visit/visit_details.dart';
import 'package:adventuresclub/models/visit/get_visit_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class VisitList extends StatefulWidget {
  final List<GetVisitModel> gGv;
  const VisitList(this.gGv, {super.key});

  @override
  State<VisitList> createState() => _VisitListState();
}

class _VisitListState extends State<VisitList> {
  void goToDetails(GetVisitModel vm) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return VisitDetails(vm: vm);
        },
      ),
    );
  }

  List text = [
    'pikon',
    'fort',
    'SQU',
    'pikon',
    'fort',
    'SQU',
    'fort',
  ];

  double convert(String rating) {
    double result = double.parse(rating);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: widget.gGv.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => goToDetails(widget.gGv[index]),
            child: Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.1,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.darken),
                                image: NetworkImage(
                                  "${"${Constants.baseUrl}/public/uploads/"}${widget.gGv[index].destinationImage}",
                                ),
                                // const ExactAssetImage(
                                //   'images/image13.png',
                                // ),
                                fit: BoxFit.cover)),
                      ),
                      const Positioned(
                          bottom: 5,
                          right: 5,
                          child: CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.favorite,
                                size: 14,
                              ))),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MyText(
                              text: widget
                                  .gGv[index].destinationName, //text[index],
                              color: blackColor,
                              size: 12,
                              weight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: RatingBar.builder(
                              initialRating:
                                  convert(widget.gGv[index].rS.toString()), //3,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //   MyText(text: 'Wadi haver',color: blackColor,size: 12,),
                  // const SizedBox(width:45),
                  //   MyText(text: 'Earn 200 points',color: Colors.blue,size: 9,),

                  // ],),
                  //const SizedBox(height:5),
                ]),
              ),
            ),
          );
        });
  }
}
