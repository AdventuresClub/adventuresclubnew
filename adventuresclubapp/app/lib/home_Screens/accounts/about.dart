// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:developer';

import 'package:app/app_theme.dart';
import 'package:app/constants.dart';
import 'package:app/models/filter_data_model/programs_model.dart';
import 'package:app/models/home_services/become_partner.dart';
import 'package:app/models/home_services/services_model.dart';
import 'package:app/models/profile_models/profile_become_partner.dart';
import 'package:app/models/services/aimed_for_model.dart';
import 'package:app/models/services/availability_model.dart';
import 'package:app/models/services/dependencies_model.dart';
import 'package:app/models/services/included_activities_model.dart';
import 'package:app/models/services/service_image_model.dart';
import 'package:app/models/user_profile_model.dart';
import 'package:app/widgets/grid/provided_adventure_grid.dart';
import 'package:app/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../models/services/create_services/availability_plan_model.dart';
import '../../widgets/Lists/Chat_list.dart/show_chat.dart';

class About extends StatefulWidget {
  final String? id;
  final int? sId;
  const About({this.id, this.sId, super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  ProfileBecomePartner pbp = ProfileBecomePartner(0, 0, "", "", "", "", "", "",
      "", "", 0, 0, "", "", "", "", "", "", "", 0, "", "", "", "", "", "");
  UserProfileModel profile = UserProfileModel(
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      "",
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      "",
      "",
      "",
      "",
      ProfileBecomePartner(0, 0, "", "", "", "", "", "", "", "", 0, 0, "", "",
          "", "", "", "", "", 0, "", "", "", "", "", ""));
  bool loading = false;
  bool pLoading = false;
  Map mapCountry = {};
  List<BecomePartner> nBp = [];
  List<ServicesModel> allServices = [];

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void getProfile() async {
    getProviderServices();
    setState(() {
      loading = true;
    });
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/get_profile"), body: {
        'user_id': widget.id, //"hamza@gmail.com",
      });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      dynamic userData = decodedResponse['data'];
      int userLoginId = int.tryParse(userData['id'].toString()) ?? 0;
      int countryId = int.tryParse(userData['country_id'].toString()) ?? 0;
      int languageId = int.tryParse(userData['language_id'].toString()) ?? 0;
      int currencyId = int.tryParse(userData['currency_id'].toString()) ?? 0;
      int addedFrom = int.tryParse(userData['added_from'].toString()) ?? 0;
      dynamic partnerInfo = decodedResponse['data']["become_partner"];
      if (partnerInfo != null) {
        int id = int.tryParse(partnerInfo['id'].toString()) ?? 0;
        int userId = int.tryParse(partnerInfo['user_id'].toString()) ?? 0;
        int debitCard = int.tryParse(partnerInfo['debit_card'].toString()) ?? 0;
        int visaCard = int.tryParse(partnerInfo['visa_card'].toString()) ?? 0;
        int packagesId =
            int.tryParse(partnerInfo['packages_id'].toString()) ?? 0;
        ProfileBecomePartner bp = ProfileBecomePartner(
          id,
          userId,
          partnerInfo['company_name'] ?? "",
          partnerInfo['address'] ?? "",
          partnerInfo['location'] ?? "",
          partnerInfo['description'] ?? "",
          partnerInfo['license'] ?? "",
          partnerInfo['cr_name'] ?? "",
          partnerInfo['cr_number'] ?? "",
          partnerInfo['cr_copy'] ?? "",
          debitCard,
          visaCard,
          partnerInfo['payon_arrival'] ?? "",
          partnerInfo['paypal'] ?? "",
          partnerInfo['bankname'] ?? "",
          partnerInfo['account_holdername'] ?? "",
          partnerInfo['account_number'] ?? "",
          partnerInfo['is_online'] ?? "",
          partnerInfo['is_approved'] ?? "",
          packagesId,
          partnerInfo['start_date'] ?? "",
          partnerInfo['end_date'] ?? "",
          partnerInfo['is_wiretransfer'] ?? "",
          partnerInfo['is_free_used'] ?? "",
          partnerInfo['created_at'] ?? "",
          partnerInfo['updated_at'] ?? "",
        );
        pbp = bp;
      }
      UserProfileModel up = UserProfileModel(
          userLoginId,
          userData['users_role'] ?? "",
          userData['profile_image'] ?? "",
          userData['name'] ?? "",
          userData['height'] ?? "",
          userData['weight'] ?? "",
          userData['email'] ?? "",
          countryId,
          userData['region_id'] ?? "",
          userData['city_id'] ?? "",
          userData['now_in'] ?? "",
          userData['mobile'] ?? "",
          userData['mobile_verified_at'] ?? "",
          userData['dob'] ?? "",
          userData['gender'] ?? "",
          languageId,
          userData['nationality_id'] ?? "",
          currencyId,
          userData['app_notification'] ?? "",
          userData['points'] ?? "",
          userData['health_conditions'] ?? "",
          userData['health_conditions_id'] ?? "",
          userData['email_verified_at'] ?? "",
          userData['mobile_code'] ?? "",
          userData['status'] ?? "",
          addedFrom,
          userData['created_at'] ?? "",
          userData['updated_at'] ?? "",
          userData['deleted_at'] ?? "",
          userData['device_id'] ?? "",
          pbp);
      setState(() {
        profile = up;
        loading = false;
      });

      // Constants.userRole = up.userRole;
      // prefs.setString("userRole", up.userRole);
    } catch (e) {
      print(e.toString());
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   createService();
  // }

  Future getProviderServices() async {
    setState(() {
      pLoading == true;
    });
    try {
      var response = await http.get(Uri.parse(
          "${Constants.baseUrl}/api/v1/serviceProviderProfile?id=${widget.id}"));
      if (response.statusCode == 200) {
        mapCountry = json.decode(response.body);
        List<dynamic> result = mapCountry['data'];
        result.forEach((element) {
          List<AvailabilityPlanModel> gAccomodationPlanModel = [];
          if (element['availability'] != null) {
            List<dynamic> availablePlan = element['availability'];
            availablePlan.forEach((ap) {
              AvailabilityPlanModel amPlan = AvailabilityPlanModel(
                  int.tryParse(ap['id'].toString()) ?? 0, ap['day'] ?? "");
              gAccomodationPlanModel.add(amPlan);
            });
          }
          List<AvailabilityModel> gAccomodoationAvaiModel = [];
          if (element['availability'] != null) {
            List<dynamic> available = element['availability'];
            available.forEach((a) {
              AvailabilityModel am =
                  AvailabilityModel(a['start_date'] ?? "", a['end_date'] ?? "");
              gAccomodoationAvaiModel.add(am);
            });
          }
          if (element['become_partner'] != null) {
            List<dynamic> becomePartner = element['become_partner'];
            becomePartner.forEach((b) {
              BecomePartner bp = BecomePartner(b['cr_name'] ?? "",
                  b['cr_number'] ?? "", b['description'] ?? "");
            });
          }
          List<IncludedActivitiesModel> gIAm = [];
          if (element['included_activities'] != null) {
            List<dynamic> iActivities = element['included_activities'];
            iActivities.forEach((iA) {
              IncludedActivitiesModel iAm = IncludedActivitiesModel(
                int.tryParse(iA['id'].toString()) ?? 0,
                int.tryParse(iA['service_id'].toString()) ?? 0,
                iA['activity_id'] ?? "",
                iA['activity'] ?? "",
                iA['image'] ?? "",
              );
              gIAm.add(iAm);
            });
          }
          List<DependenciesModel> gdM = [];
          if (element['dependencies'] != null) {
            List<dynamic> dependency = element['dependencies'];
            dependency.forEach((d) {
              DependenciesModel dm = DependenciesModel(
                int.tryParse(d['id'].toString()) ?? 0,
                d['dependency_name'] ?? "",
                d['image'] ?? "",
                d['updated_at'] ?? "",
                d['created_at'] ?? "",
                d['deleted_at'] ?? "",
              );
              gdM.add(dm);
            });
          }
          List<AimedForModel> gAccomodationAimedfm = [];
          if (element['aimed_for'] != null) {
            List<dynamic> aF = element['aimed_for'];
            aF.forEach((a) {
              AimedForModel afm = AimedForModel(
                int.tryParse(a['id'].toString()) ?? 0,
                a['AimedName'] ?? "",
                a['image'] ?? "",
                a['created_at'] ?? "",
                a['updated_at'] ?? "",
                a['deleted_at'] ?? "",
                int.tryParse(a['service_id'].toString()) ?? 0,
              );
              gAccomodationAimedfm.add(afm);
            });
          }
          List<ServiceImageModel> gAccomodationServImgModel = [];
          if (element['images'] != null) {
            List<dynamic> image = element['images'];
            image.forEach((i) {
              ServiceImageModel sm = ServiceImageModel(
                int.tryParse(i['id'].toString()) ?? 0,
                int.tryParse(i['service_id'].toString()) ?? 0,
                int.tryParse(i['is_default'].toString()) ?? 0,
                i['image_url'] ?? "",
                i['thumbnail'] ?? "",
              );
              gAccomodationServImgModel.add(sm);
            });
          }
          List<ProgrammesModel> gPm = [];
          if (element['images'] != null) {
            List<dynamic> programs = element['programs'];
            programs.forEach((p) {
              ProgrammesModel pm = ProgrammesModel(
                int.tryParse(p['id'].toString()) ?? 0,
                int.tryParse(p['service_id'].toString()) ?? 0,
                p['title'] ?? "",
                p['start_datetime'] ?? "",
                p['end_datetime'] ?? "",
                p['description'] ?? "",
              );
              gPm.add(pm);
            });
          }
          DateTime sDate =
              DateTime.tryParse(element['start_date'].toString()) ??
                  DateTime.now();
          DateTime eDate = DateTime.tryParse(element['end_date'].toString()) ??
              DateTime.now();
          log(sDate.day.toString());
          //DateTime e
          ServicesModel nSm = ServicesModel(
            id: int.tryParse(element['id'].toString()) ?? 0,
            owner: int.tryParse(element['owner'].toString()) ?? 0,
            adventureName: element['adventure_name'] ?? "",
            country: element['country'] ?? "",
            region: element['region'] ?? "",
            cityId: element['city_id'] ?? "",
            serviceSector: element['service_sector'] ?? "",
            serviceCategory: element['service_category'] ?? "",
            serviceType: element['service_type'] ?? "",
            serviceLevel: element['service_level'] ?? "",
            duration: element['duration'] ?? "",
            aSeats: int.tryParse(element['available_seats'].toString()) ?? 0,
            startDate: sDate,
            endDate: eDate,
            //int.tryParse(element['start_date'].toString()) ?? "",
            //int.tryParse(element['end_date'].toString()) ?? "",
            lat: element['latitude'] ?? "",
            lng: element['longitude'] ?? "",
            writeInformation: element['write_information'] ?? "",
            sPlan: int.tryParse(element['service_plan'].toString()) ?? 0,
            sForID: int.tryParse(element['sfor_id'].toString()) ?? 0,
            availability: gAccomodoationAvaiModel,
            availabilityPlan: gAccomodationPlanModel,
            geoLocation: element['geo_location'] ?? "",
            sAddress: element['specific_address'] ?? "",
            costInc: element['cost_inc'] ?? "",
            costExc: element['cost_exc'] ?? "",
            currency: element['currency'] ?? "",
            points: int.tryParse(element['points'].toString()) ?? 0,
            preRequisites: element['pre_requisites'] ?? "",
            mRequirements: element['minimum_requirements'] ?? "",
            tnc: element['terms_conditions'] ?? "",
            recommended: int.tryParse(element['recommended'].toString()) ?? 0,
            status: element['status'] ?? "",
            image: element['image'] ?? "",
            des: element['descreption]'] ?? "",
            fImage: element['favourite_image'] ?? "",
            ca: element['created_at'] ?? "",
            upda: element['updated_at'] ?? "",
            da: element['delete_at'] ?? "",
            providerId: int.tryParse(element['provider_id'].toString()) ?? 0,
            serviceId: int.tryParse(element['service_id'].toString()) ?? 0,
            pName: element['name'] ?? "",
            pProfile: element['provider_profile'] ?? "",
            serviceCategoryImage: element['service_category_image'] ?? "",
            serviceSectorImage: element['service_sector_image'] ?? "",
            serviceTypeImage: element['service_type_image'] ?? "",
            serviceLevelImage: element['service_level_image'] ?? "",
            iaot: element['including_gerea_and_other_taxes'] ?? "",
            eaot: element['excluding_gerea_and_other_taxes'] ?? "",
            activityIncludes: gIAm,
            dependency: gdM,
            bp: nBp,
            am: gAccomodationAimedfm,
            programmes: gPm,
            stars: element['stars'].toString() ?? "",
            isLiked: element['is_liked'] ?? 0,
            baseURL: element['baseurl'] ?? "",
            images: gAccomodationServImgModel,
            rating: element['rating'] ?? "",
            reviewdBy: element['reviewd_by'].toString() ?? "",
            remainingSeats:
                int.tryParse(element['remaining_seats'].toString()) ?? 0,
          );
          //gAccomodationSModel.add(nSm);
          if (nSm.status != "0") {
            allServices.add(nSm);
          }
          setState(() {
            pLoading = false;
          });

          // accomodation.add(adv);
          // accomodation.forEach((acco) {
          //   gm.add(acco);
          // });
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void selected(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
            "${Constants.baseUrl}/newreceiverchat/${Constants.userId}/${widget.sId}/${profile.id}",
          );
        },
      ),
    );
  }

  // Chat Provider : ${Constants.baseUrl}/newreceiverchat/3/34/24
  // string ChatUrl = $"{CommonConstantUrl.ChatUrl}newreceiverchat/{Settings.UserId}/{completedDataModel.service_id}/{completedDataModel.provider_id}";

  Future<void> shareLinkOnWhatsApp() async {
    String link = "https://adventuresclub.net/aDetails/${widget.id}";
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

  abc() {}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: whiteColor,
        //   elevation: 1.5,
        //   centerTitle: true,
        //   leading: IconButton(
        //     onPressed: () => Navigator.pop(context),
        //     icon: Image.asset(
        //       'images/backArrow.png',
        //       height: 20,
        //     ),
        //   ),
        //   title: MyText(
        //     text: 'serviceProviderProfile'.tr(),
        //     color: bluishColor,
        //     weight: FontWeight.bold,
        //   ),
        // ),
        body: loading
            ? Text("loading".tr())
            : NestedScrollView(
                physics: const BouncingScrollPhysics(),
                headerSliverBuilder: (((context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      toolbarHeight: 50,
                      expandedHeight: MediaQuery.of(context).size.height / 3.2,
                      elevation: 4,
                      floating: false,
                      pinned: true,
                      centerTitle: true,
                      iconTheme: const IconThemeData(color: bluishColor),
                      title: MyText(
                        text: 'serviceProviderProfile'.tr(),
                        color: bluishColor,
                        weight: FontWeight.bold,
                        size: 18,
                      ),
                      actions: [
                        const SizedBox(
                          width: 10,
                        )
                      ],
                      flexibleSpace: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: FlexibleSpaceBar(
                          background: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundImage: NetworkImage(
                                        "${'${Constants.baseUrl}/public/'}${profile.profileImage}",
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: MyText(
                                        text: profile.name, //'Alexander',
                                        weight: FontWeight.w600,
                                        color: blackColor,
                                        size: 18,
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: shareLinkOnWhatsApp,
                                          child: Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              color: redColor,
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            ),
                                            child: const Icon(Icons.share,
                                                size: 30, color: whiteColor),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () => selected(context),
                                          child: Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              color: redColor,
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            ),
                                            child: const Icon(Icons.chat,
                                                size: 25, color: whiteColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Container(
                                    //   height:
                                    //       MediaQuery.of(context).size.height /
                                    //           16,
                                    //   width:
                                    //       MediaQuery.of(context).size.width / 8,
                                    //   decoration: BoxDecoration(
                                    //     border: Border.all(
                                    //       color: const Color.fromARGB(
                                    //           255, 15, 71, 116),
                                    //       width: 2.0,
                                    //     ),
                                    //     color: const Color.fromARGB(
                                    //         255, 15, 71, 116),
                                    //     borderRadius: const BorderRadius.all(
                                    //         Radius.circular(36)),
                                    //   ),
                                    //   child: Material(
                                    //     color: Colors.transparent,
                                    //     child: InkWell(
                                    //       onTap: () => selected(context),
                                    //       child: Center(
                                    //         child: Padding(
                                    //             padding: const EdgeInsets.only(
                                    //                 left: 0),
                                    //             child: Icon(
                                    //               Icons.chat,
                                    //               color: whiteColor,
                                    //             )
                                    //             // Row(
                                    //             //   mainAxisAlignment:
                                    //             //       MainAxisAlignment.center,
                                    //             //   children: [
                                    //             //     // Text(
                                    //             //     //   'chat'.tr(),
                                    //             //     //   style: const TextStyle(
                                    //             //     //       color: whiteColor,
                                    //             //     //       fontWeight:
                                    //             //     //           FontWeight.bold,
                                    //             //     //       letterSpacing: 0.8,
                                    //             //     //       fontFamily: "Raleway",
                                    //             //     //       fontSize: 14),
                                    //             //     // ),
                                    //             //   ],
                                    //             // ),
                                    //             ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                // ListTile(
                                //   dense: true,
                                //   leading: CircleAvatar(
                                //     radius: 40,
                                //     backgroundImage: NetworkImage(
                                //       "${'${Constants.baseUrl}/public/'}${profile.profileImage}",
                                //     ),
                                //   ),
                                //   title: Column(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: [
                                //       MyText(
                                //         text: profile.name, //'Alexander',
                                //         weight: FontWeight.w600,
                                //         color: blackColor,
                                //         size: 18,
                                //       ),
                                //     ],
                                //   ),
                                //   trailing: Container(
                                //     height:
                                //         MediaQuery.of(context).size.height / 22,
                                //     width:
                                //         MediaQuery.of(context).size.width / 4,
                                //     decoration: BoxDecoration(
                                //       border: Border.all(
                                //         color: const Color.fromARGB(
                                //             255, 15, 71, 116),
                                //         width: 2.0,
                                //       ),
                                //       color: const Color.fromARGB(
                                //           255, 15, 71, 116),
                                //       borderRadius: const BorderRadius.all(
                                //           Radius.circular(28)),
                                //     ),
                                //     child: Material(
                                //       color: Colors.transparent,
                                //       child: InkWell(
                                //         onTap: () => selected(context),
                                //         child: Center(
                                //           child: Padding(
                                //             padding:
                                //                 const EdgeInsets.only(left: 0),
                                //             child: Row(
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment.center,
                                //               children: [
                                //                 Text(
                                //                   'chat'.tr(),
                                //                   style: const TextStyle(
                                //                       color: whiteColor,
                                //                       fontWeight:
                                //                           FontWeight.bold,
                                //                       letterSpacing: 0.8,
                                //                       fontFamily: "Raleway",
                                //                       fontSize: 14),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: 'about'.tr(),
                                      color: bluishColor,
                                      size: 18,
                                      weight: FontWeight.bold,
                                    ),
                                    MyText(
                                      text: profile.bp
                                          .companyName, //'Travel Instructor',
                                      //weight: FontWeight.w500,
                                      color: blackColor,
                                      size: 14,
                                    ),
                                    MyText(
                                      overFlow: TextOverflow.fade,
                                      text: "${profile.bp.location}"
                                          "${","}"
                                          "${profile.bp.address}", //'County, City',
                                      //weight: FontWeight.w500,
                                      color: blackColor,
                                      size: 14,
                                    ),
                                  ],
                                ),
                                // const Divider(
                                //   color: greyColor,
                                // ),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 20.0),
                                //   child: Align(
                                //     alignment: Alignment.centerLeft,
                                //     child: MyText(
                                //       text: 'providerAdventure'.tr(),
                                //       color: greyColor,
                                //       weight: FontWeight.w600,
                                //       size: 16,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ];
                })),
                body: Column(
                  children: [
                    pLoading
                        ? MyText(text: "loading".tr())
                        : Expanded(
                            child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12),
                            child: ProvidedAdventureGrid(allServices),
                          ))
                  ],
                ),
              ),
      ),
    );
  }
}
