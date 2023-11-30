// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/getParticipants/get_participants_model.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/models/services/service_image_model.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/service_description.dart';
import 'package:adventuresclub/widgets/tabs/participants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MyServicesTab extends StatefulWidget {
  final ServicesModel sm;
  const MyServicesTab(this.sm, {super.key});

  @override
  State<MyServicesTab> createState() => _MyServicesTabState();
}

class _MyServicesTabState extends State<MyServicesTab> {
  String aPlan = "";
  bool loading = false;
  List<GetParticipantsModel> gGM = [];
  List<ServiceImageModel> gSim = [];
  List<String> adventuresPlan = [""];
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String st = "";
  String ed = "";
  // "${widget.sm.availability[0].st.substring(8, 10)}-${widget.sm.availability[0].st.substring(5, 8)}${widget.sm.availability[0].st.substring(0, 4)}"

  @override
  void initState() {
    super.initState();
    getParticipants();
    if (widget.sm.sPlan == 2) {
      startDate =
          DateTime.tryParse(widget.sm.availability[0].st) ?? DateTime.now();
      String sMonth = DateFormat('MMMM').format(startDate);
      st = "${startDate.day}-$sMonth-${startDate.year}";
      endDate =
          DateTime.tryParse(widget.sm.availability[0].ed) ?? DateTime.now();
      String eMonth = DateFormat('MMMM').format(startDate);
      ed = "${endDate.day}-$eMonth-${endDate.year}";
    }
    if (widget.sm.sPlan == 2) {
      setState(() {
        text1.insert(5, "Start Date");
        text5.insert(4, "End Date");
        text4.insert(0, widget.sm.country);
        text4.insert(1, widget.sm.region);
        text4.insert(2, widget.sm.serviceCategory);
        text4.insert(3, widget.sm.aSeats.toString());
        text4.insert(4, widget.sm.duration.toString());
        widget.sm.availability.isEmpty
            ? text4.insert(5, "Start Date")
            : text4.insert(5, st.substring(0, 11));
        text6.insert(0, widget.sm.reviewdBy);
        text6.insert(1, widget.sm.serviceSector);
        text6.insert(2, widget.sm.serviceType);
        text6.insert(3, widget.sm.serviceLevel);
        widget.sm.availability.isEmpty
            ? text6.insert(4, "End Date")
            : text6.insert(4, ed.substring(0, 11));
      });
    }
    if (widget.sm.sPlan == 1) {
      getSteps();
      setState(() {
        text1.insert(5, "Availability");
        text4.insert(0, widget.sm.country);
        text4.insert(1, widget.sm.region);
        text4.insert(2, widget.sm.serviceCategory);
        text4.insert(3, widget.sm.aSeats.toString());
        text4.insert(4, widget.sm.duration.toString());
        text4.insert(5, aPlan);
        text6.insert(0, widget.sm.reviewdBy);
        text6.insert(1, widget.sm.serviceSector);
        text6.insert(2, widget.sm.serviceType);
        text6.insert(3, widget.sm.serviceLevel);
        // text6.insert(4, widget.gm.availability[0].ed);
        // text6.insert(4, widget.gm.availability[0].ed);
      });
    }
  }

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
    '4.8 (1048 Reviews)',
    'Service Sector',
    'Service Type',
    'Level',
    // 'End Date :',
  ];
  List<String> text6 = [];

  List schedule = [
    ' Pick and drop from gathering location,',
    'Team introduction (welcome tea).',
    'Brief on the planned distination.',
    'Drive to the hike start point.'
  ];
  List journey = [
    ' Start driving towards wadi hawar.',
    ' One stop before arriving to wadi hawar refreshment.',
    'Take required snacks before starting the hike.',
    'Drive to the hike start point.'
  ];
  List activity = [
    'Start the hike/abseiling activities with a careful soft skills pr actice.',
    ' Assuring all team confidence.',
    ' Put the required gears on.',
    'Getting into the water, hiking though the curves of the Wadi. ',
    'Climbing efferent levels of curves/rocks with the help of the leads.'
  ];
  List aimedFor = ['Ladies,', 'Gents'];
  List dependencyList = ['Health Conditions', 'License '];
  List activitesInclude = [
    'First Aid',
    'Gears',
  ];

  void getSteps() {
    widget.sm.availabilityPlan.forEach((element) {
      adventuresPlan.add(element.day.tr());
    });
    aPlan = adventuresPlan.join(", ");
  }

  void getParticipants() async {
    setState(() {
      loading = true;
    });
    try {
      var response = await http.post(
          Uri.parse("${Constants.baseUrl}/api/v1/get_participant"),
          body: {
            'service_id': widget.sm.id.toString(),
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

  double convert(String rating) {
    double result = double.parse(rating);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // length of tabs
      initialIndex: 0,
      child: Column(
        children: <Widget>[
          SizedBox(
            child: Theme(
              //<-- SEE HERE
              data: ThemeData(
                primarySwatch: Colors.blue,
                tabBarTheme:
                    const TabBarTheme(labelColor: Colors.black), //<-- SEE HERE
              ),
              child: TabBar(
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
                  Tab(
                    text: 'adventureDetails'.tr(),
                  ),
                  Tab(text: "${'participants'.tr()} " "(${gGM.length})"),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ServiceDescription(
                    widget.sm,
                    text1,
                    text4,
                    text5,
                    text6,
                    convert(widget.sm.stars.toString()),
                    widget.sm.reviewdBy.toString(),
                    widget.sm.id.toString(),
                    show: true,
                  ),
                ),
                loading ? Container() : Participants(gGM)
                // Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
