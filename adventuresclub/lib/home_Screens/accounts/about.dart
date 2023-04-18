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
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/grid/provided_adventure_grid.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/services/create_services/availability_plan_model.dart';

class About extends StatefulWidget {
  final String? id;
  const About({this.id, super.key});

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
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/get_profile"),
          body: {
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
          partnerInfo['company_name'].toString() ?? "",
          partnerInfo['address'].toString() ?? "",
          partnerInfo['location'].toString() ?? "",
          partnerInfo['description'].toString() ?? "",
          partnerInfo['license'].toString() ?? "",
          partnerInfo['cr_name'].toString() ?? "",
          partnerInfo['cr_number'].toString() ?? "",
          partnerInfo['cr_copy'].toString() ?? "",
          debitCard,
          visaCard,
          partnerInfo['payon_arrival'].toString() ?? "",
          partnerInfo['paypal'].toString() ?? "",
          partnerInfo['bankname'].toString() ?? "",
          partnerInfo['account_holdername'].toString() ?? "",
          partnerInfo['account_number'].toString() ?? "",
          partnerInfo['is_online'].toString() ?? "",
          partnerInfo['is_approved'].toString() ?? "",
          packagesId,
          partnerInfo['start_date'].toString() ?? "",
          partnerInfo['end_date'].toString() ?? "",
          partnerInfo['is_wiretransfer'].toString() ?? "",
          partnerInfo['is_free_used'].toString() ?? "",
          partnerInfo['created_at'].toString() ?? "",
          partnerInfo['updated_at'].toString() ?? "",
        );
        pbp = bp;
      }
      UserProfileModel up = UserProfileModel(
          userLoginId,
          userData['users_role'].toString() ?? "",
          userData['profile_image'].toString() ?? "",
          userData['name'].toString() ?? "",
          userData['height'].toString() ?? "",
          userData['weight'].toString() ?? "",
          userData['email'].toString() ?? "",
          countryId,
          userData['region_id'].toString() ?? "",
          userData['city_id'].toString() ?? "",
          userData['now_in'].toString() ?? "",
          userData['mobile'].toString() ?? "",
          userData['mobile_verified_at'].toString() ?? "",
          userData['dob'].toString() ?? "",
          userData['gender'].toString() ?? "",
          languageId,
          userData['nationality_id'].toString() ?? "",
          currencyId,
          userData['app_notification'].toString() ?? "",
          userData['points'].toString() ?? "",
          userData['health_conditions'].toString() ?? "",
          userData['health_conditions_id'].toString() ?? "",
          userData['email_verified_at'].toString() ?? "",
          userData['mobile_code'].toString() ?? "",
          userData['status'].toString() ?? "",
          addedFrom,
          userData['created_at'].toString() ?? "",
          userData['updated_at'].toString() ?? "",
          userData['deleted_at'].toString() ?? "",
          userData['device_id'].toString() ?? "",
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
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/serviceProviderProfile?id=${widget.id}"));
    if (response.statusCode == 200) {
      mapCountry = json.decode(response.body);
      List<dynamic> result = mapCountry['data'];
      result.forEach((element) {
        List<AvailabilityPlanModel> gAccomodationPlanModel = [];
        if (element['availability'] != null) {
          List<dynamic> availablePlan = element['availability'];
          availablePlan.forEach((ap) {
            AvailabilityPlanModel amPlan = AvailabilityPlanModel(
                ap['id'].toString() ?? "", ap['day'].toString() ?? "");
            gAccomodationPlanModel.add(amPlan);
          });
        }
        List<AvailabilityModel> gAccomodoationAvaiModel = [];
        if (element['availability'] != null) {
          List<dynamic> available = element['availability'];
          available.forEach((a) {
            AvailabilityModel am = AvailabilityModel(
                a['start_date'].toString() ?? "",
                a['end_date'].toString() ?? "");
            gAccomodoationAvaiModel.add(am);
          });
        }
        if (element['become_partner'] != null) {
          List<dynamic> becomePartner = element['become_partner'];
          becomePartner.forEach((b) {
            BecomePartner bp = BecomePartner(
                b['cr_name'].toString() ?? "",
                b['cr_number'].toString() ?? "",
                b['description'].toString() ?? "");
          });
        }
        List<IncludedActivitiesModel> gIAm = [];
        List<dynamic> iActivities = element['included_activities'];
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
        List<dynamic> dependency = element['dependencies'];
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
        List<dynamic> aF = element['aimed_for'];
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
        if (element['images'] != null) {
          List<dynamic> image = element['images'];
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
        }
        List<ProgrammesModel> gPm = [];
        List<dynamic> programs = element['programs'];
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
        DateTime sDate = DateTime.tryParse(element['start_date'].toString()) ??
            DateTime.now();
        DateTime eDate =
            DateTime.tryParse(element['end_date'].toString()) ?? DateTime.now();
        log(sDate.day.toString());
        //DateTime e
        ServicesModel nSm = ServicesModel(
          int.tryParse(element['id'].toString()) ?? 0,
          int.tryParse(element['owner'].toString()) ?? 0,
          element['adventure_name'].toString() ?? "",
          element['country'].toString() ?? "",
          element['region'].toString() ?? "",
          element['city_id'].toString() ?? "",
          element['service_sector'].toString() ?? "",
          element['service_category'].toString() ?? "",
          element['service_type'].toString() ?? "",
          element['service_level'].toString() ?? "",
          element['duration'].toString() ?? "",
          int.tryParse(element['available_seats'].toString()) ?? 0,
          sDate,
          eDate,
          //int.tryParse(element['start_date'].toString()) ?? "",
          //int.tryParse(element['end_date'].toString()) ?? "",
          element['latitude'].toString() ?? "",
          element['longitude'].toString() ?? "",
          element['write_information'].toString() ?? "",
          int.tryParse(element['service_plan'].toString()) ?? 0,
          int.tryParse(element['sfor_id'].toString()) ?? 0,
          gAccomodoationAvaiModel,
          gAccomodationPlanModel,
          element['geo_location'].toString() ?? "",
          element['specific_address'].toString() ?? "",
          element['cost_inc'].toString() ?? "",
          element['cost_exc'].toString() ?? "",
          element['currency'].toString() ?? "",
          int.tryParse(element['points'].toString()) ?? 0,
          element['pre_requisites'].toString() ?? "",
          element['minimum_requirements'].toString() ?? "",
          element['terms_conditions'].toString() ?? "",
          int.tryParse(element['recommended'].toString()) ?? 0,
          element['status'].toString() ?? "",
          element['image'].toString() ?? "",
          element['descreption]'].toString() ?? "",
          element['favourite_image'].toString() ?? "",
          element['created_at'].toString() ?? "",
          element['updated_at'].toString() ?? "",
          element['delete_at'].toString() ?? "",
          int.tryParse(element['provider_id'].toString()) ?? 0,
          int.tryParse(element['service_id'].toString()) ?? 0,
          element['provided_name'].toString() ?? "",
          element['provider_profile'].toString() ?? "",
          element['including_gerea_and_other_taxes'].toString() ?? "",
          element['excluding_gerea_and_other_taxes'].toString() ?? "",
          gIAm,
          gdM,
          nBp,
          gAccomodationAimedfm,
          gPm,
          element['stars'].toString() ?? "",
          int.tryParse(element['is_liked'].toString()) ?? 0,
          element['baseurl'].toString() ?? "",
          gAccomodationServImgModel,
          element['rating'].toString() ?? "",
          element['reviewd_by'].toString() ?? "",
          int.tryParse(element['remaining_seats'].toString()) ?? 0,
        );
        //gAccomodationSModel.add(nSm);
        allServices.add(nSm);
        setState(() {
          pLoading = false;
        });

        // accomodation.add(adv);
        // accomodation.forEach((acco) {
        //   gm.add(acco);
        // });
      });
    }
  }

  abc() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.5,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset(
            'images/backArrow.png',
            height: 20,
          ),
        ),
        title: MyText(
          text: 'Service Provider Profile',
          color: bluishColor,
          weight: FontWeight.bold,
        ),
      ),
      body: loading
          ? const Text("Loading...")
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                        "${'https://adventuresclub.net/adventureClub/public/'}${profile.profileImage}",
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: profile.name, //'Alexander',
                                          weight: FontWeight.w600,
                                          color: blackColor,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        MyText(
                                          text: profile.bp
                                              .companyName, //'Travel Instructor',
                                          weight: FontWeight.w500,
                                          color: greyTextColor,
                                          size: 14,
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        MyText(
                                          text: "${profile.bp.location}"
                                              "${","}"
                                              "${profile.bp.address}", //'County, City',
                                          weight: FontWeight.w500,
                                          color: greyTextColor,
                                          size: 12,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Button(
                                            'Chat',
                                            const Color.fromARGB(
                                                255, 15, 71, 116),
                                            const Color.fromARGB(
                                                255, 15, 71, 116),
                                            whiteColor,
                                            14,
                                            abc,
                                            Icons.add,
                                            whiteColor,
                                            false,
                                            4,
                                            'Roboto',
                                            FontWeight.w400,
                                            26)
                                      ],
                                    ),
                                  ],
                                ),
                                const Align(
                                  alignment: Alignment.centerRight,
                                  child: Image(
                                    image:
                                        ExactAssetImage('images/forward.png'),
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            text: 'About',
                            color: greyColor,
                            size: 18,
                            weight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            text: profile.bp
                                .description, //'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu tempus dolor, sit amet laoreet libero. Quisque eleifend, elit placerat condimentum condimentum, nibh lectus mollis eros, at condimentum metus turpis et turpis. Maecenas eu finibus erat. Ut nec gravida nibh. Donec sed nisi volutpat, fermentum felis in, bibendum dolor. ',
                            color: greyColor,
                            size: 14,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: greyColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: MyText(
                        text: 'Provided Adventures',
                        color: greyColor,
                        size: 16,
                      ),
                    ),
                  ),
                  pLoading
                      ? MyText(text: "Loading...")
                      : ProvidedAdventureGrid(allServices)
                ],
              ),
            ),
    );
  }
}
