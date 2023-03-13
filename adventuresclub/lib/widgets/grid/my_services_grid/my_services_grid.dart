// ignore_for_file: unused_local_variable

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/myservices_ad_details.dart';
import 'package:adventuresclub/models/my_services/my_services_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class MyServicesGrid extends StatefulWidget {
  final List<MyServicesModel> gSm;
  const MyServicesGrid(this.gSm, {super.key});

  @override
  State<MyServicesGrid> createState() => _MyServicesGridState();
}

class _MyServicesGridState extends State<MyServicesGrid> {
  List images = ['images/location-on.png', 'images/user.png'];
  List text = ['Muscat, Oman', 'Accepted'];

  void goToAd(MyServicesModel sm) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return MyServicesAdDetails(sm);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 6.75;
    final double itemWidth = MediaQuery.of(context).size.width / 4.5;
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12, left: 5, right: 5),
      child: GridView.count(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        mainAxisSpacing: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 2,
        crossAxisCount: 2,
        children: List.generate(
          widget.gSm.length, // widget.profileURL.length,
          (index) {
            return GestureDetector(
              onTap: () => goToAd(widget.gSm[index]),
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(12)
                                          // topLeft: Radius.circular(12),
                                          // topRight: Radius.circular(12),
                                          ),
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
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: MyText(
                                      text: widget.gSm[index]
                                          .adventureName, //'Hill Climbing',
                                      color: blackColor,
                                      size: 14,
                                      weight: FontWeight.w700,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  // const SizedBox(width: 5),
                                  MyText(
                                    text: widget.gSm[index].startDate,
                                    //.substring(0, 10), //'09 April, 2020',
                                    color: greyColor,
                                    weight: FontWeight.w600,
                                    size: 10,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Wrap(
                                direction: Axis.vertical,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Image(
                                          image: ExactAssetImage(
                                              'images/user.png'),
                                          height: 12,
                                          color: greyColor),
                                      const SizedBox(width: 5),
                                      MyText(
                                        text: widget.gSm[index]
                                            .geoLocation, //text[index],
                                        color: greyColor.withOpacity(1),
                                        size: 10,
                                        height: 1.6,
                                        weight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Image(
                                        image: ExactAssetImage(
                                            'images/location-on.png'),
                                        height: 12,
                                        color: Color.fromARGB(255, 19, 84, 21),
                                      ),
                                      const SizedBox(width: 5),
                                      MyText(
                                        letterSpacing: 1,
                                        text: widget.gSm[index].status == 1
                                            ? "Accepted"
                                            : "Pending",
                                        color: const Color.fromARGB(
                                            255, 19, 84, 21),
                                        size: 10,
                                        height: 1.6,
                                        weight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
