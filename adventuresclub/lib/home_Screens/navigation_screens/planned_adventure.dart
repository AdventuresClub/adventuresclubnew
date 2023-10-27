// // ignore_for_file: avoid_function_literals_in_foreach_calls

// import 'dart:convert';
// import 'dart:developer';
// import 'package:adventuresclub/constants.dart';
// import 'package:adventuresclub/home_Screens/accounts/about.dart';
// import 'package:adventuresclub/home_Screens/details.dart';
// import 'package:adventuresclub/models/filter_data_model/programs_model.dart';
// import 'package:adventuresclub/models/home_services/home_services_model.dart';
// import 'package:adventuresclub/models/home_services/services_model.dart';
// import 'package:adventuresclub/models/services/aimed_for_model.dart';
// import 'package:adventuresclub/models/services/availability_model.dart';
// import 'package:adventuresclub/models/services/booking_data_model.dart';
// import 'package:adventuresclub/models/services/dependencies_model.dart';
// import 'package:adventuresclub/models/services/get_services_model.dart';
// import 'package:adventuresclub/models/services/included_activities_model.dart';
// import 'package:adventuresclub/models/services/manish_model.dart';
// import 'package:adventuresclub/widgets/my_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:http/http.dart' as http;
// import '../../../models/services/service_image_model.dart';
// import '../../models/home_services/become_partner.dart';

// class PlannedAdventure extends StatefulWidget {
//   final String? day;
//   const PlannedAdventure({this.day, super.key});

//   @override
//   State<PlannedAdventure> createState() => PlannedAdventureState();
// }

// class PlannedAdventureState extends State<PlannedAdventure> {
//   DateTime _selectedDay = DateTime.now();
//   Map getServicesMap = {};
//   bool loading = false;
//   String id = "1";
//   List<AvailabilityModel> gAm = [];
//   List<ServiceImageModel> gSim = [];
//   List<IncludedActivitiesModel> gIAm = [];
//   List<DependenciesModel> gdM = [];
//   List<ProgrammesModel> gPm = [];
//   List<AimedForModel> gAfm = [];
//   List<BookingDataModel> gBdm = [];
//   List<ManishModel> gMm = [];
//   List<HomeServicesModel> gm = [];
//   List<GetServicesModel> pGm = [];
//   List<ServicesModel> ngSM = [];
//   List<BecomePartner> nBp = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //getServicesList();
//   }

//   Future getServicesList() async {
//     setState(() {
//       loading = true;
//     });
//     var response = await http.post(
//         Uri.parse(
//             "${Constants.baseUrl}/api/v1/get_allservices"),
//         body: {
//           "country_id": id,
//         });
//     if (response.statusCode == 200) {
//       var getServicesMap = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
//       dynamic result = getServicesMap['data'];
//       List<dynamic> s = result['services'];
//       s.forEach((services) {
//         List<dynamic> available = services['availability'];
//         available.forEach((a) {
//           AvailabilityModel am = AvailabilityModel(
//               a['start_date'].toString() ?? "", a['end_date'].toString() ?? "");
//           gAm.add(am);
//         });
//         List<dynamic> becomePartner = services['become_partner'];
//         becomePartner.forEach((b) {
//           BecomePartner bp = BecomePartner(
//               b['cr_name'].toString() ?? "",
//               b['cr_number'].toString() ?? "",
//               b['description'].toString() ?? "");
//         });
//         List<dynamic> aF = services['aimed_for'];
//         aF.forEach((a) {
//           AimedForModel afm = AimedForModel(
//             int.tryParse(a['id'].toString()) ?? 0,
//             a['AimedName'].toString() ?? "",
//             a['image'].toString() ?? "",
//             a['created_at'].toString() ?? "",
//             a['updated_at'].toString() ?? "",
//             a['deleted_at'].toString() ?? "",
//             int.tryParse(a['service_id'].toString()) ?? 0,
//           );
//           gAfm.add(afm);
//         });
//         List<dynamic> image = services['images'];
//         image.forEach((i) {
//           ServiceImageModel sm = ServiceImageModel(
//             int.tryParse(i['id'].toString()) ?? 0,
//             int.tryParse(i['service_id'].toString()) ?? 0,
//             int.tryParse(i['is_default'].toString()) ?? 0,
//             i['image_url'].toString() ?? "",
//             i['thumbnail'].toString() ?? "",
//           );
//           gSim.add(sm);
//         });
//         ServicesModel nSm = ServicesModel(
//           int.tryParse(services['id'].toString()) ?? 0,
//           int.tryParse(services['owner'].toString()) ?? 0,
//           services['adventure_name'].toString() ?? "",
//           services['country'].toString() ?? "",
//           services['region'].toString() ?? "",
//           services['city_id'].toString() ?? "",
//           services['service_sector'].toString() ?? "",
//           services['service_category'].toString() ?? "",
//           services['service_type'].toString() ?? "",
//           services['service_level'].toString() ?? "",
//           services['duration'].toString() ?? "",
//           int.tryParse(services['availability_seats'].toString()) ?? 0,
//           int.tryParse(services['start_date'].toString()) ?? "",
//           int.tryParse(services['end_date'].toString()) ?? "",
//           services['latitude'].toString() ?? "",
//           services['longitude'].toString() ?? "",
//           services['write_information'].toString() ?? "",
//           int.tryParse(services['service_plan'].toString()) ?? 0,
//           int.tryParse(services['sfor_id'].toString()) ?? 0,
//           gAm,
//           services['geo_location'].toString() ?? "",
//           services['specific_address'].toString() ?? "",
//           services['cost_inc'].toString() ?? "",
//           services['cost_exc'].toString() ?? "",
//           services['currency'].toString() ?? "",
//           int.tryParse(services['points'].toString()) ?? 0,
//           services['pre_requisites'].toString() ?? "",
//           services['minimum_requirements'].toString() ?? "",
//           services['terms_conditions'].toString() ?? "",
//           int.tryParse(services['recommended'].toString()) ?? 0,
//           services['status'].toString() ?? "",
//           services['image'].toString() ?? "",
//           services['descreption]'].toString() ?? "",
//           services['favourite_image'].toString() ?? "",
//           services['created_at'].toString() ?? "",
//           services['updated_at'].toString() ?? "",
//           services['delete_at'].toString() ?? "",
//           int.tryParse(services['provider_id'].toString()) ?? 0,
//           int.tryParse(services['service_id'].toString()) ?? 0,
//           services['provider_name'].toString() ?? "",
//           services['provider_profile'].toString() ?? "",
//           services['including_gerea_and_other_taxes'].toString() ?? "",
//           services['excluding_gerea_and_other_taxes'].toString() ?? "",
//           nBp,
//           gAfm,
//           result['stars'].toString() ?? "",
//           int.tryParse(result['is_liked'].toString()) ?? 0,
//           result['baseurl'].toString() ?? "",
//           gSim,
//         );
//         ngSM.add(nSm);
//       });
//       HomeServicesModel sm =
//           HomeServicesModel(result['category'].toString() ?? "", ngSM);
//       gm.add(sm);
//     }
//   }

//   // Future getServicesList() async {
//   //   setState(() {
//   //     loading = true;
//   //   });
//   //   var response = await http.get(Uri.parse(
//   //       "${Constants.baseUrl}/api/v1/services/$id"));
//   //   if (response.statusCode == 200) {
//   //     getServicesMap = json.decode(response.body);
//   //     dynamic result = getServicesMap['data'];
//   //     List<dynamic> available = result['availability'];
//   //     available.forEach((a) {
//   //       AvailabilityModel am = AvailabilityModel(
//   //           int.tryParse(a['id'].toString()) ?? 0, a['day'].toString() ?? "");
//   //       gAm.add(am);
//   //     });
//   //     List<dynamic> image = result['images'];
//   //     image.forEach((i) {
//   //       ServiceImageModel sm = ServiceImageModel(
//   //         int.tryParse(i['id'].toString()) ?? 0,
//   //         int.tryParse(i['service_id'].toString()) ?? 0,
//   //         int.tryParse(i['is_default'].toString()) ?? 0,
//   //         i['image_url'].toString() ?? "",
//   //         i['thumbnail'].toString() ?? "",
//   //       );
//   //       gSim.add(sm);
//   //     });
//   //     List<dynamic> iActivities = result['included_activities'];
//   //     iActivities.forEach((iA) {
//   //       IncludedActivitiesModel iAm = IncludedActivitiesModel(
//   //         int.tryParse(iA['id'].toString()) ?? 0,
//   //         int.tryParse(iA['service_id'].toString()) ?? 0,
//   //         iA['activity_id'].toString() ?? "",
//   //         iA['activity'].toString() ?? "",
//   //         iA['image'].toString() ?? "",
//   //       );
//   //       gIAm.add(iAm);
//   //     });
//   //     List<dynamic> dependency = result['dependencies'];
//   //     dependency.forEach((d) {
//   //       DependenciesModel dm = DependenciesModel(
//   //         int.tryParse(d['id'].toString()) ?? 0,
//   //         d['dependency_name'].toString() ?? "",
//   //         d['image'].toString() ?? "",
//   //         d['updated_at'].toString() ?? "",
//   //         d['created_at'].toString() ?? "",
//   //         d['deleted_at'].toString() ?? "",
//   //       );
//   //       gdM.add(dm);
//   //     });
//   //     List<dynamic> programs = result['programs'];
//   //     programs.forEach((p) {
//   //       ProgrammesModel pm = ProgrammesModel(
//   //         int.tryParse(p['id'].toString()) ?? 0,
//   //         int.tryParse(p['service_id'].toString()) ?? 0,
//   //         p['title'].toString() ?? "",
//   //         p['start_datetime'].toString() ?? "",
//   //         p['end_datetime'].toString() ?? "",
//   //         p['description'].toString() ?? "",
//   //       );
//   //       gPm.add(pm);
//   //     });
//   //     List<dynamic> aF = result['aimed_for'];
//   //     aF.forEach((a) {
//   //       AimedForModel afm = AimedForModel(
//   //         int.tryParse(a['id'].toString()) ?? 0,
//   //         a['AimedName'].toString() ?? "",
//   //         a['image'].toString() ?? "",
//   //         a['created_at'].toString() ?? "",
//   //         a['updated_at'].toString() ?? "",
//   //         a['deleted_at'].toString() ?? "",
//   //         int.tryParse(a['service_id'].toString()) ?? 0,
//   //       );
//   //       gAfm.add(afm);
//   //     });
//   //     List<dynamic> booking = result['bookingData'];
//   //     booking.forEach((b) {
//   //       BookingDataModel bdm = BookingDataModel(
//   //         int.tryParse(b['id'].toString()) ?? 0,
//   //         int.tryParse(b['user_id'].toString()) ?? 0,
//   //         int.tryParse(b['service_id'].toString()) ?? 0,
//   //         int.tryParse(b['transaction_id'].toString()) ?? 0,
//   //         int.tryParse(b['pay_status'].toString()) ?? 0,
//   //         int.tryParse(b['provider_id'].toString()) ?? 0,
//   //         int.tryParse(b['adult'].toString()) ?? 0,
//   //         int.tryParse(b['kids'].toString()) ?? 0,
//   //         b['message'].toString() ?? "",
//   //         b['unit_amount'].toString() ?? "",
//   //         b['total_amount'].toString() ?? "",
//   //         b['discounted_amount'].toString() ?? "",
//   //         int.tryParse(b['future_plan'].toString()) ?? 0,
//   //         b['booking_date'].toString() ?? "",
//   //         int.tryParse(b['currency'].toString()) ?? 0,
//   //         int.tryParse(b['coupon_applied'].toString()) ?? 0,
//   //         b['status'].toString() ?? "",
//   //         int.tryParse(b['updated_by'].toString()) ?? 0,
//   //         b['cancelled_reason'].toString() ?? "",
//   //         b['payment_status'].toString() ?? "",
//   //         b['payment_channel'].toString() ?? "",
//   //         b['deleted_at'].toString() ?? "",
//   //         b['created_at'].toString() ?? "",
//   //         b['updated_at'].toString() ?? "",
//   //       );
//   //       gBdm.add(bdm);
//   //     });
//   //     GetServicesModel sm = GetServicesModel(
//   //       int.tryParse(result['id'].toString()) ?? 0,
//   //       int.tryParse(result['owner'].toString()) ?? 0,
//   //       result['adventure_name'].toString() ?? "",
//   //       result['country'].toString() ?? "",
//   //       result['region'].toString() ?? "",
//   //       result['city_id'].toString() ?? "",
//   //       result['service_sector'].toString() ?? "",
//   //       result['service_category'].toString() ?? "",
//   //       result['service_type'].toString() ?? "",
//   //       result['service_level'].toString() ?? "",
//   //       result['duration'].toString() ?? "",
//   //       int.tryParse(result['availability_seats'].toString()) ?? 0,
//   //       int.tryParse(result['start_date'].toString()) ?? "",
//   //       int.tryParse(result['end_date'].toString()) ?? "",
//   //       result['latitude'].toString() ?? "",
//   //       result['longitude'].toString() ?? "",
//   //       result['write_information'].toString() ?? "",
//   //       int.tryParse(result['service_plan'].toString()) ?? 0,
//   //       int.tryParse(result['sfor_id'].toString()) ?? 0,
//   //       gAm,
//   //       result['geo_location'].toString() ?? "",
//   //       result['specific_address'].toString() ?? "",
//   //       result['cost_inc'].toString() ?? "",
//   //       result['cost_exc'].toString() ?? "",
//   //       result['currency'].toString() ?? "",
//   //       int.tryParse(result['points'].toString()) ?? 0,
//   //       result['pre_requisites'].toString() ?? "",
//   //       result['minimum_requirements'].toString() ?? "",
//   //       result['terms_conditions'].toString() ?? "",
//   //       int.tryParse(result['recommended'].toString()) ?? 0,
//   //       result['status'].toString() ?? "",
//   //       result['image'].toString() ?? "",
//   //       result['descreption]'].toString() ?? "",
//   //       result['favourite_image'].toString() ?? "",
//   //       result['created_at'].toString() ?? "",
//   //       result['updated_at'].toString() ?? "",
//   //       result['delete_at'].toString() ?? "",
//   //       int.tryParse(result['provider_id'].toString()) ?? 0,
//   //       result['provider_name'].toString() ?? "",
//   //       result['provider_profile'].toString() ?? "",
//   //       result['thumbnail'].toString() ?? "",
//   //       result['rating'].toString() ?? "",
//   //       int.tryParse(result['reviewed_by'].toString()) ?? 0,
//   //       int.tryParse(result['is_liked'].toString()) ?? 0,
//   //       result['baseurl'].toString() ?? "",
//   //       gSim,
//   //       gIAm,
//   //       gdM,
//   //       gPm,
//   //       int.tryParse(result['stars'].toString()) ?? 0,
//   //       int.tryParse(result['booked_seats'].toString()) ?? 0,
//   //       gAfm,
//   //       int.tryParse(result['booking'].toString()) ?? 0,
//   //       gBdm,
//   //       gMm,
//   //       int.tryParse(result['booking'].toString()) ?? 0,
//   //     );
//   //     pGm.add(sm);
//   //     setState(() {
//   //       loading = false;
//   //     });
//   //   }
//   // }

//   void filter() {
//     getServicesList();
//     pGm.forEach(
//       (element) {
//         List<AvailabilityModel> am = element.availability;
//         am.forEach(
//           (a) {
//             if (widget.day == a.day) {
//               gm.add(element);
//             }
//           },
//         );
//       },
//     );
//   }

//   void goToDetails(HomeServicesModel gm) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) {
//           return Details(gm: gm);
//         },
//       ),
//     );
//   }

//   void goToProvider() {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) {
//           return const About();
//         },
//       ),
//     );
//   }

//   List activityHeading = [
//     'Cycling',
//     'Summit Hike',
//     'Kit Surfing',
//     'Paramotor...',
//     'Scuba diving',
//     'Sky diving',
//     'Highline ad...',
//   ];

//   double convert(String rating) {
//     double result = double.parse(rating);
//     return result;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return loading
//         ? Center(
//             child: Column(
//               children: const [
//                 Text("Loading ....."),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 CircularProgressIndicator()
//               ],
//             ),
//           )
//         : ListView.builder(
//             padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
//             shrinkWrap: true,
//             physics: const ClampingScrollPhysics(),
//             itemCount: gm.length,
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () => goToDetails(gm[index]),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 3.0),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16)),
//                     elevation: 2,
//                     child: Padding(
//                       padding:
//                           const EdgeInsets.only(top: 0.0, left: 0, right: 0),
//                       child: Column(
//                         children: [
//                           //Text(gm[index].pProfile),
//                           // ElevatedButton(
//                           //     onPressed: getServicesList,
//                           //     child: const Text("test")),
//                           Stack(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 4.0, right: 4, left: 4),
//                                 child: Container(
//                                   width:
//                                       MediaQuery.of(context).size.width / 2.4,
//                                   height: 100,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(8),
//                                     image: DecorationImage(
//                                         // colorFilter: ColorFilter.mode(
//                                         //     Colors.black.withOpacity(0.1),
//                                         //     BlendMode.darken),
//                                         image: const ExactAssetImage(
//                                           'images/png',
//                                           // ),
//                                           //   NetworkImage(
//                                           // "${gm[index].baseURL}${gm[index].images[index].imageUrl}",
//                                           //gm[index].images[index].imageUrl,
//                                         ),
//                                         fit: BoxFit.cover),
//                                   ),
//                                 ),
//                               ),
//                               const Positioned(
//                                 bottom: 5,
//                                 right: 5,
//                                 child: CircleAvatar(
//                                   radius: 12,
//                                   backgroundColor: transparentColor,
//                                   child: Image(
//                                     image: ExactAssetImage(
//                                       'images/heart.png',
//                                     ),
//                                     height: 14,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 5),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width / 2.4,
//                             child: Row(
//                               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               // crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     MyText(
//                                       text: gm[index].sm[index].adventureName,
//                                       maxLines: 1,
//                                       color: blackColor,
//                                       size: 11,
//                                       fontFamily: 'Roboto',
//                                       weight: FontWeight.bold,
//                                       height: 1.3,
//                                     ),
//                                     MyText(
//                                       text: gm[index].sm[index].geoLocation,
//                                       //text: 'Dhufar',
//                                       color: greyColor3,
//                                       size: 10,
//                                       height: 1.3,
//                                     ),
//                                     MyText(
//                                       text: gm[index].sm[index].serviceLevel,
//                                       //text: 'Advanced',
//                                       color: blackTypeColor3,
//                                       size: 10,
//                                       height: 1.3,
//                                     ),
//                                     Row(
//                                       children: [
//                                         MyText(
//                                           text: gm[index]
//                                               .sm[index]
//                                               .am[index]
//                                               .aimedName,
//                                           color: redColor,
//                                           size: 10,
//                                           height: 1.3,
//                                         ),
//                                         const SizedBox(width: 10),
//                                         // MyText(
//                                         //   text: gm[index]
//                                         //       .aimedFor[index]
//                                         //       .aimedName,
//                                         //   color: redColor,
//                                         //   size: 10,
//                                         //   height: 1.3,
//                                         // ),
//                                       ],
//                                     ),
//                                     // Row(
//                                     //   children: [
//                                     //     MyText(
//                                     //       text: 'Mixed...',
//                                     //       color: redColor,
//                                     //       size: 10,
//                                     //       height: 1.3,
//                                     //     ),
//                                     //     const SizedBox(width: 5),
//                                     //     MyText(
//                                     //       text: 'Girls',
//                                     //       color: redColor,
//                                     //       size: 10,
//                                     //       height: 1.3,
//                                     //     ),
//                                     //   ],
//                                     // ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     const SizedBox(height: 2),
//                                     Align(
//                                       alignment: Alignment.centerRight,
//                                       child: RatingBar.builder(
//                                         initialRating:
//                                             convert(gm[index].sm[index].stars),
//                                         itemSize: 10,
//                                         //minRating: 1,
//                                         direction: Axis.horizontal,
//                                         allowHalfRating: true,
//                                         itemCount: 5,
//                                         itemPadding: const EdgeInsets.symmetric(
//                                             horizontal: 1.0),
//                                         itemBuilder: (context, _) => const Icon(
//                                           Icons.star,
//                                           color: Colors.amber,
//                                           size: 12,
//                                         ),
//                                         onRatingUpdate: (rating) {
//                                           print(rating);
//                                         },
//                                       ),
//                                     ),
//                                     const SizedBox(height: 2),
//                                     MyText(
//                                       text: 'Earn 0 points',
//                                       color: blueTextColor,
//                                       size: 10,
//                                       height: 1.3,
//                                     ),
//                                     MyText(
//                                       text: '',
//                                       color: blueTextColor,
//                                       size: 10,
//                                       height: 1.3,
//                                     ),
//                                     MyText(
//                                       text: "${gm[index].sm[index].costExc} "
//                                           "${gm[index].sm[index].currency}",
//                                       //text: 'OMR 20.00',
//                                       color: blackTypeColor3,
//                                       size: 10,
//                                       height: 1.3,
//                                     ),
//                                     const SizedBox(height: 2),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Image(
//                             image: const ExactAssetImage(
//                               'images/line.png',
//                             ),
//                             width: MediaQuery.of(context).size.width / 2.4,
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width / 2.4,
//                             child: Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: GestureDetector(
//                                 onTap: goToProvider,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     CircleAvatar(
//                                         radius: 10,
//                                         backgroundColor: transparentColor,
//                                         child: Image(
//                                           height: 40,
//                                           width: 50,
//                                           image: NetworkImage(
//                                               gm[index].sm[index].pProfile),
//                                           //ExactAssetImage('images/avatar.png'),
//                                           fit: BoxFit.cover,
//                                         )),
//                                     const SizedBox(width: 2),

//                                     //   MyText(text: 'Provided By AdventuresClub',color:blackColor,fontStyle: FontStyle.italic,size: 10,),
//                                     Text.rich(
//                                       TextSpan(
//                                         children: [
//                                           const TextSpan(
//                                               text: "Provided By ",
//                                               style: TextStyle(
//                                                 color: greyColor,
//                                                 fontSize: 8,
//                                               )),
//                                           TextSpan(
//                                             text: gm[index].sm[index].pName,
//                                             //text: 'AdventuresClub',
//                                             style: const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: blackTypeColor4,
//                                               fontSize: 9,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//   }
// }
