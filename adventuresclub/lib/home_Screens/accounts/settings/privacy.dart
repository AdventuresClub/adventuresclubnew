// import 'package:adventuresclub/constants.dart';
// import 'package:adventuresclub/widgets/my_text.dart';
// import 'package:flutter/material.dart';

// class Privacy extends StatefulWidget {
//   const Privacy({super.key});

//   @override
//   State<Privacy> createState() => _PrivacyState();
// }

// class _PrivacyState extends State<Privacy> {
//    Map MapFilter = {};
//   List<TermsConditionModel> termsList = [];
//   bool loading = false;

//   @override
//   void initState() {
//     super.initState();
//     getTerms();
//   }

//   Future getTerms() async {
//     setState(() {
//       loading = true;
//     });
//     var response = await http.get(Uri.parse(
//         "https://adventuresclub.net/adventureClub/api/v1/terms-conditions"));
//     if (response.statusCode == 200) {
//       MapFilter = json.decode(response.body);
//       List<dynamic> result = MapFilter['data'];
//       result.forEach((element) {
//         int id = int.tryParse(element['id'].toString()) ?? 0;
//         TermsConditionModel tc = TermsConditionModel(
//           id,
//           element['title'].toString() ?? "",
//           element['description'].toString() ?? "",
//           element['created_at'].toString() ?? "",
//           element['updated_at'].toString() ?? "",
//           element['deleted_at'].toString() ?? "",
//         );
//         termsList.add(tc);
//       });
//       setState(() {
//         loading = false;
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: greyProfileColor,
//       appBar: AppBar(
//         backgroundColor: whiteColor,
//         elevation: 1.5,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Image.asset(
//             'images/backArrow.png',
//             height: 20,
//           ),
//         ),
//         title: MyText(
//           text: 'Privacy Policy',
//           color: bluishColor,
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(12),
//         shrinkWrap: true,
//         physics: const ClampingScrollPhysics(),
//         children: [
//           MyText(
//             text:
//                 '1 Cybersecurity should underpin digital payment infrastructures...',
//             weight: FontWeight.w500,
//             color: blackTypeColor1,
//           ),
//           const SizedBox(
//             height: 7,
//           ),
//           MyText(
//             text:
//                 'As we come close to a year of being separated from or colleagues, friends, family, and conducting both our professional and personal lives through our laptops and phone screens - It is a good time to take a step back and re-evaluate the p',
//             weight: FontWeight.w400,
//             color: greyColor,
//           ),
//           const Divider(
//             color: blackTypeColor3,
//           ),
//           MyText(
//             text: 'Tapping into the data boom with DBaaS',
//             weight: FontWeight.w500,
//             color: blackTypeColor1,
//             size: 14,
//           ),
//           const SizedBox(
//             height: 7,
//           ),
//           MyText(
//             text:
//                 'MultiCloud is here to stay and is slowly becoming inevitable for many organizations. At the same time, it is important to go beyond the hype of the buzzword and undestand where it can help, and where it cannot. One of the common benef',
//             weight: FontWeight.w400,
//             color: greyColor,
//           ),
//           const Divider(
//             color: blackTypeColor3,
//           ),
//           MyText(
//             text: 'IoT Security: Is Blockchain the way to go?',
//             weight: FontWeight.w500,
//             color: blackTypeColor1,
//             size: 14,
//           ),
//           const SizedBox(
//             height: 7,
//           ),
//           MyText(
//             text:
//                 'The first generation blockchain has demonstrated immense value being a secure and cost effective way for recording and maintaining history of transactions for asset tracking purposes.What makes blockchain secure is the fact that it is a',
//             weight: FontWeight.w400,
//             color: greyColor,
//           ),
//           const Divider(
//             color: blackTypeColor3,
//           ),
//           MyText(
//             text:
//                 'As we increase our tech-dependence, be vigilant about protecting data',
//             weight: FontWeight.w500,
//             color: blackTypeColor1,
//             size: 14,
//           ),
//           const SizedBox(
//             height: 7,
//           ),
//           MyText(
//             text:
//                 'Like much of the world, Indias enterprises saw a significant advancement in technology use over the past year, and the digital transformation of enterprises is expected to maintain its momentum. The business opportunities presented by',
//             weight: FontWeight.w400,
//             color: greyColor,
//           ),
//           const Divider(
//             color: blackTypeColor3,
//           ),
//           MyText(
//             text: 'Recommended summer camp programs:',
//             weight: FontWeight.w500,
//             color: blackTypeColor1,
//             size: 14,
//           ),
//           const SizedBox(
//             height: 7,
//           ),
//           MyText(
//             text:
//                 "That one time at band camp: became a ciche for a reason: because summer camp is the ultimate source of absurd and wonderful adventures - the kind you can embarrass yur grandchildren with for decades to come.Count on plenty of crafting with natural materials, group hiking, and schmoozing with co-eds on your summer camp adventuretravel program. The campfire songs and s'more at the end of each night are just the icing on the cake.",
//             weight: FontWeight.w400,
//             color: greyColor,
//           ),
//           const Divider(
//             color: blackTypeColor3,
//           ),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.all(18),
//         height: 70,
//         child: Column(
//           children: [
//             Divider(
//               indent: MediaQuery.of(context).size.width / 2,
//               endIndent: 18,
//               color: blackTypeColor3,
//             ),
//             Align(
//                 alignment: Alignment.centerRight,
//                 child: MyText(
//                   text: 'All Rights Reserved AdventuresClub',
//                   color: greyColor,
//                   size: 12,
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
