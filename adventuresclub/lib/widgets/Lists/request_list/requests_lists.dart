// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/client_requests.dart';
import 'package:adventuresclub/home_Screens/accounts/my_adventures.dart';
import 'package:adventuresclub/home_Screens/accounts/my_services.dart';
import 'package:adventuresclub/home_Screens/details.dart';
import 'package:adventuresclub/home_Screens/payment_methods/payment_methods.dart';
import 'package:adventuresclub/models/filter_data_model/programs_model.dart';
import 'package:adventuresclub/models/home_services/become_partner.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/models/requests/upcoming_Requests_Model.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/models/services/availability_model.dart';
import 'package:adventuresclub/models/services/create_services/availability_plan_model.dart';
import 'package:adventuresclub/models/services/dependencies_model.dart';
import 'package:adventuresclub/models/services/included_activities_model.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/buttons/square_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/services/service_image_model.dart';

class RequestsList extends StatefulWidget {
  const RequestsList({super.key});

  @override
  State<RequestsList> createState() => _RequestsListState();
}

class _RequestsListState extends State<RequestsList> {
  Map Ulist = {};
  String userID = "27";
  List<ServiceImageModel> gSim = [];
  List<UpcomingRequestsModel> uRequestList = [];
  bool loading = false;
  Map mapDetails = {};
  List<BecomePartner> nBp = [];
  static List<AvailabilityModel> ab = [];
  static List<AvailabilityPlanModel> ap = [];
  static List<IncludedActivitiesModel> ia = [];
  static List<DependenciesModel> dm = [];
  static List<BecomePartner> bp = [];
  static List<AimedForModel> am = []; // new
  static List<ProgrammesModel> programmes = [];
  static List<ServiceImageModel> images = [];
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

  @override
  initState() {
    super.initState();
    getList();
  }

  Future getList() async {
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/get_requests?user_id=${Constants.userId}&type=0"));
    try {
      if (response.statusCode == 200) {
        Ulist = json.decode(response.body);
        List<dynamic> result = Ulist['data'];

        result.forEach((element) {
          List<dynamic> image = element['images'];
          image.forEach((i) {
            ServiceImageModel sm = ServiceImageModel(
              int.tryParse(i['id'].toString()) ?? 0,
              int.tryParse(i['service_id'].toString()) ?? 0,
              int.tryParse(i['is_default'].toString()) ?? 0,
              i['image_url'].toString() ?? "",
              i['thumbnail'].toString() ?? "",
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
              element["country"].toString() ?? "",
              element["currency"].toString() ?? "",
              element["region"].toString() ?? "",
              element["adventure_name"].toString() ?? "",
              element["provider_name"].toString() ?? "",
              element["height"].toString() ?? "",
              element["weight"].toString() ?? "",
              element["health_conditions"].toString() ?? "",
              element["booking_date"].toString() ?? "",
              element["activity_date"].toString() ?? "",
              int.tryParse(element["adult"].toString()) ?? 0,
              int.tryParse(element["kids"].toString()) ?? 0,
              element["unit_cost"].toString() ?? "",
              element["total_cost"].toString() ?? "",
              element["discounted_amount"].toString() ?? "",
              element["payment_channel"].toString() ?? "",
              element["status"].toString() ?? "",
              element["payment_status"].toString() ?? "",
              element["points"].toString() ?? "",
              element["description"].toString() ?? "",
              element["registrations"].toString() ?? "",
              gSim);
          uRequestList.add(up);
        });
      }
      setState(() {});
      print(response.statusCode);
      print(response.body);
    } catch (e) {
      print(e);
    }
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
            ap['id'].toString() ?? "", ap['day'].toString() ?? "");
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

  void goToMakePayments() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const PaymentMethods();
    }));
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

  void selected(BuildContext context, int serviceId, int providerId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
              "https://adventuresclub.net/adventureClub/newreceiverchat/${Constants.userId}/$serviceId/$providerId");
        },
      ),
    );
  }

  void goToMyAd(UpcomingRequestsModel gm) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return MyAdventures(gm);
        },
      ),
    );
  }

  void showConfirmation(String id) async {
    showDialog(
        context: context,
        builder: (ctx) => SimpleDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: MyText(
                text: "Alert",
                weight: FontWeight.bold,
                color: blackColor,
              ),
              children: [
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: MyText(
                    text: "Are you sure you want to delete?",
                    size: 16,
                    weight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
                // text:
                //     "After approval you'll be notified and have to buy your subscription package",
                // size: 18,
                // weight: FontWeight.w500,
                // color: blackColor.withOpacity(0.6),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: homePage,
                      child: MyText(
                        text: "No",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {}, //() => delete(id),
                      child: MyText(
                        text: "Yes",
                      ),
                    ),
                  ],
                )
                //BottomButton(bgColor: blueButtonColor, onTap: homePage)
              ],
            ));
  }

  void homePage() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return uRequestList.isEmpty
        ? Center(
            child: Column(
              children: const [Text("There is no upcoming adventure yet")],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 00),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: uRequestList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: uRequestList[index].region, //'Location Name',
                            color: blackColor,
                            weight: FontWeight.bold,
                          ),
                          Row(
                            children: [
                              if (uRequestList[index].status == "0")
                                MyText(
                                  text: "Paid", //'Confirmed',
                                  color: blueButtonColor,
                                  weight: FontWeight.bold,
                                ),
                              if (uRequestList[index].status == "1")
                                MyText(
                                  text: "Accepted", //'Confirmed',
                                  color: blueButtonColor,
                                  weight: FontWeight.bold,
                                ),
                              if (uRequestList[index].status == "2")
                                MyText(
                                  text: "Requested", //'Confirmed',
                                  color: redColor,
                                  weight: FontWeight.bold,
                                ),
                              if (uRequestList[index].status == "3")
                                MyText(
                                  text: "Declined", //'Confirmed',
                                  color: redColor,
                                  weight: FontWeight.bold,
                                ),
                              if (uRequestList[index].status == "4")
                                MyText(
                                  text: "Completed", //'Confirmed',
                                  color: greenColor1,
                                  weight: FontWeight.bold,
                                ),
                              if (uRequestList[index].status == "5")
                                MyText(
                                  text: "Dropped", //'Confirmed',
                                  color: redColor,
                                  weight: FontWeight.bold,
                                ),
                              if (uRequestList[index].status == "6")
                                MyText(
                                  text: "Confirm", //'Confirmed',
                                  color: greenColor1,
                                  weight: FontWeight.bold,
                                ),
                              if (uRequestList[index].status == "7")
                                MyText(
                                  text: "UnPaid", //'Confirmed',
                                  color: greenColor1,
                                  weight: FontWeight.bold,
                                ),
                              const SizedBox(
                                width: 5,
                              ),
                              // GestureDetector(
                              //   onTap: () => showConfirmation(
                              //       uRequestList[index].serviceId.toString()),
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
                          const CircleAvatar(
                            radius: 26,
                            backgroundImage:
                                ExactAssetImage('images/airrides.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Booking Number",
                                          color: blackColor,
                                          weight: FontWeight.w500,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                        MyText(
                                          text: uRequestList[index].BookingId,
                                          color: greyColor,
                                          weight: FontWeight.w400,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Activity Name",
                                          color: blackColor,
                                          weight: FontWeight.w500,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                        MyText(
                                          text:
                                              uRequestList[index].adventureName,
                                          color: greyColor,
                                          weight: FontWeight.w400,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Provider Name",
                                          color: blackColor,
                                          weight: FontWeight.w500,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                        MyText(
                                          text: uRequestList[index].pName,
                                          color: greyColor,
                                          weight: FontWeight.w400,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Booking Date",
                                          color: blackColor,
                                          weight: FontWeight.w500,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                        MyText(
                                          text: uRequestList[index].bDate,
                                          color: greyColor,
                                          weight: FontWeight.w400,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Activity Date",
                                          color: blackColor,
                                          weight: FontWeight.w500,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                        MyText(
                                          text: uRequestList[index].aDate,
                                          color: greyColor,
                                          weight: FontWeight.w400,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: 'Registrations : ',
                                          color: blackColor,
                                          weight: FontWeight.w400,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                        if (uRequestList[index].adult != 0)
                                          MyText(
                                            text:
                                                "${uRequestList[index].adult} "
                                                " ${"Adult"}"
                                                ",  "
                                                "${uRequestList[index].kids} "
                                                " ${"Youngsters"}",
                                            color: greyTextColor,
                                            weight: FontWeight.w400,
                                            size: 12,
                                            height: 1.8,
                                          ),
                                        if (uRequestList[index].kids != 0)
                                          MyText(
                                            text: "${uRequestList[index].kids} "
                                                " ${"Kids"}",
                                            color: greyTextColor,
                                            weight: FontWeight.w400,
                                            size: 12,
                                            height: 1.8,
                                          ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Unit Cost",
                                          color: blackColor,
                                          weight: FontWeight.w500,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                        MyText(
                                          text: uRequestList[index].uCost,
                                          color: greyColor,
                                          weight: FontWeight.w400,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Total Cost",
                                          color: blackColor,
                                          weight: FontWeight.w500,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                        MyText(
                                          text: uRequestList[index].tCost,
                                          color: greyColor,
                                          weight: FontWeight.w400,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Payable Cost",
                                          color: blackColor,
                                          weight: FontWeight.w500,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                        MyText(
                                          text: uRequestList[index].tCost,
                                          color: greyColor,
                                          weight: FontWeight.w400,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "Payment Channel",
                                          color: blackColor,
                                          weight: FontWeight.w500,
                                          size: 13,
                                          height: 1.8,
                                        ),
                                        MyText(
                                          text: uRequestList[index].pChanel,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => getDetails(
                                uRequestList[index].serviceId.toString(),
                                uRequestList[index].providerId.toString()),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 21,
                              width: MediaQuery.of(context).size.width / 3.8,
                              decoration: const BoxDecoration(
                                color: bluishColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'View Details',
                                        style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // SquareButton('View Details', bluishColor, whiteColor,
                          //     3.7, 21, 12, abc),
                          // SquareButton('Rate Now', yellowcolor,
                          //     whiteColor, 3.7, 21, 12, goToMyAd),
                          GestureDetector(
                            //onTap: () => goToMyAd(uRequestList[index]),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 21,
                              width: MediaQuery.of(context).size.width / 3.8,
                              decoration: const BoxDecoration(
                                color: redColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Cancel Request',
                                        style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => selected(
                                context,
                                uRequestList[index].serviceId,
                                uRequestList[index].providerId),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 21,
                              width: MediaQuery.of(context).size.width / 3.8,
                              decoration: const BoxDecoration(
                                color: greenColor1,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Make Payment',
                                        style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
  }
}
