import 'dart:io';

import 'package:adventuresclub/complete_profile/banner_page.dart';
import 'package:adventuresclub/complete_profile/cost.dart';
import 'package:adventuresclub/complete_profile/description.dart';
import 'package:adventuresclub/complete_profile/program.dart';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/buttons/bottom_button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CreateNewServices extends StatefulWidget {
  const CreateNewServices({super.key});

  @override
  State<CreateNewServices> createState() => _CreateNewServicesState();
}

class _CreateNewServicesState extends State<CreateNewServices> {
  List text = ['Banner', 'Description', 'Program', 'Cost/GeoLoc'];
  List text1 = ['1', '2', '3', '4'];
  int count = 0;
  List<File> imageList = [];

  final List<Map<String, dynamic>> steps = [
    {
      'heading': 'Just follow simple four steps to list up your adventure',
      'child': const Description()
    },
    {
      'heading': 'Just follow simple four steps to list up your adventure',
      'child': const Program()
    },
    {
      'heading': 'Just follow simple four steps to list up your adventure',
      'child': const Cost()
    },
  ];

  void next() {
    if (count == 0 && imageList.length < 2) {
      MyText(text: "Please add Image");
    }
    setState(() {
      count++;
    });
  }

  void previous() {
    setState(() {
      count--;
    });
  }

  void getImages(List<File> imgList) {
    imageList = imgList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.5,
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(
            'images/backArrow.png',
            height: 20,
          ),
          onPressed: previous, //() => Navigator.of(context).pop(),
        ),
        title: MyText(
          text: 'Create Adventure',
          color: bluishColor,
          weight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: MyText(
                text: 'Just follow simple four steps to list up your adventure',
                size: 14,
                weight: FontWeight.w600,
                color: greyColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StepProgressIndicator(
              padding: 0,
              totalSteps: text1.length,
              currentStep: count + 1,
              size: 60,
              selectedColor: bluishColor,
              unselectedColor: greyColor,
              customStep: (index, color, _) => color == bluishColor
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                  color: bluishColor,
                                  borderRadius: BorderRadius.circular(65)),
                              child: Center(
                                  child: MyText(
                                text: text1[index],
                                color: whiteColor,
                                weight: FontWeight.w700,
                                fontFamily: 'Roboto',
                                size: 12,
                              )),
                            ),
                            const Expanded(
                              child: Divider(
                                color: bluishColor,
                                thickness: 7,
                              ),
                            ),
                          ],
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: MyText(
                              text: text[index],
                              color: bluishColor,
                              weight: FontWeight.w700,
                              fontFamily: 'Roboto',
                              size: 12,
                            )),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                  color: greyColor3,
                                  borderRadius: BorderRadius.circular(65)),
                              child: Center(
                                  child: MyText(
                                text: text1[index],
                                color: whiteColor,
                                weight: FontWeight.w700,
                                fontFamily: 'Roboto',
                                size: 12,
                              )),
                            ),
                            if (index != 3)
                              const Expanded(
                                child: Divider(
                                  color: greyColor,
                                  thickness: 7,
                                ),
                              ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            text: text[index],
                            color: greyColor,
                            weight: FontWeight.w700,
                            fontFamily: 'Roboto',
                            size: 12,
                          ),
                        ),
                      ],
                    ),
            ),
            Expanded(
              child: IndexedStack(
                index: count,
                children: [
                  BannerPage(getImages),
                  const Description(),
                  const Program(),
                  const Cost(),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomButton(bgColor: whiteColor, onTap: next),
    );
  }
}
