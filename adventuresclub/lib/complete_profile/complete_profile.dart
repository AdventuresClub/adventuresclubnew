import 'dart:developer';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:adventuresclub/widgets/buttons/bottom_button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  PageController pageController = PageController(initialPage: 0);

  List text = ['Banner', 'Description', 'Program', 'Cost/GeoLoc'];
  List text1 = ['1', '2', '3', '4'];
  List stepText = [
    'Official Details',
    'Payment Setup',
    'Select Package',
  ];
  @override
  Widget build(BuildContext context) {
    final completeProfileProvider =
        Provider.of<CompleteProfileProvider>(context, listen: false);
    log('Rebuilding');
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.5,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => completeProfileProvider.back(context),
          icon: Image.asset(
            'images/backArrow.png',
            height: 20,
          ),
        ),
        title: MyText(
          text: 'Create Adventure',
          color: bluishColor,
        ),
      ),
      body: Consumer<CompleteProfileProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, bottom: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text:
                        'Just follow simple four steps to list up your adventure',
                    size: 12,
                    weight: FontWeight.w500,
                    color: greyColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: Consumer<CompleteProfileProvider>(
                  builder: (context, provider, child) {
                    return StepProgressIndicator(
                      padding: 0,
                      totalSteps: provider.steps.length,
                      currentStep: provider.currentStep + 1,
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
                                          borderRadius:
                                              BorderRadius.circular(65)),
                                      child: Center(
                                          child: MyText(
                                        text: text1[index],
                                        color: whiteColor,
                                        weight: FontWeight.w500,
                                        fontFamily: 'Roboto',
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
                                      weight: FontWeight.w500,
                                      fontFamily: 'Roboto',
                                      size: 10,
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
                                          borderRadius:
                                              BorderRadius.circular(65)),
                                      child: Center(
                                          child: MyText(
                                              text: text1[index],
                                              color: whiteColor,
                                              weight: FontWeight.w500,
                                              fontFamily: 'Roboto')),
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
                                    weight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                    size: 10,
                                  ),
                                ),
                              ],
                            ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Consumer<CompleteProfileProvider>(
                  builder: (context, provider, child) {
                    return ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 0,
                      ),
                      children: [
                        SizedBox(
                          child: provider.steps[provider.currentStep]['child'],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomButton(
          bgColor: whiteColor,
          onTap: () => completeProfileProvider.nextStep(context)),
    );
  }
}
