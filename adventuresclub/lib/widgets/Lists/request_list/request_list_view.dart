import 'dart:convert';
import 'dart:math';

import 'package:adventuresclub/constants.dart';
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
import 'package:adventuresclub/models/services/service_image_model.dart';
import 'package:adventuresclub/models/user_profile_model.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RequestListView extends StatefulWidget {
  final List<UpcomingRequestsModel> uRequestList;
  final Function getDetails;
  const RequestListView(this.uRequestList, this.getDetails, {super.key});

  @override
  State<RequestListView> createState() => _RequestListViewState();
}

class _RequestListViewState extends State<RequestListView> {
  List<UpcomingRequestsModel> uRequestListInv = [];
  bool loading = false;
  static List<AvailabilityModel> ab = [];
  static List<AvailabilityPlanModel> ap = [];
  static List<IncludedActivitiesModel> ia = [];
  static List<DependenciesModel> dm = [];
  static List<BecomePartner> bp = [];
  static List<AimedForModel> am = []; // new
  static List<ProgrammesModel> programmes = [];
  static List<ServiceImageModel> images = [];
  List<BecomePartner> nBp = [];
  String payOnArrival = "";
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
  Map mapCountry = {};
  double packagePrice = 0;
  Map mapDetails = {};
  double selectedcountryPrice = 0;
  String transactionId = "";
  String orderId = "";
  int count = 8;

  @override
  void initState() {
    super.initState();
    uRequestListInv = widget.uRequestList;
    // text2.insert(0, widget.rm[index].bookingId)
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
        return PaymentMethods(
          rm,
          amount,
          bId,
          cur,
          tCost,
        );
      }));
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
      BuildContext context, String bookingId, UpcomingRequestsModel rm) {
    generateRandomString(10);
    String price = packagePrice.toString();
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
      packagePrice = omrConverted * tc;
    });
  }

  void showConfirmation(String bookingId, int index) async {
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
                  "areYouSureYouWantToDeleteThis".tr(),
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
                      onPressed: () => dropped(bookingId, index),
                      child: MyText(
                        text: "yes",
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
      if (response.statusCode != 200) {
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 00),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: uRequestListInv.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return
            // UpcomingRequestInformation(
            //     uRequestListInv[index], showConfirmation);
            Card(
          key: Key(uRequestListInv[index].BookingId.toString()),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 2),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text:
                          uRequestListInv[index].region.tr(), //'Location Name',
                      color: blackColor,
                      weight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        if (uRequestListInv[index].status == "0")
                          MyText(
                            text: "requested".tr(), //'Confirmed',
                            color: blueColor1,
                            weight: FontWeight.bold,
                          ),
                        if (uRequestListInv[index].status == "1")
                          MyText(
                            text: "accepted".tr(), //'Confirmed',
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
                        const SizedBox(
                          width: 5,
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
                    )
                  ],
                ),
                const Divider(
                  thickness: 1,
                  color: greyColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //CircleImageAvatar(uRequestList.sImage),
                    //UpcomingRequestImage(rm),
                    CircleAvatar(
                      radius: 26,
                      backgroundImage:
                          //ExactAssetImage('images/airrides.png'),
                          NetworkImage(
                              "${'https://adventuresclub.net/adventureClub/public/uploads/'}${uRequestListInv[index].sImage[0].imageUrl}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            direction: Axis.vertical,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "bookingNumber".tr(),
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: uRequestListInv[index].BookingId,
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "activityName".tr(),
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: uRequestListInv[index]
                                        .adventureName
                                        .tr(),
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "providerName".tr(),
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: uRequestListInv[index].pName.tr(),
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "bookingDate".tr(),
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: uRequestListInv[index].bDate.tr(),
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "activityDate".tr(),
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: uRequestListInv[index].aDate.tr(),
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "registrations".tr(),
                                    color: blackColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  if (uRequestListInv[index].adult != 0)
                                    MyText(
                                      text: "${uRequestListInv[index].adult} "
                                              " ${"adult"}"
                                          .tr(),
                                      color: greyTextColor,
                                      weight: FontWeight.w400,
                                      size: 12,
                                      height: 1.8,
                                    ),
                                  if (uRequestListInv[index].kids != 0)
                                    MyText(
                                      text: "${uRequestListInv[index].kids} "
                                              " ${"kids"}"
                                          .tr(),
                                      color: greyTextColor,
                                      weight: FontWeight.w400,
                                      size: 12,
                                      height: 1.8,
                                    ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "unitCost".tr(),
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: "${uRequestListInv[index].uCost.tr()}"
                                        " "
                                        "${uRequestListInv[index].currency}",
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "totalCost".tr(),
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: "${uRequestListInv[index].tCost.tr()}"
                                        " "
                                        "${uRequestListInv[index].currency}",
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "payableCost".tr(),
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: "${uRequestListInv[index].tCost.tr()}"
                                        " "
                                        "${uRequestListInv[index].currency}",
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "paymentChannel".tr(),
                                    color: blackColor,
                                    weight: FontWeight.w500,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                  MyText(
                                    text: uRequestListInv[index].pChanel.tr(),
                                    color: greyColor,
                                    weight: FontWeight.w400,
                                    size: 13,
                                    height: 1.8,
                                  ),
                                ],
                              ),
                            ],
                            // List.generate(
                            //   text.length,
                            //   (index) {
                            //     return

                            //   },
                            // ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
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
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: bluishColor),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => widget.getDetails(
                                uRequestListInv[index].serviceId.toString(),
                                uRequestListInv[index].providerId.toString()),
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
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: redColor),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: // () {},
                                () => showConfirmation(
                                    uRequestListInv[index].BookingId.toString(),
                                    index), //     () => showConfirmation(
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
                                    uRequestListInv[index].BookingId.toString(),
                                    uRequestListInv[index].currency,
                                    uRequestListInv[index].tCost,
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
