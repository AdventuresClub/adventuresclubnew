// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:math';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/client_requests.dart';
import 'package:adventuresclub/home_Screens/accounts/my_adventures.dart';
import 'package:adventuresclub/home_Screens/accounts/my_services.dart';
import 'package:adventuresclub/home_Screens/details.dart';
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
import 'package:adventuresclub/widgets/upcoming_request_information.dart';
import 'package:easy_localization/easy_localization.dart';
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
  List<UpcomingRequestsModel> uRequestListInv = [];
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
  static List<AvailabilityModel> ab = [];
  static List<AvailabilityPlanModel> ap = [];
  static List<IncludedActivitiesModel> ia = [];
  static List<DependenciesModel> dm = [];
  static List<BecomePartner> bp = [];
  static List<AimedForModel> am = []; // new
  static List<ProgrammesModel> programmes = [];
  static List<ServiceImageModel> images = [];
  List<BecomePartner> nBp = [];
  ProfileBecomePartner pbp = ProfileBecomePartner(0, 0, "", "", "", "", "", "",
      "", "", 0, 0, "", "", "", "", "", "", "", 0, "", "", "", "", "", "");
  static ServicesModel service = ServicesModel(
      0,
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      DateTime.now(),
      DateTime.now(),
      "",
      "",
      "",
      0,
      0,
      ab,
      ap,
      "",
      "",
      "",
      "",
      "",
      0,
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
      0,
      "",
      "",
      "",
      "",
      ia,
      dm,
      bp,
      am,
      programmes,
      "",
      0,
      "",
      images,
      "",
      "",
      0);

  void goToDetails(ServicesModel gm) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return Details(gm: gm);
        },
      ),
    );
  }

  @override
  initState() {
    super.initState();
    getList();
  }

  Future getList() async {
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/get_requests?user_id=${Constants.userId}&type=0"));
    try {
      List<UpcomingRequestsModel> uRequestList = [];
      if (response.statusCode == 200) {
        uList = json.decode(response.body);
        List<dynamic> result = uList['data'];
        result.forEach((element) {
          List<ServiceImageModel> gSim = [];
          List<dynamic> image = element['images'];
          image.forEach((i) {
            ServiceImageModel sm = ServiceImageModel(
              int.tryParse(i['id'].toString()) ?? 0,
              int.tryParse(i['service_id'].toString()) ?? 0,
              int.tryParse(i['is_default'].toString()) ?? 0,
              i['image_url'].toString(),
              i['thumbnail'].toString(),
            );
            gSim.add(sm);
          });
          String bookingN = element["booking_id"].toString();
          text2[0] = bookingN;
          UpcomingRequestsModel up = UpcomingRequestsModel(
              int.tryParse(bookingN) ?? 0,
              int.tryParse(element["service_id"].toString()) ?? 0,
              int.tryParse(element["provider_id"].toString()) ?? 0,
              int.tryParse(element["service_plan"].toString()) ?? 0,
              element["country"] ?? "",
              element["currency"] ?? "",
              element["region"] ?? "",
              element["adventure_name"] ?? "",
              element["provider_name"] ?? "",
              element["height"] ?? "",
              element["weight"] ?? "",
              element["health_conditions"] ?? "",
              element["booking_date"] ?? "",
              element["activity_date"] ?? "",
              int.tryParse(element["adult"].toString()) ?? 0,
              int.tryParse(element["kids"].toString()) ?? 0,
              element["unit_cost"] ?? "",
              element["total_cost"] ?? "",
              element["discounted_amount"] ?? "",
              element["payment_channel"] ?? "",
              element["status"] ?? "",
              element["payment_status"] ?? "",
              int.tryParse(element["points"].toString()) ?? 0,
              element["description"] ?? "",
              element["registrations"] ?? "",
              gSim);
          uRequestList.add(up);
        });
      }
      setState(() {
        uRequestListInv = uRequestList.reversed.toList();
      });
    } catch (e) {
      print(e);
    }
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
  List text2 = [
    '112',
    'Mr adventure',
    'John Doe',
    '30 Sep, 2020',
    '05 Oct, 2020',
    '2 Adults, 3 Youngsters',
    '\$ 400.50',
    '\$ 1500.50',
    '\$ 1500.50',
    'Debit/Credit Card'
  ];

  // void selected(BuildContext context, int serviceId, int providerId) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (_) {
  //         return ShowChat(
  //             "https://adventuresclub.net/adventureClub/newreceiverchat/${Constants.userId}/$serviceId/$providerId");
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

  void dropped(String bookingId, int index) async {
    Navigator.of(context).pop();
    UpcomingRequestsModel gR = uRequestListInv.elementAt(index);
    setState(() {
      uRequestListInv.removeAt(index);
    });
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/booking_accept"),
          body: {
            'booking_id': bookingId,
            'user_id': Constants.userId.toString(),
            'status': "5",
          });
      if (response.statusCode == 200) {
        setState(() {
          uRequestListInv.insert(index, gR);
        });
        message("Dropped Successfully");
      }
      print(response.statusCode);
    } catch (e) {
      print(e.toString());
    }
  }

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
        "https://adventuresclub.net/adventureClub/api/v1/services/$serviceId?user_id=$userId"));
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
        int.tryParse(result['id'].toString()) ?? 0,
        int.tryParse(result['owner'].toString()) ?? 0,
        result['adventure_name'].toString() ?? "",
        result['country'].toString() ?? "",
        result['region'].toString() ?? "",
        result['city_id'].toString() ?? "",
        result['service_sector'].toString() ?? "",
        result['service_category'].toString() ?? "",
        result['service_type'].toString() ?? "",
        result['service_level'].toString() ?? "",
        result['duration'].toString() ?? "",
        int.tryParse(result['availability_seats'].toString()) ?? 0,
        sDate,
        eDate,
        //int.tryParse(services['start_date'].toString()) ?? "",
        //int.tryParse(services['end_date'].toString()) ?? "",
        result['latitude'].toString() ?? "",
        result['longitude'].toString() ?? "",
        result['write_information'].toString() ?? "",
        int.tryParse(result['service_plan'].toString()) ?? 0,
        int.tryParse(result['sfor_id'].toString()) ?? 0,
        gAccomodoationAvaiModel,
        gAccomodationPlanModel,
        result['geo_location'].toString() ?? "",
        result['specific_address'].toString() ?? "",
        result['cost_inc'].toString() ?? "",
        result['cost_exc'].toString() ?? "",
        result['currency'].toString() ?? "",
        int.tryParse(result['points'].toString()) ?? 0,
        result['pre_requisites'].toString() ?? "",
        result['minimum_requirements'].toString() ?? "",
        result['terms_conditions'].toString() ?? "",
        int.tryParse(result['recommended'].toString()) ?? 0,
        result['status'].toString() ?? "",
        result['image'].toString() ?? "",
        result['descreption]'].toString() ?? "",
        result['favourite_image'].toString() ?? "",
        result['created_at'].toString() ?? "",
        result['updated_at'].toString() ?? "",
        result['delete_at'].toString() ?? "",
        int.tryParse(result['provider_id'].toString()) ?? 0,
        int.tryParse(result['service_id'].toString()) ?? 0,
        result['provided_name'].toString() ?? "",
        result['provider_profile'].toString() ?? "",
        result['including_gerea_and_other_taxes'].toString() ?? "",
        result['excluding_gerea_and_other_taxes'].toString() ?? "",
        gIAm,
        gdM,
        nBp,
        gAccomodationAimedfm,
        gPm,
        result['stars'].toString() ?? "",
        int.tryParse(result['is_liked'].toString()) ?? 0,
        result['baseurl'].toString() ?? "",
        gAccomodationServImgModel,
        result['rating'].toString() ?? "",
        result['reviewd_by'].toString() ?? "",
        int.tryParse(result['remaining_seats'].toString()) ?? 0,
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
                      onPressed: () => dropped(bookingId, index),
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
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/get_profile"),
          body: {
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
    return uRequestListInv.isEmpty
        ? Center(
            child: Column(
              children: [Text("thereIsNoUpcomingAdventureYet".tr())],
            ),
          )
        : RequestListView(uRequestListInv, getDetails);
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
    //                             "${'https://adventuresclub.net/adventureClub/public/uploads/'}${uRequestListInv[index].sImage[index].thumbnail}"),
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
