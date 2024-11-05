// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, deprecated_member_use

import 'dart:convert';
import 'package:adventuresclub/become_a_partner/create_services/create_draft_services.dart';
import 'package:adventuresclub/become_a_partner/create_services/create_new_services.dart';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/my_drafts.dart';
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
import 'package:adventuresclub/provider/navigation_index_provider.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/services_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
  List<BecomePartner> nBpDraft = [];
  List<ServicesModel> allDraftServices = [];
  List<ServicesModel> filteredDraftServices = [];

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

  void goTo() async {
    if (Constants.expired == false) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return const CreateNewServices(); //CompleteProfile();
          },
        ),
      );
      myServicesApi();
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
        children: const [],
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
              // show: true,
              );
        },
      ),
    );
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void getNotificatioNumber() {
    Provider.of<NavigationIndexProvider>(context, listen: false)
        .getNotificationBadge();
  }

  // https://adventuresclub.net/adventureClubSIT/api/v1/get_draft_service

  Future<void> myServicesApi() async {
    getNotificatioNumber();
    setState(() {
      loading = true;
    });
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/myserviceapi"), body: {
        'owner': Constants.userId.toString(), //"3",
        'country_id': Constants.countryId.toString(),
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
                  int.tryParse(ap['id'].toString()) ?? 0,
                  ap['day'].toString() ?? "");
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
              d['dependency_name'] ?? "",
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
        dynamic image = element['images'];
        if (image != null) {
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
        dynamic programs = element['programs'];
        if (programs != null) {
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
        DateTime sDate = DateTime.tryParse(element['start_date'].toString()) ??
            DateTime.now();
        DateTime eDate =
            DateTime.tryParse(element['end_date'].toString()) ?? DateTime.now();
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
          pName: element['provided_name'] ?? "",
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
          isLiked: int.tryParse(element['is_liked'].toString()) ?? 0,
          baseURL: element['baseurl'] ?? "",
          images: gAccomodationServImgModel,
          rating: element['rating'] ?? "",
          reviewdBy: element['reviewd_by'].toString() ?? "",
          remainingSeats:
              int.tryParse(element['remaining_seats'].toString()) ?? 0,
        );
        //gAccomodationSModel.add(nSm);
        allServices.add(nSm);
        allAccomodation.add(nSm);
        HomeServicesModel adv = HomeServicesModel("", gAccomodationSModel);
        //setState(() {
        // loading = false;
        filteredServices = allServices;
        //});
        print(response.statusCode);
        print(response.body);
        print(response.headers);
      }));
      getDrafts();
    } catch (e) {
      print(e.toString());
    }
  }

  void refreshServices() {
    myServicesApi();
  }

  void goToDetails(ServicesModel gm) async {
    if (gm.status != "3") {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return MyServicesAdDetails(
              gm,
            );
          },
        ),
      );
    } else {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return CreateDraftServices(
              draftService: gm,
            );
          },
        ),
      );
    }
    myServicesApi();
  }

  void goToDrafts(ServicesModel gm) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const CreateNewServices();
        },
      ),
    );
  }

  void navDraft() {
    // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //   return const MyDrafts();
    // }));
  }

  Future<void> getDrafts() async {
    filteredDraftServices.clear();
    allDraftServices.clear();
    try {
      var response = await http.post(
          Uri.parse("${Constants.baseUrl}/api/v1/get_draft_service"),
          body: {
            "provider_id": Constants.userId
                .toString(), //Constants.profile.bp.id.toString(),
            "country_id": Constants.countryId.toString(),
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = decodedResponse['data'];
      result.forEach(((element) {
        List<AvailabilityPlanModel> gAccomodationPlanModel = [];
        List<AvailabilityModel> gAccomodoationAvaiModel = [];
        if (element['service_plan'] == 1) {
          dynamic ga = element['availability'];
          if (ga != null) {
            List<dynamic> availablePlan = element['availability'];
            availablePlan.forEach((ap) {
              AvailabilityPlanModel amPlan = AvailabilityPlanModel(
                  int.tryParse(ap['id'].toString()) ?? 0,
                  ap['day'].toString() ?? "");
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
              d['dependency_name'] ?? "",
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
        dynamic image = element['images'];
        if (image != null) {
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
        dynamic programs = element['programs'];
        if (programs != null) {
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
        DateTime sDate = DateTime.tryParse(element['start_date'].toString()) ??
            DateTime.now();
        DateTime eDate =
            DateTime.tryParse(element['end_date'].toString()) ?? DateTime.now();
        ServicesModel nSm = ServicesModel(
          id: int.tryParse(element['id'].toString()) ?? 0,
          owner: int.tryParse(element['owner'].toString()) ?? 0,
          adventureName: element['adventure_name'] ?? "",
          country: element['country'].toString() ?? "",
          region: element['region'].toString() ?? "",
          cityId: element['city_id'].toString() ?? "",
          serviceSector: element['service_sector'].toString() ?? "",
          serviceCategory: element['service_category'].toString() ?? "",
          serviceType: element['service_type'].toString() ?? "",
          serviceLevel: element['service_level'].toString() ?? "",
          duration: element['duration'].toString() ?? "",
          aSeats: int.tryParse(element['available_seats'].toString()) ?? 0,
          startDate: sDate,
          endDate: eDate,
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
          pName: element['provided_name'] ?? "",
          pProfile: element['provider_profile'] ?? "",
          serviceCategoryImage: element['service_category_image'] ?? "",
          serviceSectorImage: element['service_sector_image'] ?? "",
          serviceTypeImage: element['service_type_image'] ?? "",
          serviceLevelImage: element['service_level_image'] ?? "",
          iaot: element['including_gerea_and_other_taxes'] ?? "",
          eaot: element['excluding_gerea_and_other_taxes'] ?? "",
          activityIncludes: gIAm,
          dependency: gdM,
          bp: nBpDraft,
          am: gAccomodationAimedfm,
          programmes: gPm,
          stars: element['stars'].toString() ?? "",
          isLiked: int.tryParse(element['is_liked'].toString()) ?? 0,
          baseURL: element['baseurl'] ?? "",
          images: gAccomodationServImgModel,
          rating: element['rating'] ?? "",
          reviewdBy: element['reviewd_by'].toString() ?? "",
          remainingSeats:
              int.tryParse(element['remaining_seats'].toString()) ?? 0,
        );
        //gAccomodationSModel.add(nSm);
        allDraftServices.add(nSm);
        filteredDraftServices = allDraftServices;
        filteredServices.insert(0, filteredDraftServices[0]);
      }));
    } catch (e) {
      if (mounted) {
        Constants.showMessage(context, e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
            text: 'myServices'.tr(),
            color: bluishColor,
            weight: FontWeight.w700,
            fontFamily: "Roboto",
          ),
          actions: [
            // GestureDetector(
            //   onTap: goTo,
            //   child: IconButton(
            //     onPressed: navDraft,
            //     icon: const Icon(
            //       Icons.drafts_outlined,
            //       size: 24,
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   width: 5,
            // ),
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
              data: Theme.of(context).copyWith(hintColor: Colors.white),
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 4),
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
                        borderSide:
                            BorderSide(color: greyColor.withOpacity(0.5)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6.0)),
                        borderSide:
                            BorderSide(color: greyColor.withOpacity(0.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6.0)),
                        borderSide:
                            BorderSide(color: greyColor.withOpacity(0.5)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: filteredServices.isEmpty
            ? const Center(
                child: Text("No Services Created Yet",
                    style: TextStyle(fontWeight: FontWeight.w600)),
              )
            : Column(
                children: [
                  // if (filteredDraftServices.isNotEmpty)
                  //   Expanded(
                  //       child: MyDrafts(
                  //           filteredDraftServices: filteredDraftServices)),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: myServicesApi,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, bottom: 12, left: 16, right: 16),
                        child: ListView.builder(
                            itemCount: filteredServices.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () =>
                                    goToDetails(filteredServices[index]),
                                child: SizedBox(
                                  height: 310,
                                  child: ServicesCard(
                                    show: true,
                                    filteredServices[index],
                                    providerShow: false,
                                  ),
                                ),
                              );
                            }),
                        // GridView.count(
                        //   physics: const AlwaysScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   mainAxisSpacing: 2,
                        //   childAspectRatio: 1,
                        //   crossAxisSpacing: 2,
                        //   crossAxisCount: 2,
                        //   children: List.generate(
                        //     filteredServices.length, // widget.profileURL.length,
                        //     (index) {
                        //       return GestureDetector(
                        //         onTap: () => goToDetails(filteredServices[index]),
                        //         child: ServicesCard(
                        //           filteredServices[index],
                        //           show: true,
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
