// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:developer';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/filter_data_model/programs_model.dart';
import 'package:adventuresclub/models/home_services/become_partner.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/models/profile_models/profile_become_partner.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/models/services/availability_model.dart';
import 'package:adventuresclub/models/services/dependencies_model.dart';
import 'package:adventuresclub/models/services/included_activities_model.dart';
import 'package:adventuresclub/models/services/service_image_model.dart';
import 'package:adventuresclub/models/user_profile_model.dart';
import 'package:adventuresclub/widgets/grid/provided_adventure_grid.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
            int.tryParse(element['id'].toString()) ?? 0,
            int.tryParse(element['owner'].toString()) ?? 0,
            element['adventure_name'] ?? "",
            element['country'] ?? "",
            element['region'] ?? "",
            element['city_id'] ?? "",
            element['service_sector'] ?? "",
            element['service_category'] ?? "",
            element['service_type'] ?? "",
            element['service_level'] ?? "",
            element['duration'] ?? "",
            int.tryParse(element['available_seats'].toString()) ?? 0,
            sDate,
            eDate,
            //int.tryParse(element['start_date'].toString()) ?? "",
            //int.tryParse(element['end_date'].toString()) ?? "",
            element['latitude'] ?? "",
            element['longitude'] ?? "",
            element['write_information'] ?? "",
            int.tryParse(element['service_plan'].toString()) ?? 0,
            int.tryParse(element['sfor_id'].toString()) ?? 0,
            gAccomodoationAvaiModel,
            gAccomodationPlanModel,
            element['geo_location'] ?? "",
            element['specific_address'] ?? "",
            element['cost_inc'] ?? "",
            element['cost_exc'] ?? "",
            element['currency'] ?? "",
            int.tryParse(element['points'].toString()) ?? 0,
            element['pre_requisites'] ?? "",
            element['minimum_requirements'] ?? "",
            element['terms_conditions'] ?? "",
            int.tryParse(element['recommended'].toString()) ?? 0,
            element['status'] ?? "",
            element['image'] ?? "",
            element['descreption]'] ?? "",
            element['favourite_image'] ?? "",
            element['created_at'] ?? "",
            element['updated_at'] ?? "",
            element['delete_at'] ?? "",
            int.tryParse(element['provider_id'].toString()) ?? 0,
            int.tryParse(element['service_id'].toString()) ?? 0,
            element['name'] ?? "",
            element['provider_profile'] ?? "",
            element['including_gerea_and_other_taxes'] ?? "",
            element['excluding_gerea_and_other_taxes'] ?? "",
            gIAm,
            gdM,
            nBp,
            gAccomodationAimedfm,
            gPm,
            element['stars'].toString() ?? "",
            element['is_liked'] ?? 0,
            element['baseurl'] ?? "",
            gAccomodationServImgModel,
            element['rating'] ?? "",
            element['reviewd_by'].toString() ?? "",
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
                physics: BouncingScrollPhysics(),
                headerSliverBuilder: (((context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      toolbarHeight: 50,
                      expandedHeight: 280,
                      elevation: 1,
                      floating: false,
                      pinned: true,
                      title: MyText(
                        text: 'serviceProviderProfile'.tr(),
                        color: bluishColor,
                        weight: FontWeight.bold,
                        size: 22,
                      ),
                      flexibleSpace: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: FlexibleSpaceBar(
                          background: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  dense: true,
                                  leading: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                      "${'${Constants.baseUrl}/public/'}${profile.profileImage}",
                                    ),
                                  ),
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                        text: profile.name, //'Alexander',
                                        weight: FontWeight.w600,
                                        color: blackColor,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                  trailing: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 15, 71, 116),
                                        width: 2.0,
                                      ),
                                      color: const Color.fromARGB(
                                          255, 15, 71, 116),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(28)),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () => selected(context),
                                        child: Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'chat'.tr(),
                                                  style: const TextStyle(
                                                      color: whiteColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 0.8,
                                                      fontFamily: "Raleway",
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
                                const Divider(
                                  color: greyColor,
                                ),
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
                        : Expanded(child: ProvidedAdventureGrid(allServices))
                  ],
                ),
              ),
      ),
    );
  }
}
