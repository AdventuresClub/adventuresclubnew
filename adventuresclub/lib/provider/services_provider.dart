// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:adventuresclub/models/home_services/home_services_model.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/models/services/availability_model.dart';
import 'package:adventuresclub/models/services/service_image_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/home_services/become_partner.dart';

class ServicesProvider with ChangeNotifier {
  ServicesProvider({Key? key});
  String resultService = "";
  String resultRequest = "";
  String totalNotication = "";
  String id = "1";
  List<AvailabilityModel> gAccomodoationAvaiModel = [];
  List<AvailabilityModel> gTransportAvaiModel = [];
  List<AvailabilityModel> gSkyAvaiModel = [];
  List<AvailabilityModel> gWaterAvaiModel = [];
  List<AvailabilityModel> gLandAvaiModel = [];
  List<ServiceImageModel> gAccomodationServImgModel = [];
  List<ServiceImageModel> gTransportServImgModel = [];
  List<ServiceImageModel> gSkyServImgModel = [];
  List<ServiceImageModel> gWaterServImgModel = [];
  List<ServiceImageModel> gLandServImgModel = [];
  List<AimedForModel> gAccomodationAimedfm = [];
  List<AimedForModel> gTransportAimedfm = [];
  List<AimedForModel> gSkyAimedfm = [];
  List<AimedForModel> gWaterAimedfm = [];
  List<AimedForModel> gLandAimedfm = [];
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
  List<HomeServicesModel> accomodation = [];
  List<HomeServicesModel> transport = [];
  List<HomeServicesModel> sky = [];
  List<HomeServicesModel> water = [];
  List<HomeServicesModel> land = [];
  List<HomeServicesModel> gm = [];
  List<ServicesModel> allServices = [];
  List<ServicesModel> allAccomodation = [];
  List<ServicesModel> allTransport = [];
  List<ServicesModel> allSky = [];
  List<ServicesModel> allWater = [];
  List<ServicesModel> allLand = [];

  Future getServicesList() async {
    var response = await http.post(
        Uri.parse(
            "https://adventuresclub.net/adventureClub/api/v1/get_allservices"),
        body: {
          "country_id": id,
        });
    if (response.statusCode == 200) {
      var getServicesMap = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = getServicesMap['data'];
      result.forEach((element) {
        if (element['category'] == "Accomodation") {
          String acc = element['category'].toString() ?? "";
          List<dynamic> s = element['services'];
          s.forEach((services) {
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
              int.tryParse(services['availability_seats'].toString()) ?? 0,
              int.tryParse(services['start_date'].toString()) ?? "",
              int.tryParse(services['end_date'].toString()) ?? "",
              services['latitude'].toString() ?? "",
              services['longitude'].toString() ?? "",
              services['write_information'].toString() ?? "",
              int.tryParse(services['service_plan'].toString()) ?? 0,
              int.tryParse(services['sfor_id'].toString()) ?? 0,
              gAccomodoationAvaiModel,
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
              nBp,
              gAccomodationAimedfm,
              services['stars'].toString() ?? "",
              int.tryParse(services['is_liked'].toString()) ?? 0,
              services['baseurl'].toString() ?? "",
              gAccomodationServImgModel,
            );
            gAccomodationSModel.add(nSm);
            allServices.add(nSm);
            allAccomodation.add(nSm);
          });
          HomeServicesModel adv = HomeServicesModel(acc, gAccomodationSModel);
          accomodation.add(adv);
          accomodation.forEach((acco) {
            gm.add(acco);
          });
        } else if (element['category'] == "Transport") {
          List<dynamic> t = element['services'];
          t.forEach((tServices) {
            List<dynamic> tAvailable = tServices['availability'];
            tAvailable.forEach((aS) {
              AvailabilityModel tAM = AvailabilityModel(
                  aS['start_date'].toString() ?? "",
                  aS['end_date'].toString() ?? "");
              gTransportAvaiModel.add(tAM);
            });
            List<dynamic> tBecomePartner = tServices['become_partner'];
            tBecomePartner.forEach((bS) {
              BecomePartner transportBp = BecomePartner(
                  bS['cr_name'].toString() ?? "",
                  bS['cr_number'].toString() ?? "",
                  bS['description'].toString() ?? "");
            });
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
            ServicesModel tServicesModelList = ServicesModel(
              int.tryParse(tServices['id'].toString()) ?? 0,
              int.tryParse(tServices['owner'].toString()) ?? 0,
              tServices['adventure_name'].toString() ?? "",
              tServices['country'].toString() ?? "",
              tServices['region'].toString() ?? "",
              tServices['city_id'].toString() ?? "",
              tServices['service_sector'].toString() ?? "",
              tServices['service_category'].toString() ?? "",
              tServices['service_type'].toString() ?? "",
              tServices['service_level'].toString() ?? "",
              tServices['duration'].toString() ?? "",
              int.tryParse(tServices['availability_seats'].toString()) ?? 0,
              int.tryParse(tServices['start_date'].toString()) ?? "",
              int.tryParse(tServices['end_date'].toString()) ?? "",
              tServices['latitude'].toString() ?? "",
              tServices['longitude'].toString() ?? "",
              tServices['write_information'].toString() ?? "",
              int.tryParse(tServices['service_plan'].toString()) ?? 0,
              int.tryParse(tServices['sfor_id'].toString()) ?? 0,
              gTransportAvaiModel,
              tServices['geo_location'].toString() ?? "",
              tServices['specific_address'].toString() ?? "",
              tServices['cost_inc'].toString() ?? "",
              tServices['cost_exc'].toString() ?? "",
              tServices['currency'].toString() ?? "",
              int.tryParse(tServices['points'].toString()) ?? 0,
              tServices['pre_requisites'].toString() ?? "",
              tServices['minimum_requirements'].toString() ?? "",
              tServices['terms_conditions'].toString() ?? "",
              int.tryParse(tServices['recommended'].toString()) ?? 0,
              tServices['status'].toString() ?? "",
              tServices['image'].toString() ?? "",
              tServices['descreption]'].toString() ?? "",
              tServices['favourite_image'].toString() ?? "",
              tServices['created_at'].toString() ?? "",
              tServices['updated_at'].toString() ?? "",
              tServices['delete_at'].toString() ?? "",
              int.tryParse(tServices['provider_id'].toString()) ?? 0,
              int.tryParse(tServices['service_id'].toString()) ?? 0,
              tServices['provided_name'].toString() ?? "",
              tServices['provider_profile'].toString() ?? "",
              tServices['including_gerea_and_other_taxes'].toString() ?? "",
              tServices['excluding_gerea_and_other_taxes'].toString() ?? "",
              transportBp,
              gTransportAimedfm,
              tServices['stars'].toString() ?? "",
              int.tryParse(tServices['is_liked'].toString()) ?? 0,
              tServices['baseurl'].toString() ?? "",
              gTransportServImgModel,
            );
            gTransportSModel.add(tServicesModelList);
            allServices.add(tServicesModelList);
            allTransport.add(tServicesModelList);
          });
          HomeServicesModel transportList = HomeServicesModel(
              element['category'].toString() ?? "", gTransportSModel);
          transport.add(transportList);
          // transport.forEach((trans) {
          //   gm.add(trans);
          // });
        } else if (element['category'] == "Sky") {
          List<dynamic> skyList = element['services'];
          skyList.forEach((skyServices) {
            List<dynamic> tAvailable = skyServices['availability'];
            tAvailable.forEach((skyAvailable) {
              AvailabilityModel tAM = AvailabilityModel(
                  skyAvailable['start_date'].toString() ?? "",
                  skyAvailable['end_date'].toString() ?? "");
              gTransportAvaiModel.add(tAM);
            });
            List<dynamic> skyBecomePartnerList = skyServices['become_partner'];
            skyBecomePartnerList.forEach((skyBecomePartner) {
              BecomePartner skyBp = BecomePartner(
                  skyBecomePartner['cr_name'].toString() ?? "",
                  skyBecomePartner['cr_number'].toString() ?? "",
                  skyBecomePartner['description'].toString() ?? "");
            });
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
            ServicesModel skyServicesModelList = ServicesModel(
              int.tryParse(skyServices['id'].toString()) ?? 0,
              int.tryParse(skyServices['owner'].toString()) ?? 0,
              skyServices['adventure_name'].toString() ?? "",
              skyServices['country'].toString() ?? "",
              skyServices['region'].toString() ?? "",
              skyServices['city_id'].toString() ?? "",
              skyServices['service_sector'].toString() ?? "",
              skyServices['service_category'].toString() ?? "",
              skyServices['service_type'].toString() ?? "",
              skyServices['service_level'].toString() ?? "",
              skyServices['duration'].toString() ?? "",
              int.tryParse(skyServices['availability_seats'].toString()) ?? 0,
              int.tryParse(skyServices['start_date'].toString()) ?? "",
              int.tryParse(skyServices['end_date'].toString()) ?? "",
              skyServices['latitude'].toString() ?? "",
              skyServices['longitude'].toString() ?? "",
              skyServices['write_information'].toString() ?? "",
              int.tryParse(skyServices['service_plan'].toString()) ?? 0,
              int.tryParse(skyServices['sfor_id'].toString()) ?? 0,
              gSkyAvaiModel,
              skyServices['geo_location'].toString() ?? "",
              skyServices['specific_address'].toString() ?? "",
              skyServices['cost_inc'].toString() ?? "",
              skyServices['cost_exc'].toString() ?? "",
              skyServices['currency'].toString() ?? "",
              int.tryParse(skyServices['points'].toString()) ?? 0,
              skyServices['pre_requisites'].toString() ?? "",
              skyServices['minimum_requirements'].toString() ?? "",
              skyServices['terms_conditions'].toString() ?? "",
              int.tryParse(skyServices['recommended'].toString()) ?? 0,
              skyServices['status'].toString() ?? "",
              skyServices['image'].toString() ?? "",
              skyServices['descreption]'].toString() ?? "",
              skyServices['favourite_image'].toString() ?? "",
              skyServices['created_at'].toString() ?? "",
              skyServices['updated_at'].toString() ?? "",
              skyServices['delete_at'].toString() ?? "",
              int.tryParse(skyServices['provider_id'].toString()) ?? 0,
              int.tryParse(skyServices['service_id'].toString()) ?? 0,
              skyServices['provided_name'].toString() ?? "",
              skyServices['provider_profile'].toString() ?? "",
              skyServices['including_gerea_and_other_taxes'].toString() ?? "",
              skyServices['excluding_gerea_and_other_taxes'].toString() ?? "",
              skyBp,
              gSkyAimedfm,
              skyServices['stars'].toString() ?? "",
              int.tryParse(skyServices['is_liked'].toString()) ?? 0,
              skyServices['baseurl'].toString() ?? "",
              gSkyServImgModel,
            );
            gSkyServicesModel.add(skyServicesModelList);
            allServices.add(skyServicesModelList);
            allSky.add(skyServicesModelList);
          });
          HomeServicesModel skyListHome = HomeServicesModel(
              element['category'].toString() ?? "", gSkyServicesModel);
          sky.add(skyListHome);
          sky.forEach((ski) {
            gm.add(ski);
          });
        } else if (element['category'] == "Water") {
          List<dynamic> waterList = element['services'];
          waterList.forEach((waterServices) {
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
            ServicesModel waterServicesModelList = ServicesModel(
              int.tryParse(waterServices['id'].toString()) ?? 0,
              int.tryParse(waterServices['owner'].toString()) ?? 0,
              waterServices['adventure_name'].toString() ?? "",
              waterServices['country'].toString() ?? "",
              waterServices['region'].toString() ?? "",
              waterServices['city_id'].toString() ?? "",
              waterServices['service_sector'].toString() ?? "",
              waterServices['service_category'].toString() ?? "",
              waterServices['service_type'].toString() ?? "",
              waterServices['service_level'].toString() ?? "",
              waterServices['duration'].toString() ?? "",
              int.tryParse(waterServices['availability_seats'].toString()) ?? 0,
              int.tryParse(waterServices['start_date'].toString()) ?? "",
              int.tryParse(waterServices['end_date'].toString()) ?? "",
              waterServices['latitude'].toString() ?? "",
              waterServices['longitude'].toString() ?? "",
              waterServices['write_information'].toString() ?? "",
              int.tryParse(waterServices['service_plan'].toString()) ?? 0,
              int.tryParse(waterServices['sfor_id'].toString()) ?? 0,
              gWaterAvaiModel,
              waterServices['geo_location'].toString() ?? "",
              waterServices['specific_address'].toString() ?? "",
              waterServices['cost_inc'].toString() ?? "",
              waterServices['cost_exc'].toString() ?? "",
              waterServices['currency'].toString() ?? "",
              int.tryParse(waterServices['points'].toString()) ?? 0,
              waterServices['pre_requisites'].toString() ?? "",
              waterServices['minimum_requirements'].toString() ?? "",
              waterServices['terms_conditions'].toString() ?? "",
              int.tryParse(waterServices['recommended'].toString()) ?? 0,
              waterServices['status'].toString() ?? "",
              waterServices['image'].toString() ?? "",
              waterServices['descreption]'].toString() ?? "",
              waterServices['favourite_image'].toString() ?? "",
              waterServices['created_at'].toString() ?? "",
              waterServices['updated_at'].toString() ?? "",
              waterServices['delete_at'].toString() ?? "",
              int.tryParse(waterServices['provider_id'].toString()) ?? 0,
              int.tryParse(waterServices['service_id'].toString()) ?? 0,
              waterServices['provided_name'].toString() ?? "",
              waterServices['provider_profile'].toString() ?? "",
              waterServices['including_gerea_and_other_taxes'].toString() ?? "",
              waterServices['excluding_gerea_and_other_taxes'].toString() ?? "",
              waterBp,
              gWaterAimedfm,
              waterServices['stars'].toString() ?? "",
              int.tryParse(waterServices['is_liked'].toString()) ?? 0,
              waterServices['baseurl'].toString() ?? "",
              gWaterServImgModel,
            );
            gWaterServicesModel.add(waterServicesModelList);
            allServices.add(waterServicesModelList);
          });
          HomeServicesModel waterListHome = HomeServicesModel(
              element['category'].toString() ?? "", gWaterServicesModel);
          water.add(waterListHome);
          water.forEach((element) {
            gm.add(element);
          });
        } else if (element['category'] == "LAND") {
          List<dynamic> landList = element['services'];
          landList.forEach((landServices) {
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
            ServicesModel landServicesModelList = ServicesModel(
              int.tryParse(landServices['id'].toString()) ?? 0,
              int.tryParse(landServices['owner'].toString()) ?? 0,
              landServices['adventure_name'].toString() ?? "",
              landServices['country'].toString() ?? "",
              landServices['region'].toString() ?? "",
              landServices['city_id'].toString() ?? "",
              landServices['service_sector'].toString() ?? "",
              landServices['service_category'].toString() ?? "",
              landServices['service_type'].toString() ?? "",
              landServices['service_level'].toString() ?? "",
              landServices['duration'].toString() ?? "",
              int.tryParse(landServices['availability_seats'].toString()) ?? 0,
              int.tryParse(landServices['start_date'].toString()) ?? "",
              int.tryParse(landServices['end_date'].toString()) ?? "",
              landServices['latitude'].toString() ?? "",
              landServices['longitude'].toString() ?? "",
              landServices['write_information'].toString() ?? "",
              int.tryParse(landServices['service_plan'].toString()) ?? 0,
              int.tryParse(landServices['sfor_id'].toString()) ?? 0,
              gLandAvaiModel,
              landServices['geo_location'].toString() ?? "",
              landServices['specific_address'].toString() ?? "",
              landServices['cost_inc'].toString() ?? "",
              landServices['cost_exc'].toString() ?? "",
              landServices['currency'].toString() ?? "",
              int.tryParse(landServices['points'].toString()) ?? 0,
              landServices['pre_requisites'].toString() ?? "",
              landServices['minimum_requirements'].toString() ?? "",
              landServices['terms_conditions'].toString() ?? "",
              int.tryParse(landServices['recommended'].toString()) ?? 0,
              landServices['status'].toString() ?? "",
              landServices['image'].toString() ?? "",
              landServices['descreption]'].toString() ?? "",
              landServices['favourite_image'].toString() ?? "",
              landServices['created_at'].toString() ?? "",
              landServices['updated_at'].toString() ?? "",
              landServices['delete_at'].toString() ?? "",
              int.tryParse(landServices['provider_id'].toString()) ?? 0,
              int.tryParse(landServices['service_id'].toString()) ?? 0,
              landServices['provided_name'].toString() ?? "",
              landServices['provider_profile'].toString() ?? "",
              landServices['including_gerea_and_other_taxes'].toString() ?? "",
              landServices['excluding_gerea_and_other_taxes'].toString() ?? "",
              landBp,
              gLandAimedfm,
              landServices['stars'].toString() ?? "",
              int.tryParse(landServices['is_liked'].toString()) ?? 0,
              landServices['baseurl'].toString() ?? "",
              gLandServImgModel,
            );
            gLandServicesModel.add(landServicesModelList);
            allServices.add(landServicesModelList);
            allLand.add(landServicesModelList);
          });
          HomeServicesModel landListHome = HomeServicesModel(
              element['category'].toString() ?? "", gLandServicesModel);
          land.add(landListHome);
          land.forEach((element) {
            gm.add(element);
          });
        }
      });
    }
    notifyListeners();
  }
}
