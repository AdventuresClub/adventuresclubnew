// // ignore_for_file: unused_field, prefer_final_fields, avoid_print
// import 'dart:async';
// import 'dart:convert';
// import 'package:app/constants.dart';
// import 'package:app/home_Screens/book_ticket.dart';
// import 'package:app/home_Screens/plan%20_for_future.dart';
// import 'package:app/models/filter_data_model/programs_model.dart';
// import 'package:app/models/home_services/become_partner.dart';
// import 'package:app/models/services/aimed_for_model.dart';
// import 'package:app/models/services/availability_model.dart';
// import 'package:app/models/services/create_services/availability_plan_model.dart';
// import 'package:app/models/services/dependencies_model.dart';
// import 'package:app/models/services/included_activities_model.dart';
// import 'package:app/models/services/service_image_model.dart';
// import 'package:app/new_signup/new_register.dart';
// import 'package:app/widgets/buttons/button_icon_less.dart';
// import 'package:app/widgets/loading_widget.dart';
// import 'package:app/widgets/my_text.dart';
// import 'package:app/widgets/tabs/details_tabs/newdetails_tab.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../models/home_services/services_model.dart';
// import 'package:http/http.dart' as http;

// import '../widgets/buttons/button.dart';

// class NewDetails extends StatefulWidget {
//   final ServicesModel? gm;
//   final bool? show;
//   final String? id;
//   const NewDetails({this.gm, this.show = true, this.id, super.key});

//   @override
//   State<NewDetails> createState() => _NewDetailsState();
// }

// class _NewDetailsState extends State<NewDetails> {
//   final PageController _pageViewController = PageController(initialPage: 0);
//   bool favourite = false;
//   int _activePage = 0;
//   int index = 0;
//   bool future = false;
//   bool costInc = false;
//   String sPrice = "";
//   int _currentPage = 0;
//   ServicesModel? service;
//   late Timer _timer;
//   bool loading = false;
//   Map mapDetails = {};
//   List<BecomePartner> nBp = [];

//   @override
//   void initState() {
//     super.initState();
//     if (widget.gm != null) {
//       service = widget.gm;
//       if (service!.sPlan == 2) {
//         DateTime d = service!.startDate;
//         DateTime now = DateTime.now();
//         future = service!.startDate.isAfter(DateTime.now());
//         // if (d.year < now.year) {
//         //   future = true;
//         // } else if (d.month < now.month) {
//         //   future = true;
//         // } else if (d.day <= now.day) {
//         //   future = true;
//         // }
//       }
//       // _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
//       //   if (_activePage < 6) {
//       //     _activePage++;
//       //   } else {
//       //     _activePage = 0;
//       //   }
//       //   _pageViewController.animateToPage(
//       //     _activePage,
//       //     duration: const Duration(milliseconds: 350),
//       //     curve: Curves.easeIn,
//       //   );
//       // });
//     } else if (widget.id != null) {
//       getDetails(widget.id!);
//       // debugPrint("Widget ID: ${widget.id}");
//       // debugPrint(
//       //     "Available Services: ${provider.allServices.map((e) => e.serviceId).toList()}");
//       // service = provider.allServices.firstWhere(
//       //   (item) => item.serviceId.toString() == widget.id,
//       //   orElse: () => throw Exception("Service with ID ${widget.id} not found"),
//       // );
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _pageViewController.dispose(); // dispose the PageController
//     _timer.cancel();
//   }

// //https://we.tl/t-1oiPMXkgu8`
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     //final provider = Provider.of<ServicesProvider>(context, listen: false);
//     if (widget.gm != null) {
//       service = widget.gm;
//       if (service!.sPlan == 2) {
//         DateTime d = service!.startDate;
//         DateTime now = DateTime.now();
//         if (d.year < now.year) {
//           future = true;
//         } else if (d.month < now.month) {
//           future = true;
//         } else if (d.day <= now.day) {
//           future = true;
//         }
//       }
//       _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
//         if (_activePage < 6) {
//           _activePage++;
//         } else {
//           _activePage = 0;
//         }
//         _pageViewController.animateToPage(
//           _activePage,
//           duration: const Duration(milliseconds: 350),
//           curve: Curves.easeIn,
//         );
//       });
//     }
//     // else if (widget.id != null) {
//     //   getDetails(widget.id!);
//     //   // debugPrint("Widget ID: ${widget.id}");
//     //   // debugPrint(
//     //   //     "Available Services: ${provider.allServices.map((e) => e.serviceId).toList()}");
//     //   // service = provider.allServices.firstWhere(
//     //   //   (item) => item.serviceId.toString() == widget.id,
//     //   //   orElse: () => throw Exception("Service with ID ${widget.id} not found"),
//     //   // );
//     // }

//     // setState(() {});
//   }

//   Future<void> getDetails(String serviceId) async {
//     setState(() {
//       loading = true;
//     });
//     var response = await http
//         .get(Uri.parse("${Constants.baseUrl}/api/v1/services/$serviceId"));
//     if (response.statusCode == 200) {
//       mapDetails = json.decode(response.body);
//       dynamic result = mapDetails['data'];
//       List<AvailabilityPlanModel> gAccomodationPlanModel = [];
//       List<dynamic> availablePlan = result['availability'];
//       availablePlan.forEach((ap) {
//         AvailabilityPlanModel amPlan = AvailabilityPlanModel(
//             int.tryParse(ap['id'].toString()) ?? 0, ap['day'].toString());
//         gAccomodationPlanModel.add(amPlan);
//       });
//       List<AvailabilityModel> gAccomodoationAvaiModel = [];
//       List<dynamic> available = result['availability'];
//       available.forEach((a) {
//         AvailabilityModel am = AvailabilityModel(
//             a['start_date'].toString() ?? "", a['end_date'].toString() ?? "");
//         gAccomodoationAvaiModel.add(am);
//       });
//       if (result['become_partner'] != null) {
//         List<dynamic> becomePartner = result['become_partner'];
//         becomePartner.forEach((b) {
//           BecomePartner bp = BecomePartner(
//               b['cr_name'].toString() ?? "",
//               b['cr_number'].toString() ?? "",
//               b['description'].toString() ?? "");
//         });
//       }
//       List<IncludedActivitiesModel> gIAm = [];
//       List<dynamic> iActivities = result['included_activities'];
//       iActivities.forEach((iA) {
//         IncludedActivitiesModel iAm = IncludedActivitiesModel(
//           int.tryParse(iA['id'].toString()) ?? 0,
//           int.tryParse(iA['service_id'].toString()) ?? 0,
//           iA['activity_id'].toString() ?? "",
//           iA['activity'].toString() ?? "",
//           iA['image'].toString() ?? "",
//         );
//         gIAm.add(iAm);
//       });
//       List<DependenciesModel> gdM = [];
//       List<dynamic> dependency = result['dependencies'];
//       dependency.forEach((d) {
//         DependenciesModel dm = DependenciesModel(
//           int.tryParse(d['id'].toString()) ?? 0,
//           d['dependency_name'].toString() ?? "",
//           d['image'].toString() ?? "",
//           d['updated_at'].toString() ?? "",
//           d['created_at'].toString() ?? "",
//           d['deleted_at'].toString() ?? "",
//         );
//         gdM.add(dm);
//       });
//       List<AimedForModel> gAccomodationAimedfm = [];
//       List<dynamic> aF = result['aimed_for'];
//       aF.forEach((a) {
//         AimedForModel afm = AimedForModel(
//           int.tryParse(a['id'].toString()) ?? 0,
//           a['AimedName'].toString() ?? "",
//           a['image'].toString() ?? "",
//           a['created_at'].toString() ?? "",
//           a['updated_at'].toString() ?? "",
//           a['deleted_at'].toString() ?? "",
//           int.tryParse(a['service_id'].toString()) ?? 0,
//         );
//         gAccomodationAimedfm.add(afm);
//       });
//       List<ServiceImageModel> gAccomodationServImgModel = [];
//       List<dynamic> image = result['images'];
//       image.forEach((i) {
//         ServiceImageModel sm = ServiceImageModel(
//           int.tryParse(i['id'].toString()) ?? 0,
//           int.tryParse(i['service_id'].toString()) ?? 0,
//           int.tryParse(i['is_default'].toString()) ?? 0,
//           i['image_url'].toString() ?? "",
//           i['thumbnail'].toString() ?? "",
//         );
//         gAccomodationServImgModel.add(sm);
//       });
//       List<ProgrammesModel> gPm = [];
//       List<dynamic> programs = result['programs'];
//       programs.forEach((p) {
//         ProgrammesModel pm = ProgrammesModel(
//           int.tryParse(p['id'].toString()) ?? 0,
//           int.tryParse(p['service_id'].toString()) ?? 0,
//           p['title'].toString() ?? "",
//           p['start_datetime'].toString() ?? "",
//           p['end_datetime'].toString() ?? "",
//           p['description'].toString() ?? "",
//         );
//         gPm.add(pm);
//       });
//       DateTime sDate =
//           DateTime.tryParse(result['start_date'].toString()) ?? DateTime.now();
//       DateTime eDate =
//           DateTime.tryParse(result['end_date'].toString()) ?? DateTime.now();
//       ServicesModel nSm = ServicesModel(
//         incDescription: result['inc_description'] ?? "",
//         excDescription: result['exc_description'] ?? "",
//         id: int.tryParse(result['id'].toString()) ?? 0,
//         owner: int.tryParse(result['owner'].toString()) ?? 0,
//         adventureName: result['adventure_name'].toString() ?? "",
//         country: result['country'].toString() ?? "",
//         region: result['region'].toString() ?? "",
//         cityId: result['city_id'].toString() ?? "",
//         serviceSector: result['service_sector'].toString() ?? "",
//         serviceCategory: result['service_category'].toString() ?? "",
//         serviceType: result['service_type'].toString() ?? "",
//         serviceLevel: result['service_level'].toString() ?? "",
//         duration: result['duration'].toString() ?? "",
//         aSeats: int.tryParse(result['available_seats'].toString()) ?? 0,
//         startDate: sDate,
//         endDate: eDate,
//         //int.tryParse(services['start_date'].toString()) ?? "",
//         //int.tryParse(services['end_date'].toString()) ?? "",
//         lat: result['latitude'].toString() ?? "",
//         lng: result['longitude'].toString() ?? "",
//         writeInformation: result['write_information'].toString() ?? "",
//         sPlan: int.tryParse(result['service_plan'].toString()) ?? 0,
//         sForID: int.tryParse(result['sfor_id'].toString()) ?? 0,
//         availability: gAccomodoationAvaiModel,
//         availabilityPlan: gAccomodationPlanModel,
//         geoLocation: result['geo_location'].toString() ?? "",
//         sAddress: result['specific_address'].toString() ?? "",
//         costInc: result['cost_inc'].toString() ?? "",
//         costExc: result['cost_exc'].toString() ?? "",
//         currency: result['currency'].toString() ?? "",
//         points: int.tryParse(result['points'].toString()) ?? 0,
//         preRequisites: result['pre_requisites'].toString() ?? "",
//         mRequirements: result['minimum_requirements'].toString() ?? "",
//         tnc: result['terms_conditions'].toString() ?? "",
//         recommended: int.tryParse(result['recommended'].toString()) ?? 0,
//         status: result['status'].toString() ?? "",
//         image: result['image'].toString() ?? "",
//         des: result['descreption]'].toString() ?? "",
//         fImage: result['favourite_image'].toString() ?? "",
//         ca: result['created_at'].toString() ?? "",
//         upda: result['updated_at'].toString() ?? "",
//         da: result['delete_at'].toString() ?? "",
//         providerId: int.tryParse(result['provider_id'].toString()) ?? 0,
//         serviceId: int.tryParse(result['service_id'].toString()) ?? 0,
//         pName: result['provided_name'].toString() ?? "",
//         pProfile: result['provider_profile'].toString() ?? "",
//         serviceCategoryImage: result['service_category_image'] ?? "",
//         serviceSectorImage: result['service_sector_image'] ?? "",
//         serviceTypeImage: result['service_type_image'] ?? "",
//         serviceLevelImage: result['service_level_image'] ?? "",
//         iaot: result['including_gerea_and_other_taxes'].toString() ?? "",
//         eaot: result['excluding_gerea_and_other_taxes'].toString() ?? "",
//         activityIncludes: gIAm,
//         dependency: gdM,
//         bp: nBp,
//         am: gAccomodationAimedfm,
//         programmes: gPm,
//         stars: result['stars'].toString() ?? "",
//         isLiked: int.tryParse(result['is_liked'].toString()) ?? 0,
//         baseURL: result['baseurl'].toString() ?? "",
//         images: gAccomodationServImgModel,
//         rating: result['rating'].toString() ?? "",
//         reviewdBy: result['reviewd_by'].toString() ?? "",
//         remainingSeats: int.tryParse(result['remaining_seats'].toString()) ?? 0,
//       );
//       //gAccomodationSModel.add(nSm);
//       setState(() {
//         service = nSm;
//         loading = false;
//       });
//     }
//   }

//   abc() {}
//   void goToPlan() {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) {
//           return const PlanForFuture();
//         },
//       ),
//     );
//   }

//   void goToBookTicket() {
//     if (Constants.userId != 0) {
//       if (sPrice != "") {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (_) {
//               return BookTicket(
//                 service!,
//                 costInc: costInc,
//                 selectedPrice: sPrice,
//               );
//             },
//           ),
//         );
//       } else {
//         Constants.showMessage(context, "pleaseChooseCost".tr());
//       }
//     } else {
//       //Constants.showMessage(context, "Please Login to make any bookings");
//       showError();
//     }
//   }

//   void navLogin() {
//     // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//     //   return const SignIn();
//     // }));
//     context.push('/signIn');
//   }

//   void navRegister() {
//     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//       return const NewRegister();
//     }));
//   }

//   void showError() {
//     showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//               contentPadding: const EdgeInsets.all(12),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               title: ListTile(
//                 tileColor: Colors.transparent,
//                 //onTap: showCamera,
//                 leading: const Icon(
//                   Icons.notification_important,
//                   size: 42,
//                   color: redColor,
//                 ),
//                 title: MyText(
//                   text: "You Are Not logged In",
//                   color: Colors.black,
//                   weight: FontWeight.w600,
//                 ),
//                 trailing: const Icon(Icons.chevron_right_rounded),
//               ),
//               actions: [
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Button(
//                         "login".tr(),
//                         //'Register',
//                         greenishColor,
//                         greenishColor,
//                         whiteColor,
//                         20,
//                         navLogin,
//                         Icons.add,
//                         whiteColor,
//                         false,
//                         2,
//                         'Raleway',
//                         FontWeight.w600,
//                         18),
//                     Container(
//                       color: transparentColor,
//                       height: 40,
//                       child: GestureDetector(
//                         onTap: () {},
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: Text.rich(
//                             TextSpan(
//                               children: [
//                                 TextSpan(
//                                     text: "dontHaveAnAccount?".tr(),
//                                     style: const TextStyle(
//                                         color: bluishColor, fontSize: 16)),
//                                 // TextSpan(
//                                 //   text: "register".tr(),
//                                 //   style: const TextStyle(
//                                 //       fontWeight: FontWeight.bold, color: whiteColor),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 40),
//                       child: Button(
//                           "register".tr(),
//                           greenishColor,
//                           greenishColor,
//                           whiteColor,
//                           20,
//                           navRegister,
//                           Icons.add,
//                           whiteColor,
//                           false,
//                           2,
//                           'Raleway',
//                           FontWeight.w600,
//                           20),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     )
//                   ],
//                 ),
//               ],
//             ));
//   }

//   void plan() {
//     if (Constants.userId != 0) {
//       if (sPrice != "") {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (_) {
//               return BookTicket(
//                 service!,
//                 show: true,
//                 costInc: costInc,
//                 selectedPrice: sPrice,
//               );
//             },
//           ),
//         );
//       } else {
//         Constants.showMessage(context, "pleaseChooseCost".tr());
//       }
//     } else {
//       //Constants.showMessage(context, "Please Login to make any bookings");
//       showError();
//     }
//   }

//   void addFav() async {
//     setState(() {
//       favourite = true;
//     });
//     try {
//       var response = await http
//           .post(Uri.parse("${Constants.baseUrl}/api/v1/add_favourite"), body: {
//         'user_id': Constants.userId.toString(), //"27",
//         'service_id': service!.serviceId.toString(),
//       });
//       if (response.statusCode == 200) {
//         cancel();
//         message("adventureHasBeenAddedToYourFavourites".tr());
//       }
//       print(response.statusCode);
//       print(response.body);
//       print(response.headers);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   void cancel() {
//     Navigator.of(context).pop();
//   }

//   void message(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//       ),
//     );
//   }

//   void launchURL() async {
//     //   https://adventuresclub.net/adventureClubSIT/provider-details/38
//     //https://Adventuresclub.net/adventureClub
//     const url = 'https://adventuresclub.net/';
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   void getPrice(bool type, String selectedPrice) {
//     if (type) {
//       costInc = true;
//     } else {
//       costInc = false;
//     }
//     setState(() {
//       sPrice = selectedPrice;
//     });
//   }

//   Future<void> shareLinkOnWhatsApp() async {
//     //https://adventuresclub.net/adventureClubSIT/adventure-details/180
//     //String link = "https://adventuresclub.net/aDetails/${widget.gm!.id}";
//     String link = "${Constants.baseUrl}/adventure-details/${widget.gm!.id}";
//     final encodedLink = Uri.encodeComponent(link);

//     // WhatsApp share URL (opens directly in the app)
//     final whatsAppUrl = "https://wa.me/?text=$encodedLink";

//     try {
//       if (await canLaunchUrl(Uri.parse(whatsAppUrl))) {
//         await launchUrl(
//           Uri.parse(whatsAppUrl),
//           mode:
//               LaunchMode.externalApplication, // Forces opening outside the app
//         );
//       } else {
//         // Fallback: Open WhatsApp Web if the app isn't installed
//         final whatsAppWebUrl =
//             "https://web.whatsapp.com/send?text=$encodedLink";
//         await launchUrl(
//           Uri.parse(whatsAppWebUrl),
//           mode: LaunchMode.externalApplication,
//         );
//       }
//     } catch (e) {
//       throw Exception("Failed to launch WhatsApp: $e");
//     }
//   }

// //final PageController _pageViewController = PageController(initialPage: 0);
//   bool _isFullScreen = false;
//   int _currentFullScreenIndex = 0;
//   double _scale = 1.0;
//   double _previousScale = 1.0;
//   double _rotation = 0.0;
//   PageController _fullScreenPageController = PageController();

//   void _openFullScreenImage(int index) {
//     setState(() {
//       _isFullScreen = true;
//       _currentFullScreenIndex = index;
//       _fullScreenPageController = PageController(initialPage: index);
//     });
//   }

//   void _closeFullScreenImage() {
//     setState(() {
//       _isFullScreen = false;
//     });
//   }

//   void _onFullScreenPageChanged(int index) {
//     setState(() {
//       _currentFullScreenIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: loading
//             ? LoadingWidget()
//             : service == null && service!.serviceId.toString().isEmpty
//                 ? Center(
//                     child: Text(
//                       "No data Found",
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                     ),
//                   )
//                 : NestedScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     headerSliverBuilder: ((context, innerBoxIsScrolled) {
//                       return [
//                         SliverAppBar(
//                           toolbarHeight: 0,
//                           expandedHeight: 300,
//                           floating: true,
//                           pinned: true,
//                           flexibleSpace: FlexibleSpaceBar(
//                             background: Stack(
//                               children: [
//                                 SizedBox(
//                                   height: 300,
//                                   child: Stack(
//                                     clipBehavior: Clip.none,
//                                     children: [
//                                       PageView.builder(
//                                         controller: _fullScreenPageController,
//                                         itemCount: service!.images.length,
//                                         onPageChanged: _onFullScreenPageChanged,
//                                         itemBuilder: (context, index) {
//                                           return InteractiveViewer(
//                                             panEnabled: true,
//                                             scaleEnabled: true,
//                                             minScale: 0.5,
//                                             maxScale: 4.0,
//                                             child: Center(
//                                               child: Image.network(
//                                                 "${"${Constants.baseUrl}/public/uploads/"}${service!.images[index].imageUrl}",
//                                                 fit: BoxFit.contain,
//                                                 width: double.infinity,
//                                                 height: double.infinity,
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                       // PageView.builder(
//                                       //   controller: _pageViewController,
//                                       //   onPageChanged: (index) {
//                                       //     setState(() {
//                                       //       _activePage = index;
//                                       //     });
//                                       //   },
//                                       //   itemCount: service!.images.length,
//                                       //   itemBuilder:
//                                       //       (BuildContext context, int index) {
//                                       //     return GestureDetector(
//                                       //       onTap: () {
//                                       //         setState(() {
//                                       //           _isFullScreen = true;
//                                       //           _currentFullScreenIndex = index;
//                                       //           _scale = 1.0;
//                                       //           _rotation = 0.0;
//                                       //         });
//                                       //       },
//                                       //       child: Container(
//                                       //         decoration: BoxDecoration(
//                                       //           image: DecorationImage(
//                                       //             colorFilter: ColorFilter.mode(
//                                       //               Colors.grey
//                                       //                   .withOpacity(0.2),
//                                       //               BlendMode.darken,
//                                       //             ),
//                                       //             image: NetworkImage(
//                                       //               "${"${Constants.baseUrl}/public/uploads/"}${service!.images[index].imageUrl}",
//                                       //             ),
//                                       //             fit: BoxFit.fill,
//                                       //           ),
//                                       //         ),
//                                       //       ),
//                                       //     );
//                                       //   },
//                                       // ),
//                                       // Your existing Positioned widgets (share, favorite, back)
//                                       Positioned(
//                                         top: 20,
//                                         right: 70,
//                                         child: GestureDetector(
//                                           onTap: shareLinkOnWhatsApp,
//                                           child: Container(
//                                             height: 40,
//                                             width: 40,
//                                             decoration: BoxDecoration(
//                                               color: redColor,
//                                               borderRadius:
//                                                   BorderRadius.circular(32),
//                                             ),
//                                             child: const Icon(Icons.share,
//                                                 size: 30, color: whiteColor),
//                                           ),
//                                         ),
//                                       ),
//                                       Positioned(
//                                         top: 20,
//                                         right: 15,
//                                         child: GestureDetector(
//                                           onTap: addFav,
//                                           child: favourite
//                                               ? Container(
//                                                   height: 40,
//                                                   width: 40,
//                                                   decoration: BoxDecoration(
//                                                     color: redColor,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             32),
//                                                   ),
//                                                   child: const Icon(
//                                                     Icons.favorite_border,
//                                                     size: 30,
//                                                     color: redColor,
//                                                   ),
//                                                 )
//                                               : Container(
//                                                   height: 40,
//                                                   width: 40,
//                                                   decoration: BoxDecoration(
//                                                     color: redColor,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             32),
//                                                   ),
//                                                   child: const Icon(
//                                                     Icons.favorite_border,
//                                                     size: 30,
//                                                     color: whiteColor,
//                                                   ),
//                                                 ),
//                                         ),
//                                       ),
//                                       Positioned(
//                                         top: 20,
//                                         left: 15,
//                                         child: GestureDetector(
//                                           onTap: cancel,
//                                           child: Container(
//                                             height: 40,
//                                             width: 40,
//                                             decoration: BoxDecoration(
//                                               color: whiteColor,
//                                               borderRadius:
//                                                   BorderRadius.circular(30),
//                                             ),
//                                             child: const Icon(
//                                               Icons.arrow_back_ios_new,
//                                               color: blackColor,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),

// // Full screen image viewer
//                                 if (_isFullScreen)
//                                   Stack(
//                                     children: [
//                                       // Background
//                                       Container(
//                                         color: Colors.black87,
//                                         width: double.infinity,
//                                         height: double.infinity,
//                                       ),

//                                       // Image with zoom and rotate
//                                       Positioned.fill(
//                                         child: InteractiveViewer(
//                                           boundaryMargin: EdgeInsets.all(20),
//                                           minScale: 0.1,
//                                           maxScale: 5.0,
//                                           child: Transform.rotate(
//                                             angle: _rotation,
//                                             child: Center(
//                                               child: Container(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     0.8,
//                                                 height: MediaQuery.of(context)
//                                                         .size
//                                                         .height *
//                                                     0.8,
//                                                 child: PageView.builder(
//                                                   itemCount:
//                                                       service!.images.length,
//                                                   controller: PageController(
//                                                       initialPage:
//                                                           _currentFullScreenIndex),
//                                                   onPageChanged: (index) {
//                                                     setState(() {
//                                                       _currentFullScreenIndex =
//                                                           index;
//                                                       _scale = 1.0;
//                                                       _rotation = 0.0;
//                                                     });
//                                                   },
//                                                   itemBuilder:
//                                                       (context, index) {
//                                                     return Image.network(
//                                                       "${"${Constants.baseUrl}/public/uploads/"}${service!.images[index].imageUrl}",
//                                                       fit: BoxFit.contain,
//                                                     );
//                                                   },
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),

//                                       // Close button
//                                       Positioned(
//                                         top: 50,
//                                         right: 20,
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             setState(() {
//                                               _isFullScreen = false;
//                                               _scale = 1.0;
//                                               _rotation = 0.0;
//                                             });
//                                           },
//                                           child: Container(
//                                             width: 50,
//                                             height: 50,
//                                             decoration: BoxDecoration(
//                                               color: Colors.black54,
//                                               shape: BoxShape.circle,
//                                             ),
//                                             child: Icon(
//                                               Icons.close,
//                                               color: Colors.white,
//                                               size: 30,
//                                             ),
//                                           ),
//                                         ),
//                                       ),

//                                       // Rotation buttons
//                                       Positioned(
//                                         bottom: 100,
//                                         left: 20,
//                                         child: Row(
//                                           children: [
//                                             // Rotate left
//                                             GestureDetector(
//                                               onTap: () {
//                                                 setState(() {
//                                                   _rotation -=
//                                                       0.5; // Rotate 90 degrees counter-clockwise
//                                                 });
//                                               },
//                                               child: Container(
//                                                 width: 50,
//                                                 height: 50,
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.black54,
//                                                   shape: BoxShape.circle,
//                                                 ),
//                                                 child: Icon(
//                                                   Icons.rotate_left,
//                                                   color: Colors.white,
//                                                   size: 30,
//                                                 ),
//                                               ),
//                                             ),
//                                             SizedBox(width: 10),
//                                             // Rotate right
//                                             GestureDetector(
//                                               onTap: () {
//                                                 setState(() {
//                                                   _rotation +=
//                                                       0.5; // Rotate 90 degrees clockwise
//                                                 });
//                                               },
//                                               child: Container(
//                                                 width: 50,
//                                                 height: 50,
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.black54,
//                                                   shape: BoxShape.circle,
//                                                 ),
//                                                 child: Icon(
//                                                   Icons.rotate_right,
//                                                   color: Colors.white,
//                                                   size: 30,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),

//                                       // Reset button
//                                       Positioned(
//                                         bottom: 40,
//                                         right: 20,
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             setState(() {
//                                               _scale = 1.0;
//                                               _rotation = 0.0;
//                                             });
//                                           },
//                                           child: Container(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 16, vertical: 8),
//                                             decoration: BoxDecoration(
//                                               color: Colors.black54,
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                             ),
//                                             child: Text(
//                                               'Reset',
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),

//                                       // Page indicator
//                                       Positioned(
//                                         bottom: 100,
//                                         right: 20,
//                                         child: Container(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 16, vertical: 8),
//                                           decoration: BoxDecoration(
//                                             color: Colors.black54,
//                                             borderRadius:
//                                                 BorderRadius.circular(20),
//                                           ),
//                                           child: Text(
//                                             '${_currentFullScreenIndex + 1}/${service!.images.length}',
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 Positioned(
//                                   bottom: 0,
//                                   left: 0,
//                                   right: 0,
//                                   height: 40,
//                                   child: SizedBox(
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: List<Widget>.generate(
//                                         service!.images.length,
//                                         (index) => Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 5),
//                                           child: InkWell(
//                                             onTap: () {
//                                               _pageViewController.animateToPage(
//                                                   index,
//                                                   duration: const Duration(
//                                                       milliseconds: 300),
//                                                   curve: Curves.easeIn);
//                                             },
//                                             child: CircleAvatar(
//                                               radius: 6.5,
//                                               backgroundColor:
//                                                   _activePage == index
//                                                       ? const Color.fromARGB(
//                                                           255, 202, 122, 2)
//                                                       : whiteColor,
//                                               child: CircleAvatar(
//                                                   radius: _activePage != index
//                                                       ? 4.5
//                                                       : 5.5,
//                                                   // check if a dot is connected to the current page
//                                                   // if true, give it a different color
//                                                   backgroundColor:
//                                                       _activePage == index
//                                                           ? Colors.orange
//                                                           : transparentColor
//                                                               .withOpacity(
//                                                                   0.1)),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ];
//                     }),
//                     body: NewDetailsTab(
//                       gm: service!,
//                       sendData: getPrice,
//                       show: widget.show,
//                     ),
//                     // children: [

//                     //   Expanded(child: NewDetailsTab(service!)),
//                     // ],
//                   ),
//         bottomNavigationBar: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: loading
//                 ? LoadingWidget()
//                 : service!.sPlan == 2
//                     ? future
//                         ? ButtonIconLess('planFuture'.tr(), greenishColor,
//                             whiteColor, 2, 17, 16, plan)
//                         : ButtonIconLess('bookNow'.tr(), greenishColor,
//                             whiteColor, 2, 17, 16, goToBookTicket)
//                     : ButtonIconLess('planFuture'.tr(), greenishColor,
//                         whiteColor, 2, 17, 16, plan)
//             // GestureDetector(
//             //     onTap: plan,
//             //     child: Container(
//             //       decoration: BoxDecoration(
//             //         borderRadius: BorderRadius.circular(26),
//             //         color: bluishColor,
//             //       ),
//             //       height: 50,
//             //       width: MediaQuery.of(context).size.width / 2,
//             //       child: Center(
//             //         child: MyText(
//             //           text: 'planFuture'.tr(),
//             //           size: 16,
//             //           weight: FontWeight.w600,
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             // Row(
//             //     mainAxisAlignment: MainAxisAlignment.spaceAround,
//             //     children: [
//             //       ButtonIconLess('Plan For Future', greenishColor, whiteColor,
//             //           1.2, 17, 12, goToBookTicket),
//             //     ],
//             //   ),
//             ),
//       ),
//     );
//   }
// }

// ignore_for_file: unused_field, prefer_final_fields, avoid_print
import 'dart:async';
import 'dart:convert';
import 'package:app/constants.dart';
import 'package:app/home_Screens/book_ticket.dart';
import 'package:app/home_Screens/plan%20_for_future.dart';
import 'package:app/models/filter_data_model/programs_model.dart';
import 'package:app/models/home_services/become_partner.dart';
import 'package:app/models/services/aimed_for_model.dart';
import 'package:app/models/services/availability_model.dart';
import 'package:app/models/services/create_services/availability_plan_model.dart';
import 'package:app/models/services/dependencies_model.dart';
import 'package:app/models/services/included_activities_model.dart';
import 'package:app/models/services/service_image_model.dart';
import 'package:app/new_signup/new_register.dart';
import 'package:app/widgets/buttons/button_icon_less.dart';
import 'package:app/widgets/loading_widget.dart';
import 'package:app/widgets/my_text.dart';
import 'package:app/widgets/tabs/details_tabs/newdetails_tab.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/home_services/services_model.dart';
import 'package:http/http.dart' as http;

import '../widgets/buttons/button.dart';

// class NewDetails extends StatefulWidget {
//   final ServicesModel? gm;
//   final bool? show;
//   final String? id;
//   const NewDetails({this.gm, this.show = true, this.id, super.key});

//   @override
//   State<NewDetails> createState() => _NewDetailsState();
// }

// class _NewDetailsState extends State<NewDetails> {
//   final PageController _pageViewController = PageController(initialPage: 0);
//   bool favourite = false;
//   int _activePage = 0;
//   int index = 0;
//   bool future = false;
//   bool costInc = false;
//   String sPrice = "";
//   int _currentPage = 0;
//   ServicesModel? service;
//   late Timer _timer;
//   bool loading = false;
//   Map mapDetails = {};
//   List<BecomePartner> nBp = [];

//   // Full screen image viewer variables
//   bool _isFullScreen = false;
//   int _currentFullScreenIndex = 0;
//   double _scale = 1.0;
//   double _previousScale = 1.0;
//   double _rotation = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.gm != null) {
//       service = widget.gm;
//       if (service!.sPlan == 2) {
//         DateTime d = service!.startDate;
//         DateTime now = DateTime.now();
//         future = service!.startDate.isAfter(DateTime.now());
//       }
//       _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
//         if (_activePage < service!.images.length - 1) {
//           _activePage++;
//         } else {
//           _activePage = 0;
//         }
//         _pageViewController.animateToPage(
//           _activePage,
//           duration: const Duration(milliseconds: 350),
//           curve: Curves.easeIn,
//         );
//       });
//     } else if (widget.id != null) {
//       getDetails(widget.id!);
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _pageViewController.dispose();
//     _timer.cancel();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (widget.gm != null) {
//       service = widget.gm;
//       if (service!.sPlan == 2) {
//         DateTime d = service!.startDate;
//         DateTime now = DateTime.now();
//         if (d.year < now.year) {
//           future = true;
//         } else if (d.month < now.month) {
//           future = true;
//         } else if (d.day <= now.day) {
//           future = true;
//         }
//       }
//     }
//   }

//   Future<void> getDetails(String serviceId) async {
//     setState(() {
//       loading = true;
//     });
//     var response = await http
//         .get(Uri.parse("${Constants.baseUrl}/api/v1/services/$serviceId"));
//     if (response.statusCode == 200) {
//       mapDetails = json.decode(response.body);
//       dynamic result = mapDetails['data'];
//       List<AvailabilityPlanModel> gAccomodationPlanModel = [];
//       List<dynamic> availablePlan = result['availability'];
//       availablePlan.forEach((ap) {
//         AvailabilityPlanModel amPlan = AvailabilityPlanModel(
//             int.tryParse(ap['id'].toString()) ?? 0, ap['day'].toString());
//         gAccomodationPlanModel.add(amPlan);
//       });
//       List<AvailabilityModel> gAccomodoationAvaiModel = [];
//       List<dynamic> available = result['availability'];
//       available.forEach((a) {
//         AvailabilityModel am = AvailabilityModel(
//             a['start_date'].toString() ?? "", a['end_date'].toString() ?? "");
//         gAccomodoationAvaiModel.add(am);
//       });
//       if (result['become_partner'] != null) {
//         List<dynamic> becomePartner = result['become_partner'];
//         becomePartner.forEach((b) {
//           BecomePartner bp = BecomePartner(
//               b['cr_name'].toString() ?? "",
//               b['cr_number'].toString() ?? "",
//               b['description'].toString() ?? "");
//         });
//       }
//       List<IncludedActivitiesModel> gIAm = [];
//       List<dynamic> iActivities = result['included_activities'];
//       iActivities.forEach((iA) {
//         IncludedActivitiesModel iAm = IncludedActivitiesModel(
//           int.tryParse(iA['id'].toString()) ?? 0,
//           int.tryParse(iA['service_id'].toString()) ?? 0,
//           iA['activity_id'].toString() ?? "",
//           iA['activity'].toString() ?? "",
//           iA['image'].toString() ?? "",
//         );
//         gIAm.add(iAm);
//       });
//       List<DependenciesModel> gdM = [];
//       List<dynamic> dependency = result['dependencies'];
//       dependency.forEach((d) {
//         DependenciesModel dm = DependenciesModel(
//           int.tryParse(d['id'].toString()) ?? 0,
//           d['dependency_name'].toString() ?? "",
//           d['image'].toString() ?? "",
//           d['updated_at'].toString() ?? "",
//           d['created_at'].toString() ?? "",
//           d['deleted_at'].toString() ?? "",
//         );
//         gdM.add(dm);
//       });
//       List<AimedForModel> gAccomodationAimedfm = [];
//       List<dynamic> aF = result['aimed_for'];
//       aF.forEach((a) {
//         AimedForModel afm = AimedForModel(
//           int.tryParse(a['id'].toString()) ?? 0,
//           a['AimedName'].toString() ?? "",
//           a['image'].toString() ?? "",
//           a['created_at'].toString() ?? "",
//           a['updated_at'].toString() ?? "",
//           a['deleted_at'].toString() ?? "",
//           int.tryParse(a['service_id'].toString()) ?? 0,
//         );
//         gAccomodationAimedfm.add(afm);
//       });
//       List<ServiceImageModel> gAccomodationServImgModel = [];
//       List<dynamic> image = result['images'];
//       image.forEach((i) {
//         ServiceImageModel sm = ServiceImageModel(
//           int.tryParse(i['id'].toString()) ?? 0,
//           int.tryParse(i['service_id'].toString()) ?? 0,
//           int.tryParse(i['is_default'].toString()) ?? 0,
//           i['image_url'].toString() ?? "",
//           i['thumbnail'].toString() ?? "",
//         );
//         gAccomodationServImgModel.add(sm);
//       });
//       List<ProgrammesModel> gPm = [];
//       List<dynamic> programs = result['programs'];
//       programs.forEach((p) {
//         ProgrammesModel pm = ProgrammesModel(
//           int.tryParse(p['id'].toString()) ?? 0,
//           int.tryParse(p['service_id'].toString()) ?? 0,
//           p['title'].toString() ?? "",
//           p['start_datetime'].toString() ?? "",
//           p['end_datetime'].toString() ?? "",
//           p['description'].toString() ?? "",
//         );
//         gPm.add(pm);
//       });
//       DateTime sDate =
//           DateTime.tryParse(result['start_date'].toString()) ?? DateTime.now();
//       DateTime eDate =
//           DateTime.tryParse(result['end_date'].toString()) ?? DateTime.now();
//       ServicesModel nSm = ServicesModel(
//         incDescription: result['inc_description'] ?? "",
//         excDescription: result['exc_description'] ?? "",
//         id: int.tryParse(result['id'].toString()) ?? 0,
//         owner: int.tryParse(result['owner'].toString()) ?? 0,
//         adventureName: result['adventure_name'].toString() ?? "",
//         country: result['country'].toString() ?? "",
//         region: result['region'].toString() ?? "",
//         cityId: result['city_id'].toString() ?? "",
//         serviceSector: result['service_sector'].toString() ?? "",
//         serviceCategory: result['service_category'].toString() ?? "",
//         serviceType: result['service_type'].toString() ?? "",
//         serviceLevel: result['service_level'].toString() ?? "",
//         duration: result['duration'].toString() ?? "",
//         aSeats: int.tryParse(result['available_seats'].toString()) ?? 0,
//         startDate: sDate,
//         endDate: eDate,
//         lat: result['latitude'].toString() ?? "",
//         lng: result['longitude'].toString() ?? "",
//         writeInformation: result['write_information'].toString() ?? "",
//         sPlan: int.tryParse(result['service_plan'].toString()) ?? 0,
//         sForID: int.tryParse(result['sfor_id'].toString()) ?? 0,
//         availability: gAccomodoationAvaiModel,
//         availabilityPlan: gAccomodationPlanModel,
//         geoLocation: result['geo_location'].toString() ?? "",
//         sAddress: result['specific_address'].toString() ?? "",
//         costInc: result['cost_inc'].toString() ?? "",
//         costExc: result['cost_exc'].toString() ?? "",
//         currency: result['currency'].toString() ?? "",
//         points: int.tryParse(result['points'].toString()) ?? 0,
//         preRequisites: result['pre_requisites'].toString() ?? "",
//         mRequirements: result['minimum_requirements'].toString() ?? "",
//         tnc: result['terms_conditions'].toString() ?? "",
//         recommended: int.tryParse(result['recommended'].toString()) ?? 0,
//         status: result['status'].toString() ?? "",
//         image: result['image'].toString() ?? "",
//         des: result['descreption]'].toString() ?? "",
//         fImage: result['favourite_image'].toString() ?? "",
//         ca: result['created_at'].toString() ?? "",
//         upda: result['updated_at'].toString() ?? "",
//         da: result['delete_at'].toString() ?? "",
//         providerId: int.tryParse(result['provider_id'].toString()) ?? 0,
//         serviceId: int.tryParse(result['service_id'].toString()) ?? 0,
//         pName: result['provided_name'].toString() ?? "",
//         pProfile: result['provider_profile'].toString() ?? "",
//         serviceCategoryImage: result['service_category_image'] ?? "",
//         serviceSectorImage: result['service_sector_image'] ?? "",
//         serviceTypeImage: result['service_type_image'] ?? "",
//         serviceLevelImage: result['service_level_image'] ?? "",
//         iaot: result['including_gerea_and_other_taxes'].toString() ?? "",
//         eaot: result['excluding_gerea_and_other_taxes'].toString() ?? "",
//         activityIncludes: gIAm,
//         dependency: gdM,
//         bp: nBp,
//         am: gAccomodationAimedfm,
//         programmes: gPm,
//         stars: result['stars'].toString() ?? "",
//         isLiked: int.tryParse(result['is_liked'].toString()) ?? 0,
//         baseURL: result['baseurl'].toString() ?? "",
//         images: gAccomodationServImgModel,
//         rating: result['rating'].toString() ?? "",
//         reviewdBy: result['reviewd_by'].toString() ?? "",
//         remainingSeats: int.tryParse(result['remaining_seats'].toString()) ?? 0,
//       );
//       setState(() {
//         service = nSm;
//         loading = false;
//       });
//     }
//   }

//   void _openFullScreenImage(int index) {
//     setState(() {
//       _isFullScreen = true;
//       _currentFullScreenIndex = index;
//       _scale = 1.0;
//       _rotation = 0.0;
//     });
//   }

//   void _closeFullScreenImage() {
//     setState(() {
//       _isFullScreen = false;
//     });
//   }

//   void _onFullScreenPageChanged(int index) {
//     setState(() {
//       _currentFullScreenIndex = index;
//     });
//   }

//   void goToPlan() {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) {
//           return const PlanForFuture();
//         },
//       ),
//     );
//   }

//   void goToBookTicket() {
//     if (Constants.userId != 0) {
//       if (sPrice != "") {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (_) {
//               return BookTicket(
//                 service!,
//                 costInc: costInc,
//                 selectedPrice: sPrice,
//               );
//             },
//           ),
//         );
//       } else {
//         Constants.showMessage(context, "pleaseChooseCost".tr());
//       }
//     } else {
//       showError();
//     }
//   }

//   void navLogin() {
//     context.push('/signIn');
//   }

//   void navRegister() {
//     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//       return const NewRegister();
//     }));
//   }

//   void showError() {
//     showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//               contentPadding: const EdgeInsets.all(12),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               title: ListTile(
//                 tileColor: Colors.transparent,
//                 leading: const Icon(
//                   Icons.notification_important,
//                   size: 42,
//                   color: redColor,
//                 ),
//                 title: MyText(
//                   text: "You Are Not logged In",
//                   color: Colors.black,
//                   weight: FontWeight.w600,
//                 ),
//                 trailing: const Icon(Icons.chevron_right_rounded),
//               ),
//               actions: [
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Button(
//                         "login".tr(),
//                         greenishColor,
//                         greenishColor,
//                         whiteColor,
//                         20,
//                         navLogin,
//                         Icons.add,
//                         whiteColor,
//                         false,
//                         2,
//                         'Raleway',
//                         FontWeight.w600,
//                         18),
//                     Container(
//                       color: transparentColor,
//                       height: 40,
//                       child: GestureDetector(
//                         onTap: () {},
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: Text.rich(
//                             TextSpan(
//                               children: [
//                                 TextSpan(
//                                     text: "dontHaveAnAccount?".tr(),
//                                     style: const TextStyle(
//                                         color: bluishColor, fontSize: 16)),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 40),
//                       child: Button(
//                           "register".tr(),
//                           greenishColor,
//                           greenishColor,
//                           whiteColor,
//                           20,
//                           navRegister,
//                           Icons.add,
//                           whiteColor,
//                           false,
//                           2,
//                           'Raleway',
//                           FontWeight.w600,
//                           20),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     )
//                   ],
//                 ),
//               ],
//             ));
//   }

//   void plan() {
//     if (Constants.userId != 0) {
//       if (sPrice != "") {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (_) {
//               return BookTicket(
//                 service!,
//                 show: true,
//                 costInc: costInc,
//                 selectedPrice: sPrice,
//               );
//             },
//           ),
//         );
//       } else {
//         Constants.showMessage(context, "pleaseChooseCost".tr());
//       }
//     } else {
//       showError();
//     }
//   }

//   void addFav() async {
//     setState(() {
//       favourite = true;
//     });
//     try {
//       var response = await http
//           .post(Uri.parse("${Constants.baseUrl}/api/v1/add_favourite"), body: {
//         'user_id': Constants.userId.toString(),
//         'service_id': service!.serviceId.toString(),
//       });
//       if (response.statusCode == 200) {
//         cancel();
//         message("adventureHasBeenAddedToYourFavourites".tr());
//       }
//       print(response.statusCode);
//       print(response.body);
//       print(response.headers);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   void cancel() {
//     Navigator.of(context).pop();
//   }

//   void message(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//       ),
//     );
//   }

//   void launchURL() async {
//     const url = 'https://adventuresclub.net/';
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   void getPrice(bool type, String selectedPrice) {
//     if (type) {
//       costInc = true;
//     } else {
//       costInc = false;
//     }
//     setState(() {
//       sPrice = selectedPrice;
//     });
//   }

//   Future<void> shareLinkOnWhatsApp() async {
//     String link = "${Constants.baseUrl}/adventure-details/${widget.gm!.id}";
//     final encodedLink = Uri.encodeComponent(link);

//     final whatsAppUrl = "https://wa.me/?text=$encodedLink";

//     try {
//       if (await canLaunchUrl(Uri.parse(whatsAppUrl))) {
//         await launchUrl(
//           Uri.parse(whatsAppUrl),
//           mode: LaunchMode.externalApplication,
//         );
//       } else {
//         final whatsAppWebUrl =
//             "https://web.whatsapp.com/send?text=$encodedLink";
//         await launchUrl(
//           Uri.parse(whatsAppWebUrl),
//           mode: LaunchMode.externalApplication,
//         );
//       }
//     } catch (e) {
//       throw Exception("Failed to launch WhatsApp: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             // Main Content
//             loading
//                 ? LoadingWidget()
//                 : service == null || service!.serviceId.toString().isEmpty
//                     ? Center(
//                         child: Text(
//                           "No data Found",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 16),
//                         ),
//                       )
//                     : NestedScrollView(
//                         physics: const BouncingScrollPhysics(),
//                         headerSliverBuilder: ((context, innerBoxIsScrolled) {
//                           return [
//                             SliverAppBar(
//                               toolbarHeight: 0,
//                               expandedHeight: 300,
//                               floating: true,
//                               pinned: true,
//                               flexibleSpace: FlexibleSpaceBar(
//                                 background: Stack(
//                                   children: [
//                                     SizedBox(
//                                       height: 300,
//                                       child: Stack(
//                                         clipBehavior: Clip.none,
//                                         children: [
//                                           // Main Image Gallery
//                                           PageView.builder(
//                                             controller: _pageViewController,
//                                             onPageChanged: (index) {
//                                               setState(() {
//                                                 _activePage = index;
//                                               });
//                                             },
//                                             itemCount: service!.images.length,
//                                             itemBuilder: (BuildContext context,
//                                                 int index) {
//                                               return GestureDetector(
//                                                 onTap: () =>
//                                                     _openFullScreenImage(index),
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                     image: DecorationImage(
//                                                       colorFilter:
//                                                           ColorFilter.mode(
//                                                         Colors.grey
//                                                             .withOpacity(0.2),
//                                                         BlendMode.darken,
//                                                       ),
//                                                       image: NetworkImage(
//                                                         "${"${Constants.baseUrl}/public/uploads/"}${service!.images[index].imageUrl}",
//                                                       ),
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                           ),

//                                           // Action Buttons
//                                           Positioned(
//                                             top: 20,
//                                             right: 70,
//                                             child: GestureDetector(
//                                               onTap: shareLinkOnWhatsApp,
//                                               child: Container(
//                                                 height: 40,
//                                                 width: 40,
//                                                 decoration: BoxDecoration(
//                                                   color: redColor,
//                                                   borderRadius:
//                                                       BorderRadius.circular(32),
//                                                 ),
//                                                 child: const Icon(Icons.share,
//                                                     size: 30,
//                                                     color: whiteColor),
//                                               ),
//                                             ),
//                                           ),
//                                           Positioned(
//                                             top: 20,
//                                             right: 15,
//                                             child: GestureDetector(
//                                               onTap: addFav,
//                                               child: Container(
//                                                 height: 40,
//                                                 width: 40,
//                                                 decoration: BoxDecoration(
//                                                   color: redColor,
//                                                   borderRadius:
//                                                       BorderRadius.circular(32),
//                                                 ),
//                                                 child: Icon(
//                                                   Icons.favorite_border,
//                                                   size: 30,
//                                                   color: favourite
//                                                       ? Colors.red
//                                                       : whiteColor,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Positioned(
//                                             top: 20,
//                                             left: 15,
//                                             child: GestureDetector(
//                                               onTap: () =>
//                                                   Navigator.of(context).pop(),
//                                               child: Container(
//                                                 height: 40,
//                                                 width: 40,
//                                                 decoration: BoxDecoration(
//                                                   color: whiteColor,
//                                                   borderRadius:
//                                                       BorderRadius.circular(30),
//                                                 ),
//                                                 child: const Icon(
//                                                   Icons.arrow_back_ios_new,
//                                                   color: blackColor,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),

//                                           // Page Indicators
//                                           Positioned(
//                                             bottom: 10,
//                                             left: 0,
//                                             right: 0,
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: List<Widget>.generate(
//                                                 service!.images.length,
//                                                 (index) => Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(horizontal: 4),
//                                                   child: Container(
//                                                     width: 8,
//                                                     height: 8,
//                                                     decoration: BoxDecoration(
//                                                       shape: BoxShape.circle,
//                                                       color: _activePage ==
//                                                               index
//                                                           ? Colors.orange
//                                                           : Colors.white
//                                                               .withOpacity(0.7),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ];
//                         }),
//                         body: NewDetailsTab(
//                           gm: service!,
//                           sendData: getPrice,
//                           show: widget.show,
//                         ),
//                       ),

//             // Full Screen Image Viewer - Overlay
//             if (_isFullScreen)
//               Container(
//                 color: Colors.black.withOpacity(0.95),
//                 width: double.infinity,
//                 height: double.infinity,
//                 child: Stack(
//                   children: [
//                     // Close button
//                     Positioned(
//                       top: 50,
//                       right: 20,
//                       child: GestureDetector(
//                         onTap: _closeFullScreenImage,
//                         child: Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             color: Colors.black54,
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Icons.close,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                       ),
//                     ),

//                     // Main image viewer
//                     Positioned.fill(
//                       child: PageView.builder(
//                         controller: PageController(
//                             initialPage: _currentFullScreenIndex),
//                         onPageChanged: _onFullScreenPageChanged,
//                         itemCount: service!.images.length,
//                         itemBuilder: (context, index) {
//                           return InteractiveViewer(
//                             panEnabled: true,
//                             scaleEnabled: true,
//                             minScale: 0.5,
//                             maxScale: 10,
//                             child: Transform.rotate(
//                               angle: _rotation,
//                               child: Center(
//                                 child: Image.network(
//                                   "${"${Constants.baseUrl}/public/uploads/"}${service!.images[index].imageUrl}",
//                                   fit: BoxFit.contain,
//                                   width: double.infinity,
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),

//                     // Control buttons at the bottom
//                     Positioned(
//                       bottom: 30,
//                       left: 0,
//                       right: 0,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           // Rotate left
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 _rotation -= 0.5;
//                               });
//                             },
//                             child: Container(
//                               width: 50,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 color: Colors.black54,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(
//                                 Icons.rotate_left,
//                                 color: Colors.white,
//                                 size: 30,
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 20),

//                           // Reset button
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 _scale = 1.0;
//                                 _rotation = 0.0;
//                               });
//                             },
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 20, vertical: 12),
//                               decoration: BoxDecoration(
//                                 color: Colors.black54,
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                               child: Text(
//                                 'Reset',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 20),

//                           // Rotate right
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 _rotation += 0.5;
//                               });
//                             },
//                             child: Container(
//                               width: 50,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 color: Colors.black54,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(
//                                 Icons.rotate_right,
//                                 color: Colors.white,
//                                 size: 30,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Page indicator
//                     Positioned(
//                       top: 60,
//                       left: 0,
//                       right: 0,
//                       child: Center(
//                         child: Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                           decoration: BoxDecoration(
//                             color: Colors.black54,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             '${_currentFullScreenIndex + 1}/${service!.images.length}',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//         bottomNavigationBar: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: loading
//               ? LoadingWidget()
//               : service!.sPlan == 2
//                   ? future
//                       ? ButtonIconLess('planFuture'.tr(), greenishColor,
//                           whiteColor, 2, 17, 16, plan)
//                       : ButtonIconLess('bookNow'.tr(), greenishColor,
//                           whiteColor, 2, 17, 16, goToBookTicket)
//                   : ButtonIconLess('planFuture'.tr(), greenishColor, whiteColor,
//                       2, 17, 16, plan),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: unused_field, prefer_final_fields, avoid_print
import 'dart:async';
import 'dart:convert';
import 'package:app/constants.dart';
import 'package:app/home_Screens/book_ticket.dart';
import 'package:app/home_Screens/plan%20_for_future.dart';
import 'package:app/models/filter_data_model/programs_model.dart';
import 'package:app/models/home_services/become_partner.dart';
// import 'package:app/models/home_services/aimed_for_model.dart';
// import 'package:app/models/home_services/availability_model.dart';
// import 'package:app/models/home_services/create_services/availability_plan_model.dart';
// import 'package:app/models/home_services/dependencies_model.dart';
// import 'package:app/models/home_services/included_activities_model.dart';
// import 'package:app/models/home_services/service_image_model.dart';
import 'package:app/new_signup/new_register.dart';
import 'package:app/widgets/buttons/button_icon_less.dart';
import 'package:app/widgets/loading_widget.dart';
import 'package:app/widgets/my_text.dart';
import 'package:app/widgets/tabs/details_tabs/newdetails_tab.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/home_services/services_model.dart';
import 'package:http/http.dart' as http;

import '../widgets/buttons/button.dart';

class ImageTransformState {
  double scale = 1.0;
  double previousScale = 1.0;
  double rotation = 0.0;
  Offset offset = Offset.zero;
  Offset previousOffset = Offset.zero;

  void reset() {
    scale = 1.0;
    previousScale = 1.0;
    rotation = 0.0;
    offset = Offset.zero;
    previousOffset = Offset.zero;
  }
}

class NewDetails extends StatefulWidget {
  final ServicesModel? gm;
  final bool? show;
  final String? id;
  const NewDetails({this.gm, this.show = true, this.id, super.key});

  @override
  State<NewDetails> createState() => _NewDetailsState();
}

class _NewDetailsState extends State<NewDetails> {
  final PageController _pageViewController = PageController(initialPage: 0);
  bool favourite = false;
  int _activePage = 0;
  int index = 0;
  bool future = false;
  bool costInc = false;
  String sPrice = "";
  int _currentPage = 0;
  ServicesModel? service;
  late Timer _timer;
  bool loading = false;
  Map mapDetails = {};
  List<BecomePartner> nBp = [];
  Map<int, ImageTransformState> _imageTransforms = {};
  // Full screen image viewer variables
  bool _isFullScreen = false;
  int _currentFullScreenIndex = 0;
  double _scale = 1.0;
  double _previousScale = 1.0;
  double _rotation = 0.0;
  PageController _fullScreenPageController = PageController();

  @override
  void initState() {
    super.initState();
    if (widget.gm != null) {
      service = widget.gm;
      if (service!.sPlan == 2) {
        DateTime d = service!.startDate;
        DateTime now = DateTime.now();
        future = service!.startDate.isAfter(DateTime.now());
      }
      _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
        if (_activePage < service!.images.length - 1) {
          _activePage++;
        } else {
          _activePage = 0;
        }
        _pageViewController.animateToPage(
          _activePage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      });
    } else if (widget.id != null) {
      getDetails(widget.id!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _fullScreenPageController.dispose();
    _timer.cancel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.gm != null) {
      service = widget.gm;
      if (service!.sPlan == 2) {
        DateTime d = service!.startDate;
        DateTime now = DateTime.now();
        if (d.year < now.year) {
          future = true;
        } else if (d.month < now.month) {
          future = true;
        } else if (d.day <= now.day) {
          future = true;
        }
      }
    }
  }

  Future<void> getDetails(String serviceId) async {
    setState(() {
      loading = true;
    });
    var response = await http
        .get(Uri.parse("${Constants.baseUrl}/api/v1/services/$serviceId"));
    if (response.statusCode == 200) {
      mapDetails = json.decode(response.body);
      dynamic result = mapDetails['data'];
      List<AvailabilityPlanModel> gAccomodationPlanModel = [];
      List<dynamic> availablePlan = result['availability'];
      availablePlan.forEach((ap) {
        AvailabilityPlanModel amPlan = AvailabilityPlanModel(
            int.tryParse(ap['id'].toString()) ?? 0, ap['day'].toString());
        gAccomodationPlanModel.add(amPlan);
      });
      List<AvailabilityModel> gAccomodoationAvaiModel = [];
      List<dynamic> available = result['availability'];
      available.forEach((a) {
        AvailabilityModel am = AvailabilityModel(
            a['start_date'].toString() ?? "", a['end_date'].toString() ?? "");
        gAccomodoationAvaiModel.add(am);
      });
      if (result['become_partner'] != null) {
        List<dynamic> becomePartner = result['become_partner'];
        becomePartner.forEach((b) {
          BecomePartner bp = BecomePartner(
              b['cr_name'].toString() ?? "",
              b['cr_number'].toString() ?? "",
              b['description'].toString() ?? "");
        });
      }
      List<IncludedActivitiesModel> gIAm = [];
      List<dynamic> iActivities = result['included_activities'];
      iActivities.forEach((iA) {
        IncludedActivitiesModel iAm = IncludedActivitiesModel(
          int.tryParse(iA['id'].toString()) ?? 0,
          int.tryParse(iA['service_id'].toString()) ?? 0,
          iA['activity_id'].toString() ?? "",
          iA['activity'].toString() ?? "",
          iA['image'].toString() ?? "",
        );
        gIAm.add(iAm);
      });
      List<DependenciesModel> gdM = [];
      List<dynamic> dependency = result['dependencies'];
      dependency.forEach((d) {
        DependenciesModel dm = DependenciesModel(
          int.tryParse(d['id'].toString()) ?? 0,
          d['dependency_name'].toString() ?? "",
          d['image'].toString() ?? "",
          d['updated_at'].toString() ?? "",
          d['created_at'].toString() ?? "",
          d['deleted_at'].toString() ?? "",
        );
        gdM.add(dm);
      });
      List<AimedForModel> gAccomodationAimedfm = [];
      List<dynamic> aF = result['aimed_for'];
      aF.forEach((a) {
        AimedForModel afm = AimedForModel(
          int.tryParse(a['id'].toString()) ?? 0,
          a['AimedName'].toString() ?? "",
          a['image'].toString() ?? "",
          a['created_at'].toString() ?? "",
          a['updated_at'].toString() ?? "",
          a['deleted_at'].toString() ?? "",
          int.tryParse(a['service_id'].toString()) ?? 0,
        );
        gAccomodationAimedfm.add(afm);
      });
      List<ServiceImageModel> gAccomodationServImgModel = [];
      List<dynamic> image = result['images'];
      image.forEach((i) {
        ServiceImageModel sm = ServiceImageModel(
          int.tryParse(i['id'].toString()) ?? 0,
          int.tryParse(i['service_id'].toString()) ?? 0,
          int.tryParse(i['is_default'].toString()) ?? 0,
          i['image_url'].toString() ?? "",
          i['thumbnail'].toString() ?? "",
        );
        gAccomodationServImgModel.add(sm);
      });
      List<ProgrammesModel> gPm = [];
      List<dynamic> programs = result['programs'];
      programs.forEach((p) {
        ProgrammesModel pm = ProgrammesModel(
          int.tryParse(p['id'].toString()) ?? 0,
          int.tryParse(p['service_id'].toString()) ?? 0,
          p['title'].toString() ?? "",
          p['start_datetime'].toString() ?? "",
          p['end_datetime'].toString() ?? "",
          p['description'].toString() ?? "",
        );
        gPm.add(pm);
      });
      DateTime sDate =
          DateTime.tryParse(result['start_date'].toString()) ?? DateTime.now();
      DateTime eDate =
          DateTime.tryParse(result['end_date'].toString()) ?? DateTime.now();
      ServicesModel nSm = ServicesModel(
        incDescription: result['inc_description'] ?? "",
        excDescription: result['exc_description'] ?? "",
        id: int.tryParse(result['id'].toString()) ?? 0,
        owner: int.tryParse(result['owner'].toString()) ?? 0,
        adventureName: result['adventure_name'].toString() ?? "",
        country: result['country'].toString() ?? "",
        region: result['region'].toString() ?? "",
        cityId: result['city_id'].toString() ?? "",
        serviceSector: result['service_sector'].toString() ?? "",
        serviceCategory: result['service_category'].toString() ?? "",
        serviceType: result['service_type'].toString() ?? "",
        serviceLevel: result['service_level'].toString() ?? "",
        duration: result['duration'].toString() ?? "",
        aSeats: int.tryParse(result['available_seats'].toString()) ?? 0,
        startDate: sDate,
        endDate: eDate,
        lat: result['latitude'].toString() ?? "",
        lng: result['longitude'].toString() ?? "",
        writeInformation: result['write_information'].toString() ?? "",
        sPlan: int.tryParse(result['service_plan'].toString()) ?? 0,
        sForID: int.tryParse(result['sfor_id'].toString()) ?? 0,
        availability: gAccomodoationAvaiModel,
        availabilityPlan: gAccomodationPlanModel,
        geoLocation: result['geo_location'].toString() ?? "",
        sAddress: result['specific_address'].toString() ?? "",
        costInc: result['cost_inc'].toString() ?? "",
        costExc: result['cost_exc'].toString() ?? "",
        currency: result['currency'].toString() ?? "",
        points: int.tryParse(result['points'].toString()) ?? 0,
        preRequisites: result['pre_requisites'].toString() ?? "",
        mRequirements: result['minimum_requirements'].toString() ?? "",
        tnc: result['terms_conditions'].toString() ?? "",
        recommended: int.tryParse(result['recommended'].toString()) ?? 0,
        status: result['status'].toString() ?? "",
        image: result['image'].toString() ?? "",
        des: result['descreption]'].toString() ?? "",
        fImage: result['favourite_image'].toString() ?? "",
        ca: result['created_at'].toString() ?? "",
        upda: result['updated_at'].toString() ?? "",
        da: result['delete_at'].toString() ?? "",
        providerId: int.tryParse(result['provider_id'].toString()) ?? 0,
        serviceId: int.tryParse(result['service_id'].toString()) ?? 0,
        pName: result['provided_name'].toString() ?? "",
        pProfile: result['provider_profile'].toString() ?? "",
        serviceCategoryImage: result['service_category_image'] ?? "",
        serviceSectorImage: result['service_sector_image'] ?? "",
        serviceTypeImage: result['service_type_image'] ?? "",
        serviceLevelImage: result['service_level_image'] ?? "",
        iaot: result['including_gerea_and_other_taxes'].toString() ?? "",
        eaot: result['excluding_gerea_and_other_taxes'].toString() ?? "",
        activityIncludes: gIAm,
        dependency: gdM,
        bp: nBp,
        am: gAccomodationAimedfm,
        programmes: gPm,
        stars: result['stars'].toString() ?? "",
        isLiked: int.tryParse(result['is_liked'].toString()) ?? 0,
        baseURL: result['baseurl'].toString() ?? "",
        images: gAccomodationServImgModel,
        rating: result['rating'].toString() ?? "",
        reviewdBy: result['reviewd_by'].toString() ?? "",
        remainingSeats: int.tryParse(result['remaining_seats'].toString()) ?? 0,
      );
      setState(() {
        service = nSm;
        loading = false;
      });
    }
  }

  // void _openFullScreenImage(int index) {
  //   setState(() {
  //     _isFullScreen = true;
  //     _currentFullScreenIndex = index;
  //     _scale = 1.0;
  //     _rotation = 0.0;
  //     _fullScreenPageController = PageController(initialPage: index);
  //   });
  // }

  void _closeFullScreenImage() {
    setState(() {
      _isFullScreen = false;
    });
  }

  void _onFullScreenPageChanged(int index) {
    setState(() {
      _currentFullScreenIndex = index;
    });
  }

  void goToPlan() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const PlanForFuture();
        },
      ),
    );
  }

  void goToBookTicket() {
    if (Constants.userId != 0) {
      if (sPrice != "") {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return BookTicket(
                service!,
                costInc: costInc,
                selectedPrice: sPrice,
              );
            },
          ),
        );
      } else {
        Constants.showMessage(context, "pleaseChooseCost".tr());
      }
    } else {
      showError();
    }
  }

  void navLogin() {
    context.push('/signIn');
  }

  void navRegister() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const NewRegister();
    }));
  }

  void showError() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: ListTile(
                tileColor: Colors.transparent,
                leading: const Icon(
                  Icons.notification_important,
                  size: 42,
                  color: redColor,
                ),
                title: MyText(
                  text: "You Are Not logged In",
                  color: Colors.black,
                  weight: FontWeight.w600,
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
              actions: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Button(
                        "login".tr(),
                        greenishColor,
                        greenishColor,
                        whiteColor,
                        20,
                        navLogin,
                        Icons.add,
                        whiteColor,
                        false,
                        2,
                        'Raleway',
                        FontWeight.w600,
                        18),
                    Container(
                      color: transparentColor,
                      height: 40,
                      child: GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.center,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: "dontHaveAnAccount?".tr(),
                                    style: const TextStyle(
                                        color: bluishColor, fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Button(
                          "register".tr(),
                          greenishColor,
                          greenishColor,
                          whiteColor,
                          20,
                          navRegister,
                          Icons.add,
                          whiteColor,
                          false,
                          2,
                          'Raleway',
                          FontWeight.w600,
                          20),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ],
            ));
  }

  void plan() {
    if (Constants.userId != 0) {
      if (sPrice != "") {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return BookTicket(
                service!,
                show: true,
                costInc: costInc,
                selectedPrice: sPrice,
              );
            },
          ),
        );
      } else {
        Constants.showMessage(context, "pleaseChooseCost".tr());
      }
    } else {
      showError();
    }
  }

  void addFav() async {
    setState(() {
      favourite = true;
    });
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/add_favourite"), body: {
        'user_id': Constants.userId.toString(),
        'service_id': service!.serviceId.toString(),
      });
      if (response.statusCode == 200) {
        cancel();
        message("adventureHasBeenAddedToYourFavourites".tr());
      }
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void launchURL() async {
    const url = 'https://adventuresclub.net/';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  void getPrice(bool type, String selectedPrice) {
    if (type) {
      costInc = true;
    } else {
      costInc = false;
    }
    setState(() {
      sPrice = selectedPrice;
    });
  }

  Future<void> shareLinkOnWhatsApp() async {
    String link = "${Constants.baseUrl}/adventure-details/${widget.gm!.id}";
    final encodedLink = Uri.encodeComponent(link);

    final whatsAppUrl = "https://wa.me/?text=$encodedLink";

    try {
      if (await canLaunchUrl(Uri.parse(whatsAppUrl))) {
        await launchUrl(
          Uri.parse(whatsAppUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        final whatsAppWebUrl =
            "https://web.whatsapp.com/send?text=$encodedLink";
        await launchUrl(
          Uri.parse(whatsAppWebUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      throw Exception("Failed to launch WhatsApp: $e");
    }
  }

//   double _scale = 1.0;
// double _previousScale = 1.0;
// double _rotation = 0.0;
  Offset _offset = Offset.zero;
  Offset _previousOffset = Offset.zero;

  // Widget _buildCustomZoomableImage(int index) {
  //   return GestureDetector(
  //     onScaleUpdate: (ScaleUpdateDetails details) {
  //       setState(() {
  //         _scale = (_previousScale * details.scale).clamp(0.1, 10.0);

  //         // Calculate panning
  //         if (details.pointerCount == 1) {
  //           _offset = Offset(
  //             _previousOffset.dx + details.focalPointDelta.dx,
  //             _previousOffset.dy + details.focalPointDelta.dy,
  //           );
  //         }
  //       });
  //     },
  //     onScaleStart: (ScaleStartDetails details) {
  //       _previousScale = _scale;
  //       _previousOffset = _offset;
  //     },
  //     onScaleEnd: (ScaleEndDetails details) {
  //       _previousScale = _scale;
  //       _previousOffset = _offset;
  //     },
  //     onDoubleTap: () {
  //       setState(() {
  //         if (_scale > 1.5) {
  //           _resetImageTransform();
  //         } else {
  //           _scale = 3.0;
  //         }
  //       });
  //     },
  //     child: Transform(
  //       transform: Matrix4.identity()
  //         ..translate(_offset.dx, _offset.dy)
  //         ..scale(_scale)
  //         ..rotateZ(_rotation),
  //       child: Center(
  //         child: Container(
  //           // Make the container much larger than screen
  //           width: MediaQuery.of(context).size.width * 3, // 3x screen width
  //           height: MediaQuery.of(context).size.height * 3, // 3x screen height
  //           child: Image.network(
  //             "${"${Constants.baseUrl}/public/uploads/"}${service!.images[index].imageUrl}",
  //             fit: BoxFit.contain,
  //             loadingBuilder: (context, child, loadingProgress) {
  //               if (loadingProgress == null) return child;
  //               return Center(
  //                 child: CircularProgressIndicator(),
  //               );
  //             },
  //             errorBuilder: (context, error, stackTrace) {
  //               return Center(
  //                 child: Icon(Icons.error, color: Colors.white, size: 50),
  //               );
  //             },
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildCustomZoomableImage(int index) {
    return GestureDetector(
      onScaleUpdate: (ScaleUpdateDetails details) {
        setState(() {
          _scale = (_previousScale * details.scale)
              .clamp(0.05, 20.0); // Even wider range

          if (details.pointerCount == 1) {
            _offset = Offset(
              _previousOffset.dx + details.focalPointDelta.dx,
              _previousOffset.dy + details.focalPointDelta.dy,
            );
          }
        });
      },
      onScaleStart: (ScaleStartDetails details) {
        _previousScale = _scale;
        _previousOffset = _offset;
      },
      onScaleEnd: (ScaleEndDetails details) {
        _previousScale = _scale;
        _previousOffset = _offset;
      },
      onDoubleTap: () {
        setState(() {
          _scale = _scale > 2.0 ? 1.0 : 5.0;
        });
      },
      child: Transform(
        transform: Matrix4.identity()
          ..translate(_offset.dx, _offset.dy)
          ..scale(_scale)
          ..rotateZ(_rotation),
        child: Image.network(
          "${"${Constants.baseUrl}/public/uploads/"}${service!.images[index].imageUrl}",
          width: double.infinity, // No constraints
          height: double.infinity, // No constraints
          fit: BoxFit.none, // Show original size without any fitting
          alignment: Alignment.center,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return Center(
                child: Icon(Icons.error, color: Colors.white, size: 50));
          },
        ),
      ),
    );
  }

  void _resetImageTransform() {
    setState(() {
      _scale = 1.0;
      _rotation = 0.0;
      _offset = Offset.zero;
      _previousScale = 1.0;
      _previousOffset = Offset.zero;
    });
  }

// Also reset transform when opening new image
  void _openFullScreenImage(int index) {
    setState(() {
      _isFullScreen = true;
      _currentFullScreenIndex = index;
      _scale = 1.0;
      _rotation = 0.0;
      _offset = Offset.zero;
      _previousScale = 1.0;
      _previousOffset = Offset.zero;
      _fullScreenPageController = PageController(initialPage: index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Main Content
            loading
                ? LoadingWidget()
                : service == null || service!.serviceId.toString().isEmpty
                    ? Center(
                        child: Text(
                          "No data Found",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      )
                    : NestedScrollView(
                        physics: const BouncingScrollPhysics(),
                        headerSliverBuilder: ((context, innerBoxIsScrolled) {
                          return [
                            SliverAppBar(
                              toolbarHeight: 0,
                              expandedHeight: 300,
                              floating: true,
                              pinned: true,
                              flexibleSpace: FlexibleSpaceBar(
                                background: Stack(
                                  children: [
                                    SizedBox(
                                      height: 300,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          // Main Image Gallery
                                          PageView.builder(
                                            controller: _pageViewController,
                                            onPageChanged: (index) {
                                              setState(() {
                                                _activePage = index;
                                              });
                                            },
                                            itemCount: service!.images.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return GestureDetector(
                                                onTap: () =>
                                                    _openFullScreenImage(index),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                        Colors.grey
                                                            .withOpacity(0.2),
                                                        BlendMode.darken,
                                                      ),
                                                      image: NetworkImage(
                                                        "${"${Constants.baseUrl}/public/uploads/"}${service!.images[index].imageUrl}",
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),

                                          // Action Buttons
                                          Positioned(
                                            top: 20,
                                            right: 70,
                                            child: GestureDetector(
                                              onTap: shareLinkOnWhatsApp,
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  color: redColor,
                                                  borderRadius:
                                                      BorderRadius.circular(32),
                                                ),
                                                child: const Icon(Icons.share,
                                                    size: 30,
                                                    color: whiteColor),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 20,
                                            right: 15,
                                            child: GestureDetector(
                                              onTap: addFav,
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  color: redColor,
                                                  borderRadius:
                                                      BorderRadius.circular(32),
                                                ),
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  size: 30,
                                                  color: favourite
                                                      ? Colors.red
                                                      : whiteColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 20,
                                            left: 15,
                                            child: GestureDetector(
                                              onTap: () =>
                                                  Navigator.of(context).pop(),
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  color: whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: const Icon(
                                                  Icons.arrow_back_ios_new,
                                                  color: blackColor,
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Page Indicators
                                          Positioned(
                                            bottom: 10,
                                            left: 0,
                                            right: 0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: List<Widget>.generate(
                                                service!.images.length,
                                                (index) => Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: Container(
                                                    width: 8,
                                                    height: 8,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: _activePage ==
                                                              index
                                                          ? Colors.orange
                                                          : Colors.white
                                                              .withOpacity(0.7),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ];
                        }),
                        body: NewDetailsTab(
                          gm: service!,
                          sendData: getPrice,
                          show: widget.show,
                        ),
                      ),

            // Full Screen Image Viewer - Overlay
            if (_isFullScreen)
              // Add these variables to your class

// Full Screen Image Viewer with custom zoom for larger images
              // if (_isFullScreen)
              //   Material(
              //     color: Colors.black,
              //     child: Stack(
              //       children: [
              //         // Custom zoom implementation for truly large images
              //         Positioned.fill(
              //           child: PageView.builder(
              //             controller: _fullScreenPageController,
              //             onPageChanged: _onFullScreenPageChanged,
              //             itemCount: service!.images.length,
              //             itemBuilder: (context, index) {
              //               return _buildCustomZoomableImage(index);
              //             },
              //           ),
              //         ),

              //         // Close button
              //         Positioned(
              //           top: MediaQuery.of(context).padding.top + 20,
              //           right: 20,
              //           child: GestureDetector(
              //             onTap: _closeFullScreenImage,
              //             child: Container(
              //               width: 50,
              //               height: 50,
              //               decoration: BoxDecoration(
              //                 color: Colors.black54,
              //                 shape: BoxShape.circle,
              //               ),
              //               child: Icon(
              //                 Icons.close,
              //                 color: Colors.white,
              //                 size: 30,
              //               ),
              //             ),
              //           ),
              //         ),

              //         // Control buttons
              //         Positioned(
              //           bottom: MediaQuery.of(context).padding.bottom + 30,
              //           left: 0,
              //           right: 0,
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               // Rotate left
              //               GestureDetector(
              //                 onTap: () {
              //                   setState(() {
              //                     _rotation -= 0.5;
              //                   });
              //                 },
              //                 child: Container(
              //                   width: 50,
              //                   height: 50,
              //                   decoration: BoxDecoration(
              //                     color: Colors.black54,
              //                     shape: BoxShape.circle,
              //                   ),
              //                   child: Icon(
              //                     Icons.rotate_left,
              //                     color: Colors.white,
              //                     size: 30,
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(width: 20),

              //               // Reset button
              //               GestureDetector(
              //                 onTap: _resetImageTransform,
              //                 child: Container(
              //                   padding: EdgeInsets.symmetric(
              //                       horizontal: 20, vertical: 12),
              //                   decoration: BoxDecoration(
              //                     color: Colors.black54,
              //                     borderRadius: BorderRadius.circular(25),
              //                   ),
              //                   child: Text(
              //                     'Reset',
              //                     style: TextStyle(
              //                       color: Colors.white,
              //                       fontSize: 16,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(width: 20),

              //               // Rotate right
              //               GestureDetector(
              //                 onTap: () {
              //                   setState(() {
              //                     _rotation += 0.5;
              //                   });
              //                 },
              //                 child: Container(
              //                   width: 50,
              //                   height: 50,
              //                   decoration: BoxDecoration(
              //                     color: Colors.black54,
              //                     shape: BoxShape.circle,
              //                   ),
              //                   child: Icon(
              //                     Icons.rotate_right,
              //                     color: Colors.white,
              //                     size: 30,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),

              //         // Page indicator
              //         Positioned(
              //           top: MediaQuery.of(context).padding.top + 70,
              //           left: 0,
              //           right: 0,
              //           child: Center(
              //             child: Container(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: 16, vertical: 8),
              //               decoration: BoxDecoration(
              //                 color: Colors.black54,
              //                 borderRadius: BorderRadius.circular(20),
              //               ),
              //               child: Text(
              //                 '${_currentFullScreenIndex + 1}/${service!.images.length}',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              if (_isFullScreen)
                Scaffold(
                  backgroundColor: Colors.black,
                  body: Stack(
                    children: [
                      // Simple full screen image viewer
                      PageView.builder(
                        controller: _fullScreenPageController,
                        onPageChanged: _onFullScreenPageChanged,
                        itemCount: service!.images.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap:
                                _closeFullScreenImage, // Tap anywhere to close
                            child: Center(
                              child: Image.network(
                                "${"${Constants.baseUrl}/public/uploads/"}${service!.images[index].imageUrl}",
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          );
                        },
                      ),

                      // Close button
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 20,
                        right: 20,
                        child: GestureDetector(
                          onTap: _closeFullScreenImage,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),

                      // Page indicator
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 70,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${_currentFullScreenIndex + 1}/${service!.images.length}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            // Material(
            //   color: Colors.black,
            //   child: Stack(
            //     children: [
            //       // Main image viewer - FULL SCREEN
            //       Positioned.fill(
            //         child: PageView.builder(
            //           controller: _fullScreenPageController,
            //           onPageChanged: _onFullScreenPageChanged,
            //           itemCount: service!.images.length,
            //           itemBuilder: (context, index) {
            //             return InteractiveViewer(
            //               panEnabled: true,
            //               scaleEnabled: true,
            //               minScale: 0.1,
            //               maxScale: 20,
            //               child: Transform.rotate(
            //                 angle: _rotation,
            //                 child: Center(
            //                   child: Image.network(
            //                     "${"${Constants.baseUrl}/public/uploads/"}${service!.images[index].imageUrl}",
            //                     fit: BoxFit.contain,
            //                     width: double.infinity,
            //                     height: double.infinity,
            //                   ),
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            //       ),

            //       // Close button - FIXED: Now properly positioned and working
            //       Positioned(
            //         top: MediaQuery.of(context).padding.top + 20,
            //         right: 20,
            //         child: GestureDetector(
            //           onTap: _closeFullScreenImage,
            //           child: Container(
            //             width: 50,
            //             height: 50,
            //             decoration: BoxDecoration(
            //               color: Colors.black54,
            //               shape: BoxShape.circle,
            //             ),
            //             child: Icon(
            //               Icons.close,
            //               color: Colors.white,
            //               size: 30,
            //             ),
            //           ),
            //         ),
            //       ),

            //       // Control buttons at the bottom
            //       Positioned(
            //         bottom: MediaQuery.of(context).padding.bottom + 30,
            //         left: 0,
            //         right: 0,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             // Rotate left
            //             GestureDetector(
            //               onTap: () {
            //                 setState(() {
            //                   _rotation -= 0.5;
            //                 });
            //               },
            //               child: Container(
            //                 width: 50,
            //                 height: 50,
            //                 decoration: BoxDecoration(
            //                   color: Colors.black54,
            //                   shape: BoxShape.circle,
            //                 ),
            //                 child: Icon(
            //                   Icons.rotate_left,
            //                   color: Colors.white,
            //                   size: 30,
            //                 ),
            //               ),
            //             ),
            //             SizedBox(width: 20),

            //             // Reset button
            //             GestureDetector(
            //               onTap: () {
            //                 setState(() {
            //                   _scale = 1.0;
            //                   _rotation = 0.0;
            //                 });
            //               },
            //               child: Container(
            //                 padding: EdgeInsets.symmetric(
            //                     horizontal: 20, vertical: 12),
            //                 decoration: BoxDecoration(
            //                   color: Colors.black54,
            //                   borderRadius: BorderRadius.circular(25),
            //                 ),
            //                 child: Text(
            //                   'Reset',
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             SizedBox(width: 20),

            //             // Rotate right
            //             GestureDetector(
            //               onTap: () {
            //                 setState(() {
            //                   _rotation += 0.5;
            //                 });
            //               },
            //               child: Container(
            //                 width: 50,
            //                 height: 50,
            //                 decoration: BoxDecoration(
            //                   color: Colors.black54,
            //                   shape: BoxShape.circle,
            //                 ),
            //                 child: Icon(
            //                   Icons.rotate_right,
            //                   color: Colors.white,
            //                   size: 30,
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),

            //       // Page indicator
            //       Positioned(
            //         top: MediaQuery.of(context).padding.top + 70,
            //         left: 0,
            //         right: 0,
            //         child: Center(
            //           child: Container(
            //             padding:
            //                 EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //             decoration: BoxDecoration(
            //               color: Colors.black54,
            //               borderRadius: BorderRadius.circular(20),
            //             ),
            //             child: Text(
            //               '${_currentFullScreenIndex + 1}/${service!.images.length}',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: loading
              ? LoadingWidget()
              : service!.sPlan == 2
                  ? future
                      ? ButtonIconLess('planFuture'.tr(), greenishColor,
                          whiteColor, 2, 17, 16, plan)
                      : ButtonIconLess('bookNow'.tr(), greenishColor,
                          whiteColor, 2, 17, 16, goToBookTicket)
                  : ButtonIconLess('planFuture'.tr(), greenishColor, whiteColor,
                      2, 17, 16, plan),
        ),
      ),
    );
  }
}
