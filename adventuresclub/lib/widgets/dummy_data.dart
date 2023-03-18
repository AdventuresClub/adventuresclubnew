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