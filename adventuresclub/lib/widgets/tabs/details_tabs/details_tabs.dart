// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/service_description.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/service_gathering_location.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/service_program/service_plans.dart';
import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';

class DetailsTab extends StatefulWidget {
  final ServicesModel gm;
  final bool? show;
  const DetailsTab(this.gm, {this.show, super.key});

  @override
  State<DetailsTab> createState() => _DetailsTabState();
}

class _DetailsTabState extends State<DetailsTab> with TickerProviderStateMixin {
  late TabController _tabController;
  PageController controller = PageController();
  String x = "";
  List<String> adventuresPlan = [""];
  String aPlan = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
    if (widget.gm.sPlan == 2) {
      setState(() {
        text1.insert(5, "Start Date");
        text5.insert(4, "End Date");
        text4.insert(0, widget.gm.country);
        text4.insert(1, widget.gm.region);
        text4.insert(2, widget.gm.serviceCategory);
        text4.insert(3, widget.gm.aSeats.toString());
        text4.insert(4, widget.gm.duration);
        text4.insert(5, widget.gm.availability[0].st.substring(0, 10));
        text6.insert(0, widget.gm.reviewdBy);
        text6.insert(1, widget.gm.serviceSector);
        text6.insert(2, widget.gm.serviceType);
        text6.insert(3, widget.gm.serviceLevel);
        text6.insert(4, widget.gm.availability[0].ed.substring(0, 10));
      });
    }
    if (widget.gm.sPlan == 1) {
      getSteps();
      setState(() {
        text1.insert(5, "Availability : ");
        text4.insert(0, widget.gm.country);
        text4.insert(1, widget.gm.region);
        text4.insert(2, widget.gm.serviceCategory);
        text4.insert(3, widget.gm.aSeats.toString());
        text4.insert(4, widget.gm.duration);
        text4.insert(5, aPlan);
        text6.insert(0, widget.gm.reviewdBy);
        text6.insert(1, widget.gm.serviceSector);
        text6.insert(2, widget.gm.serviceType);
        text6.insert(3, widget.gm.serviceLevel);
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
      adventuresPlan.add(element.day);
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
  List text1 = [
    'Country  :',
    'Region  :',
    'Service Category  :',
    'Available Seats :',
    'Duration :',
    //'Start Date :'
  ];
  List text11 = [
    'Country  :',
    'Region  :',
    'Service Category  :',
    'Available Seats :',
    'Duration :',
    'Availaibilty :'
  ];
  List text4 = [
    //'Oman', 'Salalah', 'Sea', '70', '36 hours', '25 Jul 2020'
  ];
  List text5 = [
    '4.8 (1048 Reviews)',
    'Service Sector  :',
    'Service Type :',
    'Level  :',
    // 'End Date :',
  ];
  List text6 = [];
  List aimedFor = ['Ladies,', 'Gents'];

  List dependencyList = ['Health Conditions', 'License '];
  List activitesInclude = [
    'Transportation from gathering area',
    'Snacks',
    'Bike Riding'
  ];

  double convert(String rating) {
    double result = double.parse(rating);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // length of tabs
      initialIndex: 0,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            //color: greyTextColor,
            child: const TabBar(
              padding: EdgeInsets.all(0),
              labelPadding: EdgeInsets.symmetric(horizontal: 4),
              labelColor: blackColor,
              labelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              indicatorColor: greenishColor,
              isScrollable: true,
              unselectedLabelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto"),
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: greyColor,
              tabs: [
                SizedBox(
                  width: 90.0,
                  child: Tab(
                    text: 'Description',
                  ),
                ),
                SizedBox(
                  width: 70.0,
                  child: Tab(text: 'Program'),
                ),
                SizedBox(
                  width: 150.0,
                  child: Tab(text: 'Gathering Location'),
                ),
                SizedBox(
                  width: 60.0,
                  child: Tab(text: 'Chat'),
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
                  convert(widget.gm.stars),
                ),
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
                ShowChat(
                    "https://adventuresclub.net/adventureClub/receiverlist/${widget.gm.providerId}${widget.gm.id}"),
                //AdventureChatDetails(widget.gm.serviceId.toString())
                // "https://adventuresclub.net/adventureClub/receiverlist/27/'${widget.serviceId}'"
              ],
            ),
          ),
        ],
      ),
    );
  }
}
