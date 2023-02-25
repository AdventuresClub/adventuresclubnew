// ignore_for_file: unused_local_variable

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/myservices_ad_details.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class MyServicesGrid extends StatefulWidget {
  const MyServicesGrid({super.key});

  @override
  State<MyServicesGrid> createState() => _MyServicesGridState();
}

class _MyServicesGridState extends State<MyServicesGrid> {
  List images = ['images/location-on.png', 'images/user.png'];
  List text = ['Muscat, Oman', 'Accepted'];
  goToAd() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const MyServicesAdDetails();
    }));
  }

  @override
  Widget build(BuildContext context) {
    final double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 8.75;
    final double itemWidth = MediaQuery.of(context).size.width / 4.5;
    return GridView.count(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      mainAxisSpacing: 0.3,
      childAspectRatio: 0.8,
      crossAxisSpacing: 0.3,
      crossAxisCount: 2,
      children: List.generate(
        6, // widget.profileURL.length,
        (index) {
          return GestureDetector(
            onTap: goToAd,
            child: Card(
              child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 130,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                text: 'Hill Climbing',
                                color: blackColor,
                                size: 12,
                                weight: FontWeight.w500,
                                fontFamily: 'Roboto',
                              ),
                              const SizedBox(width: 5),
                              MyText(
                                text: '09 April, 2020',
                                color: greyColor,
                                size: 9,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Wrap(
                            direction: Axis.vertical,
                            children: List.generate(2, (index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(
                                      image: ExactAssetImage(images[index]),
                                      height: 12,
                                      color: images[index] == 'images/user.png'
                                          ? Colors.green
                                          : greyColor),
                                  const SizedBox(width: 5),
                                  MyText(
                                    text: text[index],
                                    color: text[index] == 'Accepted'
                                        ? Colors.green
                                        : bluishColor,
                                    size: 9,
                                    height: 1.6,
                                  ),
                                ],
                              );
                            }),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
