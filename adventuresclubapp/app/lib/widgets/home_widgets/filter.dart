// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:app/constants.dart';
import 'package:app/constants_filter.dart';
import 'package:app/home_Screens/Chat/chat.dart';
import 'package:app/models/filter_data_model/activities_inc_model.dart';
import 'package:app/models/filter_data_model/category_filter_model.dart';
import 'package:app/models/filter_data_model/countries_filter.dart';
import 'package:app/models/filter_data_model/filter_data_model.dart';
import 'package:app/models/filter_data_model/region_model.dart';
import 'package:app/models/filter_data_model/sector_filter_model.dart';
import 'package:app/models/filter_data_model/service_types_filter.dart';
import 'package:app/models/services/aimed_for_model.dart';
import 'package:app/provider/services_provider.dart';
import 'package:app/widgets/dropdowns/duration_drop_down.dart';
import 'package:app/widgets/dropdowns/level_drop_down.dart';
import 'package:app/widgets/dropdowns/regionFilter_dropdown.dart';
import 'package:app/widgets/dropdowns/service_category.dart';
import 'package:app/widgets/dropdowns/service_sector_drop_down.dart';
import 'package:app/widgets/dropdowns/service_type_drop_down.dart';
import 'package:app/widgets/my_text.dart';
import 'package:app/widgets/search_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../home_Screens/navigation_screens/bottom_navigation.dart';
import '../../models/create_adventure/regions_model.dart';
import '../../models/filter_data_model/durations_model.dart';
import '../../models/filter_data_model/level_filter_mode.dart';
import '../../models/get_country.dart';

class FilterPage extends StatefulWidget {
  final List<String> images;
  const FilterPage(
    this.images, {
    super.key,
  });

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final PageController _pageViewController = PageController(initialPage: 0);
  TextEditingController searchController = TextEditingController();

  int _activePage = 0;
  int index = 0;
  int currentPage = 0;
  late Timer _timer;
  bool value = false;
  Map mapFilter = {};
  dynamic ccCode;
  int _currentSliderValue = 1;
  Map mapAimedFilter = {};
  List<SectorFilterModel> filterSectors = [];
  List<CategoryFilterModel> categoryFilter = [];
  List<ServiceTypeFilterModel> serviceFilter = [];
  List<CountriesFilterModel> countriesFilter = [];
  List<LevelFilterModel> levelFilter = [];
  List<AimedForModel> dummyAm = [];
  List<RegionsModel> regionList = [];
  List<AimedForModel> am = [];
  List<String> sectorsList = [];
  String categoryDropDown = 'One';
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String selectedCatergoryFilter = "Training";
  List<String> images = [];
  List<DurationsModel> durationFilter = [];
  List<ActivitiesIncludeModel> activitiesFilter = [];
  List<RegionFilterModel> regionFilter = [];
  List<FilterDataModel> fDM = [];
  Map mapCountry = {};
  List<GetCountryModel> countriesList1 = [];
  List<GetCountryModel> filteredServices = [];
  RangeValues values = const RangeValues(0, 1000);
  SectorFilterModel sectorList = SectorFilterModel(0, "", "", 0, "", "", "");
  List<bool> activityValue = [];
  List<ActivitiesIncludeModel> activityIds = [];

  @override
  void initState() {
    super.initState();
    getData();
    aimedFor();
    ccCode = Constants.countryId.toString();
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

  // void getSector() {
  //   Constants.filterSectors.forEach((element) {
  //     sectors
  //   })
  // }

  void getData() {
    regionList = Constants.regionList;
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
  List<String> dropDownTileTextList = [
    'Sector',
    'Category',
    'Type',
    'Level',
    'Duration',
  ];
  List<String> dropDownList = [
    'Oman',
    'Drinks',
    'Snacks',
    'Bike Riding',
    'Sand Smashing',
    'Sand Skiing',
    'Cimbing',
    'Swimming',
  ];
  List<String> activitiesList = [
    'Transportant from gathering area',
    'Drinks',
    'Snacks',
    'Bike Riding',
    'Sand Smashing',
    'Sand Skiing',
    'Cimbing',
    'Swimming',
  ];
  List aimedText = [
    'Gents',
    'Ladies',
  ];
  List<IconData> aimedIconList = [
    Icons.person,
    Icons.person_2,
  ];

  List<IconData> iconList = [
    Icons.place_rounded,
    Icons.no_drinks,
    Icons.food_bank,
    Icons.bike_scooter,
    Icons.get_app,
    Icons.skateboarding,
    Icons.upcoming,
    Icons.swipe
  ];
  List<IconData> dDIconList = [
    Icons.place_rounded,
    Icons.category,
    Icons.merge_type,
    Icons.density_large,
    Icons.timelapse,
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
    var response =
        await http.get(Uri.parse("${Constants.baseUrl}/api/v1/getServiceFor"));
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

  Future getCountries() async {
    var response =
        await http.get(Uri.parse("${Constants.baseUrl}/api/v1/get_countries"));
    if (response.statusCode == 200) {
      mapCountry = json.decode(response.body);
      List<dynamic> result = mapCountry['data'];
      result.forEach((element) {
        GetCountryModel gc = GetCountryModel(
          element['country'],
          element['short_name'],
          element['flag'],
          element['code'],
          element['id'],
          element['currency'] ?? "",
        );
        countriesList1.add(gc);
      });
      setState(() {
        filteredServices = countriesList1;
      });
    }
  }

  void getC(String country, dynamic code, int id, String countryflag) {
    Navigator.of(context).pop();
    setState(
      () {
        // countryCode = country;
        ccCode = id.toString();
        // countryId = id;
        // flag = countryflag;
      },
    );
    print(ccCode);
  }

  void getActivitiesList() {
    for (int i = 0; i < activityValue.length; i++) {
      if (activityValue[i]) {
        activityIds.add(activitiesFilter[i]);
      }
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
        return StatefulBuilder(builder: (context, setState) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 20, top: 30, right: 12, left: 12),
              child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                            Center(
                              child: MyText(
                                  text: 'filter'.tr(),
                                  weight: FontWeight.w800,
                                  color: blackColor.withOpacity(0.7),
                                  size: 18,
                                  fontFamily: 'Raleway'),
                            ),
                            const SizedBox(width: 40),
                          ],
                        ),
                        pickCountry(context, 'Country Location'),
                        Divider(
                          indent: 18,
                          endIndent: 18,
                          color: blackColor.withOpacity(0.3),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: MyText(
                                text: "priceRange".tr(),
                                weight: FontWeight.w800,
                                color: blackColor,
                                size: 18,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              //width: Get.width,
                              child: Column(
                                children: [
                                  RangeSlider(
                                      activeColor: greyColor,
                                      inactiveColor: greyColor.withOpacity(0.3),
                                      min: 0,
                                      max: 1000,
                                      values: values,
                                      onChanged: (value) {
                                        setState(() {
                                          values = value;
                                        });
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 35.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 22, vertical: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: greyColor
                                                      .withOpacity(0.6))),
                                          child: Column(
                                            children: [
                                              MyText(
                                                text: 'minimum'.tr(),
                                                color: greyColor,
                                                size: 12,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text("\$${values.start.toInt()}"),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 22, vertical: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: greyColor
                                                      .withOpacity(0.6))),
                                          child: Column(
                                            children: [
                                              MyText(
                                                text: 'maximum'.tr(),
                                                color: greyColor,
                                                size: 12,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                  "\$${values.end.toInt().toString()}"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        Divider(
                          indent: 18,
                          endIndent: 18,
                          color: blackColor.withOpacity(0.5),
                        ),
                        ListTile(
                          title: MyText(
                            text: "Region".tr(),
                            color: blackColor,
                            weight: FontWeight.bold,
                            size: 14,
                          ),
                          trailing: SizedBox(
                            width: 170,
                            child: Row(
                              children: [
                                Icon(
                                  dDIconList[index],
                                  color: blackColor,
                                ),
                                RegionFilterDropDown(
                                  regionList,
                                  show: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          title: MyText(
                            text: "Sector".tr(),
                            color: blackColor,
                            weight: FontWeight.bold,
                            size: 14,
                          ),
                          trailing: SizedBox(
                            width: 180,
                            child: ServiceSectorDropDown(
                              filterSectors,
                              title: "",
                              show: true,
                            ),
                          ),
                        ),
                        ListTile(
                          title: MyText(
                            text: "Category".tr(),
                            color: blackColor,
                            weight: FontWeight.bold,
                            size: 14,
                          ),
                          trailing: SizedBox(
                            width: 180,
                            child: ServiceCategoryDropDown(
                              categoryFilter,
                              show: true,
                            ),
                          ),
                        ),
                        ListTile(
                          title: MyText(
                            text: "Type".tr(),
                            color: blackColor,
                            weight: FontWeight.bold,
                            size: 14,
                          ),
                          trailing: SizedBox(
                            width: 180,
                            child: ServiceTypeDropDown(
                              serviceFilter,
                              show: true,
                            ),
                          ),
                        ),
                        ListTile(
                          title: MyText(
                            text: "Level".tr(),
                            color: blackColor,
                            weight: FontWeight.bold,
                            size: 14,
                          ),
                          trailing: SizedBox(
                            width: 180,
                            child: LevelDropDown(
                              levelFilter,
                              show: true,
                            ),
                          ),
                        ),
                        ListTile(
                          title: MyText(
                            text: "Duration".tr(),
                            color: blackColor,
                            weight: FontWeight.bold,
                            size: 14,
                          ),
                          trailing: SizedBox(
                            width: 180,
                            child: DurationDropDown(
                              durationFilter,
                              show: true,
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 30,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 12.0),
                        //   child: Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: MyText(
                        //         text: 'Acitivities',
                        //         weight: FontWeight.w800,
                        //         color: blackColor,
                        //         size: 18,
                        //         fontFamily: 'Raleway'),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // const ActivitiesFilterList(),
                        // ListView.builder(
                        //     itemCount: activitiesList.length,
                        //     shrinkWrap: true,
                        //     padding: const EdgeInsets.only(top: 10),
                        //     physics: const ClampingScrollPhysics(),
                        //     itemBuilder: (context, index) {
                        //       return CheckboxListTile(
                        //         secondary: Icon(
                        //           iconList[index],
                        //           color: blackColor,
                        //         ),
                        //         title: MyText(
                        //           text: activitiesList[index],
                        //           color: blackColor.withOpacity(0.6),
                        //           weight: FontWeight.w700,
                        //           size: 15,
                        //         ),
                        //         value: value,
                        //         onChanged: (value) {
                        //           setState(() {
                        //             activityValue[index] =
                        //                 !activityValue[index];
                        //             // activityId
                        //             //     .add(activitiesFilter[index].id);
                        //             // activity.add(
                        //             //     activitiesFilter[index].activity);
                        //           });
                        //         },
                        //       );
                        //     }),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: MyText(
                                text: 'aimedFor'.tr(),
                                weight: FontWeight.w800,
                                color: blackColor,
                                size: 18,
                                fontFamily: 'Raleway'),
                          ),
                        ),
                        ListView.builder(
                            itemCount: aimedText.length,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                secondary: Icon(
                                  aimedIconList[index],
                                  color: blackColor,
                                ),
                                title: MyText(
                                  text: aimedText[index],
                                  color: blackColor.withOpacity(0.6),
                                  weight: FontWeight.w700,
                                  size: 15,
                                ),
                                value: value,
                                onChanged: ((bool? value) {
                                  setState(() {
                                    value = value!;
                                  });
                                }),
                              );
                            }),
                        const SizedBox(
                          height: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: changeStatus,
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
                                      text: 'clearFilter'.tr(),
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
                                      text: 'search'.tr(),
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
        });
      },
    );
  }

  void searchFilter() {
    // Provider.of<ServicesProvider>(context, listen: false).getFilterList(
    //     ccCode,
    //     values.start.toStringAsFixed(0),
    //     values.end.toStringAsFixed(0),
    //     ConstantsFilter.sectorId,
    //     ConstantsFilter.categoryId,
    //     ConstantsFilter.typeId,
    //     ConstantsFilter.levelId,
    //     ConstantsFilter.durationId,
    //     ConstantsFilter.regionId);
    // Provider.of<ServicesProvider>(context, listen: false).searchFilter;
    // Navigator.of(context).pop();
  }

  void changeStatus() {
    clearAll();
    // Navigator.of(context).pop();
    // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //   return const BottomNavigation();
    // }));
    //Provider.of<ServicesProvider>(context, listen: false).getServicesList;
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

  void clearData(String d) {
    setState(() {
      d = "";
    });
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
          left: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                // onTap: addActivites,
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
                width: 14,
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
              //             "${"${Constants.baseUrl}/public/"}${Constants.countryFlag}",
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
              SearchContainer('searchAdventure'.tr(), 1.4, 10, searchController,
                  'images/maskGroup51.png', true, true, Constants.country, 12),
              const SizedBox(
                width: 12,
              ),
              Stack(
                children: [
                  GestureDetector(
                    onTap: goToMessages,
                    child: const Icon(
                      Icons.message,
                      color: whiteColor,
                      size: 40,
                    ),
                  ),
                  if (Constants.chatCount != "0")
                    Positioned(
                      right: 4,
                      bottom: -1,
                      child: Container(
                        height: 18,
                        width: 15,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 187, 39, 28),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: MyText(
                            text: Constants.chatCount,
                            color: whiteColor,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
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
        //                         //   // "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.images[0]}",
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
          top: 90,
          left: 10,
          right: 10,
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
                  // height: MediaQuery.of(context).size.height / 6,
                  // width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: widget.images.isEmpty
                        ? const DecorationImage(
                            image: ExactAssetImage('images/maskGroup1.png'),
                            //   //   NetworkImage(
                            //   // "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.images[0]}",
                          )
                        : DecorationImage(
                            image:
                                //ExactAssetImage('images/maskGroup1.png'),
                                NetworkImage(
                              "${"${Constants.baseUrl}/public/"}${widget.images[index]}",
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

  Widget pickCountry(context, String countryName) {
    getCountries();
    return ListTile(
      onTap: () => showModalBottomSheet(
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(children: [
                      Text(
                        "selectYourCountry".tr(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Raleway-Black'),
                      )
                    ]),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: blackColor.withOpacity(0.5),
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: TextField(
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                filteredServices = countriesList1
                                    .where((element) => element.country
                                        .toLowerCase()
                                        .contains(value))
                                    .toList();
                                //log(filteredServices.length.toString());
                              } else {
                                filteredServices = countriesList1;
                              }
                              setState(() {});
                            },
                            controller: searchController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              hintText: 'Country'.tr(),
                              filled: true,
                              fillColor: lightGreyColor,
                              suffixIcon: GestureDetector(
                                //onTap: openMap,
                                child: const Icon(Icons.search),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: greyColor.withOpacity(0.2)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: greyColor.withOpacity(0.2)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: greyColor.withOpacity(0.2)),
                              ),
                            ),
                          )),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredServices.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            leading: searchController.text.isEmpty
                                ? Image.network(
                                    "${"${Constants.baseUrl}/public/"}${countriesList1[index].flag}",
                                    height: 25,
                                    width: 40,
                                  )
                                : null,
                            title: Text(filteredServices[index].country.tr()),
                            onTap: () {
                              getC(
                                  filteredServices[index].country,
                                  filteredServices[index].code,
                                  filteredServices[index].id,
                                  filteredServices[index].flag);
                            },
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              );
            });
          }),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      title: MyText(
        text: "Country".tr(),
        color: blackColor,
        size: 16,
        weight: FontWeight.w800,
      ),
      trailing: SizedBox(
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              text: "Country".tr(),
              color: blackColor.withOpacity(0.6),
              size: 10,
              weight: FontWeight.w500,
            ),
            const SizedBox(
              height: 1,
            ),
            Row(
              children: [
                Image.network(
                  "${"${Constants.baseUrl}/public/"}${Constants.countryFlag}",
                  height: 15,
                  width: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  Constants.country.tr(),
                  style: const TextStyle(
                      color: blackColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 12),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: blackColor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
