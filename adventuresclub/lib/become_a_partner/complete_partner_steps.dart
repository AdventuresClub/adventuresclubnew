import 'dart:developer';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_partner_provider.dart';
import 'package:adventuresclub/widgets/buttons/bottom_button.dart';

import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CompletePartnerSteps extends StatefulWidget {
  const CompletePartnerSteps({Key? key}) : super(key: key);

  @override
  State<CompletePartnerSteps> createState() => _CompletePartnerStepsState();
}

class _CompletePartnerStepsState extends State<CompletePartnerSteps> {
  PageController pageController = PageController(initialPage: 0);


  List text = [
    'Banner',
    'Description',
    'Program',
    'Cost/GeoLoc'
  ];
  List text1 = [
    '1',
    '2',
    '3',
    '4'
  ];
  @override
  Widget build(BuildContext context) {
    final completePartnerProvider =
        Provider.of<CompletePartnerProvider>(context, listen: false);
    log('Rebuilding');
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.5,
        centerTitle: true,
        leading: IconButton(
            onPressed:  () => Navigator.pop(context),
            icon: Image.asset(
             'images/backArrow.png',
              height: 20,
            ),
          ),
          title: MyText(text: 'Become A Partner',color: bluishColor,),
          
      ),
      body: Consumer<CompletePartnerProvider>(
              builder: (context, provider, child) {
                return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
    
          Padding(
            padding: const EdgeInsets.only(top:20.0,left:20,bottom: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: MyText(
                          text: 'Just follow simple 3 steps to list up your adventure',
                          size: 12,
                          weight: FontWeight.w400,
                          color: greyColor,
                        ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
            ),
            child: Consumer<CompletePartnerProvider>(
              builder: (context, provider, child) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:0.0),
                    child: StepProgressIndicator(
    totalSteps: provider.steps.length,
                  currentStep: provider.currentStep + 1,
    size: 36,
    selectedColor: bluishColor,
    unselectedColor: greyColor,
    customStep: (index, color, _) => color == bluishColor
        ?  Row(
                   children: [
                        const Expanded(
                        child: Divider(color: greyColor,thickness: 5,indent: 0,endIndent: 0,),),
                       CircleAvatar(
              radius: 40,
              backgroundColor: color,
              child:MyText(text: text1[index],color: whiteColor,)
            ),
                        const Expanded(
                        child: Divider(color: greyColor,thickness: 5,),),
                    ],
                  )
        
        :  Row(
                    children: [
                      const Expanded(
                        child: Divider(color: greyColor,thickness: 5,indent: 0,),),
                        
                       CircleAvatar(
              radius: 40,
              backgroundColor: color,
              child:MyText(text: text1[index],color: whiteColor,)
            ),
                       const Expanded(
                        child: Divider(color: greyColor,thickness: 5,),),
                    ],
                  ),
)
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Consumer<CompletePartnerProvider>(
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
      );}),
      bottomNavigationBar: BottomButton(
          bgColor: whiteColor,
          onTap: () => completePartnerProvider.nextStep(context)),
    );
  }
}
