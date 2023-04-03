// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
      child: SingleChildScrollView(
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
                  fontSize: 16,
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
                      )),
                  SizedBox(width: 70.0, child: Tab(text: 'Program')),
                  SizedBox(
                    width: 150.0,
                    child: Tab(text: 'Gathering Location'),
                  ),
                  SizedBox(width: 60.0, child: Tab(text: 'Chat')),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  1.5, //height of TabBarView
              width: MediaQuery.of(context).size.width,
              child: TabBarView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 3.0, vertical: 0),
                    child: Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyText(
                                      text: widget.gm.adventureName,
                                      //'River Rafting',
                                      weight: FontWeight.bold,
                                      color: blackColor,
                                      size: 16,
                                    ),
                                    MyText(
                                      text: 'Earn 180 Points',
                                      weight: FontWeight.bold,
                                      color: blueTextColor,
                                      size: 16,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyText(
                                      text: "${widget.gm.costInc} "
                                          "${widget.gm.currency}",
                                      //'\$150.00',
                                      weight: FontWeight.bold,
                                      color: blackColor,
                                      size: 14,
                                    ),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: MyText(
                                          text: "${widget.gm.costInc} "
                                              "${widget.gm.currency}",
                                          //'\$18.18',
                                          weight: FontWeight.w600,
                                          color: blackColor,
                                          size: 14,
                                          fontFamily: 'Roboto',
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyText(
                                      text: 'Including gears and other taxes',
                                      weight: FontWeight.bold,
                                      color: Colors.red,
                                      size: 10,
                                      fontFamily: 'Roboto',
                                    ),
                                    MyText(
                                      text: 'Including gears and other taxes',
                                      weight: FontWeight.bold,
                                      color: Colors.red,
                                      size: 10,
                                      fontFamily: 'Roboto',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // location etc
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                      text1.length,
                                      (index) {
                                        return RichText(
                                          text: TextSpan(
                                            text:
                                                // country
                                                text1[index],
                                            style: const TextStyle(
                                                color: greyColor2,
                                                fontSize: 14,
                                                height: 1.5),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  //text: widget.gm.country,
                                                  text: text4[index],
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      // fontWeight: FontWeight.w300,
                                                      color: blackColor,
                                                      height: 1.5)),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.vertical,
                                        children: List.generate(text5.length,
                                            (index) {
                                          return text1[index] == 'Country  :'
                                              ? Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: RatingBar.builder(
                                                    initialRating: convert(
                                                        widget.gm.stars),
                                                    itemSize: 12,
                                                    minRating: 0,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 1.0),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                      size: 12,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    },
                                                  ),
                                                )
                                              : RichText(
                                                  text: TextSpan(
                                                    text: text5[index],
                                                    style: const TextStyle(
                                                      color: greyColor2,
                                                      fontSize: 14,
                                                      height: 1.5,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: text6[index],
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              color: blackColor,
                                                              height: 1.5)),
                                                    ],
                                                  ),
                                                );
                                        }),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: MyText(
                                      text: 'Information',
                                      color: greyColor2,
                                      weight: FontWeight.w500,
                                      fontFamily: 'Roboto',
                                      size: 16,
                                    )),
                                const SizedBox(height: 5),
                                MyText(
                                  text: widget.gm.writeInformation,
                                  color: greyColor2,
                                  weight: FontWeight.w500,
                                  fontFamily: 'Roboto',
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: MyText(
                                      text: 'Activities Includes',
                                      color: greyColor.withOpacity(0.6),
                                      weight: FontWeight.bold,
                                      fontFamily: 'Roboto',
                                    )),
                                const SizedBox(height: 5),
                                Wrap(
                                  children: List.generate(
                                      widget.gm.am
                                          .length, //activitesInclude.length,
                                      (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        children: [
                                          Image.network(
                                            "${"https://adventuresclub.net/adventureClub/public/uploads/selection_manager/"}${widget.gm.activityIncludes[index].image}",
                                            height: 18,
                                            width: 18,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          MyText(
                                            text: widget
                                                .gm
                                                .activityIncludes[index]
                                                .activity,
                                            color: greyTextColor,
                                            weight: FontWeight.w500,
                                            fontFamily: 'Roboto',
                                            size: 12,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: MyText(
                                      text: 'Aimed For',
                                      color: greyColor.withOpacity(0.6),
                                      weight: FontWeight.w500,
                                      fontFamily: 'Roboto',
                                    )),
                                const SizedBox(height: 5),
                                Wrap(
                                  children: List.generate(widget.gm.am.length,
                                      (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        children: [
                                          Image.network(
                                            "${"https://adventuresclub.net/adventureClub/public/uploads/selection_manager/"}${widget.gm.am[index].image}",
                                            height: 18,
                                            width: 18,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          MyText(
                                            text: widget.gm.am[index].aimedName,
                                            //text: aimedFor[index],
                                            color: greyColor2,
                                            weight: FontWeight.w500,
                                            fontFamily: 'Roboto',
                                            size: 12,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: MyText(
                                    text: 'Dependency',
                                    color: greyTextColor,
                                    weight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                    size: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Wrap(
                                  children:
                                      List.generate(widget.gm.dependency.length,
                                          //widget.gm.dependencies.length,

                                          (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        children: [
                                          if (widget.gm.dependency[index].name
                                              .isEmpty)
                                            const Icon(
                                              Icons.power_input,
                                              size: 20,
                                            ),
                                          if (widget.gm.dependency[index].name
                                              .isNotEmpty)
                                            Image.network(
                                              "${"https://adventuresclub.net/adventureClub/public/uploads/selection_manager/"}${widget.gm.dependency[index].name}",
                                              height: 18,
                                              width: 18,
                                            ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          MyText(
                                            text: widget
                                                .gm.dependency[index].dName,
                                            //text: aimedFor[index],
                                            color: greyColor2,
                                            weight: FontWeight.w500,
                                            fontFamily: 'Roboto',
                                            size: 12,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                )
                              ],
                            ),
                          ),
                        ),
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(26),
                        //   child: Card(
                        //     child: ClipRRect(
                        //       borderRadius: BorderRadius.circular(26),
                        //       child: ExpansionTile(
                        //         collapsedIconColor: blackTypeColor3,
                        //         tilePadding:
                        //             const EdgeInsets.symmetric(horizontal: 10),
                        //         title: const Text(
                        //           'Terms and conditions',
                        //           style: TextStyle(
                        //               fontSize: 16.0,
                        //               fontWeight: FontWeight.w500,
                        //               color: greyColor2),
                        //         ),
                        //         children: <Widget>[
                        //           Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: MyText(
                        //               align: Alignment.centerLeft,
                        //               text: widget.gm.tnc,
                        //               // text:
                        //               //     'The highest peak in Al-Hajar mountain range and in all of Oman,Jebel Shams(Mountain of the sun) towers above the northern town in Al-Hamra. Rising to about 10,000 feet(3,000 meters).',
                        //               color: greyColor2,
                        //               weight: FontWeight.w400,
                        //               fontFamily: 'Roboto',
                        //               height: 1.5,
                        //               size: 12,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(26),
                          child: Card(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(26),
                              child: ExpansionTile(
                                tilePadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                title: const Text(
                                  'Pre-requisites',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: greyColor2),
                                ),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MyText(
                                      text: widget.gm.preRequisites,
                                      // text:
                                      //     'The highest peak in Al-Hajar mountain range and in all of Oman,Jebel Shams(Mountain of the sun) towers above the northern town in Al-Hamra. Rising to about 10,000 feet(3,000 meters).',
                                      color: greyColor2,
                                      weight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                      height: 1.5,
                                      size: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(26),
                          child: Card(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(26),
                              child: ExpansionTile(
                                tilePadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                title: const Text(
                                  'Minimum Requirement',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: greyColor2),
                                ),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MyText(
                                      text: widget.gm.mRequirements,
                                      // text:
                                      //     'The highest peak in Al-Hajar mountain range and in all of Oman,Jebel Shams(Mountain of the sun) towers above the northern town in Al-Hamra. Rising to about 10,000 feet(3,000 meters).',
                                      color: greyColor2,
                                      weight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                      height: 1.5,
                                      size: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // program tab
                  // 2 nd Tab /////////
                  if (widget.gm.sPlan == 1)
                    ListView.builder(
                      itemCount: widget.gm.programmes.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(4),
                            leading: CircleAvatar(
                              backgroundColor: greenishColor,
                              radius: 25,
                              child: MyText(
                                text: widget.gm.programmes.length,
                                weight: FontWeight.bold,
                              ),
                            ),
                            title: MyText(
                              text: widget.gm.programmes[index].title,
                              color: blackColor,
                              weight: FontWeight.bold,
                              fontFamily: 'Raleway',
                              size: 16,
                            ),
                            subtitle: MyText(
                              text: widget
                                  .gm.programmes[index].des, //text[index],
                              color: greyTextColor,
                              weight: FontWeight.w500,
                              fontFamily: 'Raleway',
                              size: 14,
                            ),
                          ),
                        );
                      }),
                    ),
                  if (widget.gm.sPlan == 2)
                    ListView.builder(
                      itemCount: widget.gm.programmes.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Column(
                            children: [
                              ListTile(
                                minVerticalPadding: 10,
                                contentPadding: const EdgeInsets.all(6),
                                leading: SizedBox(
                                  height: 50,
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: greenishColor,
                                        radius: 25,
                                        child: MyText(
                                          text: widget.gm.programmes.length,
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 0,
                                      ),
                                      // Container(
                                      //   height: 20,
                                      //   width: 2,
                                      //   color: blackColor,
                                      // )
                                    ],
                                  ),
                                ),
                                title: MyText(
                                  text: "${widget.gm.programmes[index].title} "
                                      " ${widget.gm.programmes[index].sD.substring(10, 16)} ${" - "} ${widget.gm.programmes[index].eD.substring(10, 16)} ${" - "} ${widget.gm.programmes[index].sD.substring(0, 10)} ${"-"} ",
                                  color: blackColor,
                                  weight: FontWeight.bold,
                                  fontFamily: 'Raleway',
                                  size: 16,
                                ),
                                subtitle: MyText(
                                  text: widget
                                      .gm.programmes[index].des, //text[index],
                                  color: greyTextColor,
                                  weight: FontWeight.w500,
                                  fontFamily: 'Raleway',
                                  size: 14,
                                ),
                              ),
                              const Divider(
                                endIndent: 30,
                                indent: 30,
                                thickness: 2,
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  // program
                  // Expanded(
                  //   child: ListView.builder(
                  //     padding: const EdgeInsets.only(top: 55),
                  //     itemCount: widget.gm.programmes.length,
                  //     itemBuilder: (context, index) {
                  //       return Padding(
                  //         padding: const EdgeInsets.symmetric(vertical: 12.0),
                  //         child: ListTile(
                  //           leading: CircleAvatar(
                  //             backgroundColor: greenishColor,
                  //             radius: 25,
                  //             child: MyText(
                  //               text: '1',
                  //               weight: FontWeight.bold,
                  //             ),
                  //           ),
                  //           title:

                  //               //  MyText(
                  //               //     //text:"${widget.gm.lat}${" ,"} ${widget.gm.lng}",
                  //               //     text:
                  //               //         "${widget.gm.programmes[index].sD.substring(10, 16)} ${" - "} ${widget.gm.programmes[index].eD.substring(10, 16)} ${" - "} ${widget.gm.programmes[index].sD.substring(0, 10)} ${"-"} ${widget.gm.programmes[index].title}",
                  //               //     //text: '6:00 AM - 6:30 AM - Gathering',
                  //               //     color: blackColor,
                  //               //     weight: FontWeight.bold,
                  //               //     fontFamily: 'Raleway',
                  //               //     size: 16,
                  //               //   ),
                  //               // if (widget.gm.sPlan == 1)
                  //               MyText(
                  //             //text:"${widget.gm.lat}${" ,"} ${widget.gm.lng}",
                  //             text: widget.gm.programmes[index].title,
                  //             //text: '6:00 AM - 6:30 AM - Gathering',
                  //             color: blackColor,
                  //             weight: FontWeight.bold,
                  //             fontFamily: 'Raleway',
                  //             size: 16,
                  //           ),
                  //           subtitle: MyText(
                  //             text: widget
                  //                 .gm.programmes[index].des, //text[index],
                  //             color: greyTextColor,
                  //             weight: FontWeight.w500,
                  //             fontFamily: 'Raleway',
                  //             size: 14,
                  //           ),
                  //         ),
                  //       );

                  //       // Row(
                  //       //   crossAxisAlignment: CrossAxisAlignment.start,
                  //       //   mainAxisAlignment: MainAxisAlignment.start,
                  //       //   children: [
                  //       //     SizedBox(
                  //       //       //width: MediaQuery.of(context).size.width / 6,
                  //       //       child: CircleAvatar(
                  //       //         backgroundColor: greenishColor,
                  //       //         radius: 25,
                  //       //         child: MyText(
                  //       //           text: '1',
                  //       //           weight: FontWeight.bold,
                  //       //         ),
                  //       //       ),
                  //       //       // child: AnotherStepper(
                  //       //       //   verticalGap: 40,
                  //       //       //   scrollPhysics: const ScrollPhysics(),
                  //       //       //   stepperList: stepperData,
                  //       //       //   activeIndex: widget.gm.programmes.length,
                  //       //       //   activeBarColor: greyColorShade400,
                  //       //       //   stepperDirection: Axis.vertical,
                  //       //       //   iconWidth:
                  //       //       //       50, // Height that will be applied to all the stepper icons
                  //       //       //   iconHeight:
                  //       //       //       50, // Width that will be applied to all the stepper icons
                  //       //       // ),
                  //       //     ),
                  //       //     const SizedBox(
                  //       //       width: 20,
                  //       //     ),
                  //       //     Expanded(
                  //       //       child: Padding(
                  //       //         padding: const EdgeInsets.only(top: 10.0),
                  //       //         child: Column(
                  //       //           crossAxisAlignment:
                  //       //               CrossAxisAlignment.start,
                  //       //           mainAxisAlignment: MainAxisAlignment.start,
                  //       //           children: [
                  //       //             if (widget.gm.sPlan == 2)
                  //       //               MyText(
                  //       //                 //text:"${widget.gm.lat}${" ,"} ${widget.gm.lng}",
                  //       //                 text:
                  //       //                     "${widget.gm.programmes[index].sD.substring(10, 16)} ${" - "} ${widget.gm.programmes[index].eD.substring(10, 16)} ${" - "} ${widget.gm.programmes[index].sD.substring(0, 10)} ${"-"} ${widget.gm.programmes[index].title}",
                  //       //                 //text: '6:00 AM - 6:30 AM - Gathering',
                  //       //                 color: blackColor,
                  //       //                 weight: FontWeight.bold,
                  //       //                 fontFamily: 'Raleway',
                  //       //                 size: 16,
                  //       //               ),
                  //       //             if (widget.gm.sPlan == 1)
                  //       //               MyText(
                  //       //                 //text:"${widget.gm.lat}${" ,"} ${widget.gm.lng}",
                  //       //                 text:
                  //       //                     widget.gm.programmes[index].title,
                  //       //                 //text: '6:00 AM - 6:30 AM - Gathering',
                  //       //                 color: blackColor,
                  //       //                 weight: FontWeight.bold,
                  //       //                 fontFamily: 'Raleway',
                  //       //                 size: 16,
                  //       //               ),
                  //       //             // Wrap(
                  //       //             //   direction: Axis.vertical,
                  //       //             //   children: List.generate(
                  //       //             //       widget.gm.programmes[index].length, (index) {
                  //       //             //     return
                  //       //             Padding(
                  //       //               padding: const EdgeInsets.symmetric(
                  //       //                   vertical: 16.0),
                  //       //               child: Row(
                  //       //                 crossAxisAlignment:
                  //       //                     CrossAxisAlignment.start,
                  //       //                 children: [
                  //       //                   const CircleAvatar(
                  //       //                     backgroundColor: greyColor2,
                  //       //                     radius: 5,
                  //       //                   ),
                  //       //                   const SizedBox(
                  //       //                     width: 5,
                  //       //                   ),
                  //       //                   Expanded(
                  //       //                     child: MyText(
                  //       //                       text: widget
                  //       //                           .gm
                  //       //                           .programmes[index]
                  //       //                           .des, //text[index],
                  //       //                       color: greyTextColor,
                  //       //                       weight: FontWeight.w500,
                  //       //                       fontFamily: 'Raleway',
                  //       //                       size: 14,
                  //       //                     ),
                  //       //                   ),
                  //       //                 ],
                  //       //               ),
                  //       //             ),
                  //       //             //   }),
                  //       //             // ),
                  //       //           ],
                  //       //         ),
                  //       //       ),
                  //       //     ),
                  //       //   ],
                  //       // );
                  //     },
                  //   ),
                  // ),

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
                                color: greyishColor.withOpacity(0.5),
                                fontSize: 14),
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
                                color: greyishColor.withOpacity(0.5),
                                fontSize: 14),
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
                                color: greyishColor.withOpacity(0.5),
                                fontSize: 14),
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
                                color: greyishColor.withOpacity(0.5),
                                fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      "${widget.gm.lat}${" ,"} ${widget.gm.lng}",
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
                      "https://adventuresclub.net/adventureClub/receiverlist/27/'${widget.gm.serviceId.toString()}'"),
                  //AdventureChatDetails(widget.gm.serviceId.toString())
                  // "https://adventuresclub.net/adventureClub/receiverlist/27/'${widget.serviceId}'"
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
