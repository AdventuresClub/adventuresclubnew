// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/Chat/chat.dart';
import 'package:adventuresclub/models/filter_data_model/activities_inc_model.dart';
import 'package:adventuresclub/models/filter_data_model/category_filter_model.dart';
import 'package:adventuresclub/models/filter_data_model/countries_filter.dart';
import 'package:adventuresclub/models/filter_data_model/filter_data_model.dart';
import 'package:adventuresclub/models/filter_data_model/region_model.dart';
import 'package:adventuresclub/models/filter_data_model/sector_filter_model.dart';
import 'package:adventuresclub/models/filter_data_model/service_types_filter.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/provider/services_provider.dart';
import 'package:adventuresclub/widgets/dropdowns/aimed_for_drop_down.dart';
import 'package:adventuresclub/widgets/dropdowns/country_drop_down.dart';
import 'package:adventuresclub/widgets/dropdowns/duration_drop_down.dart';
import 'package:adventuresclub/widgets/dropdowns/level_drop_down.dart';
import 'package:adventuresclub/widgets/dropdowns/region_dropdown.dart';
import 'package:adventuresclub/widgets/dropdowns/service_category.dart';
import 'package:adventuresclub/widgets/dropdowns/service_sector_drop_down.dart';
import 'package:adventuresclub/widgets/dropdowns/service_type_drop_down.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/search_container.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../models/filter_data_model/durations_model.dart';
import '../../models/filter_data_model/level_filter_mode.dart';

class StackHome extends StatefulWidget {
  final List<String> images;
  const StackHome(
    this.images, {
    super.key,
  });

  @override
  State<StackHome> createState() => _StackHomeState();
}

class _StackHomeState extends State<StackHome> {
  final PageController _pageViewController = PageController(initialPage: 0);
  TextEditingController searchController = TextEditingController();

  int _activePage = 0;
  int index = 0;
  int _currentPage = 0;
  late Timer _timer;
  bool value = false;
  Map mapFilter = {};
  Map mapAimedFilter = {};
  List<SectorFilterModel> filterSectors = [];
  List<CategoryFilterModel> categoryFilter = [];
  List<ServiceTypeFilterModel> serviceFilter = [];
  List<CountriesFilterModel> countriesFilter = [];
  List<LevelFilterModel> levelFilter = [];
  List<AimedForModel> dummyAm = [];
  List<AimedForModel> am = [];
  String categoryDropDown = 'One';
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String selectedCatergoryFilter = "Training";
  List<String> images = [];
  List<DurationsModel> durationFilter = [];
  List<ActivitiesIncludeModel> activitiesFilter = [];
  List<RegionFilterModel> regionFilter = [];
  List<FilterDataModel> fDM = [];

  @override
  void initState() {
    super.initState();
    getData();
    aimedFor();
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (Timer timer) {
        if (_activePage < 2) {
          _activePage++;
        } else {
          _activePage = 0;
        }
        _pageViewController.animateToPage(
          _activePage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      },
    );
  }

  void getData() {
    categoryFilter = Constants.categoryFilter;
    filterSectors = Constants.filterSectors;
    serviceFilter = Constants.serviceFilter;
    durationFilter = Constants.durationFilter;
    regionFilter = Constants.regionFilter;
    levelFilter = Constants.levelFilter;
    activitiesFilter = Constants.activitiesFilter;
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose(); // dispose the PageController
    _timer.cancel();
  }

  void goToMessages() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const Chat();
        },
      ),
    );
  }

  abc() {}
  List text = [
    'Drinks',
    'Snacks',
    'Bike Riding',
    'Sand bashing',
    'Sand Skiing',
    'Cimbing',
    'Swimming',
    'Transportation',
  ];
  List<Widget> pages = [
    Container(
      // height: MediaQuery.of(context).size.height / 6,
      // width: MediaQuery.of(context).size.width / 1.1,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('images/maskGroup1.png'),
        ),
      ),
    ),
    Container(
      // height: MediaQuery.of(context).size.height / 6,
      // width: MediaQuery.of(context).size.width / 1.1,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('images/maskGroup1.png'),
        ),
      ),
    ),
  ];

  void selectedCategory(String cf) {
    setState(() {
      selectedCatergoryFilter = cf;
    });
  }

  void clearAll() {
    filterSectors.clear();
    categoryFilter.clear();
    serviceFilter.clear();
    countriesFilter.clear();
    levelFilter.clear();
    durationFilter.clear();
    activitiesFilter.clear();
    regionFilter.clear();
    dummyAm.clear();
    fDM.clear();
  }

  void getFilters() {
    setState(() {
      Constants.getFilter1(
        mapFilter,
        filterSectors,
        categoryFilter,
        serviceFilter,
        countriesFilter,
        levelFilter,
        durationFilter,
        activitiesFilter,
        regionFilter,
        dummyAm,
        fDM,
      );
    });
  }

  void aimedFor() async {
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/getServiceFor"));
    if (response.statusCode == 200) {
      mapAimedFilter = json.decode(response.body);
      List<dynamic> result = mapAimedFilter['message'];
      result.forEach((element) {
        int id = int.tryParse(element['id'].toString()) ?? 0;
        AimedForModel amf = AimedForModel(
          id,
          element['AimedName'].toString() ?? "",
          element['image'].toString() ?? "",
          element['created_at'].toString() ?? "",
          element['updated_at'].toString() ?? "",
          element['deleted_at'].toString() ?? "",
          0,
          //  selected: false,
        );
        am.add(amf);
      });
    }
  }

  void addActivites() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, _, __) {
        return Padding(
          padding: EdgeInsets.only(
              left: 6.0,
              right: 6.0,
              bottom: MediaQuery.of(context).size.height / 4.8,
              top: 30),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.4,
            height: MediaQuery.of(context).size.height / 1,
            child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 0, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // const SizedBox(height: 0),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 40),
                            Center(
                              child: MyText(
                                  text: 'Filter',
                                  weight: FontWeight.bold,
                                  color: blackColor,
                                  size: 20,
                                  fontFamily: 'Raleway'),
                            ),
                            GestureDetector(
                              onTap: Navigator.of(context).pop,
                              child: const Align(
                                alignment: Alignment.centerRight,
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: whiteColor,
                                  child: Image(
                                    image: ExactAssetImage(
                                        'images/cancel-button.png'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                        text: 'Sector',
                                        color: greyColor,
                                        weight: FontWeight.w700,
                                        size: 12),
                                    ServiceSectorDropDown(
                                      filterSectors,
                                      show: true,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                        text: 'Category',
                                        color: greyColor,
                                        weight: FontWeight.w600,
                                        size: 12),
                                    ServiceCategoryDropDown(
                                      categoryFilter,
                                      show: true,
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                        text: 'Type',
                                        color: greyColor,
                                        weight: FontWeight.w600,
                                        size: 12),
                                    ServiceTypeDropDown(
                                      serviceFilter,
                                      show: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                        text: 'Aimed For',
                                        color: greyColor,
                                        weight: FontWeight.w700,
                                        size: 12),
                                    AimedForDropDown(
                                      am,
                                      show: true,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                        text: 'Country',
                                        color: greyColor,
                                        weight: FontWeight.w600,
                                        size: 12),
                                    CountriesDropDown(
                                      countriesFilter,
                                      show: true,
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                        text: 'Region',
                                        color: greyColor,
                                        weight: FontWeight.w600,
                                        size: 12),
                                    RegionDropDown(
                                      regionFilter,
                                      show: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                        text: 'Level',
                                        color: greyColor,
                                        weight: FontWeight.w700,
                                        size: 12),
                                    LevelDropDown(
                                      levelFilter,
                                      show: true,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                        text: 'Duration',
                                        color: greyColor,
                                        weight: FontWeight.w600,
                                        size: 12),
                                    DurationDropDown(
                                      durationFilter,
                                      show: true,
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                        text: 'Budget',
                                        color: greyColor,
                                        weight: FontWeight.w600,
                                        size: 12),
                                    ServiceCategoryDropDown(
                                      categoryFilter,
                                      show: true,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 30.0, left: 5),
                      //   child: Column(
                      //     children: [
                      //       const SizedBox(height: 5),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             children: [
                      //               Row(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.spaceBetween,
                      //                 children: [

                      //                   const SizedBox(
                      //                     width: 10,
                      //                   ),
                      //                   //Expanded(child: ServiceCategoryDropDown(categoryFilter))
                      //                   // const SizedBox(
                      //                   //   width: 5,
                      //                   // ),
                      //                   // Expanded(
                      //                   //   child: ServiceSectorDropDown(cList),
                      //                   // ),
                      //                   // DdButton(
                      //                   //   2.4,
                      //                   //   dropDown: "Training",
                      //                   //   dropDownList: serviceSector,
                      //                   // ),
                      //                   // DdButton(
                      //                   //   2.4,
                      //                   //   dropDown: "Service Category",
                      //                   //   dropDownList: cList,
                      //                   // ),
                      //                 ],
                      //               ),
                      //               // const DropdownWithTI('Training', false,
                      //               //     false, 6.1, true, true),
                      //             ],
                      //           ),
                      //           // Column(
                      //           //   mainAxisAlignment: MainAxisAlignment.start,
                      //           //   crossAxisAlignment: CrossAxisAlignment.start,
                      //           //   children: [
                      //           //     MyText(
                      //           //         text: 'Category',
                      //           //         color: greyColor,
                      //           //         weight: FontWeight.w600,
                      //           //         size: 12),
                      //           //     const DropdownWithTI('Training', false,
                      //           //         false, 6.1, true, true),
                      //           //   ],
                      //           // ),
                      //           // Column(
                      //           //   crossAxisAlignment: CrossAxisAlignment.start,
                      //           //   mainAxisAlignment: MainAxisAlignment.start,
                      //           //   children: [
                      //           //     MyText(
                      //           //         text: 'Type',
                      //           //         color: greyColor,
                      //           //         weight: FontWeight.w600,
                      //           //         size: 12),
                      //     const DropdownWithTI('Training', false,
                      //         false, 6.1, true, true),
                      //           //   ],
                      //           // ),
                      //         ],
                      //       ),
                      //       // const SizedBox(
                      //       //   height: 10,
                      //       // ),
                      //       // Row(
                      //       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       //   children: [
                      //       //     Column(
                      //       //       mainAxisAlignment: MainAxisAlignment.start,
                      //       //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       //       children: [
                      //       //         MyText(
                      //       //             text: 'Aimed For',
                      //       //             color: greyColor,
                      //       //             weight: FontWeight.w600,
                      //       //             size: 12),
                      //       //         const DropdownWithTI('Training', false,
                      //       //             false, 6.1, true, true),
                      //       //       ],
                      //       //     ),
                      //       //     Column(
                      //       //       mainAxisAlignment: MainAxisAlignment.start,
                      //       //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       //       children: [
                      //       //         MyText(
                      //       //             text: 'Country',
                      //       //             weight: FontWeight.w600,
                      //       //             color: greyColor,
                      //       //             size: 12),
                      //       //         const DropdownWithTI('Training', false,
                      //       //             false, 6.1, true, true),
                      //       //       ],
                      //       //     ),
                      //       //     Column(
                      //       //       mainAxisAlignment: MainAxisAlignment.start,
                      //       //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       //       children: [
                      //       //         MyText(
                      //       //             text: 'Region',
                      //       //             weight: FontWeight.w600,
                      //       //             color: greyColor,
                      //       //             size: 12),
                      //       //         const DropdownWithTI('Training', false,
                      //       //             false, 6.1, true, true),
                      //       //       ],
                      //       //     ),
                      //       //   ],
                      //       // ),
                      //       // const SizedBox(
                      //       //   height: 10,
                      //       // ),
                      //       // Row(
                      //       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       //   children: [
                      //       //     Column(
                      //       //       mainAxisAlignment: MainAxisAlignment.start,
                      //       //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       //       children: [
                      //       //         MyText(
                      //       //             text: 'Aimed',
                      //       //             weight: FontWeight.w600,
                      //       //             color: greyColor,
                      //       //             size: 12),
                      //       //         const DropdownWithTI('Training', false,
                      //       //             false, 6.1, true, true),
                      //       //       ],
                      //       //     ),
                      //       //     Column(
                      //       //       mainAxisAlignment: MainAxisAlignment.start,
                      //       //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       //       children: [
                      //       //         MyText(
                      //       //             text: 'Duration',
                      //       //             weight: FontWeight.w600,
                      //       //             color: greyColor,
                      //       //             size: 12),
                      //       //         const DropdownWithTI('Training', false,
                      //       //             false, 6.1, true, true),
                      //       //       ],
                      //       //     ),
                      //       //     Column(
                      //       //       mainAxisAlignment: MainAxisAlignment.start,
                      //       //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       //       children: [
                      //       //         MyText(
                      //       //             text: 'Budget',
                      //       //             color: greyColor,
                      //       //             weight: FontWeight.w600,
                      //       //             size: 12),
                      //       //         const DropdownWithTI('Training', false,
                      //       //             false, 6.1, true, true),
                      //       //       ],
                      //       //     ),
                      //       //   ],
                      //       // ),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // MyText(
                      //   text: 'Activities Included',
                      //   color: blackTypeColor4,
                      //   weight: FontWeight.bold,
                      // ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MyText(
                            text: 'Acitivites Includes',
                            weight: FontWeight.bold,
                            color: blackColor,
                            size: 16,
                            fontFamily: 'Raleway'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GridView.count(
                        padding: const EdgeInsets.only(left: 0),
                        shrinkWrap: true,
                        mainAxisSpacing: 0,
                        childAspectRatio: 3.5,
                        crossAxisSpacing: 0,
                        crossAxisCount: 3,
                        children: List.generate(text.length, (index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MyText(
                                text: text[index],
                                color: greyColor,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              SizedBox(
                                width: 15,
                                child: Checkbox(
                                  value: value,
                                  onChanged: ((bool? value) {
                                    setState(() {
                                      value = value!;
                                    });
                                  }),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // MyText(
                      //   text: 'Provider Name',
                      //   color: blackTypeColor3,
                      //   weight: FontWeight.bold,
                      // ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // SearchContainer(
                      //     'Search by provider name',
                      //     1.2,
                      //     8,
                      //     searchController,
                      //     'images/bin.png',
                      //     false,
                      //     false,
                      //     'abc',
                      //     14),
                      const SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              //    onTap: goTo,
                              child: Container(
                                  width: 130,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 18),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: redColor),
                                      color: whiteColor),
                                  child: Center(
                                      child: MyText(
                                    text: 'Clear Filter',
                                    color: redColor,
                                    weight: FontWeight.bold,
                                    size: 14,
                                  ))),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: searchFilter,
                              child: Container(
                                width: 110,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 18),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: bluishColor),
                                    color: bluishColor),
                                child: Center(
                                  child: MyText(
                                    text: 'Search',
                                    color: whiteColor,
                                    weight: FontWeight.bold,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  void searchFilter() {
    Provider.of<ServicesProvider>(context, listen: false).getFilteredList();
  }

  // void searchServices(String x) {
  //   if (x.isNotEmpty) {
  //     filteredServices = allServices
  //         .where((element) => element.adventureName.toLowerCase().contains(x))
  //         .toList();
  //     //log(filteredServices.length.toString());
  //   } else {
  //     filteredServices = allServices;
  //   }
  //   setState(() {});
  // }

  void searchAdventure(String y) {
    Provider.of<ServicesProvider>(context, listen: false).setSearch(y);
  }

  @override
  Widget build(BuildContext context) {
    return
        // loading
        //     ? Column(
        //         children: const [
        //           CircularProgressIndicator(),
        //           Text("Loading..."),
        //         ],
        //       )
        //     :
        Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.height / 1.4,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('images/homeScreen.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 35,
          left: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: addActivites,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: greyColor,
                    image: const DecorationImage(
                      image: ExactAssetImage(
                        'images/pathpic.png',
                      ),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              // Container(
              //   padding:
              //       const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 4),
              //   width: MediaQuery.of(context).size.width / 1.4,
              //   height: 50,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     border: Border.all(
              //         color: blackColor.withOpacity(0.4), width: 1.7),
              //     color: whiteColor,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           const Icon(
              //             Icons.search,
              //             color: greyColor,
              //             size: 30,
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           SizedBox(
              //             width: MediaQuery.of(context).size.width / 2.8,
              //             child: TextField(
              //               onChanged: (value) {
              //                 searchAdventure(value);
              //               },
              //               controller: searchController,
              //               decoration: const InputDecoration(
              //                   hintText: "Search Adventure",
              //                   border: InputBorder.none,
              //                   hintStyle: TextStyle(fontSize: 16)),
              //             ),
              //           ),
              //           // Text(
              //           //   widget.hinttext,
              //           //   style: TextStyle(
              //           //       color: searchTextColor.withOpacity(0.8),
              //           //       fontSize: widget.fontSize),
              //           // ),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Text(
              //             Constants.country,
              //             style: TextStyle(
              //               color: searchTextColor.withOpacity(0.8),
              //               fontSize: 12,
              //             ),
              //           ),
              //           Image.network(
              //             "${"https://adventuresclub.net/adventureClub/public/"}${Constants.countryFlag}",
              //             height: 15,
              //             width: 15,
              //           ),
              //           const SizedBox(
              //             width: 5,
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              SearchContainer('Search adventure name', 1.4, 8, searchController,
                  'images/maskGroup51.png', true, true, Constants.country, 12),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: goToMessages,
                child: const Icon(
                  Icons.message,
                  color: whiteColor,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        // widget.images.isEmpty
        //     ? Positioned(
        //         top: 100,
        //         left: 15,
        //         right: 15,
        //         child: SizedBox(
        //           height: MediaQuery.of(context).size.height / 5,
        //           child: PageView.builder(
        //             controller: _pageViewController,
        //             onPageChanged: (index) {
        //               setState(
        //                 () {
        //                   _activePage = index;
        //                 },
        //               );
        //             },
        //             itemCount: 1,
        //             itemBuilder: (BuildContext context, int index) {
        //               return ListView.builder(
        //                 itemBuilder: (context, index) {
        //                   return Container(
        //                     height: MediaQuery.of(context).size.height / 6,
        //                     width: MediaQuery.of(context).size.width / 1.1,
        //                     decoration: BoxDecoration(
        //                       color: whiteColor,
        //                       borderRadius: BorderRadius.circular(16),
        //                       image: const DecorationImage(
        //                         image: ExactAssetImage('images/maskGroup1.png'),
        //                         //   //   NetworkImage(
        //                         //   // "${"https://adventuresclub.net/adventureClub/public/uploads/selection_manager/"}${widget.images[0]}",
        //                       ),
        //                     ),
        //                   );
        //                 },
        //               );
        //             },
        //           ),
        //         ),
        //       )
        Positioned(
          top: 100,
          left: 15,
          right: 15,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            child: PageView.builder(
              controller: _pageViewController,
              onPageChanged: (index) {
                setState(
                  () {
                    _activePage = index;
                  },
                );
              },
              itemCount: widget.images.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: widget.images.isEmpty
                        ? const DecorationImage(
                            image: ExactAssetImage('images/maskGroup1.png'),
                            //   //   NetworkImage(
                            //   // "${"https://adventuresclub.net/adventureClub/public/uploads/selection_manager/"}${widget.images[0]}",
                          )
                        : DecorationImage(
                            image:
                                //ExactAssetImage('images/maskGroup1.png'),
                                NetworkImage(
                              "${"https://adventuresclub.net/adventureClub/public/"}${widget.images[index]}",
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: -55,
          left: 0,
          right: 0,
          height: 40,
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                widget.images.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: InkWell(
                    onTap: () {
                      _pageViewController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 6,
                          backgroundColor:
                              _activePage == index ? greenishColor : greyColor,
                        ),
                        CircleAvatar(
                          radius: _activePage != index ? 6 : 7,
                          // check if a dot is connected to the current page
                          // if true, give it a different color
                          backgroundColor:
                              _activePage == index ? greenishColor : whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
