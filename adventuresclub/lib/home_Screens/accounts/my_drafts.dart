import 'dart:convert';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/filter_data_model/programs_model.dart';
import 'package:adventuresclub/models/home_services/become_partner.dart';
import 'package:adventuresclub/models/home_services/home_services_model.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/models/services/availability_model.dart';
import 'package:adventuresclub/models/services/create_services/availability_plan_model.dart';
import 'package:adventuresclub/models/services/dependencies_model.dart';
import 'package:adventuresclub/models/services/included_activities_model.dart';
import 'package:adventuresclub/models/services/service_image_model.dart';
import 'package:adventuresclub/widgets/loading_widget.dart';
import 'package:adventuresclub/widgets/services_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyDrafts extends StatefulWidget {
  const MyDrafts({super.key});

  @override
  State<MyDrafts> createState() => _MyDraftsState();
}

class _MyDraftsState extends State<MyDrafts> {
  bool loading = false;
  List<BecomePartner> nBp = [];
  List<ServicesModel> allServices = [];
  List<ServicesModel> filteredServices = [];
  List<ServicesModel> allAccomodation = [];
  List<ServicesModel> gAccomodationSModel = [];

  @override
  void initState() {
    super.initState();
    getDrafts();
  }

  Future<void> getDrafts() async {
    setState(() {
      loading = true;
    });
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
        filteredServices = allServices;
      }));
    } catch (e) {
      if (mounted) {
        Constants.showMessage(context, e.toString());
      }
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: loading
            ? const LoadingWidget()
            : filteredServices.isEmpty
                ? const Center(
                    child: Text("No Services Created Yet",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, bottom: 12, left: 16, right: 16),
                    child: ListView.builder(
                        itemCount: filteredServices.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              // onTap: () => goToDetails(filteredServices[index]),
                              child: SizedBox(
                                  height: 310,
                                  child: ServicesCard(
                                    show: true,
                                    filteredServices[index],
                                    providerShow: false,
                                  )));
                        }),
                  ));
  }
}
