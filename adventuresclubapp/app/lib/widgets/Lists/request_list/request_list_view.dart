import 'dart:convert';
import 'dart:math';

import 'package:app/constants.dart';
import 'package:app/home_Screens/new_details.dart';
import 'package:app/home_Screens/payment_methods/payment_methods.dart';
import 'package:app/models/currency_model.dart';
import 'package:app/models/filter_data_model/programs_model.dart';
import 'package:app/models/home_services/become_partner.dart';
import 'package:app/models/home_services/services_model.dart';
import 'package:app/models/profile_models/profile_become_partner.dart';
import 'package:app/models/requests/upcoming_Requests_Model.dart';
import 'package:app/models/services/aimed_for_model.dart';
import 'package:app/models/services/availability_model.dart';
import 'package:app/models/services/create_services/availability_plan_model.dart';
import 'package:app/models/services/dependencies_model.dart';
import 'package:app/models/services/included_activities_model.dart';
import 'package:app/models/services/service_image_model.dart';
import 'package:app/models/user_profile_model.dart';
import 'package:app/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:app/widgets/loading_widget.dart';
import 'package:app/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RequestListView extends StatefulWidget {
  //final List<UpcomingRequestsModel> uRequestList;
  //final Function getDetails;
  const RequestListView(
      //this.uRequestList,
      //this.getDetails,
      {super.key});

  @override
  State<RequestListView> createState() => _RequestListViewState();
}

class _RequestListViewState extends State<RequestListView> {
  List<UpcomingRequestsModel> uRequestListInv = [];
  bool loading = false;
  // static List<AvailabilityModel> ab = [];
  // static List<AvailabilityPlanModel> ap = [];
  // static List<IncludedActivitiesModel> ia = [];
  // static List<DependenciesModel> dm = [];
  // static List<BecomePartner> bp = [];
  // static List<AimedForModel> am = []; // new
  // static List<ProgrammesModel> programmes = [];
  // static List<ServiceImageModel> images = [];
  List<BecomePartner> nBp = [];
  String payOnArrival = "";
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
      incDescription: "",
      excDescription: "",
      serviceSectorImage: "");
  Map mapCountry = {};
  Map uList = {};
  double packagePrice = 0;
  Map mapDetails = {};
  double selectedcountryPrice = 0;
  String transactionId = "";
  String orderId = "";
  int count = 8;
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

  // @override
  // void initState() {
  //   super.initState();
  //   uRequestListInv = widget.uRequestList;
  //   // text2.insert(0, widget.rm[index].bookingId)
  // }

  @override
  initState() {
    super.initState();
    getList();
  }

  void getList() async {
    setState(() {
      loading = true;
    });
    var response = await http.get(Uri.parse(
        "${Constants.baseUrl}/api/v1/get_requests?user_id=${Constants.userId}&type=0"));

    try {
      List<UpcomingRequestsModel> uRequestList = [];
      if (response.statusCode == 200) {
        uList = json.decode(response.body);
        List<dynamic> result = uList['data'];
        for (var element in result) {
          List<ServiceImageModel> gSim = [];
          List<dynamic> image = element['images'];
          for (var i in image) {
            ServiceImageModel sm = ServiceImageModel(
              int.tryParse(i['id'].toString()) ?? 0,
              int.tryParse(i['service_id'].toString()) ?? 0,
              int.tryParse(i['is_default'].toString()) ?? 0,
              i['image_url'].toString(),
              i['thumbnail'].toString(),
            );
            gSim.add(sm);
          }
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
        }
      }
      //setState(() {
      uRequestListInv = uRequestList.reversed.toList();

      // });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void getProfile(String providerId, String amount, String bId, String cur,
      String tCost, UpcomingRequestsModel rm, int index,
      {bool refresh = true}) async {
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
      if (refresh) {
        getPaymentMode(payOnArrival, amount, bId, cur, tCost, rm, index);
      }

      // Constants.userRole = up.userRole;
      // prefs.setString("userRole", up.userRole);
    } catch (e) {
      print(e.toString());
    }
  }

  void getPaymentMode(String pay, String amount, String bId, String cur,
      String tCost, UpcomingRequestsModel rm, int index) async {
    if (pay == "1") {
      bool? check = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return PaymentMethods(
              rm,
              amount,
              bId,
              cur,
              tCost,
            );
          },
        ),
      );
      //getList();
      UpcomingRequestsModel gR = uRequestListInv.elementAt(index);
      if (check != null && check) {
        setState(() {
          gR.status = "8";
          uRequestListInv[index].status = "8";
        });
      } else {
        getProfile(
            uRequestListInv[index].providerId.toString(),
            uRequestListInv[index].tCost,
            uRequestListInv[index].BookingId.toString(),
            uRequestListInv[index].currency,
            uRequestListInv[index].tCost,
            uRequestListInv[index],
            index,
            refresh: false);
      }
    } else {
      fetchCurrency(amount, bId, cur, tCost, rm);
    }
  }

  Future<List<CurrencyModel>> fetchCurrency(String value, String bookingId,
      String currency, String totalCost, UpcomingRequestsModel rm) async {
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
        selected(context, bookingId, rm);
      } else {
        CurrencyModel cm = CurrencyModel(result['OMR']);
        packagePrice = valueDouble * cm.currency;
        selected(context, bookingId, rm);
      }
      List<CurrencyModel> currencies = [];
      return currencies;
    } else {
      throw Exception('Failed');
    }
  }

  void selected(
      BuildContext context, String bookingId, UpcomingRequestsModel rm) async {
    generateRandomString(10);
    String price = packagePrice.toString();
    // transaction id is random uniuq generated number
    // currency has to be omr
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
            "${'https://adventuresclub.net/admin1/dataFrom.htm?amount=$packagePrice&merchant_id=${430}&order_id=$orderId&tid=$transactionId&billing_name=${Constants.profile.name}&billing_address=${Constants.profile.bp.address}&billing_city=${Constants.profile.bp.address}&billing_zip=${Constants.profile.bp.address}&billing_country=${Constants.profile.bp.address}&billing_tel=${"widget.uRequestList.bDate"}&billing_email=${"widget.uRequestList.adventureName"}'}${'&merchant_param1=${'booking'}&merchant_param2=$bookingId&merchant_param3=${Constants.userId}&merchant_param4=${"widget.uRequestList.tCost"}&merchant_param5=${"widget.uRequestList.adult"}'}",
            show: true,
          );
        },
      ),
    );
    getList();
    // update(price, rm);
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
      packagePrice = Constants.roundToDecimalPlaces(omrConverted * tc);
      ;
    });
  }

  DateTime stringToDateTime(String dateString, {String format = 'yyyy-MM-dd'}) {
    try {
      return DateFormat(format).parse(dateString);
    } catch (e) {
      throw FormatException('Invalid date format: $e');
    }
  }

  void showConfirmation(String bookingId, int index, String serviceId,
      UpcomingRequestsModel request) async {
    String status = "";
    String message = "";
    DateTime t = DateTime.now();
    DateTime act = stringToDateTime(request.aDate);
    if (t.day == act.day) {
      status = "11";
      message =
          "According to our cancellation policy. The amount is not refundable";
    } else if (act.isAfter(t)) {
      // Check if exactly 1 calendar day difference
      DateTime tomorrow = DateTime(t.year, t.month, t.day + 1);
      DateTime dayAtomorrow = DateTime(t.year, t.month, t.day + 2);
      DateTime twoDaysAhead = DateTime(t.year, t.month, t.day + 3);
      DateTime actDate = DateTime(act.year, act.month, act.day);

      if (actDate == tomorrow || actDate == dayAtomorrow) {
        status = "10";
        message =
            "According to our cancellation policy. 50% amount will be refundable";
      } else {
        status = "9";
        message =
            "According to our cancellation policy. 100% amount will be refundable";
      }
    }
    //if (request.)
    showDialog(
        context: context,
        builder: (ctx) => SimpleDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: MyText(
                text: "alert",
                size: 18,
                weight: FontWeight.bold,
                color: blackColor,
              ),
              children: [
                const SizedBox(
                  height: 10,
                ),
                //Text("data"),
                Text(
                  message, //"areYouSureYouWantToDeleteThis".tr(),
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
                        text: "no",
                        color: blackColor,
                        weight: FontWeight.bold,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () =>
                          dropped(bookingId, index, serviceId, status),
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
//10 same day

  void dropped(
      String bookingId, int index, String serviceId, String status) async {
    await leaveGroup(serviceId);
    UpcomingRequestsModel gR = uRequestListInv.elementAt(index);
    if (mounted) {
      Navigator.of(context).pop();
    }
    setState(() {
      loading = true;
      uRequestListInv.removeAt(index);
    });
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/booking_accept"), body: {
        'booking_id': bookingId,
        'user_id': Constants.userId.toString(),
        'status': status,
      });
      if (response.statusCode != 200) {
        setState(() {
          uRequestListInv.insert(index, gR);
          loading = false;
        });
        message("Dropped Successfully");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        // uRequestListInv.insert(index, gR);
        loading = false;
      });
    }
  }

  Future<void> leaveGroup(String serviceId) async {
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/groupleave"), body: {
        "user_id": Constants.userId.toString(),
        "service_id": serviceId,
      });
      if (response.statusCode == 200) {
        message("Updated Successfly");
      }
      //cancel();
    } catch (e) {
      message(e.toString());
    }
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void paymentPromt(UpcomingRequestsModel up) async {
    showDialog(
        context: context,
        builder: (ctx) => SimpleDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: const Icon(
                Icons.notifications,
                size: 80,
                color: greenColor1,
              ),
              children: [
                const SizedBox(
                  height: 10,
                ), //Text("data"),
                if (up.status == "8")
                  Text(
                    "youcanaycashtoprovideronarrival".tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                if (up.status == "0")
                  Text(
                    "Youcanmakepaymentonlyoncetheadventurerequesthasbeenapproved"
                        .tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                // text:
                //     "After approval you'll be notified and have to buy your subscription package",
                // size: 18,
                // weight: FontWeight.w500,
                // color: blackColor.withOpacity(0.6),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: cancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bluishColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: MyText(
                    text: "okGotIt",
                    weight: FontWeight.bold,
                    color: whiteColor,
                  ),
                ),
                //BottomButton(bgColor: blueButtonColor, onTap: homePage)
              ],
            ));
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
        incDescription: result['inc_description'] ?? "",
        excDescription: result['exc_description'] ?? "",
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

  void goToDetails(ServicesModel gm) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return NewDetails(gm: gm);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingWidget()
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 00),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: uRequestListInv.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              double uCost =
                  double.tryParse(uRequestListInv[index].uCost.toString()) ?? 0;
              double tCost =
                  double.tryParse(uRequestListInv[index].tCost.toString()) ?? 0;
              double pCost =
                  double.tryParse(uRequestListInv[index].tCost.toString()) ?? 0;
              return Card(
                key: Key(uRequestListInv[index].BookingId.toString()),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundImage:
                                //ExactAssetImage('images/airrides.png'),
                                NetworkImage(
                                    "${'${Constants.baseUrl}/public/uploads/'}${uRequestListInv[index].sImage[0].imageUrl}"),
                          ),
                          if (uRequestListInv[index].status == "0")
                            MyText(
                              text: "requested".tr(), //'Confirmed',
                              color: blueColor1,
                              weight: FontWeight.bold,
                            ),
                          if (uRequestListInv[index].status == "1")
                            MyText(
                              text: "ACCEPTED".tr(), //'Confirmed',
                              color: orangeColor,
                              weight: FontWeight.bold,
                            ),
                          if (uRequestListInv[index].status == "2")
                            MyText(
                              text: "paid".tr(), //'Confirmed',
                              color: greenColor1,
                              weight: FontWeight.bold,
                            ),
                          if (uRequestListInv[index].status == "3")
                            MyText(
                              text: "declined".tr(), //'Confirmed',
                              color: redColor,
                              weight: FontWeight.bold,
                            ),
                          if (uRequestListInv[index].status == "4")
                            MyText(
                              text: "completed".tr(), //'Confirmed',
                              color: greenColor1,
                              weight: FontWeight.bold,
                            ),
                          if (uRequestListInv[index].status == "5")
                            MyText(
                              text: "dropped".tr(), //'Confirmed',
                              color: redColor,
                              weight: FontWeight.bold,
                            ),
                          if (uRequestListInv[index].status == "6")
                            MyText(
                              text: "confirm".tr(), //'Confirmed',
                              color: greenColor1,
                              weight: FontWeight.bold,
                            ),
                          if (uRequestListInv[index].status == "7")
                            MyText(
                              text: "unpaid".tr(), //'Confirmed',
                              color: greenColor1,
                              weight: FontWeight.bold,
                            ),
                          if (uRequestListInv[index].status == "8")
                            MyText(
                              text: "payOnArrival".tr(), //'Confirmed',
                              color: greenColor1,
                              weight: FontWeight.bold,
                            ),
                          if (uRequestListInv[index].status == "9")
                            MyText(
                              text:
                                  "CANCELLED (100% REFUND)".tr(), //'Confirmed',
                              color: greenColor1,
                              weight: FontWeight.bold,
                            ),
                          if (uRequestListInv[index].status == "10")
                            MyText(
                              text:
                                  "CANCELLED (50% REFUND)".tr(), //'Confirmed',
                              color: greenColor1,
                              weight: FontWeight.bold,
                            ),
                          if (uRequestListInv[index].status == "11")
                            MyText(
                              text: "CANCELLED (NON-REFUNDABLE)"
                                  .tr(), //'Confirmed',
                              color: greenColor1,
                              weight: FontWeight.bold,
                            ),
                          if (uRequestListInv[index].status == "12")
                            MyText(
                              text: "Early Drop (100% REFUND)"
                                  .tr(), //'Confirmed',
                              color: greenColor1,
                              weight: FontWeight.bold,
                            ),
                          if (uRequestListInv[index].status == "13")
                            MyText(
                              text:
                                  "Late Drop (100% REFUND)".tr(), //'Confirmed',
                              color: greenColor1,
                              weight: FontWeight.bold,
                            ),

                          // GestureDetector(
                          //   onTap: () => showConfirmation(
                          //       uRequestListInv[index][index].serviceId.toString()),
                          //   child: const Icon(
                          //     Icons.delete_forever_outlined,
                          //     color: redColor,
                          //     size: 20,
                          //   ),
                          // )
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: greyColor,
                      ),
                      ListTile(
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        //children: [
                        //CircleImageAvatar(uRequestList.sImage),
                        //UpcomingRequestImage(rm),
                        //leading: ,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  text: "bookingNumber".tr(),
                                  color: bluishColor,
                                  weight: FontWeight.bold,
                                  size: 14,
                                  // height: 1.8,
                                ),
                                MyText(
                                  text: uRequestListInv[index].BookingId,
                                  color: blackColor,
                                  //weight: FontWeight.w400,
                                  size: 14,
                                  // height: 1.8,
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            RichText(
                              text: TextSpan(
                                text: "activityName".tr(), //"Activity Name: ",
                                style: const TextStyle(
                                    color: bluishColor,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          uRequestListInv[index].adventureName,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: blackColor,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Raleway')),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Region".tr(), //"Activity Name: ",
                                style: const TextStyle(
                                    color: bluishColor,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: uRequestListInv[index].region.tr(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: blackColor,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Raleway')),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     Expanded(
                            //       child: MyText(
                            //         text: "activityName".tr(),
                            //         color: blackColor,
                            //         weight: FontWeight.w500,
                            //         size: 13,
                            //         height: 1.8,
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: MyText(
                            //         text:
                            //             uRequestListInv[index].adventureName.tr(),
                            //         color: greyColor,
                            //         weight: FontWeight.w400,
                            //         size: 13,
                            //         height: 1.8,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            RichText(
                              text: TextSpan(
                                text: "providerName".tr(), //"Activity Name: ",
                                style: const TextStyle(
                                    color: bluishColor,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: uRequestListInv[index].pName.tr(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: blackColor,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Raleway')),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "bookingDate".tr(),
                                style: const TextStyle(
                                    color: bluishColor,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: uRequestListInv[index].bDate.tr(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: blackColor,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Raleway')),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "activityDate".tr(),
                                style: const TextStyle(
                                    color: bluishColor,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: uRequestListInv[index].aDate.tr(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: blackColor,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Raleway')),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "registrations".tr(),
                                style: const TextStyle(
                                    color: bluishColor,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  if (uRequestListInv[index].adult != 0)
                                    TextSpan(
                                      text: "${uRequestListInv[index].adult} "
                                              " ${"adult, "}"
                                          .tr(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: blackColor,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Raleway'),
                                    ),
                                  if (uRequestListInv[index].kids != 0)
                                    TextSpan(
                                      text: "${uRequestListInv[index].kids} "
                                              "${"Kids"}"
                                          .tr(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: blackColor,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Raleway'),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "unitCost".tr(),
                                style: const TextStyle(
                                    color: bluishColor,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "${uCost.toStringAsFixed(2)}"
                                          " "
                                          "${uRequestListInv[index].currency}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: blackColor,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Raleway')),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "totalCost".tr(),
                                style: const TextStyle(
                                    color: bluishColor,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "${tCost.toStringAsFixed(2)}"
                                          " "
                                          "${uRequestListInv[index].currency}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: blackColor,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Raleway')),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "payableCost".tr(),
                                style: const TextStyle(
                                    color: bluishColor,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "${tCost.toStringAsFixed(2)}"
                                          " "
                                          "${uRequestListInv[index].currency}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: blackColor,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Raleway')),
                                ],
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     MyText(
                            //       text: "payableCost".tr(),
                            //       color: blackColor,
                            //       weight: FontWeight.w500,
                            //       size: 13,
                            //       height: 1.8,
                            //     ),
                            //     MyText(
                            //       text: "${uRequestListInv[index].tCost.tr()}"
                            //           " "
                            //           "${uRequestListInv[index].currency}",
                            //       color: greyColor,
                            //       weight: FontWeight.w400,
                            //       size: 13,
                            //       height: 1.8,
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "paymentChannel".tr(),
                                style: const TextStyle(
                                    color: bluishColor,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: uRequestListInv[index].pChanel.tr(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: blackColor,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Raleway')),
                                ],
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     MyText(
                            //       text: "paymentChannel".tr(),
                            //       color: blackColor,
                            //       weight: FontWeight.w500,
                            //       size: 13,
                            //       height: 1.8,
                            //     ),
                            //     MyText(
                            //       text: uRequestListInv[index].pChanel.tr(),
                            //       color: greyColor,
                            //       weight: FontWeight.w400,
                            //       size: 13,
                            //       height: 1.8,
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(height: 10),
                          ],
                        ),
                        // ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  color: bluishColor),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => getDetails(
                                      //widget.getDetails(
                                      uRequestListInv[index]
                                          .serviceId
                                          .toString(),
                                      uRequestListInv[index]
                                          .providerId
                                          .toString()),
                                  child: Center(
                                    child: Text(
                                      "viewDetails".tr(),
                                      style: const TextStyle(
                                          color: whiteColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                              // color: bluishColor,
                            ),
                            Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  color: redColor),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: // () {},
                                      () => showConfirmation(
                                          uRequestListInv[index]
                                              .BookingId
                                              .toString(),
                                          index,
                                          uRequestListInv[index]
                                              .serviceId
                                              .toString(),
                                          uRequestListInv[
                                              index]), //     () => showConfirmation(
                                  //   widget.uRequestListInv[index].BookingId.toString(),
                                  // ),
                                  child: Center(
                                    child: Text(
                                      'cancelRequest'.tr(),
                                      style: const TextStyle(
                                          color: whiteColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                              // color: bluishColor,
                            ),
                            Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width / 3.6,
                              decoration: uRequestListInv[index].status == "1"
                                  ? const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      color: greenColor1)
                                  : const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      color: Color.fromARGB(255, 137, 176, 92)),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: uRequestListInv[index].status == "1"
                                      ? () => getProfile(
                                          uRequestListInv[index]
                                              .providerId
                                              .toString(),
                                          uRequestListInv[index].tCost,
                                          uRequestListInv[index]
                                              .BookingId
                                              .toString(),
                                          uRequestListInv[index].currency,
                                          uRequestListInv[index].tCost,
                                          uRequestListInv[index],
                                          index)
                                      : uRequestListInv[index].status != "2"
                                          ? () => paymentPromt(
                                              uRequestListInv[index])
                                          : () {},
                                  child: Center(
                                    child: Text(
                                      'makePayment'.tr(),
                                      style: const TextStyle(
                                          color: whiteColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                              // color: bluishColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
