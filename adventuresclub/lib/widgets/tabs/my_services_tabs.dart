import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/tabs/participants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyServicesTab extends StatefulWidget {
  final ServicesModel sm;
  const MyServicesTab(this.sm, {super.key});

  @override
  State<MyServicesTab> createState() => _MyServicesTabState();
}

class _MyServicesTabState extends State<MyServicesTab> {
  String aPlan = "";
  @override
  void initState() {
    super.initState();
    if (widget.sm.sPlan == 2) {
      setState(() {
        text1.insert(5, "Start Date");
        text5.insert(4, "End Date");
        text4.insert(0, widget.sm.country);
        text4.insert(1, widget.sm.region);
        text4.insert(2, widget.sm.serviceCategory);
        text4.insert(3, widget.sm.aSeats.toString());
        text4.insert(4, widget.sm.duration);
        text4.insert(5, widget.sm.availability[0].st.substring(0, 10));
        text6.insert(0, widget.sm.reviewdBy);
        text6.insert(1, widget.sm.serviceSector);
        text6.insert(2, widget.sm.serviceType);
        text6.insert(3, widget.sm.serviceLevel);
        text6.insert(
            4, widget.sm.availability[0].ed.substring(0, 10) ?? DateTime.now());
      });
    }
    if (widget.sm.sPlan == 1) {
      setState(() {
        text1.insert(5, "Availability : ");
        text4.insert(0, widget.sm.country);
        text4.insert(1, widget.sm.region);
        text4.insert(2, widget.sm.serviceCategory);
        text4.insert(3, widget.sm.aSeats.toString());
        text4.insert(4, widget.sm.duration);
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
              child: const TabBar(
                padding: EdgeInsets.all(0),
                labelPadding: EdgeInsets.all(0),
                labelColor: blackColor,
                labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
                indicatorColor: greenishColor,
                unselectedLabelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto'),
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: greyColor,
                tabs: [
                  Tab(
                    text: 'Adventure Details',
                  ),
                  Tab(text: "${'Participants'}"),
                ],
              ),
            ),
          ),
          SizedBox(
            height:
                MediaQuery.of(context).size.height * 1.8, //height of TabBarView
            width: MediaQuery.of(context).size.width,
            child: TabBarView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Wrap(
                              direction: Axis.vertical,
                              children: List.generate(text1.length, (index) {
                                return RichText(
                                  text: TextSpan(
                                    text: text1[index],
                                    style: const TextStyle(
                                        color: greyColor,
                                        fontSize: 12,
                                        height: 1.5),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: text4[index],
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: blackColor,
                                              height: 1.5)),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                          // const SizedBox(
                          //   width: 20,
                          // ),
                          Expanded(
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              crossAxisAlignment: WrapCrossAlignment.end,
                              direction: Axis.vertical,
                              children: List.generate(text5.length, (index) {
                                return text1[index] == 'Country : '
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: RatingBar.builder(
                                          initialRating: 3,
                                          itemSize: 12,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
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
                                          style: TextStyle(
                                            color: index == 0
                                                ? Colors.amber
                                                : greyColor,
                                            fontSize: 12,
                                            height: 1.5,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: text6[index],
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: blackColor,
                                                    height: 1.5)),
                                          ],
                                        ),
                                      );
                              }),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        thickness: 1,
                        color: greyColor.withOpacity(0.4),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: MyText(
                                  text: 'Schedule',
                                  color: greyColor,
                                  weight: FontWeight.w700,
                                  fontFamily: 'Roboto',
                                  size: 16,
                                )),
                            if (widget.sm.sPlan == 1)
                              SizedBox(
                                height: widget.sm.programmes.length * 60,
                                child: ListView.builder(
                                  itemCount: widget.sm.programmes.length,
                                  itemBuilder: ((context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0),
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.all(4),
                                        // leading: CircleAvatar(
                                        //   backgroundColor: greenishColor,
                                        //   radius: 25,
                                        //   child: MyText(
                                        //     text: widget.sm.programmes.length,
                                        //     weight: FontWeight.bold,
                                        //   ),
                                        // ),
                                        title: MyText(
                                          text:
                                              widget.sm.programmes[index].title,
                                          color: blackColor,
                                          weight: FontWeight.bold,
                                          fontFamily: 'Raleway',
                                          size: 16,
                                        ),
                                        subtitle: MyText(
                                          text: widget.sm.programmes[index]
                                              .des, //text[index],
                                          color: greyTextColor,
                                          weight: FontWeight.w500,
                                          fontFamily: 'Raleway',
                                          size: 14,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            if (widget.sm.sPlan == 2)
                              SizedBox(
                                height: widget.sm.programmes.length * 60,
                                child: ListView.builder(
                                  itemCount: widget.sm.programmes.length,
                                  itemBuilder: ((context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            minVerticalPadding: 0,
                                            contentPadding:
                                                const EdgeInsets.all(6),
                                            leading: SizedBox(
                                              height: 50,
                                              child: Column(
                                                children: const [
                                                  // CircleAvatar(
                                                  //   backgroundColor:
                                                  //       greenishColor,
                                                  //   radius: 25,
                                                  //   child: MyText(
                                                  //     text: widget
                                                  //         .sm.programmes.length,
                                                  //     weight: FontWeight.bold,
                                                  //   ),
                                                  // ),
                                                  // const SizedBox(
                                                  //   height: 0,
                                                  // ),
                                                  // Container(
                                                  //   height: 20,
                                                  //   width: 2,
                                                  //   color: blackColor,
                                                  // )
                                                ],
                                              ),
                                            ),
                                            title: MyText(
                                              text:
                                                  "${widget.sm.programmes[index].title} "
                                                  " ${widget.sm.programmes[index].sD.substring(10, 16)} ${" - "} ${widget.sm.programmes[index].eD.substring(10, 16)} ${" - "} ${widget.sm.programmes[index].sD.substring(0, 10)} ${"-"} ",
                                              color: blackColor,
                                              weight: FontWeight.bold,
                                              fontFamily: 'Raleway',
                                              size: 16,
                                            ),
                                            subtitle: MyText(
                                              text: widget.sm.programmes[index]
                                                  .des, //text[index],
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
                              ),
                            // Align(
                            //     alignment: Alignment.centerLeft,
                            //     child: MyText(
                            //         text: '6:00 AM – 6:30 AM - Gathering',
                            //         weight: FontWeight.w500,
                            //         color: blackColor)),
                            // Wrap(
                            //   children: List.generate(
                            //       widget.sm.programmes.length, (index) {
                            //     return Padding(
                            //       padding:
                            //           const EdgeInsets.symmetric(vertical: 4.0),
                            //       child: Row(
                            //         children: [
                            //           CircleAvatar(
                            //             backgroundColor:
                            //                 greyColor.withOpacity(0.8),
                            //             radius: 5,
                            //           ),
                            //           const SizedBox(
                            //             width: 5,
                            //           ),
                            //           MyText(
                            //             text: schedule[index],
                            //             color: greyColor.withOpacity(0.8),
                            //             weight: FontWeight.w400,
                            //             fontFamily: 'Roboto',
                            //             size: 12,
                            //           ),
                            //         ],
                            //       ),
                            //     );
                            //   }),
                            // ),
                            // const SizedBox(height: 20),
                            // Align(
                            //     alignment: Alignment.centerLeft,
                            //     child: MyText(
                            //         text: '6:35 AM -11:30 AM - Journey',
                            //         weight: FontWeight.w500,
                            //         color: blackColor)),
                            // Wrap(
                            //   children: List.generate(journey.length, (index) {
                            //     return Padding(
                            //       padding:
                            //           const EdgeInsets.symmetric(vertical: 4.0),
                            //       child: Row(
                            //         children: [
                            //           const CircleAvatar(
                            //             backgroundColor: greyColor,
                            //             radius: 5,
                            //           ),
                            //           const SizedBox(
                            //             width: 5,
                            //           ),
                            //           MyText(
                            //             text: journey[index],
                            //             color: greyColor.withOpacity(0.5),
                            //             weight: FontWeight.w500,
                            //             fontFamily: 'Roboto',
                            //             size: 12,
                            //           ),
                            //         ],
                            //       ),
                            //     );
                            //   }),
                            // ),
                            // const SizedBox(height: 20),
                            // Align(
                            //     alignment: Alignment.centerLeft,
                            //     child: MyText(
                            //         text: '6:35 AM -11:30 AM - Begin Activity',
                            //         weight: FontWeight.bold,
                            //         color: greenishColor)),
                            // Wrap(
                            //   children: List.generate(journey.length, (index) {
                            //     return Padding(
                            //       padding:
                            //           const EdgeInsets.symmetric(vertical: 4.0),
                            //       child: Row(
                            //         children: [
                            //           const CircleAvatar(
                            //             backgroundColor: greyColor,
                            //             radius: 5,
                            //           ),
                            //           const SizedBox(
                            //             width: 5,
                            //           ),
                            //           MyText(
                            //             text: journey[index],
                            //             color: greyColor.withOpacity(0.5),
                            //             weight: FontWeight.w500,
                            //             fontFamily: 'Roboto',
                            //             size: 12,
                            //           ),
                            //         ],
                            //       ),
                            //     );
                            //   }),
                            // ),
                            const SizedBox(height: 20),
                            Divider(
                              thickness: 1,
                              color: greyColor.withOpacity(0.4),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                text: 'Information',
                                color: greyColor,
                                weight: FontWeight.w700,
                                fontFamily: 'Roboto',
                                size: 16,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: MyText(
                                text: widget.sm
                                    .writeInformation, //'you will need an acceptable fitness to do  this canyon. It is long  canyon and requires  lots of bouldering around on uneven terrain',
                                size: 14,
                                color: greyColor,
                                weight: FontWeight.w400,
                                fontFamily: 'Roboto',
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Divider(
                              thickness: 1,
                              color: greyColor.withOpacity(0.4),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                text: 'Activities Include',
                                color: greyColor.withOpacity(0.8),
                                weight: FontWeight.w700,
                                fontFamily: 'Roboto',
                                size: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Wrap(
                              children: List.generate(
                                  widget
                                      .sm.am.length, //activitesInclude.length,
                                  (index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        "${"https://adventuresclub.net/adventureClub/public/uploads/selection_manager/"}${widget.sm.activityIncludes[index].image}",
                                        height: 18,
                                        width: 18,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      MyText(
                                        text: widget.sm.activityIncludes[index]
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
                            ),
                            // Wrap(
                            //   direction: Axis.horizontal,
                            //   children: List.generate(
                            //     widget.sm.am.length-6,
                            //     (index) {
                            //       return Padding(
                            //         padding:
                            //             const EdgeInsets.symmetric(vertical: 4.0),
                            //         child: Row(
                            //           children: [
                            //              const Icon(Icons.medication),
                            //             const SizedBox(
                            //               width: 5,
                            //             ),
                            //             MyText(
                            //               text: widget.sm.am[index]
                            //                   .aimedName, //aimedFor[index],
                            //               color: greyColor.withOpacity(0.8),
                            //               weight: FontWeight.bold,
                            //               fontFamily: 'Roboto',
                            //               size: 14,
                            //             ),
                            //           ],
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                            Divider(
                              thickness: 1,
                              color: greyColor.withOpacity(0.4),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                text: 'Aimed For',
                                color: greyColor,
                                weight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                size: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Wrap(
                              children:
                                  List.generate(widget.sm.am.length, (index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        "${"https://adventuresclub.net/adventureClub/public/uploads/selection_manager/"}${widget.sm.am[index].image}",
                                        height: 18,
                                        width: 18,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      MyText(
                                        text: widget.sm.am[index].aimedName,
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
                            // Wrap(
                            //   children:
                            //       List.generate(widget.sm.am.length, (index) {
                            //     return Padding(
                            //       padding:
                            //           const EdgeInsets.symmetric(vertical: 4.0),
                            //       child: Row(
                            //         children: [
                            //           const CircleAvatar(
                            //             backgroundColor: greyColorShade400,
                            //             radius: 5,
                            //           ),
                            //           const SizedBox(
                            //             width: 5,
                            //           ),
                            //           MyText(
                            //             text: widget.sm.am[index]
                            //                 .aimedName, //aimedFor[index],
                            //             color: greyColorShade400,
                            //             weight: FontWeight.bold,
                            //             fontFamily: 'Roboto',
                            //             size: 14,
                            //           ),
                            //         ],
                            //       ),
                            //     );
                            //   }),
                            // ),
                            const SizedBox(height: 10),
                            Divider(
                              thickness: 1,
                              color: greyColor.withOpacity(0.4),
                            ),
                            const SizedBox(height: 10),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: MyText(
                                  text: 'Dependency',
                                  color: greyColor,
                                  size: 16,
                                  weight: FontWeight.bold,
                                  fontFamily: 'Roboto',
                                )),
                            const SizedBox(height: 5),
                            Wrap(
                              children:
                                  List.generate(widget.sm.dependency.length,
                                      //widget.gm.dependencies.length,

                                      (index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      if (widget
                                          .sm.dependency[index].name.isEmpty)
                                        const Icon(
                                          Icons.power_input,
                                          size: 20,
                                        ),
                                      if (widget
                                          .sm.dependency[index].name.isNotEmpty)
                                        Image.network(
                                          "${"https://adventuresclub.net/adventureClub/public/uploads/selection_manager/"}${widget.sm.dependency[index].name}",
                                          height: 18,
                                          width: 18,
                                        ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      MyText(
                                        text: widget.sm.dependency[index].dName,
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
                            // Wrap(
                            //   children: List.generate(2, (index) {
                            //     return Padding(
                            //       padding:
                            //           const EdgeInsets.symmetric(vertical: 4.0),
                            //       child: Row(
                            //         children: [
                            //           const CircleAvatar(
                            //             backgroundColor: greyColorShade400,
                            //             radius: 5,
                            //           ),
                            //           const SizedBox(
                            //             width: 5,
                            //           ),
                            //           MyText(
                            //             text: aimedFor[index],
                            //             color: greyColorShade400,
                            //             weight: FontWeight.w500,
                            //             fontFamily: 'Roboto',
                            //             size: 12,
                            //           ),
                            //         ],
                            //       ),
                            //     );
                            //   }),
                            // ),
                            Divider(
                              color: greyColor.withOpacity(0.4),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: greyColor.withOpacity(0.4),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                text: 'Terms and conditions ',
                                color: greyColor,
                                weight: FontWeight.w700,
                                fontFamily: 'Roboto',
                                size: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                text: widget.sm.tnc,
                                color: greyColor,
                                weight: FontWeight.w500,
                                fontFamily: 'Roboto',
                                size: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: greyColor.withOpacity(0.4),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                text: 'Pre-Requisites :',
                                color: greyColor,
                                weight: FontWeight.w500,
                                fontFamily: 'Roboto',
                                size: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                text: widget.sm.preRequisites,
                                color: greyColor,
                                weight: FontWeight.w700,
                                fontFamily: 'Roboto',
                                size: 16,
                              ),
                            ),
                            Divider(
                              color: greyColor.withOpacity(0.4),
                            ),
                            // RichText(
                            //   text: TextSpan(
                            //     text: 'Pre-Requisites :',
                            //     style: const TextStyle(
                            //         color: greyColor,
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w500),
                            //     children: <TextSpan>[
                            //       TextSpan(
                            //           text: widget.sm
                            //               .preRequisites, //'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer fermentum nunc vehicula ligula placerat, et fermentum turpis ornare. Nullam ultricies pretium faucibus. In pulvinar rhoncus libero, eget lacinia sem condimentum ut. Nullam rutrum id mauris a venenatis. Aenean ipsum ante, iaculis iaculis ante quis',
                            //           style: TextStyle(
                            //               fontSize: 14,
                            //               color: greyColor.withOpacity(0.8))),
                            //     ],
                            //   ),
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: greyColor.withOpacity(0.4),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                text: 'Minimum Requirement  :',
                                color: greyColor,
                                weight: FontWeight.w700,
                                fontFamily: 'Roboto',
                                size: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                text: widget.sm.mRequirements,
                                color: greyColor,
                                weight: FontWeight.w500,
                                fontFamily: 'Roboto',
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Participants(widget.sm.id)
                // SquareButton('Upcoming', bluishColor, whiteColor, 2.4, 16, 16, abc),
                //         SquareButton('Completed', greyColor, whiteColor, 2.4, 16, 16, abc), ///////
              ],
            ),
          ),
        ],
      ),
    );
  }
}
