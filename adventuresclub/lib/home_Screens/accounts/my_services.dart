// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, deprecated_member_use

import 'dart:convert';
import 'package:adventuresclub/become_a_partner/create_services/create_new_services.dart';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/myservices_ad_details.dart';
import 'package:adventuresclub/models/filter_data_model/programs_model.dart';
import 'package:adventuresclub/models/home_services/become_partner.dart';
import 'package:adventuresclub/models/home_services/home_services_model.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/models/my_services/my_services_model.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/models/services/availability_model.dart';
import 'package:adventuresclub/models/services/create_services/availability_plan_model.dart';
import 'package:adventuresclub/models/services/dependencies_model.dart';
import 'package:adventuresclub/models/services/included_activities_model.dart';
import 'package:adventuresclub/models/services/service_image_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/services_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../become_partner/become_partner_packages.dart';

class MyServices extends StatefulWidget {
  const MyServices({super.key});

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  TextEditingController searchController = TextEditingController();
  List<ServiceImageModel> gSim = [];
  List<AimedForModel> gAfm = [];
  List<MyServicesModel> gSm = [];
  List<BecomePartner> nBp = [];
  List<ServicesModel> allServices = [];
  List<ServicesModel> filteredServices = [];
  List<ServicesModel> allAccomodation = [];
  List<ServicesModel> gAccomodationSModel = [];

  bool loading = false;
  @override
  void initState() {
    super.initState();
    myServicesApi();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchServices(String x) {
    if (x.isNotEmpty) {
      filteredServices = allServices
          .where((element) => element.adventureName.toLowerCase().contains(x))
          .toList();
      //log(filteredServices.length.toString());
    } else {
      filteredServices = allServices;
    }
    setState(() {});
  }

  void goTo() {
    if (Constants.expired == false) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return const CreateNewServices(); //CompleteProfile();
          },
        ),
      );
    } else if (Constants.expired == true) {
      requestSent();
    }
  }

  void requestSent() async {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Text(
                "Alert",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Your Subscription exprired. Please renew to extend the subscription",
                style: TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: packagesList,
                    child: MyText(
                      text: "Yes",
                      weight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                  MaterialButton(
                    onPressed: cancel,
                    child: MyText(
                      text: "No",
                      weight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        children: [],
      ),
    );
  }

  void packagesList() {
    cancel();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const BecomePartnerPackages(
            //bp,
            show: true,
          );
        },
      ),
    );
  }

  void cancel() {
    Navigator.of(context).pop();
  }

// 0:
// "id" -> 44
// 1:
// "owner" -> 27
// 2:
// "adventure_name" -> "hamza adventure name"
// 3:
// "country" -> "INDIA"
// 4:
// "region" -> "Al sharqiyah South"
// 5:
// "city_id" -> null
// 6:
// "service_sector" -> "Tour"
// 7:
// "service_category" -> "Accomodation"
// 8:
// "service_type" -> "Bike riding"
// 9:
// "service_level" -> "Master"
// 10:
// "duration" -> "38 Min"
// 11:
// "available_seats" -> 90
// 12:
// "start_date" -> "0000-00-00 00:00:00"

// "end_date" -> "0000-00-00 00:00:00"
// 14:
// "latitude" -> "37.4219983"
// 15:
// "longitude" -> "-122.084"
// 16:
// "write_information" -> "hamza information"
// 17:
// "service_plan" -> null
// 18:
// "sfor_id" -> null
// 19:
// "availability" -> List (0 items)
// 20:
// "geo_location" -> null
// 21:
// "specific_address" -> null
// 22:
// "cost_inc" -> "100.00"
// 23:
// "cost_exc" -> "50.00"
// 24:
// "currency" -> "INR"
// 25:
// "points" -> 0
// 26:
// "pre_requisites" -> "be careful"
// "minimum_requirements" -> "take care"
// 28:
// "terms_conditions" -> "be kind"
// 29:
// "recommended" -> 1
// 30:
// "status" -> "0"
// 31:
// "image" -> ""
// 32:
// "descreption" -> "hamza information"
// 33:
// "favourite_image" -> ""
// 34:
// "created_at" -> "2023-03-02 16:52:50"
// 35:
// "updated_at" -> "2023-03-02 16:52:50"
// 36:
// "deleted_at" -> null
// 37:
// "service_id" -> 44
// 38:
// "provider_id" -> 27
// 39:
// "provided_name" -> "talha"
// 40:
// "provider_profile" -> "https://adventuresclub.net/adventureClub/public/profile_image/no-image.png"
// 41:
// "including_gerea_and_other_taxes" -> "100.00"
// 42:
// "excluding_gerea_and_other_taxes" -> "50.00"
// 43:
// "image_url" -> List (0 items)
// 44:
// "aimed_for" -> List (1 item)
// 45:
// "cost_incclude" -> "100.00"
// 46:
// "cost_exclude" -> "50.00"

  Future<void> myServicesApi() async {
    setState(() {
      loading = true;
    });
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/myserviceapi"),
          body: {
            'owner': Constants.userId.toString(), //"3",
            'country_id': Constants.countryId.toString(),
            //.toString(),
            //"2", //Constants.countryId.toString(), //"2",
            //'forgot_password': "0"
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = decodedResponse['data'];
      filteredServices.clear();
      result.forEach(((element) {
        List<AvailabilityPlanModel> gAccomodationPlanModel = [];
        List<AvailabilityModel> gAccomodoationAvaiModel = [];
        if (element['service_plan'] == 1) {
          dynamic ga = element['availability'];
          if (ga != null) {
            List<dynamic> availablePlan = element['availability'];
            availablePlan.forEach((ap) {
              AvailabilityPlanModel amPlan = AvailabilityPlanModel(
                  ap['id'].toString() ?? "", ap['day'].toString() ?? "");
              gAccomodationPlanModel.add(amPlan);
            });
          }
        } else {
          dynamic pga = element['availability'];
          if (pga != null) {
            List<dynamic> available = element['availability'];
            available.forEach((a) {
              AvailabilityModel am = AvailabilityModel(
                  a['start_date'].toString() ?? "",
                  a['end_date'].toString() ?? "");
              gAccomodoationAvaiModel.add(am);
            });
          }
        }
        dynamic nullbp = element['become_partner'];
        if (nullbp != null) {
          List<dynamic> becomePartner = element['become_partner'];
          becomePartner.forEach((b) {
            BecomePartner bp = BecomePartner(
                b['cr_name'].toString() ?? "",
                b['cr_number'].toString() ?? "",
                b['description'].toString() ?? "");
          });
        }
        dynamic nullActivity = element['included_activities'];
        List<IncludedActivitiesModel> gIAm = [];
        if (nullActivity != null) {
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
        }
        List<DependenciesModel> gdM = [];
        dynamic dependency = element['dependencies'];
        if (dependency != null) {
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
        }
        List<AimedForModel> gAccomodationAimedfm = [];
        dynamic aF = element['aimed_for'];
        if (aF != null) {
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
        }
        List<ServiceImageModel> gAccomodationServImgModel = [];
        dynamic image = element['images'];
        if (image != null) {
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
        dynamic programs = element['programs'];
        if (programs != null) {
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
        }
        DateTime sDate = DateTime.tryParse(element['start_date'].toString()) ??
            DateTime.now();
        DateTime eDate =
            DateTime.tryParse(element['end_date'].toString()) ?? DateTime.now();
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
        allAccomodation.add(nSm);
        HomeServicesModel adv = HomeServicesModel("", gAccomodationSModel);
        setState(() {
          loading = false;
          filteredServices = allServices;
        });
        print(response.statusCode);
        print(response.body);
        print(response.headers);
      }));
    } catch (e) {
      print(e.toString());
    }
  }

  void goToDetails(ServicesModel gm) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return MyServicesAdDetails(gm);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 232, 232),
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
          text: 'My services',
          color: bluishColor,
          weight: FontWeight.w700,
          fontFamily: "Roboto",
        ),
        actions: [
          GestureDetector(
              onTap: goTo,
              child: const Image(
                image: ExactAssetImage('images/add-circle.png'),
                width: 25,
                height: 25,
              )),
          const SizedBox(
            width: 15,
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(65.0),
          child: Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.white),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: blackColor.withOpacity(0.5),
                  ),
                ),
                child: TextField(
                  onChanged: (value) {
                    searchServices(value);
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: bluishColor,
                    ),
                    // label: Icon(
                    //   Icons.search,
                    // ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    hintText: 'Search by Adventure Name',
                    filled: true,
                    fillColor: whiteColor,
                    suffixIcon: GestureDetector(
                      //onTap: openMap,
                      child: const Icon(
                        Icons.filter_alt,
                        color: bluishColor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(6.0)),
                      borderSide: BorderSide(color: greyColor.withOpacity(0.5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(6.0)),
                      borderSide: BorderSide(color: greyColor.withOpacity(0.5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(6.0)),
                      borderSide: BorderSide(color: greyColor.withOpacity(0.5)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: myServicesApi,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 12.0, bottom: 12, left: 5, right: 5),
          child: GridView.count(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            mainAxisSpacing: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 2,
            crossAxisCount: 2,
            children: List.generate(
              filteredServices.length, // widget.profileURL.length,
              (index) {
                return GestureDetector(
                  onTap: () => goToDetails(filteredServices[index]),
                  child: ServicesCard(
                    filteredServices[index],
                    show: true,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
