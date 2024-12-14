// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:math';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/client_requests.dart';
import 'package:adventuresclub/home_Screens/accounts/my_adventures.dart';
import 'package:adventuresclub/home_Screens/accounts/my_services.dart';
import 'package:adventuresclub/home_Screens/details.dart';
import 'package:adventuresclub/home_Screens/new_details.dart';
import 'package:adventuresclub/home_Screens/payment_methods/payment_methods.dart';
import 'package:adventuresclub/models/currency_model.dart';
import 'package:adventuresclub/models/filter_data_model/programs_model.dart';
import 'package:adventuresclub/models/home_services/become_partner.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/models/profile_models/profile_become_partner.dart';
import 'package:adventuresclub/models/requests/upcoming_Requests_Model.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/models/services/availability_model.dart';
import 'package:adventuresclub/models/services/create_services/availability_plan_model.dart';
import 'package:adventuresclub/models/services/dependencies_model.dart';
import 'package:adventuresclub/models/services/included_activities_model.dart';
import 'package:adventuresclub/models/user_profile_model.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:adventuresclub/widgets/Lists/request_list/request_list_view.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../models/services/service_image_model.dart';

class RequestsList extends StatefulWidget {
  const RequestsList({super.key});

  @override
  State<RequestsList> createState() => _RequestsListState();
}

class _RequestsListState extends State<RequestsList> {
  Map uList = {};
  // List<UpcomingRequestsModel> uRequestListInv = [];
  List<UpcomingRequestsModel> customList = [];
  bool loading = false;
  String payOnArrival = "";
  Map mapCountry = {};
  double packagePrice = 0;
  Map mapDetails = {};
  double selectedcountryPrice = 0;
  String transactionId = "";
  String orderId = "";
  int count = 8;
  // static List<AvailabilityModel> ab = [];
  // static List<AvailabilityPlanModel> ap = [];
  // static List<IncludedActivitiesModel> ia = [];
  // static List<DependenciesModel> dm = [];
  // static List<BecomePartner> bp = [];
  // static List<AimedForModel> am = []; // new
  // static List<ProgrammesModel> programmes = [];
  // static List<ServiceImageModel> images = [];
  List<BecomePartner> nBp = [];
  ProfileBecomePartner pbp = ProfileBecomePartner(0, 0, "", "", "", "", "", "",
      "", "", 0, 0, "", "", "", "", "", "", "", 0, "", "", "", "", "", "");
  static ServicesModel service = ServicesModel(
      id: 0,
      owner: 0,
      adventureName: "",
      country: "",
      region: "",
      cityId: "",
      serviceSector: "",
      serviceCategory: "",
      serviceId: 0,
      serviceLevel: "",
      serviceType: "",
      sAddress: "",
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      iaot: "",
      eaot: "",
      duration: "",
      aSeats: 0,
      lat: "",
      lng: "",
      writeInformation: "",
      sPlan: 0,
      sForID: 0,
      availability: [],
      availabilityPlan: [],
      geoLocation: "",
      costExc: "",
      costInc: "",
      currency: "",
      points: 0,
      preRequisites: "",
      providerId: 0,
      pName: "",
      pProfile: "",
      programmes: [],
      mRequirements: "",
      tnc: "",
      activityIncludes: [],
      am: [],
      recommended: 0,
      status: "",
      stars: "",
      remainingSeats: 0,
      image: "",
      fImage: "",
      des: "",
      da: "",
      upda: "",
      ca: "",
      dependency: [],
      bp: [],
      isLiked: "",
      baseURL: "",
      images: [],
      rating: "",
      reviewdBy: "",
      serviceCategoryImage: "",
      serviceLevelImage: "",
      serviceTypeImage: "",
      serviceSectorImage: "");

  void goToDetails(ServicesModel gm) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return NewDetails(gm: gm);
        },
      ),
    );
  }

  void goTo() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const ClientsRequests();
    }));
  }

  void goTo_() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const MyServices();
    }));
  }

  List text = [
    'Booking Number :',
    'Activity Name :',
    'Provider Name :',
    'Booking Date :',
    'Activity Date :',
    'Registrations :',
    'Unit Cost :',
    'Total Cost :',
    'Payable Cost',
    'Payment Channel :'
  ];

  // void selected(BuildContext context, int serviceId, int providerId) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (_) {
  //         return ShowChat(
  //             "${Constants.baseUrl}/newreceiverchat/${Constants.userId}/$serviceId/$providerId");
  //       },
  //     ),
  //   );
  // }

  void goToMyAd(UpcomingRequestsModel gm) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return MyAdventures(gm);
        },
      ),
    );
  }

  // void dropped(String bookingId, int index) async {
  //   Navigator.of(context).pop();
  //   UpcomingRequestsModel gR = uRequestListInv.elementAt(index);
  //   setState(() {
  //     uRequestListInv.removeAt(index);
  //   });
  //   try {
  //     var response = await http
  //         .post(Uri.parse("${Constants.baseUrl}/api/v1/booking_accept"), body: {
  //       'booking_id': bookingId,
  //       'user_id': Constants.userId.toString(),
  //       'status': "5",
  //     });
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         uRequestListInv.insert(index, gR);
  //       });
  //       message("Dropped Successfully");
  //     }
  //     print(response.statusCode);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future getDetails(String serviceId, String userId) async {
    setState(() {
      loading = true;
    });
    var response = await http.get(Uri.parse(
        "${Constants.baseUrl}/api/v1/services/$serviceId?user_id=$userId"));
    if (response.statusCode == 200) {
      mapDetails = json.decode(response.body);
      dynamic result = mapDetails['data'];
      List<AvailabilityPlanModel> gAccomodationPlanModel = [];
      List<dynamic> availablePlan = result['availability'];
      availablePlan.forEach((ap) {
        AvailabilityPlanModel amPlan = AvailabilityPlanModel(
            int.tryParse(ap['id'].toString()) ?? 0, ap['day'].toString());
        gAccomodationPlanModel.add(amPlan);
      });
      List<AvailabilityModel> gAccomodoationAvaiModel = [];
      List<dynamic> available = result['availability'];
      available.forEach((a) {
        AvailabilityModel am = AvailabilityModel(
            a['start_date'].toString() ?? "", a['end_date'].toString() ?? "");
        gAccomodoationAvaiModel.add(am);
      });
      if (result['become_partner'] != null) {
        List<dynamic> becomePartner = result['become_partner'];
        becomePartner.forEach((b) {
          BecomePartner bp = BecomePartner(
              b['cr_name'].toString() ?? "",
              b['cr_number'].toString() ?? "",
              b['description'].toString() ?? "");
        });
      }
      List<IncludedActivitiesModel> gIAm = [];
      List<dynamic> iActivities = result['included_activities'];
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
      List<dynamic> dependency = result['dependencies'];
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
      List<dynamic> aF = result['aimed_for'];
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
      List<dynamic> image = result['images'];
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
      List<dynamic> programs = result['programs'];
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
          DateTime.tryParse(result['start_date'].toString()) ?? DateTime.now();
      DateTime eDate =
          DateTime.tryParse(result['end_date'].toString()) ?? DateTime.now();
      ServicesModel nSm = ServicesModel(
        id: int.tryParse(result['id'].toString()) ?? 0,
        owner: int.tryParse(result['owner'].toString()) ?? 0,
        adventureName: result['adventure_name'].toString() ?? "",
        country: result['country'].toString() ?? "",
        region: result['region'].toString() ?? "",
        cityId: result['city_id'].toString() ?? "",
        serviceSector: result['service_sector'].toString() ?? "",
        serviceCategory: result['service_category'].toString() ?? "",
        serviceType: result['service_type'].toString() ?? "",
        serviceLevel: result['service_level'].toString() ?? "",
        duration: result['duration'].toString() ?? "",
        aSeats: int.tryParse(result['available_seats'].toString()) ?? 0,
        startDate: sDate,
        endDate: eDate,
        //int.tryParse(services['start_date'].toString()) ?? "",
        //int.tryParse(services['end_date'].toString()) ?? "",
        lat: result['latitude'].toString() ?? "",
        lng: result['longitude'].toString() ?? "",
        writeInformation: result['write_information'].toString() ?? "",
        sPlan: int.tryParse(result['service_plan'].toString()) ?? 0,
        sForID: int.tryParse(result['sfor_id'].toString()) ?? 0,
        availability: gAccomodoationAvaiModel,
        availabilityPlan: gAccomodationPlanModel,
        geoLocation: result['geo_location'].toString() ?? "",
        sAddress: result['specific_address'].toString() ?? "",
        costInc: result['cost_inc'].toString() ?? "",
        costExc: result['cost_exc'].toString() ?? "",
        currency: result['currency'].toString() ?? "",
        points: int.tryParse(result['points'].toString()) ?? 0,
        preRequisites: result['pre_requisites'].toString() ?? "",
        mRequirements: result['minimum_requirements'].toString() ?? "",
        tnc: result['terms_conditions'].toString() ?? "",
        recommended: int.tryParse(result['recommended'].toString()) ?? 0,
        status: result['status'].toString() ?? "",
        image: result['image'].toString() ?? "",
        des: result['descreption]'].toString() ?? "",
        fImage: result['favourite_image'].toString() ?? "",
        ca: result['created_at'].toString() ?? "",
        upda: result['updated_at'].toString() ?? "",
        da: result['delete_at'].toString() ?? "",
        providerId: int.tryParse(result['provider_id'].toString()) ?? 0,
        serviceId: int.tryParse(result['service_id'].toString()) ?? 0,
        pName: result['provided_name'].toString() ?? "",
        pProfile: result['provider_profile'].toString() ?? "",
        serviceCategoryImage: result['service_category_image'] ?? "",
        serviceSectorImage: result['service_sector_image'] ?? "",
        serviceTypeImage: result['service_type_image'] ?? "",
        serviceLevelImage: result['service_level_image'] ?? "",
        iaot: result['including_gerea_and_other_taxes'].toString() ?? "",
        eaot: result['excluding_gerea_and_other_taxes'].toString() ?? "",
        activityIncludes: gIAm,
        dependency: gdM,
        bp: nBp,
        am: gAccomodationAimedfm,
        programmes: gPm,
        stars: result['stars'].toString() ?? "",
        isLiked: int.tryParse(result['is_liked'].toString()) ?? 0,
        baseURL: result['baseurl'].toString() ?? "",
        images: gAccomodationServImgModel,
        rating: result['rating'].toString() ?? "",
        reviewdBy: result['reviewd_by'].toString() ?? "",
        remainingSeats: int.tryParse(result['remaining_seats'].toString()) ?? 0,
      );
      //gAccomodationSModel.add(nSm);
      setState(() {
        service = nSm;
        loading = false;
      });
      goToDetails(service);
    }
  }

  void showConfirmation(String bookingId, int index) async {
    showDialog(
        context: context,
        builder: (ctx) => SimpleDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: MyText(
                text: "Alert",
                size: 18,
                weight: FontWeight.bold,
                color: blackColor,
              ),
              children: [
                const SizedBox(
                  height: 10,
                ),
                //Text("data"),
                const Text(
                  "Are you sure you want to Delete This?",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: MyText(
                        text: "No",
                        color: blackColor,
                        weight: FontWeight.bold,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () => {}, //dropped(bookingId, index),
                      child: MyText(
                        text: "Yes",
                        color: blackColor,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                //BottomButton(bgColor: blueButtonColor, onTap: homePage)
              ],
            ));
  }

  void getProfile(String providerId, String amount, String bId, String cur,
      String tCost, UpcomingRequestsModel rm) async {
    setState(() {
      loading = true;
    });
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/get_profile"), body: {
        'user_id': providerId, //"hamza@gmail.com",
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
          partnerInfo['company_name'].toString(),
          partnerInfo['address'].toString(),
          partnerInfo['location'].toString(),
          partnerInfo['description'].toString(),
          partnerInfo['license'].toString(),
          partnerInfo['cr_name'].toString(),
          partnerInfo['cr_number'].toString(),
          partnerInfo['cr_copy'].toString(),
          debitCard,
          visaCard,
          partnerInfo['payon_arrival'].toString(),
          partnerInfo['paypal'].toString(),
          partnerInfo['bankname'].toString(),
          partnerInfo['account_holdername'].toString(),
          partnerInfo['account_number'].toString(),
          partnerInfo['is_online'].toString(),
          partnerInfo['is_approved'].toString(),
          packagesId,
          partnerInfo['start_date'].toString(),
          partnerInfo['end_date'].toString(),
          partnerInfo['is_wiretransfer'].toString(),
          partnerInfo['is_free_used'].toString(),
          partnerInfo['created_at'].toString(),
          partnerInfo['updated_at'].toString(),
        );
        pbp = bp;
      }
      UserProfileModel up = UserProfileModel(
          userLoginId,
          userData['users_role'].toString(),
          userData['profile_image'].toString(),
          userData['name'].toString(),
          userData['height'].toString(),
          userData['weight'].toString(),
          userData['email'].toString(),
          countryId,
          userData['region_id'].toString(),
          userData['city_id'].toString(),
          userData['now_in'].toString(),
          userData['mobile'].toString(),
          userData['mobile_verified_at'].toString(),
          userData['dob'].toString(),
          userData['gender'].toString(),
          languageId,
          userData['nationality_id'].toString(),
          currencyId,
          userData['app_notification'].toString(),
          userData['points'].toString(),
          userData['health_conditions'].toString(),
          userData['health_conditions_id'].toString(),
          userData['email_verified_at'].toString(),
          userData['mobile_code'].toString(),
          userData['status'].toString(),
          addedFrom,
          userData['created_at'].toString(),
          userData['updated_at'].toString(),
          userData['deleted_at'].toString(),
          userData['device_id'].toString(),
          pbp);
      setState(() {
        payOnArrival = up.bp.payOnArrival;
        loading = false;
      });
      getPaymentMode(payOnArrival, amount, bId, cur, tCost, rm);
      // Constants.userRole = up.userRole;
      // prefs.setString("userRole", up.userRole);
    } catch (e) {
      print(e.toString());
    }
  }

  void getPaymentMode(String pay, String amount, String bId, String cur,
      String tCost, UpcomingRequestsModel rm) async {
    if (pay == "1") {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return PaymentMethods(rm, amount, bId, cur, tCost);
      }));
    } else {
      fetchCurrency(amount, bId, cur, tCost);
    }
  }

  Future<List<CurrencyModel>> fetchCurrency(
      String value, String bookingId, String currency, String totalCost) async {
    double valueDouble = double.tryParse(value) ?? 0;
    final response = await http.get(Uri.parse(
        'https://api.fastforex.io/fetch-all?api_key=5d7d771c49-103d05e0d0-riwfxc'));
    mapCountry = jsonDecode(response.body);
    if (response.statusCode == 200) {
      dynamic result = mapCountry['results'];
      if (result['OMR'] != currency) {
        double tcDouble = double.tryParse(totalCost) ?? 0;
        CurrencyModel cm = CurrencyModel(result[currency]);
        CurrencyModel omrPrice = CurrencyModel(result['OMR']);
        convertCurrency(cm.currency, omrPrice.currency, tcDouble);
        selected(context, bookingId);
        print(selectedcountryPrice);
      } else {
        CurrencyModel cm = CurrencyModel(result['OMR']);
        packagePrice = valueDouble * cm.currency;
        selected(context, bookingId);
        print(packagePrice);
        print(cm.currency);
      }
      //  transactionApi(packagePrice.toString(), id);

      List<CurrencyModel> currencies = [];
      return currencies;
    } else {
      throw Exception('Failed');
    }
  }

  void selected(BuildContext context, String bookingId) {
    generateRandomString(10);
    // transaction id is random uniuq generated number
    // currency has to be omr
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
            "${'https://adventuresclub.net/admin1/dataFrom.htm?amount=$packagePrice&merchant_id=${67}&order_id=$orderId&tid=$transactionId&billing_name=${Constants.profile.name}&billing_address=${Constants.profile.bp.address}&billing_city=${Constants.profile.bp.address}&billing_zip=${Constants.profile.bp.address}&billing_country=${Constants.profile.bp.address}&billing_tel=${"widget.uRequestList.bDate"}&billing_email=${"widget.uRequestList.adventureName"}'}${'&merchant_param1=${'booking'}&merchant_param2=$bookingId&merchant_param3=${Constants.userId}&merchant_param4=${"widget.uRequestList.tCost"}&merchant_param5=${"widget.uRequestList.adult"}'}",
            show: true,
          );
        },
      ),
    );
    // print(object);
  }

  String generateRandomString(int lengthOfString) {
    generateRandomId(10);
    final random = Random();
    const allChars = 'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL';
    final randomString = List.generate(
        count, (index) => allChars[random.nextInt(allChars.length)]).join();
    setState(() {
      orderId = randomString;
    });
    return randomString; // return the generated string
  }

  String generateRandomId(int lengthOfString) {
    final random = Random();
    const allChars = "18744651324650"; //'RrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL';
    final randomString = List.generate(
        count, (index) => allChars[random.nextInt(allChars.length)]).join();
    setState(() {
      transactionId = randomString;
    });
    return randomString; // return the generated string
  }

  void convertCurrency(double p, double omrPrice, double tc) {
    selectedcountryPrice = p;
    double omrInverse = 1 / omrPrice;
    double product = selectedcountryPrice * omrInverse;
    double omrConverted = 1 / product;
    setState(() {
      packagePrice = omrConverted * tc;
    });
    print(packagePrice);
  }

  @override
  Widget build(BuildContext context) {
    return
        // uRequestListInv.isEmpty
        //     ?
        // Center(
        //     child: Column(
        //       children: [Text("thereIsNoUpcomingAdventureYet".tr())],
        //     ),
        //   )
        // :
        Container();
    //RequestListView(getDetails);
    // ListView.builder(
    //     padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 00),
    //     shrinkWrap: true,
    //     physics: const ClampingScrollPhysics(),
    //     itemCount: uRequestListInv.length,
    //     scrollDirection: Axis.vertical,
    //     itemBuilder: (context, index) {
    //       return
    //           // UpcomingRequestInformation(
    //           //     uRequestListInv[index], showConfirmation);
    //           Card(
    //         key: Key(uRequestListInv[index].BookingId.toString()),
    //         elevation: 4,
    //         child: Padding(
    //           padding:
    //               const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5),
    //           child: Column(
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   MyText(
    //                     text: uRequestListInv[index]
    //                         .region, //'Location Name',
    //                     color: blackColor,
    //                     weight: FontWeight.bold,
    //                   ),
    //                   Row(
    //                     children: [
    //                       if (uRequestListInv[index].status == "0")
    //                         MyText(
    //                           text: "REQUESTED", //'Confirmed',
    //                           color: blueColor1,
    //                           weight: FontWeight.bold,
    //                         ),
    //                       if (uRequestListInv[index].status == "1")
    //                         MyText(
    //                           text: "ACCEPTED", //'Confirmed',
    //                           color: orangeColor,
    //                           weight: FontWeight.bold,
    //                         ),
    //                       if (uRequestListInv[index].status == "2")
    //                         MyText(
    //                           text: "PAID", //'Confirmed',
    //                           color: greenColor1,
    //                           weight: FontWeight.bold,
    //                         ),
    //                       if (uRequestListInv[index].status == "3")
    //                         MyText(
    //                           text: "DECLINED", //'Confirmed',
    //                           color: redColor,
    //                           weight: FontWeight.bold,
    //                         ),
    //                       if (uRequestListInv[index].status == "4")
    //                         MyText(
    //                           text: "COMPLETED", //'Confirmed',
    //                           color: greenColor1,
    //                           weight: FontWeight.bold,
    //                         ),
    //                       if (uRequestListInv[index].status == "5")
    //                         MyText(
    //                           text: "DROPPED", //'Confirmed',
    //                           color: redColor,
    //                           weight: FontWeight.bold,
    //                         ),
    //                       if (uRequestListInv[index].status == "6")
    //                         MyText(
    //                           text: "CONFIRM", //'Confirmed',
    //                           color: greenColor1,
    //                           weight: FontWeight.bold,
    //                         ),
    //                       if (uRequestListInv[index].status == "7")
    //                         MyText(
    //                           text: "UNPAID", //'Confirmed',
    //                           color: greenColor1,
    //                           weight: FontWeight.bold,
    //                         ),
    //                       const SizedBox(
    //                         width: 5,
    //                       ),
    //                       // GestureDetector(
    //                       //   onTap: () => showConfirmation(
    //                       //       uRequestListInv[index][index].serviceId.toString()),
    //                       //   child: const Icon(
    //                       //     Icons.delete_forever_outlined,
    //                       //     color: redColor,
    //                       //     size: 20,
    //                       //   ),
    //                       // )
    //                     ],
    //                   )
    //                 ],
    //               ),
    //               const Divider(
    //                 thickness: 1,
    //                 color: greyColor,
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   //CircleImageAvatar(uRequestList.sImage),
    //                   //UpcomingRequestImage(rm),
    //                   CircleAvatar(
    //                     radius: 26,
    //                     backgroundImage:
    //                         //ExactAssetImage('images/airrides.png'),
    //                         NetworkImage(
    //                             "${'${Constants.baseUrl}/public/uploads/'}${uRequestListInv[index].sImage[index].thumbnail}"),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(
    //                         horizontal: 12.0, vertical: 5),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Wrap(
    //                           direction: Axis.vertical,
    //                           children: [
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.start,
    //                               children: [
    //                                 MyText(
    //                                   text: "Booking Number : ",
    //                                   color: blackColor,
    //                                   weight: FontWeight.w500,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                                 MyText(
    //                                   text:
    //                                       uRequestListInv[index].BookingId,
    //                                   color: greyColor,
    //                                   weight: FontWeight.w400,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                               ],
    //                             ),
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.start,
    //                               children: [
    //                                 MyText(
    //                                   text: "Activity Name : ",
    //                                   color: blackColor,
    //                                   weight: FontWeight.w500,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                                 MyText(
    //                                   text: uRequestListInv[index]
    //                                       .adventureName,
    //                                   color: greyColor,
    //                                   weight: FontWeight.w400,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                               ],
    //                             ),
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.start,
    //                               children: [
    //                                 MyText(
    //                                   text: "Provider Name : ",
    //                                   color: blackColor,
    //                                   weight: FontWeight.w500,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                                 MyText(
    //                                   text: uRequestListInv[index].pName,
    //                                   color: greyColor,
    //                                   weight: FontWeight.w400,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                               ],
    //                             ),
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.start,
    //                               children: [
    //                                 MyText(
    //                                   text: "Booking Date : ",
    //                                   color: blackColor,
    //                                   weight: FontWeight.w500,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                                 MyText(
    //                                   text: uRequestListInv[index].bDate,
    //                                   color: greyColor,
    //                                   weight: FontWeight.w400,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                               ],
    //                             ),
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.start,
    //                               children: [
    //                                 MyText(
    //                                   text: "Activity Date : ",
    //                                   color: blackColor,
    //                                   weight: FontWeight.w500,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                                 MyText(
    //                                   text: uRequestListInv[index].aDate,
    //                                   color: greyColor,
    //                                   weight: FontWeight.w400,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                               ],
    //                             ),
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.start,
    //                               children: [
    //                                 MyText(
    //                                   text: 'Registrations : ',
    //                                   color: blackColor,
    //                                   weight: FontWeight.w400,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                                 if (uRequestListInv[index].adult != 0)
    //                                   MyText(
    //                                     text:
    //                                         "${uRequestListInv[index].adult} "
    //                                         " ${"Adult, "}",
    //                                     color: greyTextColor,
    //                                     weight: FontWeight.w400,
    //                                     size: 12,
    //                                     height: 1.8,
    //                                   ),
    //                                 if (uRequestListInv[index].kids != 0)
    //                                   MyText(
    //                                     text:
    //                                         "${uRequestListInv[index].kids} "
    //                                         " ${"Kids"}",
    //                                     color: greyTextColor,
    //                                     weight: FontWeight.w400,
    //                                     size: 12,
    //                                     height: 1.8,
    //                                   ),
    //                               ],
    //                             ),
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.start,
    //                               children: [
    //                                 MyText(
    //                                   text: "Unit Cost : ",
    //                                   color: blackColor,
    //                                   weight: FontWeight.w500,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                                 MyText(
    //                                   text: uRequestListInv[index].uCost,
    //                                   color: greyColor,
    //                                   weight: FontWeight.w400,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                               ],
    //                             ),
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.start,
    //                               children: [
    //                                 MyText(
    //                                   text: "Total Cost : ",
    //                                   color: blackColor,
    //                                   weight: FontWeight.w500,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                                 MyText(
    //                                   text: uRequestListInv[index].tCost,
    //                                   color: greyColor,
    //                                   weight: FontWeight.w400,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                               ],
    //                             ),
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.start,
    //                               children: [
    //                                 MyText(
    //                                   text: "Payable Cost : ",
    //                                   color: blackColor,
    //                                   weight: FontWeight.w500,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                                 MyText(
    //                                   text: uRequestListInv[index].tCost,
    //                                   color: greyColor,
    //                                   weight: FontWeight.w400,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                               ],
    //                             ),
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.start,
    //                               children: [
    //                                 MyText(
    //                                   text: "Payment Channel : ",
    //                                   color: blackColor,
    //                                   weight: FontWeight.w500,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                                 MyText(
    //                                   text: uRequestListInv[index].pChanel,
    //                                   color: greyColor,
    //                                   weight: FontWeight.w400,
    //                                   size: 13,
    //                                   height: 1.8,
    //                                 ),
    //                               ],
    //                             ),
    //                           ],
    //                           // List.generate(
    //                           //   text.length,
    //                           //   (index) {
    //                           //     return

    //                           //   },
    //                           // ),
    //                         ),
    //                         const SizedBox(height: 10),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 4),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Container(
    //                       height: 45,
    //                       width: MediaQuery.of(context).size.width / 3.6,
    //                       decoration: const BoxDecoration(
    //                           borderRadius:
    //                               BorderRadius.all(Radius.circular(12)),
    //                           color: bluishColor),
    //                       child: Material(
    //                         color: Colors.transparent,
    //                         child: InkWell(
    //                           onTap: () => getDetails(
    //                               uRequestListInv[index]
    //                                   .serviceId
    //                                   .toString(),
    //                               uRequestListInv[index]
    //                                   .providerId
    //                                   .toString()),
    //                           child: const Center(
    //                             child: Text(
    //                               'View Details',
    //                               style: TextStyle(
    //                                   color: whiteColor,
    //                                   fontSize: 12,
    //                                   fontWeight: FontWeight.w700),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       // color: bluishColor,
    //                     ),
    //                     Container(
    //                       height: 45,
    //                       width: MediaQuery.of(context).size.width / 3.6,
    //                       decoration: const BoxDecoration(
    //                           borderRadius:
    //                               BorderRadius.all(Radius.circular(12)),
    //                           color: redColor),
    //                       child: Material(
    //                         color: Colors.transparent,
    //                         child: InkWell(
    //                           onTap: // () {},
    //                               () => showConfirmation(
    //                                   uRequestListInv[index]
    //                                       .BookingId
    //                                       .toString(),
    //                                   index), //     () => showConfirmation(
    //                           //   widget.uRequestListInv[index].BookingId.toString(),
    //                           // ),
    //                           child: const Center(
    //                             child: Text(
    //                               'Cancel Request',
    //                               style: TextStyle(
    //                                   color: whiteColor,
    //                                   fontSize: 12,
    //                                   fontWeight: FontWeight.w700),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       // color: bluishColor,
    //                     ),
    //                     Container(
    //                       height: 45,
    //                       width: MediaQuery.of(context).size.width / 3.6,
    //                       decoration: uRequestListInv[index].status == "1"
    //                           ? const BoxDecoration(
    //                               borderRadius:
    //                                   BorderRadius.all(Radius.circular(12)),
    //                               color: greenColor1)
    //                           : const BoxDecoration(
    //                               borderRadius:
    //                                   BorderRadius.all(Radius.circular(12)),
    //                               color: Color.fromARGB(255, 137, 176, 92)),
    //                       child: Material(
    //                         color: Colors.transparent,
    //                         child: InkWell(
    //                           onTap: uRequestListInv[index].status == "1"
    //                               ? () => getProfile(
    //                                   uRequestListInv[index]
    //                                       .providerId
    //                                       .toString(),
    //                                   uRequestListInv[index].tCost,
    //                                   uRequestListInv[index]
    //                                       .BookingId
    //                                       .toString(),
    //                                   uRequestListInv[index].currency,
    //                                   uRequestListInv[index].tCost,
    //                                   uRequestListInv[index])
    //                               : () {},
    //                           child: const Center(
    //                             child: Text(
    //                               'Make Payment',
    //                               style: TextStyle(
    //                                   color: whiteColor,
    //                                   fontSize: 12,
    //                                   fontWeight: FontWeight.w700),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       // color: bluishColor,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   );
  }
}
