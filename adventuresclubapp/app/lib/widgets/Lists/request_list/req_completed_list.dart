// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:app/constants.dart';
import 'package:app/home_Screens/accounts/my_adventures.dart';
import 'package:app/home_Screens/details.dart';
import 'package:app/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:app/home_Screens/new_details.dart';
import 'package:app/models/filter_data_model/programs_model.dart';
import 'package:app/models/home_services/become_partner.dart';
import 'package:app/models/home_services/services_model.dart';
import 'package:app/models/requests/upcoming_Requests_Model.dart';
import 'package:app/models/services/aimed_for_model.dart';
import 'package:app/models/services/availability_model.dart';
import 'package:app/models/services/create_services/availability_plan_model.dart';
import 'package:app/models/services/dependencies_model.dart';
import 'package:app/models/services/included_activities_model.dart';
import 'package:app/models/services/service_image_model.dart';
import 'package:app/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../Chat_list.dart/show_chat.dart';

class ReqCompletedList extends StatefulWidget {
  const ReqCompletedList({super.key});

  @override
  State<ReqCompletedList> createState() => _ReqCompletedListState();
}

class _ReqCompletedListState extends State<ReqCompletedList> {
  Map Ulist = {};
  List<UpcomingRequestsModel> uRequestList = [];
  Map mapChat = {};
  bool loading = false;
  Map mapDetails = {};
  static ServicesModel service = ServicesModel(
      incDescription: "",
      excDescription: "",
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
  List<BecomePartner> nBp = [];
  static List<AvailabilityModel> ab = [];
  // static List<AvailabilityPlanModel> ap = [];
  // static List<IncludedActivitiesModel> ia = [];
  // static List<DependenciesModel> dm = [];
  // static List<BecomePartner> bp = [];
  // static List<AimedForModel> am = []; // new
  // static List<ProgrammesModel> programmes = [];
  // static List<ServiceImageModel> images = [];

  @override
  initState() {
    super.initState();
    getReqList();
    List<AvailabilityModel> av = ab;
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

  Future getReqList() async {
    setState(() {
      loading = true;
    });
    var response = await http.get(Uri.parse(
        "${Constants.baseUrl}/api/v1/get_requests?user_id=${Constants.userId}&type=1"));
    try {
      if (response.statusCode == 200) {
        Ulist = json.decode(response.body);
        List<dynamic> result = Ulist['data'];
        result.forEach((element) {
          List<ServiceImageModel> gSim = [];
          List<dynamic> image = element['images'];
          image.forEach((i) {
            ServiceImageModel sm = ServiceImageModel(
              int.tryParse(i['id'].toString()) ?? 0,
              int.tryParse(i['service_id'].toString()) ?? 0,
              int.tryParse(i['is_default'].toString()) ?? 0,
              i['image_url'] ?? "",
              i['thumbnail'] ?? "",
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
              element["health_conditions"] ?? "",
              element["booking_date"] ?? "",
              element["activity_date"] ?? "",
              int.tryParse(element["adult"].toString()) ?? 0,
              int.tryParse(element["kids"].toString()) ?? 0,
              element["unit_cost"].toString() ?? "",
              element["total_cost"].toString() ?? "",
              element["discounted_amount"].toString() ?? "",
              element["payment_channel"].toString() ?? "",
              element["status"].toString() ?? "",
              element["payment_status"].toString() ?? "",
              int.tryParse(element["points"].toString()) ?? 0,
              element["description"].toString() ?? "",
              element["registrations"].toString() ?? "",
              gSim);
          uRequestList.add(up);
        });
      }
      setState(() {
        loading = false;
        uRequestList = uRequestList.reversed.toList();
      });
      print(uRequestList);
      print(response.statusCode);
      print(response.body);
    } catch (e) {
      print(e);
    }
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
            int.tryParse(ap['id'].toString()) ?? 0, ap['day'].toString() ?? "");
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
        adventureName: result['adventure_name'] ?? "",
        country: result['country'] ?? "",
        region: result['region'] ?? "",
        cityId: result['city_id'].toString() ?? "",
        serviceSector: result['service_sector'].toString() ?? "",
        serviceCategory: result['service_category'].toString() ?? "",
        serviceType: result['service_type'].toString() ?? "",
        serviceLevel: result['service_level'].toString() ?? "",
        duration: result['duration'] ?? "",
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
        iaot: result['including_gerea_and_other_taxes'].toString() ?? "",
        eaot: result['excluding_gerea_and_other_taxes'].toString() ?? "",
        serviceCategoryImage: result['service_category_image'].toString() ?? "",
        serviceSectorImage: result['service_sector_image'].toString() ?? "",
        serviceTypeImage: result['service_type_image'].toString() ?? "",
        serviceLevelImage: result['service_level_image'].toString() ?? "",
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

  abc() {}
  void goToMyAd(UpcomingRequestsModel gm) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return MyAdventures(gm);
        },
      ),
    );
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

  // void selected(BuildContext context) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (_) {
  //         return ShowChat(
  //             "${Constants.baseUrl}/newreceiverchat/${Constants.userId}/${widget.sId}/${profile.id}");
  //       },
  //     ),
  //   );
  // }

  void selected(BuildContext context, int serviceId, int providerUserId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
              "${Constants.baseUrl}/newreceiverchat/${Constants.userId}/$serviceId/$providerUserId");
        },
      ),
    );
  }

  void showConfirmation(String id, int index, String serviceId) async {
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
                        color: blackColor,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => delete(id, index, serviceId),
                      child: MyText(
                        text: "Yes",
                        color: blackColor,
                      ),
                    ),
                  ],
                )
                //BottomButton(bgColor: blueButtonColor, onTap: homePage)
              ],
            ));
  }

  void delete(String id, int index, String serviceId) async {
    leaveGroup(serviceId);
    Navigator.of(context).pop();
    UpcomingRequestsModel uR = uRequestList.elementAt(index);
    setState(() {
      uRequestList.removeAt(index);
    });
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/booking_accept"), body: {
        'booking_id': id,
        'status': "5",
        'user_id': Constants.userId.toString(),
      });
      if (response.statusCode != 200) {
        setState(() {
          uRequestList.insert(index, uR);
        });
      } else {
        message("Deleted Successfully");
      }
      print(response.statusCode);
    } catch (e) {
      print(e.toString());
    }
  }

  void leaveGroup(String serviceId) async {
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

  void homePage() {
    context.push('/home');
    // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //   return const BottomNavigation();
    // }));
  }

  void dropped(String bookingId) async {
    Navigator.of(context).pop();
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/booking_accept"), body: {
        'booking_id': bookingId,
        'user_id': Constants.userId.toString(),
        'status': "5",
      });
      if (response.statusCode == 200) {
        message("Deleted Successfully");
        // homePage();
      }
      print(response.statusCode);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(
                text: "loading".tr(),
                color: bluishColor,
                weight: FontWeight.w700,
              ),
              const SizedBox(
                height: 5,
              ),
              const CircularProgressIndicator(),
            ],
          )
        : uRequestList.isEmpty
            ? Center(
                child: Column(
                children: [
                  MyText(
                    text: "No Data Found",
                    color: blackColor,
                    size: 16,
                  ),
                ],
              ))
            : ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 00),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: uRequestList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return loading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyText(
                              text: "Loading Information...",
                              color: blackColor,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const CircularProgressIndicator(),
                          ],
                        )
                      : Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 26,
                                      backgroundImage:
                                          //  ExactAssetImage('images/airrides.png'),
                                          NetworkImage(
                                              "${'${Constants.baseUrl}/public/uploads/'}${uRequestList[index].sImage[0].thumbnail}"),
                                    ),
                                    Row(
                                      children: [
                                        if (uRequestList[index].status == "0")
                                          MyText(
                                            text:
                                                "requested".tr(), //'Confirmed',
                                            color: blueColor1,
                                            weight: FontWeight.bold,
                                          ),
                                        if (uRequestList[index].status == "1")
                                          MyText(
                                            text:
                                                "ACCEPTED".tr(), //'Confirmed',
                                            color: orangeColor,
                                            weight: FontWeight.bold,
                                          ),
                                        if (uRequestList[index].status == "2")
                                          MyText(
                                            text: "paid".tr(), //'Confirmed',
                                            color: greenColor1,
                                            weight: FontWeight.bold,
                                          ),
                                        if (uRequestList[index].status == "3")
                                          MyText(
                                            text:
                                                "declined".tr(), //'Confirmed',
                                            color: redColor,
                                            weight: FontWeight.bold,
                                          ),
                                        if (uRequestList[index].status == "4")
                                          MyText(
                                            text:
                                                "completed".tr(), //'Confirmed',
                                            color: greenColor1,
                                            weight: FontWeight.bold,
                                          ),
                                        if (uRequestList[index].status == "5")
                                          MyText(
                                            text: "dropped".tr(), //'Confirmed',
                                            color: redColor,
                                            weight: FontWeight.bold,
                                          ),
                                        if (uRequestList[index].status == "6")
                                          MyText(
                                            text: "confirm".tr(), //'Confirmed',
                                            color: greenColor1,
                                            weight: FontWeight.bold,
                                          ),
                                        if (uRequestList[index].status == "7")
                                          MyText(
                                            text: "unPaid".tr(), //'Confirmed',
                                            color: greenColor1,
                                            weight: FontWeight.bold,
                                          ),
                                        if (uRequestList[index].status == "8")
                                          MyText(
                                            text: "payOnArrival"
                                                .tr(), //'Confirmed',
                                            color: greenColor1,
                                            weight: FontWeight.bold,
                                          ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        GestureDetector(
                                          onTap: () => showConfirmation(
                                              uRequestList[index]
                                                  .BookingId
                                                  .toString(),
                                              index,
                                              uRequestList[index]
                                                  .serviceId
                                                  .toString()),
                                          child: const Icon(
                                            Icons.delete_forever_outlined,
                                            color: redColor,
                                            size: 24,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Divider(
                                  color: blackColor.withOpacity(0.3),
                                  thickness: 2,
                                ),
                                ListTile(
                                  title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      //direction: Axis.vertical,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: "bookingNumber"
                                                .tr(), //"Activity Name: ",
                                            style: const TextStyle(
                                                color: bluishColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Raleway'),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: uRequestList[index]
                                                      .BookingId
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'Raleway')),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: "Region"
                                                .tr(), //"Activity Name: ",
                                            style: const TextStyle(
                                                color: bluishColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Raleway'),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: uRequestList[index]
                                                      .region, //'Location Name',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'Raleway')),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: "activityName"
                                                .tr(), //"Activity Name: ",
                                            style: const TextStyle(
                                                color: bluishColor,
                                                fontSize: 14,
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.bold),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: uRequestList[index]
                                                      .adventureName,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'Raleway')),
                                            ],
                                          ),
                                        ),
                                        // const SizedBox(
                                        //   height: 5,
                                        // ),
                                        RichText(
                                          text: TextSpan(
                                            text: "providerName".tr(),
                                            style: const TextStyle(
                                                color: bluishColor,
                                                fontSize: 14,
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.bold),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      uRequestList[index].pName,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'Raleway')),
                                            ],
                                          ),
                                        ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.start,
                                        //   children: [
                                        //     MyText(
                                        //       text: "providerName"
                                        //           .tr(), //"Provider Name: ",
                                        //       color: blackColor,
                                        //       weight: FontWeight.w700,
                                        //       size: 13,
                                        //       height: 1.8,
                                        //     ),
                                        //     MyText(
                                        //       text: uRequestList[index].pName,
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
                                            text: "bookingDate".tr(),
                                            style: const TextStyle(
                                                color: bluishColor,
                                                fontSize: 14,
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.bold),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      uRequestList[index].bDate,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'Raleway')),
                                            ],
                                          ),
                                        ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.start,
                                        //   children: [
                                        //     MyText(
                                        //       text: "bookingDate"
                                        //           .tr(), //"Booking Date: ",
                                        //       color: blackColor,
                                        //       weight: FontWeight.w700,
                                        //       size: 13,
                                        //       height: 1.8,
                                        //     ),
                                        //     MyText(
                                        //       text: uRequestList[index].bDate,
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
                                            text: "activityDate".tr(),
                                            style: const TextStyle(
                                                color: bluishColor,
                                                fontSize: 14,
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.bold),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      uRequestList[index].aDate,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                              TextSpan(
                                                  text: uRequestList[index]
                                                      .registration,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'Raleway')),
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
                                                  text:
                                                      "${uRequestList[index].uCost} "
                                                      " ${uRequestList[index].currency}",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                  text:
                                                      "${uRequestList[index].tCost} "
                                                      " ${uRequestList[index].currency}",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                  text:
                                                      "${uRequestList[index].tCost} "
                                                      " ${uRequestList[index].currency}",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'Raleway')),
                                            ],
                                          ),
                                        ),
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
                                                  text: uRequestList[index]
                                                      .pChanel,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'Raleway')),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [

//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 2.0, vertical: 5),
//                                       child:
// //const SizedBox(height: 10),
//                                     ),
//                                   ],
//                                 ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          color: bluishColor),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () => getDetails(
                                              uRequestList[index]
                                                  .serviceId
                                                  .toString(),
                                              uRequestList[index]
                                                  .providerId
                                                  .toString()),
                                          child: Center(
                                            child: Text(
                                              "viewDetails"
                                                  .tr(), //'View Details',
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
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      decoration: uRequestList[index].status ==
                                                  "2" ||
                                              uRequestList[index].status == "4"
                                          ? const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              color: Color.fromARGB(
                                                  255, 255, 166, 0),
                                            )
                                          : const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              color: Color.fromARGB(
                                                  255, 189, 145, 65),
                                            ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: uRequestList[index].status ==
                                                      "2" ||
                                                  uRequestList[index].status ==
                                                      "4"
                                              ? () =>
                                                  goToMyAd(uRequestList[index])
                                              : () {},
                                          child: Center(
                                            child: Text(
                                              "rateNow".tr(), //'Rate Now',
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
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          color: blueColor1),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () => selected(
                                              context,
                                              uRequestList[index].serviceId,
                                              uRequestList[index].providerId),
                                          child: Center(
                                            child: Text(
                                              "chatProvider"
                                                  .tr(), //'Chat Provider',
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
                                    // SquareButton(
                                    //     'Chat Provider',
                                    //     blueColor1,
                                    //     whiteColor,
                                    //     3.7,
                                    //     21,
                                    //     12,
                                    //     () => selected(
                                    //         context,
                                    //         uRequestList[index].serviceId.toString(),
                                    //         uRequestList[index].providerId.toString())),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                });
  }
}
