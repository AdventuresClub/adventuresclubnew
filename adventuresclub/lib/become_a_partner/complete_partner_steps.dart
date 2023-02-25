// import 'dart:developer';

// import 'package:adventuresclub/constants.dart';
// import 'package:adventuresclub/provider/complete_profile_provider/complete_partner_provider.dart';
// import 'package:adventuresclub/widgets/buttons/bottom_button.dart';

// import 'package:adventuresclub/widgets/my_text.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:step_progress_indicator/step_progress_indicator.dart';

// class CompletePartnerSteps extends StatefulWidget {
//   const CompletePartnerSteps({Key? key}) : super(key: key);

//   @override
//   State<CompletePartnerSteps> createState() => _CompletePartnerStepsState();
// }

// class _CompletePartnerStepsState extends State<CompletePartnerSteps> {
//   PageController pageController = PageController(initialPage: 0);

//   List text = ['Banner', 'Description', 'Program', 'Cost/GeoLoc'];
//   List text1 = ['1', '2', '3', '4'];
//   List stepText = [
//     'Official Details',
//     'Payment Setup',
//     'Select Package',
//   ];

//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   super.dispose();
//   //   pageController;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final completePartnerProvider =
//         Provider.of<CompletePartnerProvider>(context, listen: false);
//     log('Rebuilding');
//     return Scaffold(
//       backgroundColor: whiteColor,
//       appBar: AppBar(
//         backgroundColor: whiteColor,
//         elevation: 1.5,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () => completePartnerProvider.previousStep(context),
//           icon: Image.asset(
//             'images/backArrow.png',
//             height: 20,
//           ),
//         ),
//         title: MyText(
//           text: 'Become A Partner',
//           color: bluishColor,
//         ),
//       ),
//       body: Consumer<CompletePartnerProvider>(
//           builder: (context, provider, child) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 20.0, left: 20, bottom: 15),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: MyText(
//                   text: 'Just follow simple 3 steps to list up your adventure',
//                   size: 12,
//                   weight: FontWeight.w400,
//                   color: greyColor,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 left: 35,
//               ),
//               child: Consumer<CompletePartnerProvider>(
//                 builder: (context, provider, child) {
//                   return StepProgressIndicator(
//                     padding: 0,
//                     totalSteps: provider.steps.length,
//                     currentStep: provider.currentStep + 1,
//                     size: 60,
//                     selectedColor: bluishColor,
//                     unselectedColor: greyColor,
//                     customStep: (index, color, _) => color == bluishColor
//                         ? Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   if (index == 0)
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 8.0),
//                                       child: Container(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 16, vertical: 12),
//                                         decoration: BoxDecoration(
//                                             color: bluishColor,
//                                             borderRadius:
//                                                 BorderRadius.circular(65)),
//                                         child: Center(
//                                             child: MyText(
//                                                 text: text1[index],
//                                                 color: whiteColor,
//                                                 weight: FontWeight.w500,
//                                                 fontFamily: 'Roboto')),
//                                       ),
//                                     ),
//                                   if (index != 0)
//                                     Container(
//                                       width: 15,
//                                       color: bluishColor,
//                                       height: 7,
//                                     ),
//                                   if (index != 0)
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 16, vertical: 12),
//                                       decoration: BoxDecoration(
//                                           color: bluishColor,
//                                           borderRadius:
//                                               BorderRadius.circular(65)),
//                                       child: Center(
//                                           child: MyText(
//                                               text: text1[index],
//                                               color: whiteColor,
//                                               weight: FontWeight.w500,
//                                               fontFamily: 'Roboto')),
//                                     ),
//                                   if (index != 2)
//                                     const Expanded(
//                                       child: Divider(
//                                         color: bluishColor,
//                                         thickness: 7,
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: MyText(
//                                   text: stepText[index],
//                                   color: bluishColor,
//                                   weight: FontWeight.w500,
//                                   fontFamily: 'Roboto',
//                                   size: 10,
//                                   align: TextAlign.left,
//                                 ),
//                               ),
//                             ],
//                           )
//                         : Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 0.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     //     if(index != 0)
//                                     //  Container(
//                                     //   width: 15,
//                                     //   color: greyColor3,
//                                     //   height: 10,
//                                     // ),
//                                     if (index == 0)
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 8.0),
//                                         child: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 16, vertical: 12),
//                                           decoration: BoxDecoration(
//                                               color: greyColor3,
//                                               borderRadius:
//                                                   BorderRadius.circular(65)),
//                                           child: Center(
//                                               child: MyText(
//                                             text: text1[index],
//                                             color: whiteColor,
//                                             weight: FontWeight.w500,
//                                             fontFamily: 'Roboto',
//                                           )),
//                                         ),
//                                       ),
//                                     if (index != 0)
//                                       Container(
//                                         width: 15,
//                                         color: greyColor,
//                                         height: 7,
//                                       ),
//                                     // if (index !=0 )
//                                     //  Container(
//                                     //   width: 15,
//                                     //   color: bluishColor,
//                                     //   height: 7,
//                                     // ),
//                                     // if (index != 0 && index != 1 )
//                                     //  Container(
//                                     //   width: 15,
//                                     //   color: bluishColor,
//                                     //   height: 7,
//                                     // ),
//                                     if (index != 0)
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 0.0),
//                                         child: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 16, vertical: 12),
//                                           decoration: BoxDecoration(
//                                               color: greyColor3,
//                                               borderRadius:
//                                                   BorderRadius.circular(65)),
//                                           child: Center(
//                                               child: MyText(
//                                             text: text1[index],
//                                             color: whiteColor,
//                                             weight: FontWeight.w500,
//                                             fontFamily: 'Roboto',
//                                           )),
//                                         ),
//                                       ),
//                                     if (index != 2)
//                                       const Expanded(
//                                         child: Divider(
//                                           color: greyColor,
//                                           thickness: 7,
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: MyText(
//                                   text: stepText[index],
//                                   color: greyColor,
//                                   weight: FontWeight.w500,
//                                   fontFamily: 'Roboto',
//                                   size: 10,
//                                   align: TextAlign.left,
//                                 ),
//                               ),
//                             ],
//                           ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Expanded(
//               child: Consumer<CompletePartnerProvider>(
//                 builder: (context, provider, child) {
//                   return ListView(
//                     shrinkWrap: true,
//                     physics: const BouncingScrollPhysics(),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 15,
//                       vertical: 0,
//                     ),
//                     children: [
//                       SizedBox(
//                         child: provider.steps[provider.currentStep]['child'],
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//       }),
//       bottomNavigationBar: BottomButton(
//           bgColor: whiteColor,
//           onTap: () => completePartnerProvider.nextStep(context)),
//     );
//   }
// }
