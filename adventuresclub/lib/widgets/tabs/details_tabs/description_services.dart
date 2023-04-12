// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/service_description.dart';
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

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Description'),
    Tab(text: 'Program'),
    Tab(text: 'Gathering Location'),
    Tab(text: 'Chat'),
  ];

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
      length: myTabs.length, // length of tabs
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
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
              tabs: myTabs),
        ),
        body: TabBarView(
          children: <Widget>[
            ServiceDescription(
                widget.gm,
                text1,
                text4,
                text5,
                text6,
                convert(widget.gm.stars),
                widget.gm.reviewdBy.toString(),
                widget.gm.id.toString()),
            // program tab
            // 2 nd Tab /////////
            ServicesPlans(widget.gm.sPlan, widget.gm.programmes),
            // 3 rd Tab /////////
            // gathering location
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: MyText(
                        text: 'Description',
                        color: blackColor,
                        weight: FontWeight.w500,
                        size: 17,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  MyText(
                    text: widget.gm.writeInformation,
                    // text:
                    //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                    color: blackColor,
                    weight: FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            text: 'Full Address',
                            color: blackColor,
                            weight: FontWeight.w500,
                            size: 17,
                          )),
                      Row(
                        children: [
                          MyText(
                            text: 'Get Direction',
                            color: greyColor,
                          ),
                          Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(64)),
                            child: const CircleAvatar(
                              radius: 14,
                              backgroundColor: whiteColor,
                              child: Image(
                                image: ExactAssetImage(
                                    'images/location-arrow.png'),
                                height: 15,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Address:',
                      style: TextStyle(
                          color: greyishColor.withOpacity(0.5), fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                            text: widget.gm.sAddress,
                            // text:
                            //     ' Al Ghubra Street , PC 133 , Muscat 1101',
                            style: const TextStyle(
                                fontSize: 14, color: blackColor)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Region :',
                      style: TextStyle(
                          color: greyishColor.withOpacity(0.5), fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                            text: widget.gm.region,
                            //text: ' Omani',
                            style: const TextStyle(
                                fontSize: 14, color: blackColor)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Country :',
                      style: TextStyle(
                          color: greyishColor.withOpacity(0.5), fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                            text: widget.gm.country,
                            //text: ' Oman',
                            style: const TextStyle(
                                fontSize: 14, color: blackColor)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Geo Location :',
                      style: TextStyle(
                          color: greyishColor.withOpacity(0.5), fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                            text: "${widget.gm.lat}${" ,"} ${widget.gm.lng}",
                            //text: ' 60.25455415, 54.2555125',
                            style: const TextStyle(
                                fontSize: 14, color: blackColor)),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage('images/map.png'))),
                  )
                ],
              ),
            ),
            // 4th Tab /////////
            ShowChat(
                "https://adventuresclub.net/adventureClub/receiverlist/${widget.gm.providerId}${widget.gm.id}"),
            //AdventureChatDetails(widget.gm.serviceId.toString())
            // "https://adventuresclub.net/adventureClub/receiverlist/27/'${widget.serviceId}'"
          ],
        ),
      ),
    );
  }
}
