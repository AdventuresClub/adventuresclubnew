// ignore_for_file: avoid_function_literals_in_foreach_calls, unused_local_variable, avoid_print

import 'dart:convert';
import 'package:app/constants_filter.dart';
import 'package:app/models/filter_data_model/category_filter_model.dart';
import 'package:app/models/filter_data_model/programs_model.dart';
import 'package:app/models/home_services/home_services_model.dart';
import 'package:app/models/home_services/services_model.dart';
import 'package:app/models/search_model.dart';
import 'package:app/models/services/aimed_for_model.dart';
import 'package:app/models/services/availability_model.dart';
import 'package:app/models/services/dependencies_model.dart';
import 'package:app/models/services/included_activities_model.dart';
import 'package:app/models/services/service_image_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/home_services/become_partner.dart';
import '../models/services/create_services/availability_plan_model.dart';

class ServicesProvider with ChangeNotifier {
  ServicesProvider({Key? key});
  bool loadingServices = false;

  List<String> categories = [];
  List<BecomePartner> nBp = [];
  List<BecomePartner> transportBp = [];
  List<BecomePartner> skyBp = [];
  List<BecomePartner> waterBp = [];
  List<BecomePartner> landBp = [];
  List<ServicesModel> gAccomodationSModel = [];
  List<ServicesModel> gTransportSModel = [];
  List<ServicesModel> gSkyServicesModel = [];
  List<ServicesModel> gWaterServicesModel = [];
  List<ServicesModel> gLandServicesModel = [];
  List<ServicesModel> allServices = [];
  List<ServicesModel> filterServices = [];
  List<ServicesModel> allAccomodation = [];
  List<ServicesModel> allTransport = [];
  List<ServicesModel> allSky = [];
  List<ServicesModel> allWater = [];
  List<ServicesModel> allLand = [];
  List<CategoryFilterModel> categoryFilter = [];
  List<HomeServicesModel> gAllServices = [];
  String search = "";
  List<HomeServicesModel> filteredServices = [];
  List<SearchModel> searchedList = [];
  List<HomeServicesModel> searchfilterServices = [];
  List<DependenciesModel> gdM = [];
  bool searchFilter = false;

  bool loading = false;

  // void setHomeIndex(int i) {
  //   homeIndex = i;
  //   notifyListeners();
  // }

  void setSearch(String x) {
    filteredServices.clear();
    if (x.isNotEmpty) {
      List<ServicesModel> filtered = allServices
          .where((element) =>
              element.adventureName.toLowerCase().contains(x.toLowerCase()))
          .toList();
      for (int i = 0; i < filtered.length; i++) {
        int index = filteredServices.indexWhere(
            (element) => element.category == filtered[i].serviceCategory);
        if (index == -1) {
          filteredServices.add(
              HomeServicesModel(filtered[i].serviceCategory, [filtered[i]]));
        } else {
          filteredServices[index].sm.add(filtered[i]);
        }
      }
    } else {
      filteredServices = [...gAllServices];
    }
    notifyListeners();
  }

  void getCategory(List<CategoryFilterModel> cm) {
    cm = categoryFilter;
  }

  void clearAll() {
    allAccomodation.clear();
    allTransport.clear();
    allSky.clear();
    allWater.clear();
    allLand.clear();
    nBp.clear();
    transportBp.clear();
    skyBp.clear();
    waterBp.clear();
    landBp.clear();
    gAccomodationSModel.clear();
    gTransportSModel.clear();
    gSkyServicesModel.clear();
    gWaterServicesModel.clear();
    gLandServicesModel.clear();
    allServices.clear();
    print(filterServices);
  }

  void changeState() {
    searchFilter = true;
  }

  Future getServicesList() async {
    //if ()
    if (loading) {
      return;
    }
    setFilteredServices([], true);
    //filteredServices.clear();
    allServices.clear();
    gAllServices.clear();
    var response = await http
        .post(Uri.parse("${Constants.baseUrl}/api/v1/get_allservices"), body: {
      "country_id": Constants.countryId.toString(), //id,
    });
    if (response.statusCode == 200) {
      var getServicesMap = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = getServicesMap['data'];
      String acc = "";
      result.forEach((element) {
        List<ServicesModel> all_Services = [];
        acc = element['category'] ?? "";
        categories.add(acc);
        List<dynamic> s = element['services'];
        s.forEach((services) {
          List<AvailabilityPlanModel> gAccomodationPlanModel = [];
          List<dynamic> availablePlan = services['availability'];
          availablePlan.forEach((ap) {
            AvailabilityPlanModel amPlan = AvailabilityPlanModel(
                int.tryParse(ap['id'].toString()) ?? 0,
                ap['day'].toString() ?? "");
            gAccomodationPlanModel.add(amPlan);
          });
          List<AvailabilityModel> gAccomodoationAvaiModel = [];
          List<dynamic> available = services['availability'];
          available.forEach((a) {
            AvailabilityModel am =
                AvailabilityModel(a['start_date'] ?? "", a['end_date'] ?? "");
            gAccomodoationAvaiModel.add(am);
          });
          List<dynamic> becomePartner = services['become_partner'];
          becomePartner.forEach((b) {
            BecomePartner bp = BecomePartner(b['cr_name'] ?? "",
                b['cr_number'] ?? "", b['description'] ?? "");
          });
          List<IncludedActivitiesModel> gIAm = [];
          List<dynamic> iActivities = services['included_activities'];
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
          List<DependenciesModel> gdM = [];
          List<dynamic> dependency = services['dependencies'];
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
          List<AimedForModel> gAccomodationAimedfm = [];
          List<dynamic> aF = services['aimed_for'];
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
          List<ServiceImageModel> gAccomodationServImgModel = [];
          List<dynamic> image = services['images'];
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
          List<ProgrammesModel> gPm = [];
          List<dynamic> programs = services['programs'];
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
          DateTime sDate =
              DateTime.tryParse(services['start_date'].toString()) ??
                  DateTime.now();
          DateTime eDate = DateTime.tryParse(services['end_date'].toString()) ??
              DateTime.now();
          List<ServicesModel> aS = [];
          ServicesModel nSm = ServicesModel(
            id: int.tryParse(services['id'].toString()) ?? 0,
            owner: int.tryParse(services['owner'].toString()) ?? 0,
            adventureName: services['adventure_name'] ?? "",
            country: services['country'] ?? "",
            region: services['region'] ?? "",
            cityId: services['city_id'] ?? "",
            serviceSector: services['service_sector'] ?? "",
            serviceCategory: services['service_category'] ?? "",
            serviceType: services['service_type'] ?? "",
            serviceLevel: services['service_level'] ?? "",
            duration: services['duration'].toString() ?? "",
            aSeats: int.tryParse(services['available_seats'].toString()) ?? 0,
            startDate: sDate,
            endDate: eDate,
            lat: services['latitude'] ?? "",
            lng: services['longitude'] ?? "",
            writeInformation: services['write_information'] ?? "",
            sPlan: int.tryParse(services['service_plan'].toString()) ?? 0,
            sForID: int.tryParse(services['sfor_id'].toString()) ?? 0,
            availability: gAccomodoationAvaiModel,
            availabilityPlan: gAccomodationPlanModel,
            geoLocation: services['geo_location'] ?? "",
            sAddress: services['specific_address'] ?? "",
            costInc: services['cost_inc'] ?? "",
            costExc: services['cost_exc'] ?? "",
            currency: services['currency'] ?? "",
            points: int.tryParse(services['points'].toString()) ?? 0,
            preRequisites: services['pre_requisites'] ?? "",
            mRequirements: services['minimum_requirements'] ?? "",
            tnc: services['terms_conditions'] ?? "",
            recommended: int.tryParse(services['recommended'].toString()) ?? 0,
            status: services['status'] ?? "",
            image: services['image'] ?? "",
            des: services['descreption]'] ?? "",
            fImage: services['favourite_image'] ?? "",
            ca: services['created_at'] ?? "",
            upda: services['updated_at'] ?? "",
            da: services['delete_at'] ?? "",
            providerId: int.tryParse(services['provider_id'].toString()) ?? 0,
            serviceId: int.tryParse(services['service_id'].toString()) ?? 0,
            pName: services['provided_name'] ?? "",
            pProfile: services['provider_profile'] ?? "",
            serviceCategoryImage: services['service_category_image'] ?? "",
            serviceSectorImage: services['service_sector_image'] ?? "",
            serviceTypeImage: services['service_type_image'] ?? "",
            serviceLevelImage: services['service_level_image'] ?? "",
            iaot: services['including_gerea_and_other_taxes'] ?? "",
            eaot: services['excluding_gerea_and_other_taxes'] ?? "",
            activityIncludes: gIAm,
            dependency: gdM,
            bp: nBp,
            am: gAccomodationAimedfm,
            programmes: gPm,
            stars: services['stars'].toString() ?? "",
            isLiked: int.tryParse(services['is_liked'].toString()) ?? 0,
            baseURL: services['baseurl'] ?? "",
            images: gAccomodationServImgModel,
            rating: services['rating'] ?? "",
            reviewdBy: services['reviewd_by'].toString() ?? "",
            remainingSeats:
                int.tryParse(services['remaining_seats'].toString()) ?? 0,
          );
          allServices.add(nSm);
          all_Services.add(nSm);
        });
        HomeServicesModel adv = HomeServicesModel(acc, all_Services);
        gAllServices.add(adv);
        List<String> serviceId = [];
        List<String> adventureName = [];
        all_Services.forEach((element) {
          serviceId.add(element.id.toString());
          adventureName.add(element.adventureName);
        });
        searchedList.add(SearchModel(acc, serviceId, adventureName));
      });
      setFilteredServices([...gAllServices], false);
      //filteredServices = [...gAllServices];

      //notifyListeners();
      // allServices.forEach((element) {
      //     gAllServices.add(element.serviceCategory, element);
      //   });
    }
    //loading = false;
  }

  // void getFilterList(
  //     String ccode,
  //     String minPrice,
  //     String maxPrice,
  //     String sId,
  //     String cId,
  //     String serviceType,
  //     String serviceLevel,
  //     String duration) async {
  //   var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //           '${Constants.baseUrl}Dev/api/v1/filterServices'));
  //   request.fields.addAll({
  //     'country_id': ccode, //'14',
  //     'min_price': minPrice, //'10',
  //     'max_price': maxPrice, //'100',
  //     'sector_id': sId, //'1',
  //     'category_id': cId, //'4',
  //     'service_type': serviceType, //'1',
  //     'service_level': serviceLevel, //'1',
  //     'duration': duration //'1'
  //   });
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {

  //     print(await response.stream.bytesToString());
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

  void getFilterList(
    String ccode,
    String minPrice,
    String maxPrice,
    String sId,
    String cId,
    String serviceType,
    String serviceLevel,
    String duration,
    String region,
    String aimedFor,
  ) async {
    setFilteredServices([], true);
    //filteredServices.clear();
    allServices.clear();
    gAllServices.clear();
    // dynamic body = {
    //   'country': ccode, //'14',
    //   'min_price': minPrice, //'10',
    //   'max_price': maxPrice, //'100',
    //   'region': region,
    //   'service_sector': sId, //'1',
    //   'category': cId, //'4',
    //   'service_type': serviceType, //'1',
    //   'duration': duration, //'1',
    //   'service_level': serviceLevel, //'1',
    //   'aimed_for': "",
    //   'provider_name': "",
    // };
    var response = await http
        .post(Uri.parse('${Constants.baseUrl}/api/v1/services_filter'), body: {
      'country': ccode,
      'min_price': minPrice,
      'max_price': maxPrice,
      'region': region,
      'service_sector': sId,
      'category': cId,
      'service_type': serviceType,
      'duration': duration,
      'service_level': serviceLevel,
      'aimed_for': aimedFor,
      'provider_name': "",
    });

    if (response.statusCode == 200) {
      loading = true;
      notifyListeners();
      var getServicesMap = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = getServicesMap['data'];
      String acc = "";
      result.forEach((element) {
        List<ServicesModel> all_Services = [];
        acc = element['category'] ?? "";
        categories.add(acc);
        List<dynamic> s = element['services'] ?? [];
        s.forEach((services) {
          List<AvailabilityPlanModel> gAccomodationPlanModel = [];
          List<dynamic> availablePlan = services['availability'];
          availablePlan.forEach((ap) {
            AvailabilityPlanModel amPlan = AvailabilityPlanModel(
                int.tryParse(ap['id'].toString()) ?? 0,
                ap['day'].toString() ?? "");
            gAccomodationPlanModel.add(amPlan);
          });
          List<AvailabilityModel> gAccomodoationAvaiModel = [];
          List<dynamic> available = services['availability'];
          available.forEach((a) {
            AvailabilityModel am =
                AvailabilityModel(a['start_date'] ?? "", a['end_date'] ?? "");
            gAccomodoationAvaiModel.add(am);
          });
          List<dynamic> becomePartner = services['become_partner'];
          becomePartner.forEach((b) {
            BecomePartner bp = BecomePartner(b['cr_name'] ?? "",
                b['cr_number'] ?? "", b['description'] ?? "");
          });
          List<IncludedActivitiesModel> gIAm = [];
          List<dynamic> iActivities = services['included_activities'];
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
          List<DependenciesModel> gdM = [];
          List<dynamic> dependency = services['dependencies'];
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
          List<AimedForModel> gAccomodationAimedfm = [];
          List<dynamic> aF = services['aimed_for'];
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
          List<ServiceImageModel> gAccomodationServImgModel = [];
          List<dynamic> image = services['images'];
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
          List<ProgrammesModel> gPm = [];
          List<dynamic> programs = services['programs'];
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
          DateTime sDate =
              DateTime.tryParse(services['start_date'].toString()) ??
                  DateTime.now();
          DateTime eDate = DateTime.tryParse(services['end_date'].toString()) ??
              DateTime.now();
          List<ServicesModel> aS = [];
          ServicesModel nSm = ServicesModel(
            id: int.tryParse(services['id'].toString()) ?? 0,
            owner: int.tryParse(services['owner'].toString()) ?? 0,
            adventureName: services['adventure_name'] ?? "",
            country: services['country'] ?? "",
            region: services['region'] ?? "",
            cityId: services['city_id'] ?? "",
            serviceSector: services['service_sector'] ?? "",
            serviceCategory: services['service_category'] ?? "",
            serviceType: services['service_type'] ?? "",
            serviceLevel: services['service_level'] ?? "",
            duration: services['duration'] ?? "",
            aSeats: int.tryParse(services['available_seats'].toString()) ?? 0,
            startDate: sDate,
            endDate: eDate,
            lat: services['latitude'] ?? "",
            lng: services['longitude'] ?? "",
            writeInformation: services['write_information'] ?? "",
            sPlan: int.tryParse(services['service_plan'].toString()) ?? 0,
            sForID: int.tryParse(services['sfor_id'].toString()) ?? 0,
            availability: gAccomodoationAvaiModel,
            availabilityPlan: gAccomodationPlanModel,
            geoLocation: services['geo_location'] ?? "",
            sAddress: services['specific_address'] ?? "",
            costInc: services['cost_inc'] ?? "",
            costExc: services['cost_exc'] ?? "",
            currency: services['currency'] ?? "",
            points: int.tryParse(services['points'].toString()) ?? 0,
            preRequisites: services['pre_requisites'] ?? "",
            mRequirements: services['minimum_requirements'] ?? "",
            tnc: services['terms_conditions'] ?? "",
            recommended: int.tryParse(services['recommended'].toString()) ?? 0,
            status: services['status'] ?? "",
            image: services['image'] ?? "",
            des: services['descreption]'] ?? "",
            fImage: services['favourite_image'] ?? "",
            ca: services['created_at'] ?? "",
            upda: services['updated_at'] ?? "",
            da: services['delete_at'] ?? "",
            providerId: int.tryParse(services['provider_id'].toString()) ?? 0,
            serviceId: int.tryParse(services['service_id'].toString()) ?? 0,
            pName: services['provided_name'] ?? "",
            pProfile: services['provider_profile'] ?? "",
            serviceCategoryImage: services['service_category_image'] ?? "",
            serviceSectorImage: services['service_sector_image'] ?? "",
            serviceTypeImage: services['service_type_image'] ?? "",
            serviceLevelImage: services['service_level_image'] ?? "",
            iaot: services['including_gerea_and_other_taxes'] ?? "",
            eaot: services['excluding_gerea_and_other_taxes'] ?? "",
            activityIncludes: gIAm,
            dependency: gdM,
            bp: nBp,
            am: gAccomodationAimedfm,
            programmes: gPm,
            stars: services['stars'].toString() ?? "",
            isLiked: int.tryParse(services['is_liked'].toString()) ?? 0,
            baseURL: services['baseurl'] ?? "",
            images: gAccomodationServImgModel,
            rating: services['rating'] ?? "",
            reviewdBy: services['reviewd_by'].toString() ?? "",
            remainingSeats:
                int.tryParse(services['remaining_seats'].toString()) ?? 0,
          );
          allServices.add(nSm);
          all_Services.add(nSm);
        });
        HomeServicesModel adv = HomeServicesModel(acc, all_Services);
        gAllServices.add(adv);
        List<String> serviceId = [];
        List<String> adventureName = [];
        all_Services.forEach((element) {
          serviceId.add(element.id.toString());
          adventureName.add(element.adventureName);
        });
        searchedList.add(SearchModel(acc, serviceId, adventureName));
      });
      //filteredServices = [...gAllServices];
      setFilteredServices([...gAllServices], false);
      debugPrint("test_${filteredServices.length}***");

      //notifyListeners();
      //clearData();
      // allServices.forEach((element) {
      //     gAllServices.add(element.serviceCategory, element);
      //   });
    }
    //loading = false;
  }

  void setLoading(bool status) {
    loading = status;
    notifyListeners();
  }

  void setFilteredServices(
      List<HomeServicesModel> services, bool loadingStatus) {
    loading = loadingStatus;
    filteredServices = services;
    notifyListeners();
  }

  void clearData() {
    ConstantsFilter.sectorId = "0";
    ConstantsFilter.categoryId = "0";
    ConstantsFilter.typeId = "0";
    ConstantsFilter.levelId = "0";
    ConstantsFilter.durationId = "0";
    ConstantsFilter.regionId = "0";
  }

  Future<void> g() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('${Constants.baseUrl}/api/v1/filterServices'));
    request.body =
        '''{\r\n    "country_id": 14,\r\n    "min_price": 0,\r\n    "max_price": 1000,\r\n    "sector_id": 3,\r\n    "category_id": 7,\r\n    "service_type": 2,\r\n    "service_level": 2,\r\n    "duration": 3\r\n}''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
  }

  // void getFilteredList() async {
  //   filteredServices.clear();
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             "${Constants.baseUrl}/api/v1/services_filter"),
  //         body: {
  //           "category": "",
  //           "country": Constants.countryId.toString(),
  //           "provider_name": "",
  //           "region": "",
  //           "service_type": "",
  //           "level": "",
  //           "duration": "",
  //           "activity_id": "",
  //           "aimed": "",
  //         });
  //     var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  //     List<dynamic> rm = decodedResponse['data'];
  //     if (response.statusCode == 200) {
  //       var getServicesMap = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  //       List<dynamic> result = getServicesMap['data'];
  //       String acc = "";
  //       result.forEach((element) {
  //         List<AvailabilityPlanModel> gAccomodationPlanModel = [];
  //         List<AvailabilityModel> gAccomodoationAvaiModel = [];
  //         List<ServicesModel> filter_Services = [];
  //         acc = element['category'].toString() ?? "";
  //         categories.add(acc);
  //         if (element['service_plan'] == 1) {
  //           List<dynamic> availablePlan = element['availability'];
  //           availablePlan.forEach((ap) {
  //             AvailabilityPlanModel amPlan = AvailabilityPlanModel(
  //                 ap['id'].toString() ?? "", ap['day'].toString() ?? "");
  //             gAccomodationPlanModel.add(amPlan);
  //           });
  //         } else {
  //           List<dynamic> available = element['availability'];
  //           available.forEach((a) {
  //             AvailabilityModel am = AvailabilityModel(
  //                 a['start_date'].toString() ?? "",
  //                 a['end_date'].toString() ?? "");
  //             gAccomodoationAvaiModel.add(am);
  //           });
  //         }
  //         List<dynamic> becomePartner = element['become_partner'];
  //         becomePartner.forEach((b) {
  //           BecomePartner bp = BecomePartner(
  //               b['cr_name'].toString() ?? "",
  //               b['cr_number'].toString() ?? "",
  //               b['description'].toString() ?? "");
  //         });
  //         List<IncludedActivitiesModel> gIAm = [];
  //         if (element['included_activities'] != null) {
  //           List<dynamic> iActivities = element['included_activities'];
  //           iActivities.forEach((iA) {
  //             IncludedActivitiesModel iAm = IncludedActivitiesModel(
  //               int.tryParse(iA['id'].toString()) ?? 0,
  //               int.tryParse(iA['service_id'].toString()) ?? 0,
  //               iA['activity_id'].toString() ?? "",
  //               iA['activity'].toString() ?? "",
  //               iA['image'].toString() ?? "",
  //             );
  //             gIAm.add(iAm);
  //           });
  //         }
  //         //List<DependenciesModel> gdM = [];
  //         // List<dynamic> dependency = element['dependencies'];
  //         // dependency.forEach((d) {
  //         //   DependenciesModel dm = DependenciesModel(
  //         //     int.tryParse(d['id'].toString()) ?? 0,
  //         //     d['dependency_name'].toString() ?? "",
  //         //     d['image'].toString() ?? "",
  //         //     d['updated_at'].toString() ?? "",
  //         //     d['created_at'].toString() ?? "",
  //         //     d['deleted_at'].toString() ?? "",
  //         //   );
  //         //   gdM.add(dm);
  //         // });
  //         List<AimedForModel> gAccomodationAimedfm = [];
  //         List<dynamic> aF = element['aimed_for'];
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
  //           gAccomodationAimedfm.add(afm);
  //         });
  //         List<ServiceImageModel> gAccomodationServImgModel = [];
  //         List<dynamic> image = element['images'];
  //         image.forEach((i) {
  //           ServiceImageModel sm = ServiceImageModel(
  //             int.tryParse(i['id'].toString()) ?? 0,
  //             int.tryParse(i['service_id'].toString()) ?? 0,
  //             int.tryParse(i['is_default'].toString()) ?? 0,
  //             i['image_url'].toString() ?? "",
  //             i['thumbnail'].toString() ?? "",
  //           );
  //           gAccomodationServImgModel.add(sm);
  //         });
  //         List<ProgrammesModel> gPm = [];
  //         List<dynamic> programs = element['programs'];
  //         programs.forEach((p) {
  //           ProgrammesModel pm = ProgrammesModel(
  //             int.tryParse(p['id'].toString()) ?? 0,
  //             int.tryParse(p['service_id'].toString()) ?? 0,
  //             p['title'].toString() ?? "",
  //             p['start_datetime'].toString() ?? "",
  //             p['end_datetime'].toString() ?? "",
  //             p['description'].toString() ?? "",
  //           );
  //           gPm.add(pm);
  //         });
  //         DateTime sDate =
  //             DateTime.tryParse(element['start_date'].toString()) ??
  //                 DateTime.now();
  //         DateTime eDate = DateTime.tryParse(element['end_date'].toString()) ??
  //             DateTime.now();
  //         List<ServicesModel> aS = [];
  //         ServicesModel nSm = ServicesModel(
  //           int.tryParse(element['id'].toString()) ?? 0,
  //           int.tryParse(element['owner'].toString()) ?? 0,
  //           element['adventure_name'].toString() ?? "",
  //           element['country'].toString() ?? "",
  //           element['region'].toString() ?? "",
  //           element['city_id'].toString() ?? "",
  //           element['service_sector'].toString() ?? "",
  //           element['service_category'].toString() ?? "",
  //           element['service_type'].toString() ?? "",
  //           element['service_level'].toString() ?? "",
  //           element['duration'].toString() ?? "",
  //           int.tryParse(element['available_seats'].toString()) ?? 0,
  //           sDate,
  //           eDate,
  //           element['latitude'].toString() ?? "",
  //           element['longitude'].toString() ?? "",
  //           element['write_information'].toString() ?? "",
  //           int.tryParse(element['service_plan'].toString()) ?? 0,
  //           int.tryParse(element['sfor_id'].toString()) ?? 0,
  //           gAccomodoationAvaiModel,
  //           gAccomodationPlanModel,
  //           element['geo_location'].toString() ?? "",
  //           element['specific_address'].toString() ?? "",
  //           element['cost_inc'].toString() ?? "",
  //           element['cost_exc'].toString() ?? "",
  //           element['currency'].toString() ?? "",
  //           int.tryParse(element['points'].toString()) ?? 0,
  //           element['pre_requisites'].toString() ?? "",
  //           element['minimum_requirements'].toString() ?? "",
  //           element['terms_conditions'].toString() ?? "",
  //           int.tryParse(element['recommended'].toString()) ?? 0,
  //           element['status'].toString() ?? "",
  //           element['image'].toString() ?? "",
  //           element['descreption]'].toString() ?? "",
  //           element['favourite_image'].toString() ?? "",
  //           element['created_at'].toString() ?? "",
  //           element['updated_at'].toString() ?? "",
  //           element['delete_at'].toString() ?? "",
  //           int.tryParse(element['provider_id'].toString()) ?? 0,
  //           int.tryParse(element['service_id'].toString()) ?? 0,
  //           element['provided_name'].toString() ?? "",
  //           element['provider_profile'].toString() ?? "",
  //           element['including_gerea_and_other_taxes'].toString() ?? "",
  //           element['excluding_gerea_and_other_taxes'].toString() ?? "",
  //           gIAm,
  //           gdM,
  //           nBp,
  //           gAccomodationAimedfm,
  //           gPm,
  //           element['stars'].toString() ?? "",
  //           int.tryParse(element['is_liked'].toString()) ?? 0,
  //           element['baseurl'].toString() ?? "",
  //           gAccomodationServImgModel,
  //           element['rating'].toString() ?? "",
  //           element['reviewd_by'].toString() ?? "",
  //           int.tryParse(element['remaining_seats'].toString()) ?? 0,
  //         );
  //         filterServices.add(nSm);
  //         filter_Services.add(nSm);
  //         HomeServicesModel adv = HomeServicesModel(acc, filter_Services);
  //         searchfilterServices.add(adv);
  //       });
  //       filteredServices = [...searchfilterServices];
  //       notifyListeners();
  //       // allServices.forEach((element) {
  //       //     gAllServices.add(element.serviceCategory, element);
  //       //   });
  //     }
  //     print(response.statusCode);
  //     print(response.body);
  //     print(response.headers);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // void getFilterList() async {
  //   var headers = {'Content-Type': 'application/json'};
  //   var request = http.Request(
  //       'POST',
  //       Uri.parse(
  //           '${Constants.baseUrl}/api/v1/filterServices'));
  //   request.body =
  //       '''{\r\n    "country_id": 14,\r\n    "min_price": 0,\r\n    "max_price": 1000,\r\n    "sector_id": 3,\r\n    "category_id": 7,\r\n    "service_type": 2,\r\n    "service_level": 2,\r\n    "duration": 3\r\n}''';
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     // var getServicesMap = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  //     print(await response.stream.bytesToString());
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

  Future getServicesListy1() async {
    var response = await http
        .post(Uri.parse("${Constants.baseUrl}/api/v1/get_allservices"), body: {
      "country_id": Constants.countryId.toString(), //id,
    });
    if (response.statusCode == 200) {
      var getServicesMap = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = getServicesMap['data'];
      result.forEach((element) {
        if (element['category'] == "Accomodation") {
          String acc = element['category'] ?? "";
          List<dynamic> s = element['services'];
          s.forEach((services) {
            List<AvailabilityPlanModel> gAccomodationPlanModel = [];
            List<dynamic> availablePlan = services['availability'];
            availablePlan.forEach((ap) {
              AvailabilityPlanModel amPlan =
                  AvailabilityPlanModel(ap['id'] ?? "", ap['day'] ?? "");
              gAccomodationPlanModel.add(amPlan);
            });
            List<AvailabilityModel> gAccomodoationAvaiModel = [];
            List<dynamic> available = services['availability'];
            available.forEach((a) {
              AvailabilityModel am =
                  AvailabilityModel(a['start_date'] ?? "", a['end_date'] ?? "");
              gAccomodoationAvaiModel.add(am);
            });
            List<dynamic> becomePartner = services['become_partner'];
            becomePartner.forEach((b) {
              BecomePartner bp = BecomePartner(b['cr_name'] ?? "",
                  b['cr_number'] ?? "", b['description'] ?? "");
            });
            List<IncludedActivitiesModel> gIAm = [];
            List<dynamic> iActivities = services['included_activities'];
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
            List<DependenciesModel> gdM = [];
            List<dynamic> dependency = services['dependencies'];
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
            List<AimedForModel> gAccomodationAimedfm = [];
            List<dynamic> aF = services['aimed_for'];
            aF.forEach((a) {
              AimedForModel afm = AimedForModel(
                int.tryParse(a['id'].toString()) ?? 0,
                a['AimedName'].toString() ?? "",
                a['image'] ?? "",
                a['created_at'] ?? "",
                a['updated_at'] ?? "",
                a['deleted_at'] ?? "",
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
                i['image_url'] ?? "",
                i['thumbnail'] ?? "",
              );
              gAccomodationServImgModel.add(sm);
            });
            List<ProgrammesModel> gPm = [];
            List<dynamic> programs = services['programs'];
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
            DateTime sDate =
                DateTime.tryParse(services['start_date'].toString()) ??
                    DateTime.now();
            DateTime eDate =
                DateTime.tryParse(services['end_date'].toString()) ??
                    DateTime.now();
            ServicesModel nSm = ServicesModel(
              id: int.tryParse(services['id'].toString()) ?? 0,
              owner: int.tryParse(services['owner'].toString()) ?? 0,
              adventureName: services['adventure_name'] ?? "",
              country: services['country'] ?? "",
              region: services['region'] ?? "",
              cityId: services['city_id'] ?? "",
              serviceSector: services['service_sector'] ?? "",
              serviceCategory: services['service_category'] ?? "",
              serviceType: services['service_type'] ?? "",
              serviceLevel: services['service_level'] ?? "",
              duration: services['duration'] ?? "",
              aSeats: int.tryParse(services['available_seats'].toString()) ?? 0,
              startDate: sDate,
              endDate: eDate,
              //int.tryParse(services['start_date'].toString()) ?? "",
              //int.tryParse(services['end_date'].toString()) ?? "",
              lat: services['latitude'] ?? "",
              lng: services['longitude'] ?? "",
              writeInformation: services['write_information'] ?? "",
              sPlan: int.tryParse(services['service_plan'].toString()) ?? 0,
              sForID: int.tryParse(services['sfor_id'].toString()) ?? 0,
              availability: gAccomodoationAvaiModel,
              availabilityPlan: gAccomodationPlanModel,
              geoLocation: services['geo_location'] ?? "",
              sAddress: services['specific_address'] ?? "",
              costInc: services['cost_inc'] ?? "",
              costExc: services['cost_exc'] ?? "",
              currency: services['currency'] ?? "",
              points: int.tryParse(services['points'].toString()) ?? 0,
              preRequisites: services['pre_requisites'] ?? "",
              mRequirements: services['minimum_requirements'] ?? "",
              tnc: services['terms_conditions'] ?? "",
              recommended:
                  int.tryParse(services['recommended'].toString()) ?? 0,
              status: services['status'] ?? "",
              image: services['image'] ?? "",
              des: services['descreption]'] ?? "",
              fImage: services['favourite_image'] ?? "",
              ca: services['created_at'] ?? "",
              upda: services['updated_at'] ?? "",
              da: services['delete_at'] ?? "",
              providerId: int.tryParse(services['provider_id'].toString()) ?? 0,
              serviceId: int.tryParse(services['service_id'].toString()) ?? 0,
              pName: services['provided_name'] ?? "",
              pProfile: services['provider_profile'] ?? "",
              serviceCategoryImage: services['service_category_image'] ?? "",
              serviceSectorImage: services['service_sector_image'] ?? "",
              serviceTypeImage: services['service_type_image'] ?? "",
              serviceLevelImage: services['service_level_image'] ?? "",
              iaot: services['including_gerea_and_other_taxes'] ?? "",
              eaot: services['excluding_gerea_and_other_taxes'] ?? "",
              activityIncludes: gIAm,
              dependency: gdM,
              bp: nBp,
              am: gAccomodationAimedfm,
              programmes: gPm,
              stars: services['stars'] ?? "",
              isLiked: int.tryParse(services['is_liked'].toString()) ?? 0,
              baseURL: services['baseurl'] ?? "",
              images: gAccomodationServImgModel,
              rating: services['rating'] ?? "",
              reviewdBy: services['reviewd_by'].toString() ?? "",
              remainingSeats:
                  int.tryParse(services['remaining_seats'].toString()) ?? 0,
            );
            //gAccomodationSModel.add(nSm);
            allServices.add(nSm);
            allAccomodation.add(nSm);
          });
          HomeServicesModel adv = HomeServicesModel(acc, gAccomodationSModel);
          gAllServices.add(adv);
          // accomodation.add(adv);
          // accomodation.forEach((acco) {
          //   gm.add(acco);
          // });
        } else if (element['category'] == "Transport") {
          String acc = element['category'].toString() ?? "";
          List<dynamic> t = element['services'];
          t.forEach((tServices) {
            List<AvailabilityPlanModel> gTransportPlanModel = [];
            List<dynamic> availablePlan = tServices['availability'];
            availablePlan.forEach((ap) {
              AvailabilityPlanModel tPlan =
                  AvailabilityPlanModel(ap['id'] ?? "", ap['day'] ?? "");
              gTransportPlanModel.add(tPlan);
            });
            List<AvailabilityModel> gTransportAvaiModel = [];
            List<dynamic> tAvailable = tServices['availability'];
            tAvailable.forEach((aS) {
              AvailabilityModel tAM = AvailabilityModel(
                  aS['start_date'] ?? "", aS['end_date'] ?? "");
              gTransportAvaiModel.add(tAM);
            });
            List<dynamic> tBecomePartner = tServices['become_partner'];
            tBecomePartner.forEach((bS) {
              BecomePartner transportBp = BecomePartner(bS['cr_name'] ?? "",
                  bS['cr_number'] ?? "", bS['description'] ?? "");
            });
            List<IncludedActivitiesModel> gIAm = [];
            List<dynamic> iActivities = tServices['included_activities'];
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
            List<DependenciesModel> gdM = [];
            List<dynamic> dependency = tServices['dependencies'];
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
            List<AimedForModel> gTransportAimedfm = [];
            List<dynamic> tAimedFor = tServices['aimed_for'];
            tAimedFor.forEach((atransport) {
              AimedForModel transportAimed = AimedForModel(
                int.tryParse(atransport['id'].toString()) ?? 0,
                atransport['AimedName'].toString() ?? "",
                atransport['image'].toString() ?? "",
                atransport['created_at'].toString() ?? "",
                atransport['updated_at'].toString() ?? "",
                atransport['deleted_at'].toString() ?? "",
                int.tryParse(atransport['service_id'].toString()) ?? 0,
              );
              gTransportAimedfm.add(transportAimed);
            });
            List<ServiceImageModel> gTransportServImgModel = [];
            List<dynamic> timage = tServices['images'];
            timage.forEach((ti) {
              ServiceImageModel transportServiceImage = ServiceImageModel(
                int.tryParse(ti['id'].toString()) ?? 0,
                int.tryParse(ti['service_id'].toString()) ?? 0,
                int.tryParse(ti['is_default'].toString()) ?? 0,
                ti['image_url'].toString() ?? "",
                ti['thumbnail'].toString() ?? "",
              );
              gTransportServImgModel.add(transportServiceImage);
            });
            List<ProgrammesModel> gPm = [];
            List<dynamic> programs = tServices['programs'];
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
                DateTime.tryParse(tServices['start_date'].toString()) ??
                    DateTime.now();
            DateTime eDate =
                DateTime.tryParse(tServices['end_date'].toString()) ??
                    DateTime.now();
            ServicesModel tServicesModelList = ServicesModel(
              id: int.tryParse(tServices['id'].toString()) ?? 0,
              owner: int.tryParse(tServices['owner'].toString()) ?? 0,
              adventureName: tServices['adventure_name'].toString() ?? "",
              country: tServices['country'].toString() ?? "",
              region: tServices['region'].toString() ?? "",
              cityId: tServices['city_id'].toString() ?? "",
              serviceSector: tServices['service_sector'].toString() ?? "",
              serviceCategory: tServices['service_category'].toString() ?? "",
              serviceType: tServices['service_type'].toString() ?? "",
              serviceLevel: tServices['service_level'].toString() ?? "",
              duration: tServices['duration'] ?? "",
              aSeats:
                  int.tryParse(tServices['availability_seats'].toString()) ?? 0,
              startDate: sDate,
              endDate: eDate,
              lat: tServices['latitude'].toString() ?? "",
              lng: tServices['longitude'].toString() ?? "",
              writeInformation: tServices['write_information'].toString() ?? "",
              sPlan: int.tryParse(tServices['service_plan'].toString()) ?? 0,
              sForID: int.tryParse(tServices['sfor_id'].toString()) ?? 0,
              availability: gTransportAvaiModel,
              availabilityPlan: gTransportPlanModel,
              geoLocation: tServices['geo_location'].toString() ?? "",
              sAddress: tServices['specific_address'].toString() ?? "",
              costInc: tServices['cost_inc'].toString() ?? "",
              costExc: tServices['cost_exc'].toString() ?? "",
              currency: tServices['currency'].toString() ?? "",
              points: int.tryParse(tServices['points'].toString()) ?? 0,
              preRequisites: tServices['pre_requisites'].toString() ?? "",
              mRequirements: tServices['minimum_requirements'].toString() ?? "",
              tnc: tServices['terms_conditions'].toString() ?? "",
              recommended:
                  int.tryParse(tServices['recommended'].toString()) ?? 0,
              status: tServices['status'].toString() ?? "",
              image: tServices['image'].toString() ?? "",
              des: tServices['descreption]'].toString() ?? "",
              fImage: tServices['favourite_image'].toString() ?? "",
              ca: tServices['created_at'].toString() ?? "",
              upda: tServices['updated_at'].toString() ?? "",
              da: tServices['delete_at'].toString() ?? "",
              providerId:
                  int.tryParse(tServices['provider_id'].toString()) ?? 0,
              serviceId: int.tryParse(tServices['service_id'].toString()) ?? 0,
              pName: tServices['provided_name'].toString() ?? "",
              pProfile: tServices['provider_profile'].toString() ?? "",
              serviceCategoryImage: tServices['service_category_image'] ?? "",
              serviceSectorImage: tServices['service_sector_image'] ?? "",
              serviceTypeImage: tServices['service_type_image'] ?? "",
              serviceLevelImage: tServices['service_level_image'] ?? "",
              iaot:
                  tServices['including_gerea_and_other_taxes'].toString() ?? "",
              eaot:
                  tServices['excluding_gerea_and_other_taxes'].toString() ?? "",
              activityIncludes: gIAm,
              dependency: gdM,
              bp: transportBp,
              am: gTransportAimedfm,
              programmes: gPm,
              stars: tServices['stars'].toString() ?? "",
              isLiked: int.tryParse(tServices['is_liked'].toString()) ?? 0,
              baseURL: tServices['baseurl'].toString() ?? "",
              images: gTransportServImgModel,
              rating: tServices['rating'].toString() ?? "",
              reviewdBy: tServices['reviewd_by'].toString() ?? "",
              remainingSeats:
                  int.tryParse(tServices['remaining_seats'].toString()) ?? 0,
            );
            //gTransportSModel.add(tServicesModelList);
            allServices.add(tServicesModelList);
            allTransport.add(tServicesModelList);
          });
          HomeServicesModel transportList =
              HomeServicesModel(acc, gTransportSModel);
          gAllServices.add(transportList);
          //transport.add(transportList);
          // transport.forEach((trans) {
          //   gm.add(trans);
          // });
        } else if (element['category'] == "Sky") {
          String acc = element['category'].toString() ?? "";
          List<dynamic> skyList = element['services'];
          skyList.forEach((skyServices) {
            List<AvailabilityPlanModel> gSkyPlanModel = [];
            List<dynamic> availablePlan = skyServices['availability'];
            availablePlan.forEach((ap) {
              AvailabilityPlanModel skyPlan = AvailabilityPlanModel(
                  int.tryParse(ap['id'].toString()) ?? 0,
                  ap['day'].toString() ?? "");
              gSkyPlanModel.add(skyPlan);
            });
            List<AvailabilityModel> gSkyAvaiModel = [];
            List<dynamic> tAvailable = skyServices['availability'];
            tAvailable.forEach((skyAvailable) {
              AvailabilityModel tAM = AvailabilityModel(
                  skyAvailable['start_date'].toString() ?? "",
                  skyAvailable['end_date'].toString() ?? "");
              gSkyAvaiModel.add(tAM);
            });
            List<dynamic> skyBecomePartnerList = skyServices['become_partner'];
            skyBecomePartnerList.forEach((skyBecomePartner) {
              BecomePartner skyBp = BecomePartner(
                  skyBecomePartner['cr_name'].toString() ?? "",
                  skyBecomePartner['cr_number'].toString() ?? "",
                  skyBecomePartner['description'].toString() ?? "");
            });
            List<IncludedActivitiesModel> gIAm = [];
            List<dynamic> iActivities = skyServices['included_activities'];
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
            List<dynamic> dependency = skyServices['dependencies'];
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
            List<AimedForModel> gSkyAimedfm = [];
            List<dynamic> skyAimedForList = skyServices['aimed_for'];
            skyAimedForList.forEach((skyAimedFor) {
              AimedForModel skyAimed = AimedForModel(
                int.tryParse(skyAimedFor['id'].toString()) ?? 0,
                skyAimedFor['AimedName'].toString() ?? "",
                skyAimedFor['image'].toString() ?? "",
                skyAimedFor['created_at'].toString() ?? "",
                skyAimedFor['updated_at'].toString() ?? "",
                skyAimedFor['deleted_at'].toString() ?? "",
                int.tryParse(skyAimedFor['service_id'].toString()) ?? 0,
              );
              gSkyAimedfm.add(skyAimed);
            });
            List<ServiceImageModel> gSkyServImgModel = [];
            List<dynamic> skyImages = skyServices['images'];
            skyImages.forEach((skyImages) {
              ServiceImageModel skyServiceImage = ServiceImageModel(
                int.tryParse(skyImages['id'].toString()) ?? 0,
                int.tryParse(skyImages['service_id'].toString()) ?? 0,
                int.tryParse(skyImages['is_default'].toString()) ?? 0,
                skyImages['image_url'].toString() ?? "",
                skyImages['thumbnail'].toString() ?? "",
              );
              gSkyServImgModel.add(skyServiceImage);
            });
            List<ProgrammesModel> gPm = [];
            List<dynamic> programs = skyServices['programs'];
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
                DateTime.tryParse(skyServices['start_date'].toString()) ??
                    DateTime.now();
            DateTime eDate =
                DateTime.tryParse(skyServices['end_date'].toString()) ??
                    DateTime.now();
            ServicesModel skyServicesModelList = ServicesModel(
              id: int.tryParse(skyServices['id'].toString()) ?? 0,
              owner: int.tryParse(skyServices['owner'].toString()) ?? 0,
              adventureName: skyServices['adventure_name'].toString() ?? "",
              country: skyServices['country'].toString() ?? "",
              region: skyServices['region'].toString() ?? "",
              cityId: skyServices['city_id'].toString() ?? "",
              serviceSector: skyServices['service_sector'].toString() ?? "",
              serviceCategory: skyServices['service_category'].toString() ?? "",
              serviceType: skyServices['service_type'].toString() ?? "",
              serviceLevel: skyServices['service_level'].toString() ?? "",
              duration: skyServices['duration'] ?? "",
              aSeats:
                  int.tryParse(skyServices['availability_seats'].toString()) ??
                      0,
              startDate: sDate,
              endDate: eDate,
              lat: skyServices['latitude'].toString() ?? "",
              lng: skyServices['longitude'].toString() ?? "",
              writeInformation:
                  skyServices['write_information'].toString() ?? "",
              sPlan: int.tryParse(skyServices['service_plan'].toString()) ?? 0,
              sForID: int.tryParse(skyServices['sfor_id'].toString()) ?? 0,
              availability: gSkyAvaiModel,
              availabilityPlan: gSkyPlanModel,
              geoLocation: skyServices['geo_location'].toString() ?? "",
              sAddress: skyServices['specific_address'].toString() ?? "",
              costInc: skyServices['cost_inc'].toString() ?? "",
              costExc: skyServices['cost_exc'].toString() ?? "",
              currency: skyServices['currency'].toString() ?? "",
              points: int.tryParse(skyServices['points'].toString()) ?? 0,
              preRequisites: skyServices['pre_requisites'].toString() ?? "",
              mRequirements:
                  skyServices['minimum_requirements'].toString() ?? "",
              tnc: skyServices['terms_conditions'].toString() ?? "",
              recommended:
                  int.tryParse(skyServices['recommended'].toString()) ?? 0,
              status: skyServices['status'].toString() ?? "",
              image: skyServices['image'].toString() ?? "",
              des: skyServices['descreption]'].toString() ?? "",
              fImage: skyServices['favourite_image'].toString() ?? "",
              ca: skyServices['created_at'].toString() ?? "",
              upda: skyServices['updated_at'].toString() ?? "",
              da: skyServices['delete_at'].toString() ?? "",
              providerId:
                  int.tryParse(skyServices['provider_id'].toString()) ?? 0,
              serviceId:
                  int.tryParse(skyServices['service_id'].toString()) ?? 0,
              pName: skyServices['provided_name'].toString() ?? "",
              pProfile: skyServices['provider_profile'].toString() ?? "",
              serviceCategoryImage: skyServices['service_category_image'] ?? "",
              serviceSectorImage: skyServices['service_sector_image'] ?? "",
              serviceTypeImage: skyServices['service_type_image'] ?? "",
              serviceLevelImage: skyServices['service_level_image'] ?? "",
              iaot: skyServices['including_gerea_and_other_taxes'].toString() ??
                  "",
              eaot: skyServices['excluding_gerea_and_other_taxes'].toString() ??
                  "",
              activityIncludes: gIAm,
              dependency: gdM,
              bp: skyBp,
              am: gSkyAimedfm,
              programmes: gPm,
              stars: skyServices['stars'].toString() ?? "",
              isLiked: int.tryParse(skyServices['is_liked'].toString()) ?? 0,
              baseURL: skyServices['baseurl'].toString() ?? "",
              images: gSkyServImgModel,
              rating: skyServices['rating'].toString() ?? "",
              reviewdBy: skyServices['reviewd_by'].toString() ?? "",
              remainingSeats:
                  int.tryParse(skyServices['remaining_seats'].toString()) ?? 0,
            );
            // gSkyServicesModel.add(skyServicesModelList);
            allServices.add(skyServicesModelList);
            allSky.add(skyServicesModelList);
          });
          HomeServicesModel skyListHome =
              HomeServicesModel(acc, gSkyServicesModel);
          gAllServices.add(skyListHome);
        } else if (element['category'] == "Water") {
          String acc = element['category'].toString() ?? "";
          List<dynamic> waterList = element['services'];
          waterList.forEach((waterServices) {
            List<AvailabilityPlanModel> gWaterPlanModel = [];
            List<dynamic> availablePlan = waterServices['availability'];
            availablePlan.forEach((ap) {
              AvailabilityPlanModel waterPlan = AvailabilityPlanModel(
                  int.tryParse(ap['id'].toString()) ?? 0,
                  ap['day'].toString() ?? "");
              gWaterPlanModel.add(waterPlan);
            });
            List<AvailabilityModel> gWaterAvaiModel = [];
            List<dynamic> wAvailable = waterServices['availability'];
            wAvailable.forEach((waterAvailable) {
              AvailabilityModel wAM = AvailabilityModel(
                  waterAvailable['start_date'].toString() ?? "",
                  waterAvailable['end_date'].toString() ?? "");
              gWaterAvaiModel.add(wAM);
            });
            List<dynamic> waterBecomePartnerList =
                waterServices['become_partner'];
            waterBecomePartnerList.forEach((waterBecomePartner) {
              BecomePartner waterBp = BecomePartner(
                  waterBecomePartner['cr_name'].toString() ?? "",
                  waterBecomePartner['cr_number'].toString() ?? "",
                  waterBecomePartner['description'].toString() ?? "");
            });
            List<IncludedActivitiesModel> gIAm = [];
            List<dynamic> iActivities = waterServices['included_activities'];
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
            List<dynamic> dependency = waterServices['dependencies'];
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
            List<AimedForModel> gWaterAimedfm = [];
            List<dynamic> waterAimedForList = waterServices['aimed_for'];
            waterAimedForList.forEach((waterAimedFor) {
              AimedForModel waterAimed = AimedForModel(
                int.tryParse(waterAimedFor['id'].toString()) ?? 0,
                waterAimedFor['AimedName'].toString() ?? "",
                waterAimedFor['image'].toString() ?? "",
                waterAimedFor['created_at'].toString() ?? "",
                waterAimedFor['updated_at'].toString() ?? "",
                waterAimedFor['deleted_at'].toString() ?? "",
                int.tryParse(waterAimedFor['service_id'].toString()) ?? 0,
              );
              gWaterAimedfm.add(waterAimed);
            });
            List<ServiceImageModel> gWaterServImgModel = [];
            List<dynamic> waterImages = waterServices['images'];
            waterImages.forEach((waterImages) {
              ServiceImageModel waterServiceImage = ServiceImageModel(
                int.tryParse(waterImages['id'].toString()) ?? 0,
                int.tryParse(waterImages['service_id'].toString()) ?? 0,
                int.tryParse(waterImages['is_default'].toString()) ?? 0,
                waterImages['image_url'].toString() ?? "",
                waterImages['thumbnail'].toString() ?? "",
              );
              gWaterServImgModel.add(waterServiceImage);
            });
            List<ProgrammesModel> gPm = [];
            List<dynamic> programs = waterServices['programs'];
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
                DateTime.tryParse(waterServices['start_date'].toString()) ??
                    DateTime.now();
            DateTime eDate =
                DateTime.tryParse(waterServices['end_date'].toString()) ??
                    DateTime.now();
            ServicesModel waterServicesModelList = ServicesModel(
              id: int.tryParse(waterServices['id'].toString()) ?? 0,
              owner: int.tryParse(waterServices['owner'].toString()) ?? 0,
              adventureName: waterServices['adventure_name'].toString() ?? "",
              country: waterServices['country'].toString() ?? "",
              region: waterServices['region'].toString() ?? "",
              cityId: waterServices['city_id'].toString() ?? "",
              serviceSector: waterServices['service_sector'].toString() ?? "",
              serviceCategory:
                  waterServices['service_category'].toString() ?? "",
              serviceType: waterServices['service_type'].toString() ?? "",
              serviceLevel: waterServices['service_level'].toString() ?? "",
              duration: waterServices['duration'] ?? "",
              aSeats: int.tryParse(
                      waterServices['availability_seats'].toString()) ??
                  0,
              startDate: sDate,
              endDate: eDate,
              lat: waterServices['latitude'].toString() ?? "",
              lng: waterServices['longitude'].toString() ?? "",
              writeInformation:
                  waterServices['write_information'].toString() ?? "",
              sPlan:
                  int.tryParse(waterServices['service_plan'].toString()) ?? 0,
              sForID: int.tryParse(waterServices['sfor_id'].toString()) ?? 0,
              availability: gWaterAvaiModel,
              availabilityPlan: gWaterPlanModel,
              geoLocation: waterServices['geo_location'].toString() ?? "",
              sAddress: waterServices['specific_address'].toString() ?? "",
              costInc: waterServices['cost_inc'].toString() ?? "",
              costExc: waterServices['cost_exc'].toString() ?? "",
              currency: waterServices['currency'].toString() ?? "",
              points: int.tryParse(waterServices['points'].toString()) ?? 0,
              preRequisites: waterServices['pre_requisites'].toString() ?? "",
              mRequirements:
                  waterServices['minimum_requirements'].toString() ?? "",
              tnc: waterServices['terms_conditions'].toString() ?? "",
              recommended:
                  int.tryParse(waterServices['recommended'].toString()) ?? 0,
              status: waterServices['status'].toString() ?? "",
              image: waterServices['image'].toString() ?? "",
              des: waterServices['descreption]'].toString() ?? "",
              fImage: waterServices['favourite_image'].toString() ?? "",
              ca: waterServices['created_at'].toString() ?? "",
              upda: waterServices['updated_at'].toString() ?? "",
              da: waterServices['delete_at'].toString() ?? "",
              providerId:
                  int.tryParse(waterServices['provider_id'].toString()) ?? 0,
              serviceId:
                  int.tryParse(waterServices['service_id'].toString()) ?? 0,
              pName: waterServices['provided_name'].toString() ?? "",
              pProfile: waterServices['provider_profile'].toString() ?? "",
              serviceCategoryImage:
                  waterServices['service_category_image'] ?? "",
              serviceSectorImage: waterServices['service_sector_image'] ?? "",
              serviceTypeImage: waterServices['service_type_image'] ?? "",
              serviceLevelImage: waterServices['service_level_image'] ?? "",
              iaot:
                  waterServices['including_gerea_and_other_taxes'].toString() ??
                      "",
              eaot:
                  waterServices['excluding_gerea_and_other_taxes'].toString() ??
                      "",
              activityIncludes: gIAm,
              dependency: gdM,
              bp: waterBp,
              am: gWaterAimedfm,
              programmes: gPm,
              stars: waterServices['stars'].toString() ?? "",
              isLiked: int.tryParse(waterServices['is_liked'].toString()) ?? 0,
              baseURL: waterServices['baseurl'].toString() ?? "",
              images: gWaterServImgModel,
              rating: waterServices['rating'].toString() ?? "",
              reviewdBy: waterServices['reviewd_by'].toString() ?? "",
              remainingSeats:
                  int.tryParse(waterServices['remaining_seats'].toString()) ??
                      0,
            );
            // gWaterServicesModel.add(waterServicesModelList);
            allServices.add(waterServicesModelList);
            allWater.add(waterServicesModelList);
          });
          HomeServicesModel waterListHome =
              HomeServicesModel(acc, gWaterServicesModel);
          gAllServices.add(waterListHome);
        } else if (element['category'] == "LAND") {
          String acc = element['category'].toString() ?? "";
          List<dynamic> landList = element['services'];
          landList.forEach((landServices) {
            List<AvailabilityPlanModel> glandPlanModel = [];
            List<dynamic> availablePlan = landServices['availability'];
            availablePlan.forEach((ap) {
              AvailabilityPlanModel landPlan = AvailabilityPlanModel(
                  int.tryParse(ap['id'].toString()) ?? 0,
                  ap['day'].toString() ?? "");
              glandPlanModel.add(landPlan);
            });
            List<AvailabilityModel> gLandAvaiModel = [];
            List<dynamic> lAvailable = landServices['availability'];
            lAvailable.forEach((landAvailable) {
              AvailabilityModel lAM = AvailabilityModel(
                  landAvailable['start_date'].toString() ?? "",
                  landAvailable['end_date'].toString() ?? "");
              gLandAvaiModel.add(lAM);
            });
            List<dynamic> landBecomePartnerList =
                landServices['become_partner'];
            landBecomePartnerList.forEach((landBecomePartner) {
              BecomePartner landBp = BecomePartner(
                  landBecomePartner['cr_name'].toString() ?? "",
                  landBecomePartner['cr_number'].toString() ?? "",
                  landBecomePartner['description'].toString() ?? "");
            });
            List<IncludedActivitiesModel> gIAm = [];
            List<dynamic> iActivities = landServices['included_activities'];
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
            List<dynamic> dependency = landServices['dependencies'];
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
            List<AimedForModel> gLandAimedfm = [];
            List<dynamic> landAimedForList = landServices['aimed_for'];
            landAimedForList.forEach((landAimedFor) {
              AimedForModel landAimed = AimedForModel(
                int.tryParse(landAimedFor['id'].toString()) ?? 0,
                landAimedFor['AimedName'].toString() ?? "",
                landAimedFor['image'].toString() ?? "",
                landAimedFor['created_at'].toString() ?? "",
                landAimedFor['updated_at'].toString() ?? "",
                landAimedFor['deleted_at'].toString() ?? "",
                int.tryParse(landAimedFor['service_id'].toString()) ?? 0,
              );
              gLandAimedfm.add(landAimed);
            });
            List<ServiceImageModel> gLandServImgModel = [];
            List<dynamic> landImages = landServices['images'];
            landImages.forEach((lImages) {
              ServiceImageModel landServiceImage = ServiceImageModel(
                int.tryParse(lImages['id'].toString()) ?? 0,
                int.tryParse(lImages['service_id'].toString()) ?? 0,
                int.tryParse(lImages['is_default'].toString()) ?? 0,
                lImages['image_url'].toString() ?? "",
                lImages['thumbnail'].toString() ?? "",
              );
              gLandServImgModel.add(landServiceImage);
            });
            List<ProgrammesModel> gPm = [];
            List<dynamic> programs = landServices['programs'];
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
                DateTime.tryParse(landServices['start_date'].toString()) ??
                    DateTime.now();
            DateTime eDate =
                DateTime.tryParse(landServices['end_date'].toString()) ??
                    DateTime.now();
            ServicesModel landServicesModelList = ServicesModel(
              id: int.tryParse(landServices['id'].toString()) ?? 0,
              owner: int.tryParse(landServices['owner'].toString()) ?? 0,
              adventureName: landServices['adventure_name'].toString() ?? "",
              country: landServices['country'].toString() ?? "",
              region: landServices['region'].toString() ?? "",
              cityId: landServices['city_id'].toString() ?? "",
              serviceSector: landServices['service_sector'].toString() ?? "",
              serviceCategory:
                  landServices['service_category'].toString() ?? "",
              serviceType: landServices['service_type'].toString() ?? "",
              serviceLevel: landServices['service_level'].toString() ?? "",
              duration: landServices['duration'] ?? "",
              aSeats:
                  int.tryParse(landServices['availability_seats'].toString()) ??
                      0,
              startDate: sDate,
              endDate: eDate,
              lat: landServices['latitude'].toString() ?? "",
              lng: landServices['longitude'].toString() ?? "",
              writeInformation:
                  landServices['write_information'].toString() ?? "",
              sPlan: int.tryParse(landServices['service_plan'].toString()) ?? 0,
              sForID: int.tryParse(landServices['sfor_id'].toString()) ?? 0,
              availability: gLandAvaiModel,
              availabilityPlan: glandPlanModel,
              geoLocation: landServices['geo_location'].toString() ?? "",
              sAddress: landServices['specific_address'].toString() ?? "",
              costInc: landServices['cost_inc'].toString() ?? "",
              costExc: landServices['cost_exc'].toString() ?? "",
              currency: landServices['currency'].toString() ?? "",
              points: int.tryParse(landServices['points'].toString()) ?? 0,
              preRequisites: landServices['pre_requisites'].toString() ?? "",
              mRequirements:
                  landServices['minimum_requirements'].toString() ?? "",
              tnc: landServices['terms_conditions'].toString() ?? "",
              recommended:
                  int.tryParse(landServices['recommended'].toString()) ?? 0,
              status: landServices['status'].toString() ?? "",
              image: landServices['image'].toString() ?? "",
              des: landServices['descreption]'].toString() ?? "",
              fImage: landServices['favourite_image'].toString() ?? "",
              ca: landServices['created_at'].toString() ?? "",
              upda: landServices['updated_at'].toString() ?? "",
              da: landServices['delete_at'].toString() ?? "",
              providerId:
                  int.tryParse(landServices['provider_id'].toString()) ?? 0,
              serviceId:
                  int.tryParse(landServices['service_id'].toString()) ?? 0,
              pName: landServices['provided_name'].toString() ?? "",
              pProfile: landServices['provider_profile'].toString() ?? "",
              serviceCategoryImage:
                  landServices['service_category_image'] ?? "",
              serviceSectorImage: landServices['service_sector_image'] ?? "",
              serviceTypeImage: landServices['service_type_image'] ?? "",
              serviceLevelImage: landServices['service_level_image'] ?? "",
              iaot:
                  landServices['including_gerea_and_other_taxes'].toString() ??
                      "",
              eaot:
                  landServices['excluding_gerea_and_other_taxes'].toString() ??
                      "",
              activityIncludes: gIAm,
              dependency: gdM,
              bp: landBp,
              am: gLandAimedfm,
              programmes: gPm,
              stars: landServices['stars'].toString() ?? "",
              isLiked: int.tryParse(landServices['is_liked'].toString()) ?? 0,
              baseURL: landServices['baseurl'].toString() ?? "",
              images: gLandServImgModel,
              rating: landServices['rating'].toString() ?? "",
              reviewdBy: landServices['reviewd_by'].toString() ?? "",
              remainingSeats:
                  int.tryParse(landServices['remaining_seats'].toString()) ?? 0,
            );
            // gLandServicesModel.add(landServicesModelList);
            allServices.add(landServicesModelList);
            allLand.add(landServicesModelList);
          });
          HomeServicesModel landListHome =
              HomeServicesModel(acc, gLandServicesModel);
          gAllServices.add(landListHome);
        } else {
          String acc = element['category'].toString() ?? "";
          List<dynamic> other = element['services'];
          other.forEach((otherElement) {
            List<AvailabilityPlanModel> gWaterPlanModel = [];
            List<dynamic> availablePlan = otherElement['availability'];
            availablePlan.forEach((ap) {
              AvailabilityPlanModel waterPlan = AvailabilityPlanModel(
                  int.tryParse(ap['id'].toString()) ?? 0,
                  ap['day'].toString() ?? "");
              gWaterPlanModel.add(waterPlan);
            });
            List<AvailabilityModel> gWaterAvaiModel = [];
            List<dynamic> wAvailable = otherElement['availability'];
            wAvailable.forEach((waterAvailable) {
              AvailabilityModel wAM = AvailabilityModel(
                  waterAvailable['start_date'].toString() ?? "",
                  waterAvailable['end_date'].toString() ?? "");
              gWaterAvaiModel.add(wAM);
            });
            List<dynamic> waterBecomePartnerList =
                otherElement['become_partner'];
            waterBecomePartnerList.forEach((waterBecomePartner) {
              BecomePartner waterBp = BecomePartner(
                  waterBecomePartner['cr_name'].toString() ?? "",
                  waterBecomePartner['cr_number'].toString() ?? "",
                  waterBecomePartner['description'].toString() ?? "");
            });
            List<IncludedActivitiesModel> gIAm = [];
            List<dynamic> iActivities = otherElement['included_activities'];
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
            List<dynamic> dependency = otherElement['dependencies'];
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
            List<AimedForModel> gWaterAimedfm = [];
            List<dynamic> waterAimedForList = otherElement['aimed_for'];
            waterAimedForList.forEach((waterAimedFor) {
              AimedForModel waterAimed = AimedForModel(
                int.tryParse(waterAimedFor['id'].toString()) ?? 0,
                waterAimedFor['AimedName'].toString() ?? "",
                waterAimedFor['image'].toString() ?? "",
                waterAimedFor['created_at'].toString() ?? "",
                waterAimedFor['updated_at'].toString() ?? "",
                waterAimedFor['deleted_at'].toString() ?? "",
                int.tryParse(waterAimedFor['service_id'].toString()) ?? 0,
              );
              gWaterAimedfm.add(waterAimed);
            });
            List<ServiceImageModel> gWaterServImgModel = [];
            List<dynamic> waterImages = otherElement['images'];
            waterImages.forEach((waterImages) {
              ServiceImageModel waterServiceImage = ServiceImageModel(
                int.tryParse(waterImages['id'].toString()) ?? 0,
                int.tryParse(waterImages['service_id'].toString()) ?? 0,
                int.tryParse(waterImages['is_default'].toString()) ?? 0,
                waterImages['image_url'].toString() ?? "",
                waterImages['thumbnail'].toString() ?? "",
              );
              gWaterServImgModel.add(waterServiceImage);
            });
            List<ProgrammesModel> gPm = [];
            List<dynamic> programs = otherElement['programs'];
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
                DateTime.tryParse(otherElement['start_date'].toString()) ??
                    DateTime.now();
            DateTime eDate =
                DateTime.tryParse(otherElement['end_date'].toString()) ??
                    DateTime.now();
            ServicesModel otherModelList = ServicesModel(
              id: int.tryParse(otherElement['id'].toString()) ?? 0,
              owner: int.tryParse(otherElement['owner'].toString()) ?? 0,
              adventureName: otherElement['adventure_name'].toString() ?? "",
              country: otherElement['country'].toString() ?? "",
              region: otherElement['region'].toString() ?? "",
              cityId: otherElement['city_id'].toString() ?? "",
              serviceSector: otherElement['service_sector'].toString() ?? "",
              serviceCategory:
                  otherElement['service_category'].toString() ?? "",
              serviceType: otherElement['service_type'].toString() ?? "",
              serviceLevel: otherElement['service_level'].toString() ?? "",
              duration: otherElement['duration'] ?? "",
              aSeats:
                  int.tryParse(otherElement['availability_seats'].toString()) ??
                      0,
              startDate: sDate,
              endDate: eDate,
              lat: otherElement['latitude'].toString() ?? "",
              lng: otherElement['longitude'].toString() ?? "",
              writeInformation:
                  otherElement['write_information'].toString() ?? "",
              sPlan: int.tryParse(otherElement['service_plan'].toString()) ?? 0,
              sForID: int.tryParse(otherElement['sfor_id'].toString()) ?? 0,
              availability: gWaterAvaiModel,
              availabilityPlan: gWaterPlanModel,
              geoLocation: otherElement['geo_location'].toString() ?? "",
              sAddress: otherElement['specific_address'].toString() ?? "",
              costInc: otherElement['cost_inc'].toString() ?? "",
              costExc: otherElement['cost_exc'].toString() ?? "",
              currency: otherElement['currency'].toString() ?? "",
              points: int.tryParse(otherElement['points'].toString()) ?? 0,
              preRequisites: otherElement['pre_requisites'].toString() ?? "",
              mRequirements:
                  otherElement['minimum_requirements'].toString() ?? "",
              tnc: otherElement['terms_conditions'].toString() ?? "",
              recommended:
                  int.tryParse(otherElement['recommended'].toString()) ?? 0,
              status: otherElement['status'].toString() ?? "",
              image: otherElement['image'].toString() ?? "",
              des: otherElement['descreption]'].toString() ?? "",
              fImage: otherElement['favourite_image'].toString() ?? "",
              ca: otherElement['created_at'].toString() ?? "",
              upda: otherElement['updated_at'].toString() ?? "",
              da: otherElement['delete_at'].toString() ?? "",
              providerId:
                  int.tryParse(otherElement['provider_id'].toString()) ?? 0,
              serviceId:
                  int.tryParse(otherElement['service_id'].toString()) ?? 0,
              pName: otherElement['provided_name'].toString() ?? "",
              pProfile: otherElement['provider_profile'].toString() ?? "",
              serviceCategoryImage:
                  otherElement['service_category_image'] ?? "",
              serviceSectorImage: otherElement['service_sector_image'] ?? "",
              serviceTypeImage: otherElement['service_type_image'] ?? "",
              serviceLevelImage: otherElement['service_level_image'] ?? "",
              iaot:
                  otherElement['including_gerea_and_other_taxes'].toString() ??
                      "",
              eaot:
                  otherElement['excluding_gerea_and_other_taxes'].toString() ??
                      "",
              activityIncludes: gIAm,
              dependency: gdM,
              bp: waterBp,
              am: gWaterAimedfm,
              programmes: gPm,
              stars: otherElement['stars'].toString() ?? "",
              isLiked: int.tryParse(otherElement['is_liked'].toString()) ?? 0,
              baseURL: otherElement['baseurl'].toString() ?? "",
              images: gWaterServImgModel,
              rating: element['rating'].toString() ?? "",
              reviewdBy: otherElement['reviewd_by'].toString() ?? "",
              remainingSeats:
                  int.tryParse(otherElement['remaining_seats'].toString()) ?? 0,
            );
            // gWaterServicesModel.add(waterServicesModelList);
            allServices.add(otherModelList);
          });
          HomeServicesModel otherHome = HomeServicesModel(acc, allServices);
          gAllServices.add(otherHome);
        }
      });
    }
    notifyListeners();
  }
}
