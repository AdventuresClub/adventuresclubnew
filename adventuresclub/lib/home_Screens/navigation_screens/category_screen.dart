// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/details.dart';
import 'package:adventuresclub/models/filter_data_model/programs_model.dart';
import 'package:adventuresclub/models/home_services/become_partner.dart';
import 'package:adventuresclub/models/home_services/home_services_model.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/models/services/availability_model.dart';
import 'package:adventuresclub/models/services/dependencies_model.dart';
import 'package:adventuresclub/models/services/included_activities_model.dart';
import 'package:adventuresclub/models/services/service_image_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/services_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/services/create_services/availability_plan_model.dart';

class CategoryScreen extends StatefulWidget {
  final String type;
  const CategoryScreen(this.type, {super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool loading = false;
  List<ServicesModel> gm = [];
  List<ServicesModel> allServices = [];
  List<HomeServicesModel> gAllServices = [];
  List<BecomePartner> nBp = [];

  @override
  void initState() {
    super.initState();
    getServicesList(widget.type);
  }

  void goToDetails(ServicesModel gm) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return Details(gm: gm);
        },
      ),
    );
  }

  Future getServicesList(String type) async {
    setState(() {
      loading = true;
    });
    //gAllServices.clear();
    //getServicesListy1();
    var response = await http.post(
        Uri.parse(
            "https://adventuresclub.net/adventureClub/api/v1/get_allservices"),
        body: {
          "country_id": Constants.countryId.toString(), //id,
        });
    if (response.statusCode == 200) {
      var getServicesMap = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = getServicesMap['data'];
      String acc = "";
      result.forEach((element) {
        if (element['category'] == type) {
          List<ServicesModel> all_Services = [];
          acc = element['category'].toString() ?? "";
          List<dynamic> s = element['services'];
          allServices.clear();
          s.forEach((services) {
            List<AvailabilityPlanModel> gAccomodationPlanModel = [];
            List<dynamic> availablePlan = services['availability'];
            availablePlan.forEach((ap) {
              AvailabilityPlanModel amPlan = AvailabilityPlanModel(
                  ap['id'].toString() ?? "", ap['day'].toString() ?? "");
              gAccomodationPlanModel.add(amPlan);
            });
            List<AvailabilityModel> gAccomodoationAvaiModel = [];
            List<dynamic> available = services['availability'];
            available.forEach((a) {
              AvailabilityModel am = AvailabilityModel(
                  a['start_date'].toString() ?? "",
                  a['end_date'].toString() ?? "");
              gAccomodoationAvaiModel.add(am);
            });
            List<dynamic> becomePartner = services['become_partner'];
            becomePartner.forEach((b) {
              BecomePartner bp = BecomePartner(
                  b['cr_name'].toString() ?? "",
                  b['cr_number'].toString() ?? "",
                  b['description'].toString() ?? "");
            });
            List<IncludedActivitiesModel> gIAm = [];
            List<dynamic> iActivities = services['included_activities'];
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
            List<dynamic> dependency = services['dependencies'];
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
            List<dynamic> aF = services['aimed_for'];
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
            List<dynamic> image = services['images'];
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
            List<dynamic> programs = services['programs'];
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
                DateTime.tryParse(services['start_date'].toString()) ??
                    DateTime.now();
            DateTime eDate =
                DateTime.tryParse(services['end_date'].toString()) ??
                    DateTime.now();
            List<ServicesModel> aS = [];
            ServicesModel nSm = ServicesModel(
              int.tryParse(services['id'].toString()) ?? 0,
              int.tryParse(services['owner'].toString()) ?? 0,
              services['adventure_name'].toString() ?? "",
              services['country'].toString() ?? "",
              services['region'].toString() ?? "",
              services['city_id'].toString() ?? "",
              services['service_sector'].toString() ?? "",
              services['service_category'].toString() ?? "",
              services['service_type'].toString() ?? "",
              services['service_level'].toString() ?? "",
              services['duration'].toString() ?? "",
              int.tryParse(services['available_seats'].toString()) ?? 0,
              sDate,
              eDate,
              services['latitude'].toString() ?? "",
              services['longitude'].toString() ?? "",
              services['write_information'].toString() ?? "",
              int.tryParse(services['service_plan'].toString()) ?? 0,
              int.tryParse(services['sfor_id'].toString()) ?? 0,
              gAccomodoationAvaiModel,
              gAccomodationPlanModel,
              services['geo_location'].toString() ?? "",
              services['specific_address'].toString() ?? "",
              services['cost_inc'].toString() ?? "",
              services['cost_exc'].toString() ?? "",
              services['currency'].toString() ?? "",
              int.tryParse(services['points'].toString()) ?? 0,
              services['pre_requisites'].toString() ?? "",
              services['minimum_requirements'].toString() ?? "",
              services['terms_conditions'].toString() ?? "",
              int.tryParse(services['recommended'].toString()) ?? 0,
              services['status'].toString() ?? "",
              services['image'].toString() ?? "",
              services['descreption]'].toString() ?? "",
              services['favourite_image'].toString() ?? "",
              services['created_at'].toString() ?? "",
              services['updated_at'].toString() ?? "",
              services['delete_at'].toString() ?? "",
              int.tryParse(services['provider_id'].toString()) ?? 0,
              int.tryParse(services['service_id'].toString()) ?? 0,
              services['provided_name'].toString() ?? "",
              services['provider_profile'].toString() ?? "",
              services['including_gerea_and_other_taxes'].toString() ?? "",
              services['excluding_gerea_and_other_taxes'].toString() ?? "",
              gIAm,
              gdM,
              nBp,
              gAccomodationAimedfm,
              gPm,
              services['stars'].toString() ?? "",
              int.tryParse(services['is_liked'].toString()) ?? 0,
              services['baseurl'].toString() ?? "",
              gAccomodationServImgModel,
              element['rating'].toString() ?? "",
              services['reviewd_by'].toString() ?? "",
              int.tryParse(services['remaining_seats'].toString()) ?? 0,
            );
            allServices.add(nSm);
            all_Services.add(nSm);
            HomeServicesModel adv = HomeServicesModel(acc, all_Services);
            gAllServices.add(adv);
          });
        }
        setState(() {
          loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: blackColor),
        title: MyText(
          text: "View Details",
          weight: FontWeight.bold,
          color: blackColor,
        ),
      ),
      body: loading
          ? Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  Text("Loading...")
                ],
              ),
            )
          : SingleChildScrollView(
              child: GridView.count(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 0.2,
                childAspectRatio: 0.88,
                crossAxisSpacing: 0.2,
                crossAxisCount: 2,
                children: List.generate(
                  gAllServices.length,
                  (index) {
                    return GestureDetector(
                      onTap: () => goToDetails(gAllServices[index].sm[index]),
                      child: ServicesCard(gAllServices[index].sm[index]),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
