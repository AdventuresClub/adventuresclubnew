// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/getParticipants/get_participants_model.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/models/services/service_image_model.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/service_description.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/service_gathering_location.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/service_program/service_plans.dart';
import 'package:adventuresclub/widgets/tabs/participants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailsTab extends StatefulWidget {
  final ServicesModel gm;
  final bool? show;
  const DetailsTab(this.gm, {this.show = false, super.key});

  @override
  State<DetailsTab> createState() => _DetailsTabState();
}

class _DetailsTabState extends State<DetailsTab> with TickerProviderStateMixin {
  late TabController _tabController;
  PageController controller = PageController();
  String x = "";
  List<String> adventuresPlan = [""];
  String aPlan = "";
  bool loading = false;
  List<ServiceImageModel> gSim = [];
  List<GetParticipantsModel> gGM = [];
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String st = "";
  String ed = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
    if (widget.show!) {
      getParticipants();
    }
    if (widget.gm.sPlan == 2) {
      startDate =
          DateTime.tryParse(widget.gm.availability[0].st) ?? DateTime.now();
      String sMonth = DateFormat('MMMM').format(startDate);
      st = "${startDate.day}-$sMonth-${startDate.year}";
      endDate =
          DateTime.tryParse(widget.gm.availability[0].ed) ?? DateTime.now();
      String eMonth = DateFormat('MMMM').format(startDate);
      ed = "${endDate.day}-$eMonth-${endDate.year}";
    }
    //widget.gm.availability[0].st.substring(0, 10)
    if (widget.gm.sPlan == 2) {
      setState(() {
        text1.insert(5, "Start Date : ");
        text5.insert(3, "End Date");
        text4.insert(0, widget.gm.country);
        text4.insert(1, widget.gm.region);
        text4.insert(2, widget.gm.serviceCategory);
        text4.insert(3, "${widget.gm.aSeats}");
        text4.insert(4, widget.gm.duration.toString());
        widget.gm.availability.isEmpty
            ? text4.insert(5, "2023-10-24")
            : text4.insert(5, st);
        // text6.insert(0, widget.gm.reviewdBy);
        text6.insert(0, widget.gm.reviewdBy);
        text6.insert(1, widget.gm.serviceSector);
        text6.insert(2, widget.gm.serviceType);
        text6.insert(3, widget.gm.serviceLevel);
        widget.gm.availability.isEmpty
            ? text6.insert(4, "End Date")
            : text6.insert(4, ed);
        // text6.insert(0, widget.gm.serviceSector);
        // text6.insert(1, widget.gm.serviceType);
        // text6.insert(2, widget.gm.serviceLevel);
        // widget.gm.availability.isEmpty
        //     ? text6.insert(3, "End Date")
        //     : text6.insert(3, ed);
      });
    }
    if (widget.gm.sPlan == 1) {
      getSteps();
      setState(() {
        text1.insert(5, "Availability");
        text4.insert(0, widget.gm.country);
        text4.insert(1, widget.gm.region);
        text4.insert(2, widget.gm.serviceCategory);
        text4.insert(
          3,
          "${widget.gm.aSeats}",
        );
        text4.insert(4, widget.gm.duration.toString());
        text4.insert(5, aPlan);
        //text6.insert(0, widget.gm.reviewdBy);
        text6.insert(0, widget.gm.serviceSector);
        text6.insert(1, widget.gm.serviceType);
        text6.insert(2, widget.gm.serviceLevel);
        // text6.insert(4, widget.gm.availability[0].ed);
        // text6.insert(4, widget.gm.availability[0].ed);
      });
    }
  }

  void _handleTabSelection() {
    setState(() {});
  }

  void getSteps() {
    widget.gm.availabilityPlan.forEach((element) {
      adventuresPlan.add(element.day.tr());
    });
    aPlan = adventuresPlan.join(", ");
  }

  List<String> steps = [];
  List text = [
    'Pick and drop from gathering location.',
    'Team introduction (welcome tea).',
    'Brief on the planned destination.',
    'Drive to the hike start point.'
  ];
  List text2 = [
    'Start Driving towards wadi hawar.',
    'One stop before arriving to wadi hawar\nfor refreshment.',
    'Make required snacks before starting the hike.'
  ];
  List text3 = [
    "Start the hike/abseiling activities with\na careful soft skills practice.",
    "Assuring all team confidence.",
    "Put the required gears on.",
    "Getting into the water, hiking though the\ncurves of the Wadi. ",
    "Climbing efferent levels of curves/rocks with\nthe help of the leads.",
  ];
  String firstValue = "";
  /*
  List<StepperData> stepperData = [
    StepperData(
        iconWidget: CircleAvatar(
      radius: 20,
      backgroundColor: Colors.blue,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: greenishColor,
        child: MyText(
          text: "1",
          weight: FontWeight.bold,
        ),
      ),
    )),
    StepperData(
        iconWidget: CircleAvatar(
      radius: 20,
      backgroundColor: Colors.blue,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: greenishColor,
        child: MyText(
          text: '2',
          weight: FontWeight.bold,
        ),
      ),
    )),
    StepperData(
        iconWidget: CircleAvatar(
      radius: 20,
      backgroundColor: Colors.blue,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: greenishColor,
        child: MyText(
          text: '3',
          weight: FontWeight.bold,
        ),
      ),
    )),
    StepperData(
        iconWidget: CircleAvatar(
      radius: 20,
      backgroundColor: Colors.blue,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: greenishColor,
        child: MyText(
          text: '4',
          weight: FontWeight.bold,
        ),
      ),
    )),
    StepperData(
        iconWidget: CircleAvatar(
      radius: 20,
      backgroundColor: Colors.blue,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: whiteColor,
        child: CircleAvatar(
          radius: 23,
          backgroundColor: greenishColor,
          child: MyText(
            text: '5',
            weight: FontWeight.bold,
          ),
        ),
      ),
    )),
  ];
  */
  List<String> text1 = [
    'Country',
    'Region',
    'Service Category',
    'Available Seats',
    'Duration',
    //'Start Date :'
  ];
  List<String> text11 = [
    'Country  :',
    'Region  :',
    'Service Category  :',
    'Available Seats :',
    'Duration :',
    'Availaibilty :'
  ];
  List<String> text4 = [
    //'Oman', 'Salalah', 'Sea', '70', '36 hours', '25 Jul 2020'
  ];
  List<String> text5 = [
    'Service Sector',
    'Service Type',
    'Level',
    // 'End Date :',
  ];
  List<String> text6 = [];
  List<String> aimedFor = ['Ladies,', 'Gents'];

  List<String> dependencyList = ['Health Conditions', 'License '];
  List<String> activitesInclude = [
    'Transportation from gathering area',
    'Snacks',
    'Bike Riding'
  ];

  double convert(String rating) {
    double result = double.parse(rating);
    return result;
  }

  Future<bool> checkPermission() async {
    PermissionStatus status = await Permission.location.status;
    if (status.isPermanentlyDenied || status.isDenied) {
      return false;
    }
    return true;
  }

  void getParticipants() async {
    setState(() {
      loading = true;
    });
    try {
      var response = await http.post(
          Uri.parse("${Constants.baseUrl}/api/v1/get_participant"),
          body: {
            'service_id': widget.gm.id.toString(),
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = decodedResponse['data'];
      result.forEach((element) {
        if (element['image'] != null) {
          List<dynamic> image = element['image_url'];
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
        }
        int bookingId = int.tryParse(element['booking_id'].toString()) ?? 0;
        int bookingUser = int.tryParse(element['booking_user'].toString()) ?? 0;
        int providerId = int.tryParse(element['provider_id'].toString()) ?? 0;
        int nationalityId =
            int.tryParse(element['nationality_id'].toString()) ?? 0;
        int ownerId = int.tryParse(element['owner_id'].toString()) ?? 0;
        int serviceId = int.tryParse(element['service_id'].toString()) ?? 0;
        int adult = int.tryParse(element['adult'].toString()) ?? 0;
        int kids = int.tryParse(element['kids'].toString()) ?? 0;
        GetParticipantsModel gm = GetParticipantsModel(
            bookingId,
            bookingUser,
            providerId,
            element['provider_profile'] ?? "",
            element['email'] ?? "",
            nationalityId,
            ownerId,
            serviceId,
            element['health_conditions'] ?? "",
            element['country'] ?? "",
            element['region'] ?? "",
            element['adventure_name'] ?? "",
            element['provider_name'] ?? "",
            element['customer'] ?? "",
            element['service_date'] ?? "",
            element['booked_on'] ?? "",
            adult,
            kids,
            element['unit_cost'] ?? "",
            element['total_cost'] ?? "",
            element['discounted_amount'] ?? "",
            element['payment_channel'] ?? "",
            element['currency'] ?? "",
            element['dob'] ?? "",
            element['height'] ?? "",
            element['weight'] ?? "",
            element['message'] ?? "",
            element['booking_status'] ?? "",
            element['status'] ?? "",
            element['category'] ?? "",
            element['nationality'] ?? "",
            gSim);
        gGM.add(gm);
      });
      setState(() {
        loading = false;
      });
      print(response.statusCode);
      print(response.body);
      print(response.headers);
      print(decodedResponse['data']['user_id']);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.show!
        ? DefaultTabController(
            length: 2, // length of tabs
            initialIndex: 0,
            child: Column(
              children: <Widget>[
                SizedBox(
                  child: Theme(
                    //<-- SEE HERE
                    data: ThemeData(
                      primarySwatch: Colors.blue,
                      tabBarTheme: const TabBarTheme(
                          labelColor: Colors.black), //<-- SEE HERE
                    ),
                    child: TabBar(
                      padding: const EdgeInsets.all(0),
                      labelPadding: const EdgeInsets.all(0),
                      labelColor: blackColor,
                      labelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                      indicatorColor: greenishColor,
                      unselectedLabelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto'),
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: greyColor,
                      tabs: [
                        const Tab(
                          text: 'Adventure Details',
                        ),
                        Tab(text: "${'Participants'} " "(${gGM.length})"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ServiceDescription(
                          widget.gm,
                          text1,
                          text4,
                          text5,
                          text6,
                          convert(widget.gm.stars.toString()),
                          widget.gm.reviewdBy.toString(),
                          widget.gm.id.toString(),
                          show: true,
                        ),
                      ),
                      loading ? Container() : Participants(gGM)
                      // SquareButton('Upcoming', bluishColor, whiteColor, 2.4, 16, 16, abc),
                      //         SquareButton('Completed', greyColor, whiteColor, 2.4, 16, 16, abc), ///////
                    ],
                  ),
                ),
              ],
            ),
          )
        : DefaultTabController(
            length: 4, // length of tabs
            initialIndex: 0,
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  //color: greyTextColor,
                  child: TabBar(
                    padding: const EdgeInsets.all(0),
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    labelColor: blackColor,
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                    indicatorColor: greenishColor,
                    isScrollable: true,
                    unselectedLabelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Raleway"),
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: greyColor,
                    tabs: [
                      SizedBox(
                        width: 90.0,
                        child: Tab(
                          text: 'description'.tr(),
                        ),
                      ),
                      SizedBox(
                        width: 70.0,
                        child: Tab(text: 'program'.tr()),
                      ),
                      SizedBox(
                        width: 150.0,
                        child: Tab(text: 'gatheringLocation'.tr()),
                      ),
                      SizedBox(
                        width: 60.0,
                        child: Tab(text: 'chat'.tr()),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      ServiceDescription(
                          widget.gm,
                          text1,
                          text4,
                          text5,
                          text6,
                          convert(widget.gm.stars.toString()),
                          widget.gm.reviewdBy.toString(),
                          widget.gm.id.toString()),
                      // program tab
                      // 2 nd Tab /////////
                      ServicesPlans(widget.gm.sPlan, widget.gm.programmes),
                      // 3 rd Tab /////////
                      // gathering location
                      ServiceGatheringLocation(
                          widget.gm.writeInformation,
                          widget.gm.sAddress,
                          widget.gm.region,
                          widget.gm.country,
                          widget.gm.geoLocation,
                          widget.gm.lat,
                          widget.gm.lng),
                      // 4th Tab /////////
                      // ${Constants.baseUrl}/newchat/18/126/20
                      // 18: user_id of provider
                      // 126: Service_id
                      // 20: user_id of the client
                      // if (widget.gm.providerId.toString() ==
                      //     Constants.userId.toString())
                      // ShowChat(
                      //   "${Constants.baseUrl}/receiverlist/20/126",
                      //   appbar: false,
                      // ),
                      ShowChat(
                        "${Constants.baseUrl}/receiverlist/${Constants.userId}/${widget.gm.id}",
                        appbar: false,
                      ),
                      //AdventureChatDetails(widget.gm.serviceId.toString())
                      // "${Constants.baseUrl}/receiverlist/27/'${widget.serviceId}'"
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
