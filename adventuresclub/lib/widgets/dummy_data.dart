  // Future getServicesList() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   var response = await http.post(
  //       Uri.parse(
  //           "https://adventuresclub.net/adventureClub/api/v1/get_allservices"),
  //       body: {
  //         "country_id": id,
  //       });
  //   if (response.statusCode == 200) {
  //     var getServicesMap = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  //     List<dynamic> result = getServicesMap['data'];
  //     result.forEach((element) {
  //       List<dynamic> s = element['services'];
  //       s.forEach((services) {
  //         List<dynamic> available = services['availability'];
  //         available.forEach((a) {
  //           AvailabilityModel am = AvailabilityModel(
  //               a['start_date'].toString() ?? "",
  //               a['end_date'].toString() ?? "");
  //           gAm.add(am);
  //         });
  //         List<dynamic> becomePartner = services['become_partner'];
  //         becomePartner.forEach((b) {
  //           BecomePartner bp = BecomePartner(
  //               b['cr_name'].toString() ?? "",
  //               b['cr_number'].toString() ?? "",
  //               b['description'].toString() ?? "");
  //         });
  //         List<dynamic> aF = services['aimed_for'];
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
  //           gAfm.add(afm);
  //         });
  //         List<dynamic> image = services['images'];
  //         image.forEach((i) {
  //           ServiceImageModel sm = ServiceImageModel(
  //             int.tryParse(i['id'].toString()) ?? 0,
  //             int.tryParse(i['service_id'].toString()) ?? 0,
  //             int.tryParse(i['is_default'].toString()) ?? 0,
  //             i['image_url'].toString() ?? "",
  //             i['thumbnail'].toString() ?? "",
  //           );
  //           gSim.add(sm);
  //         });
  //         ServicesModel nSm = ServicesModel(
  //           int.tryParse(services['id'].toString()) ?? 0,
  //           int.tryParse(services['owner'].toString()) ?? 0,
  //           services['adventure_name'].toString() ?? "",
  //           services['country'].toString() ?? "",
  //           services['region'].toString() ?? "",
  //           services['city_id'].toString() ?? "",
  //           services['service_sector'].toString() ?? "",
  //           services['service_category'].toString() ?? "",
  //           services['service_type'].toString() ?? "",
  //           services['service_level'].toString() ?? "",
  //           services['duration'].toString() ?? "",
  //           int.tryParse(services['availability_seats'].toString()) ?? 0,
  //           int.tryParse(services['start_date'].toString()) ?? "",
  //           int.tryParse(services['end_date'].toString()) ?? "",
  //           services['latitude'].toString() ?? "",
  //           services['longitude'].toString() ?? "",
  //           services['write_information'].toString() ?? "",
  //           int.tryParse(services['service_plan'].toString()) ?? 0,
  //           int.tryParse(services['sfor_id'].toString()) ?? 0,
  //           gAm,
  //           services['geo_location'].toString() ?? "",
  //           services['specific_address'].toString() ?? "",
  //           services['cost_inc'].toString() ?? "",
  //           services['cost_exc'].toString() ?? "",
  //           services['currency'].toString() ?? "",
  //           int.tryParse(services['points'].toString()) ?? 0,
  //           services['pre_requisites'].toString() ?? "",
  //           services['minimum_requirements'].toString() ?? "",
  //           services['terms_conditions'].toString() ?? "",
  //           int.tryParse(services['recommended'].toString()) ?? 0,
  //           services['status'].toString() ?? "",
  //           services['image'].toString() ?? "",
  //           services['descreption]'].toString() ?? "",
  //           services['favourite_image'].toString() ?? "",
  //           services['created_at'].toString() ?? "",
  //           services['updated_at'].toString() ?? "",
  //           services['delete_at'].toString() ?? "",
  //           int.tryParse(services['provider_id'].toString()) ?? 0,
  //           int.tryParse(services['service_id'].toString()) ?? 0,
  //           services['provider_name'].toString() ?? "",
  //           services['provider_profile'].toString() ?? "",
  //           services['including_gerea_and_other_taxes'].toString() ?? "",
  //           services['excluding_gerea_and_other_taxes'].toString() ?? "",
  //           nBp,
  //           gAfm,
  //           services['stars'].toString() ?? "",
  //           int.tryParse(services['is_liked'].toString()) ?? 0,
  //           services['baseurl'].toString() ?? "",
  //           gSim,
  //         );
  //         ngSM.add(nSm);
  //       });
  //       HomeServicesModel sm =
  //           HomeServicesModel(element['category'].toString() ?? "", ngSM);
  //       gm.add(sm);
  //     });
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

  // Future getServicesList() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   var response = await http.get(Uri.parse(
  //       "https://adventuresclub.net/adventureClub/api/v1/services/$id"));
  //   if (response.statusCode == 200) {
  //     getServicesMap = json.decode(response.body);
  //     dynamic result = getServicesMap['data'];
  //     List<dynamic> available = result['availability'];
  //     available.forEach((a) {
  //       AvailabilityModel am = AvailabilityModel(
  //           int.tryParse(a['id'].toString()) ?? 0, a['day'].toString() ?? "");
  //       gAm.add(am);
  //     });
  //     List<dynamic> image = result['images'];
  //     image.forEach((i) {
  //       ServiceImageModel sm = ServiceImageModel(
  //         int.tryParse(i['id'].toString()) ?? 0,
  //         int.tryParse(i['service_id'].toString()) ?? 0,
  //         int.tryParse(i['is_default'].toString()) ?? 0,
  //         i['image_url'].toString() ?? "",
  //         i['thumbnail'].toString() ?? "",
  //       );
  //       gSim.add(sm);
  //     });
  //     List<dynamic> iActivities = result['included_activities'];
  //     iActivities.forEach((iA) {
  //       IncludedActivitiesModel iAm = IncludedActivitiesModel(
  //         int.tryParse(iA['id'].toString()) ?? 0,
  //         int.tryParse(iA['service_id'].toString()) ?? 0,
  //         iA['activity_id'].toString() ?? "",
  //         iA['activity'].toString() ?? "",
  //         iA['image'].toString() ?? "",
  //       );
  //       gIAm.add(iAm);
  //     });
  //     List<dynamic> dependency = result['dependencies'];
  //     dependency.forEach((d) {
  //       DependenciesModel dm = DependenciesModel(
  //         int.tryParse(d['id'].toString()) ?? 0,
  //         d['dependency_name'].toString() ?? "",
  //         d['image'].toString() ?? "",
  //         d['updated_at'].toString() ?? "",
  //         d['created_at'].toString() ?? "",
  //         d['deleted_at'].toString() ?? "",
  //       );
  //       gdM.add(dm);
  //     });
  //     List<dynamic> programs = result['programs'];
  //     programs.forEach((p) {
  //       ProgrammesModel pm = ProgrammesModel(
  //         int.tryParse(p['id'].toString()) ?? 0,
  //         int.tryParse(p['service_id'].toString()) ?? 0,
  //         p['title'].toString() ?? "",
  //         p['start_datetime'].toString() ?? "",
  //         p['end_datetime'].toString() ?? "",
  //         p['description'].toString() ?? "",
  //       );
  //       gPm.add(pm);
  //     });
  //     List<dynamic> aF = result['aimed_for'];
  //     aF.forEach((a) {
  //       AimedForModel afm = AimedForModel(
  //         int.tryParse(a['id'].toString()) ?? 0,
  //         a['AimedName'].toString() ?? "",
  //         a['image'].toString() ?? "",
  //         a['created_at'].toString() ?? "",
  //         a['updated_at'].toString() ?? "",
  //         a['deleted_at'].toString() ?? "",
  //         int.tryParse(a['service_id'].toString()) ?? 0,
  //       );
  //       gAfm.add(afm);
  //     });
  //     List<dynamic> booking = result['bookingData'];
  //     booking.forEach((b) {
  //       BookingDataModel bdm = BookingDataModel(
  //         int.tryParse(b['id'].toString()) ?? 0,
  //         int.tryParse(b['user_id'].toString()) ?? 0,
  //         int.tryParse(b['service_id'].toString()) ?? 0,
  //         int.tryParse(b['transaction_id'].toString()) ?? 0,
  //         int.tryParse(b['pay_status'].toString()) ?? 0,
  //         int.tryParse(b['provider_id'].toString()) ?? 0,
  //         int.tryParse(b['adult'].toString()) ?? 0,
  //         int.tryParse(b['kids'].toString()) ?? 0,
  //         b['message'].toString() ?? "",
  //         b['unit_amount'].toString() ?? "",
  //         b['total_amount'].toString() ?? "",
  //         b['discounted_amount'].toString() ?? "",
  //         int.tryParse(b['future_plan'].toString()) ?? 0,
  //         b['booking_date'].toString() ?? "",
  //         int.tryParse(b['currency'].toString()) ?? 0,
  //         int.tryParse(b['coupon_applied'].toString()) ?? 0,
  //         b['status'].toString() ?? "",
  //         int.tryParse(b['updated_by'].toString()) ?? 0,
  //         b['cancelled_reason'].toString() ?? "",
  //         b['payment_status'].toString() ?? "",
  //         b['payment_channel'].toString() ?? "",
  //         b['deleted_at'].toString() ?? "",
  //         b['created_at'].toString() ?? "",
  //         b['updated_at'].toString() ?? "",
  //       );
  //       gBdm.add(bdm);
  //     });
  //     GetServicesModel sm = GetServicesModel(
  //       int.tryParse(result['id'].toString()) ?? 0,
  //       int.tryParse(result['owner'].toString()) ?? 0,
  //       result['adventure_name'].toString() ?? "",
  //       result['country'].toString() ?? "",
  //       result['region'].toString() ?? "",
  //       result['city_id'].toString() ?? "",
  //       result['service_sector'].toString() ?? "",
  //       result['service_category'].toString() ?? "",
  //       result['service_type'].toString() ?? "",
  //       result['service_level'].toString() ?? "",
  //       result['duration'].toString() ?? "",
  //       int.tryParse(result['availability_seats'].toString()) ?? 0,
  //       int.tryParse(result['start_date'].toString()) ?? "",
  //       int.tryParse(result['end_date'].toString()) ?? "",
  //       result['latitude'].toString() ?? "",
  //       result['longitude'].toString() ?? "",
  //       result['write_information'].toString() ?? "",
  //       int.tryParse(result['service_plan'].toString()) ?? 0,
  //       int.tryParse(result['sfor_id'].toString()) ?? 0,
  //       gAm,
  //       result['geo_location'].toString() ?? "",
  //       result['specific_address'].toString() ?? "",
  //       result['cost_inc'].toString() ?? "",
  //       result['cost_exc'].toString() ?? "",
  //       result['currency'].toString() ?? "",
  //       int.tryParse(result['points'].toString()) ?? 0,
  //       result['pre_requisites'].toString() ?? "",
  //       result['minimum_requirements'].toString() ?? "",
  //       result['terms_conditions'].toString() ?? "",
  //       int.tryParse(result['recommended'].toString()) ?? 0,
  //       result['status'].toString() ?? "",
  //       result['image'].toString() ?? "",
  //       result['descreption]'].toString() ?? "",
  //       result['favourite_image'].toString() ?? "",
  //       result['created_at'].toString() ?? "",
  //       result['updated_at'].toString() ?? "",
  //       result['delete_at'].toString() ?? "",
  //       int.tryParse(result['provider_id'].toString()) ?? 0,
  //       result['provider_name'].toString() ?? "",
  //       result['provider_profile'].toString() ?? "",
  //       result['thumbnail'].toString() ?? "",
  //       result['rating'].toString() ?? "",
  //       int.tryParse(result['reviewed_by'].toString()) ?? 0,
  //       int.tryParse(result['is_liked'].toString()) ?? 0,
  //       result['baseurl'].toString() ?? "",
  //       gSim,
  //       gIAm,
  //       gdM,
  //       gPm,
  //       int.tryParse(result['stars'].toString()) ?? 0,
  //       int.tryParse(result['booked_seats'].toString()) ?? 0,
  //       gAfm,
  //       int.tryParse(result['booking'].toString()) ?? 0,
  //       gBdm,
  //       gMm,
  //       int.tryParse(result['booking'].toString()) ?? 0,
  //     );
  //     pGm.add(sm);
  //   }
  // }

  // void getServices() {
  //   ngm = Provider.of<ServicesProvider>(context).allServices;
  // }




          // var response = await http.post(
        //     Uri.parse(
        //         "https://adventuresclub.net/adventureClub/api/v1/create_service"),
        //     body: {
        //       'customer_id': Constants.userId.toString(), //"27",
        //       'adventure_name':
        //           adventureName.text, //adventureNameController.text,
        //       "country": Constants.countryId.toString(),
        //       'region': ConstantsCreateNewServices.selectedRegionId
        //           .toString(), //selectedRegionId.toString(),
        //       "service_sector": ConstantsCreateNewServices.selectedSectorId
        //           .toString(), //selectedSectorId.toString(), //"",
        //       "service_category": ConstantsCreateNewServices.selectedCategoryId
        //           .toString(), //"", //selectedCategoryId.toString(), //"",
        //       "service_type": ConstantsCreateNewServices.serviceTypeId
        //           .toString(), // //serviceTypeId.toString(), //"",
        //       "service_level": ConstantsCreateNewServices.selectedlevelId
        //           .toString(), //selectedlevelId.toString(), //"",
        //       "duration": ConstantsCreateNewServices.selectedDurationId
        //           .toString(), //selectedDurationId.toString(), //"",
        //       "available_seats": availableSeatsController.text, //"",
        //       "start_date": ConstantsCreateNewServices.startDate
        //           .toString(), //startDate, //"",
        //       "end_date": ConstantsCreateNewServices.endDate
        //           .toString(), //endDate, //"",
        //       "write_information":
        //           infoController.text, //infoController.text, //"",
        //       // it is for particular week or calender
        //       "service_plan": "1", //sPlan, //"1", //"",
        //       "cost_inc": costOne.text, //setCost1.text, //"",
        //       "cost_exc": costTwo.text, //setCost2.text, //"",
        //       "currency": "1", //  %%% this is hardcoded
        //       "pre_requisites":
        //           preRequisites.text, //"", //preReqController.text, //"",
        //       "minimum_requirements":
        //           minimumRequirement.text, //minController.text, //"",
        //       "terms_conditions": terms.text, //tncController.text, //"",
        //       "recommended": "1", // this is hardcoded
        //       // this key needs to be discussed,
        //       "service_plan_days": servicePlanId, //selectedActivitesId
        //       //.toString(), //"1,6,7", //// %%%%this needs discussion
        //       // "availability": servicePlanId,
        //       "service_for":
        //           selectedActivitesId, //selectedActivitesId.toString(),
        //       "particular_date":
        //           ConstantsCreateNewServices.startDate, //gatheringDate, //"",
        //       // this is an array
        //       "schedule_title[]":
        //           title, //titleController, //scheduleController.text, //scheduleController.text, //"",
        //       // schedule title in array is skipped
        //       // this is an array
        //       "gathering_date[]": "654", //gatheringDate, //"",
        //       // api did not accept list here
        //       "activities":
        //           selectedActivityIncludesId, //"5", // activityId, //"",
        //       "specific_address": specificAddressController
        //           .text, //"", //iLiveInController.text, //"",
        //       // this is a wrong field only for testing purposes....
        //       // this is an array
        //       "gathering_start_time[]": "10",
        //       // this is an arrayt
        //       "gathering_end_time[]": "15",
        //       "" //gatheringDate, //"",
        //               // this is an array
        //               "program_description[]":
        //           schedule, // scheduleControllerList, //scheduleDesController.text, //"",
        //       // "service_for": selectedActivitesId
        //       //     .toString(), //"1,2,5", //"4", //["1", "4", "5", "7"], //"",
        //       "dependency":
        //           selectedDependencyId, //selectedDependencyId.toString(), //["1", "2", "3"],
        //       "banner[]": banners[0], //adventureOne.toString(), //"",
        //       // banner image name.
        //       // we need file name,
        //       // after bytes array when adding into parameter. send the name of file.
        //       //
        //       "latitude": ConstantsCreateNewServices.lat
        //           .toString(), //lat.toString(), //"",
        //       "longitude": ConstantsCreateNewServices.lng
        //           .toString(), //lng.toString(), //"",
        //       // 'mobile_code': ccCode,
        //     });
        // print(response.statusCode);
        // print(response.body);
        // print(response.headers);
        // close();


  //        void myServicesApi() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //             "https://adventuresclub.net/adventureClub/api/v1/myserviceapi"),
  //         body: {
  //           'owner': Constants.userId.toString(), //"3",
  //           'country_id': Constants.countryId.toString(),
  //           //.toString(),
  //           //"2", //Constants.countryId.toString(), //"2",
  //           //'forgot_password': "0"
  //         });
  //     var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  //     List<dynamic> result = decodedResponse['data'];
  //     dynamic ga = decodedResponse['data']['availability'];
  //     dynamic nullbp = decodedResponse['data']['become_partner'];
  //     dynamic nullActivity = decodedResponse['data']['included_activities'];
  //     dynamic nullDependency = decodedResponse['data']['dependencies'];
  //     dynamic nullAimed = decodedResponse['data']['aimed_for'];
  //     dynamic nullImages = decodedResponse['data']['images'];
  //     dynamic nullProgrammes = decodedResponse['data']['programs'];
  //     List<AvailabilityPlanModel> gAccomodationPlanModel = [];
  //     List<IncludedActivitiesModel> gIAm = [];
  //     List<DependenciesModel> gdM = [];
  //     List<AimedForModel> gAccomodationAimedfm = [];
  //     List<ServiceImageModel> gAccomodationServImgModel = [];
  //     List<ProgrammesModel> gPm = [];
  //     List<AvailabilityModel> gAccomodoationAvaiModel = [];
  //     result.forEach(((element) {
  //       if (ga != null) {
  //         List<dynamic> availablePlan = element['availability'];
  //         availablePlan.forEach((ap) {
  //           AvailabilityPlanModel amPlan = AvailabilityPlanModel(
  //               ap['id'].toString() ?? "", ap['day'].toString() ?? "");
  //           gAccomodationPlanModel.add(amPlan);
  //         });
  //         List<dynamic> available = element['availability'];
  //         available.forEach((a) {
  //           AvailabilityModel am = AvailabilityModel(
  //               a['start_date'].toString() ?? "",
  //               a['end_date'].toString() ?? "");
  //           gAccomodoationAvaiModel.add(am);
  //         });
  //       }
  //       if (nullbp != null) {
  //         List<dynamic> becomePartner = element['become_partner'];
  //         becomePartner.forEach((b) {
  //           BecomePartner bp = BecomePartner(
  //               b['cr_name'].toString() ?? "",
  //               b['cr_number'].toString() ?? "",
  //               b['description'].toString() ?? "");
  //         });
  //       }
  //       if (nullActivity != null) {
  //         List<dynamic> iActivities = element['included_activities'];
  //         iActivities.forEach((iA) {
  //           IncludedActivitiesModel iAm = IncludedActivitiesModel(
  //             int.tryParse(iA['id'].toString()) ?? 0,
  //             int.tryParse(iA['service_id'].toString()) ?? 0,
  //             iA['activity_id'].toString() ?? "",
  //             iA['activity'].toString() ?? "",
  //             iA['image'].toString() ?? "",
  //           );
  //           gIAm.add(iAm);
  //         });
  //       }
  //       if (nullDependency != null) {
  //         List<dynamic> dependency = element['dependencies'];
  //         dependency.forEach((d) {
  //           DependenciesModel dm = DependenciesModel(
  //             int.tryParse(d['id'].toString()) ?? 0,
  //             d['dependency_name'].toString() ?? "",
  //             d['image'].toString() ?? "",
  //             d['updated_at'].toString() ?? "",
  //             d['created_at'].toString() ?? "",
  //             d['deleted_at'].toString() ?? "",
  //           );
  //           gdM.add(dm);
  //         });
  //       }
  //       if (nullAimed != null) {
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
  //       }
  //       if (nullImages != null) {
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
  //       }
  //       if (nullProgrammes != null) {
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
  //       }
  //       ServicesModel nSm = ServicesModel(
  //         int.tryParse(element['id'].toString()) ?? 0,
  //         int.tryParse(element['owner'].toString()) ?? 0,
  //         element['adventure_name'].toString() ?? "",
  //         element['country'].toString() ?? "",
  //         element['region'].toString() ?? "",
  //         element['city_id'].toString() ?? "",
  //         element['service_sector'].toString() ?? "",
  //         element['service_category'].toString() ?? "",
  //         element['service_type'].toString() ?? "",
  //         element['service_level'].toString() ?? "",
  //         element['duration'].toString() ?? "",
  //         int.tryParse(element['availability_seats'].toString()) ?? 0,
  //         int.tryParse(element['start_date'].toString()) ?? "",
  //         int.tryParse(element['end_date'].toString()) ?? "",
  //         element['latitude'].toString() ?? "",
  //         element['longitude'].toString() ?? "",
  //         element['write_information'].toString() ?? "",
  //         int.tryParse(element['service_plan'].toString()) ?? 0,
  //         int.tryParse(element['sfor_id'].toString()) ?? 0,
  //         gAccomodoationAvaiModel,
  //         gAccomodationPlanModel,
  //         element['geo_location'].toString() ?? "",
  //         element['specific_address'].toString() ?? "",
  //         element['cost_inc'].toString() ?? "",
  //         element['cost_exc'].toString() ?? "",
  //         element['currency'].toString() ?? "",
  //         int.tryParse(element['points'].toString()) ?? 0,
  //         element['pre_requisites'].toString() ?? "",
  //         element['minimum_requirements'].toString() ?? "",
  //         element['terms_conditions'].toString() ?? "",
  //         int.tryParse(element['recommended'].toString()) ?? 0,
  //         element['status'].toString() ?? "",
  //         element['image'].toString() ?? "",
  //         element['descreption]'].toString() ?? "",
  //         element['favourite_image'].toString() ?? "",
  //         element['created_at'].toString() ?? "",
  //         element['updated_at'].toString() ?? "",
  //         element['delete_at'].toString() ?? "",
  //         int.tryParse(element['provider_id'].toString()) ?? 0,
  //         int.tryParse(element['service_id'].toString()) ?? 0,
  //         element['provided_name'].toString() ?? "",
  //         element['provider_profile'].toString() ?? "",
  //         element['including_gerea_and_other_taxes'].toString() ?? "",
  //         element['excluding_gerea_and_other_taxes'].toString() ?? "",
  //         gIAm,
  //         gdM,
  //         nBp,
  //         gAccomodationAimedfm,
  //         gPm,
  //         element['stars'].toString() ?? "",
  //         int.tryParse(element['is_liked'].toString()) ?? 0,
  //         element['baseurl'].toString() ?? "",
  //         gAccomodationServImgModel,
  //         element['reviewd_by'].toString() ?? "",
  //         int.tryParse(element['remaining_seats'].toString()) ?? 0,
  //       );
  //       //gAccomodationSModel.add(nSm);
  //       allServices.add(nSm);
  //       allAccomodation.add(nSm);

  //       HomeServicesModel adv = HomeServicesModel("", gAccomodationSModel);
  //       setState(() {
  //         loading = false;
  //       });
  //       print(response.statusCode);
  //       print(response.body);
  //       print(response.headers);
  //     }));
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }