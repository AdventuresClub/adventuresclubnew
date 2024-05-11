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
import 'package:adventuresclub/provider/navigation_index_provider.dart';
import 'package:adventuresclub/provider/services_provider.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/top_list.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/search_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../models/create_adventure/regions_model.dart';
import '../../models/filter_data_model/durations_model.dart';
import '../../models/filter_data_model/level_filter_mode.dart';
import '../../models/get_country.dart';

class NewFilterPage extends StatefulWidget {
  const NewFilterPage({
    super.key,
  });

  @override
  State<NewFilterPage> createState() => _NewFilterPageState();
}

class _NewFilterPageState extends State<NewFilterPage> {
  TextEditingController searchController = TextEditingController();

  //int index = 0;
  int currentPage = 0;
  bool value = false;
  Map mapFilter = {};
  dynamic ccCode;
  Map mapAimedFilter = {};
  List<SectorFilterModel> filterSectors = [];
  List<CategoryFilterModel> categoryFilter = [];
  List<ServiceTypeFilterModel> serviceFilter = [];
  List<CountriesFilterModel> countriesFilter = [];
  List<LevelFilterModel> levelFilter = [];
  //List<AimedForModel> dummyAm = [];
  List<RegionsModel> regionList = [];
  //List<AimedForModel> am = [];
  List<String> sectorsList = [];
  String categoryDropDown = 'One';
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String selectedCatergoryFilter = "Training";
  List<String> images = [];
  List<DurationsModel> durationFilter = [];
  List<AimedForModel> aimedForModel = [];
  List<ActivitiesIncludeModel> activitiesFilter = [];
  //List<RegionFilterModel> regionFilter = [];
  List<FilterDataModel> fDM = [];
  Map mapCountry = {};
  List<GetCountryModel> countriesList1 = [];
  List<GetCountryModel> filteredServices = [];
  RangeValues values = const RangeValues(1, 1000);
  SectorFilterModel sectorList = SectorFilterModel(0, "", "", 0, "", "", "");
  List<bool> activityValue = [];
  List<ActivitiesIncludeModel> activityIds = [];
  String selectedRegion = "";
  String selectedCategory = "";
  String selectedServiceSector = "";
  String selectedServiceType = "";
  String selectedDuration = "";
  String selectedLevel = "";
  String selectedAimedFor = "";
  String selectedRegionId = "";
  String selectedCategoryId = "";
  String selectedServiceSectorId = "";
  String selectedServiceTypeId = "";
  String selectedDurationId = "";
  String selectedAimedForId = "";
  String selectedLevelId = "";
  String c = "";
  // String flag = "";
  // String selectedCountry = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getCountries();
    //getData();
    getFilter();
    aimedFor();
    ccCode = Constants.countryId.toString();
    getRegions();
  }

  Future<void> getFilter() async {
    categoryFilter.clear();
    filterSectors.clear();
    serviceFilter.clear();
    durationFilter.clear();
    // regionFilter.clear();
    levelFilter.clear();
    activitiesFilter.clear();
    aimedForModel.clear();
    getRegions();
    // setState(() {
    //   loading = true;
    // });
    var response = await http
        .get(Uri.parse("${Constants.baseUrl}/api/v1/filter_modal_data"));
    if (response.statusCode == 200) {
      mapFilter = json.decode(response.body);
      dynamic result = mapFilter['data'];
      List<dynamic> sectorData = result['sectors'];
      sectorData.forEach((data) {
        SectorFilterModel sm = SectorFilterModel(
          int.tryParse(data['id'].toString()) ?? 0,
          data['sector'],
          data['image'],
          int.tryParse(data['status'].toString()) ?? 0,
          data['created_at'],
          data['updated_at'],
          data['deleted_at'] ?? "",
        );
        filterSectors.add(sm);
      });
      List<dynamic> cat = result['categories'];
      cat.forEach((cateGory) {
        int c = int.tryParse(cateGory['id'].toString()) ?? 0;
        CategoryFilterModel cm = CategoryFilterModel(
          c,
          cateGory['category'],
          cateGory['image'],
          cateGory['status'],
          cateGory['created_at'],
          cateGory['updated_at'],
          cateGory['deleted_at'] ?? "",
        );
        categoryFilter.add(cm);
      });
      List<dynamic> serv = result['service_types'];
      serv.forEach((type) {
        ServiceTypeFilterModel st = ServiceTypeFilterModel(
          int.tryParse(type['id'].toString()) ?? 0,
          type['type'],
          type['image'],
          int.tryParse(type['status'].toString()) ?? 0,
          type['created_at'],
          type['updated_at'],
          type['deleted_at'] ?? "",
        );
        serviceFilter.add(st);
      });
      //List<dynamic> aimedF = result['aimed_for'];
      List<dynamic> count = result['countries'];
      count.forEach((country) {
        int cb = int.tryParse(country['created_by'].toString()) ?? 0;
        CountriesFilterModel cf = CountriesFilterModel(
          int.tryParse(country['id'].toString()) ?? 0,
          country['country'],
          country['short_name'],
          country['code'],
          country['currency'],
          country['description'] ?? "",
          country['flag'],
          country['status'],
          cb,
          country['created_at'],
          country['updated_at'],
          country['deleted_at'] ?? "",
        );
        countriesFilter.add(cf);
      });
      List<dynamic> lev = result['levels'];
      lev.forEach((level) {
        LevelFilterModel lm = LevelFilterModel(
          int.tryParse(level['id'].toString()) ?? 0,
          level['level'],
          level['image'],
          level['status'],
          level['created_at'],
          level['updated_at'],
          level['deleted_at'] ?? "",
        );
        levelFilter.add(lm);
      });
      List<dynamic> d = result['durations'];
      d.forEach((dur) {
        int id = int.tryParse(dur['id'].toString()) ?? 0;
        DurationsModel dm = DurationsModel(id, dur['duration'].toString());
        durationFilter.add(dm);
      });
      List<dynamic> a = result['activities_including'];
      a.forEach((act) {
        int id = int.tryParse(act['id'].toString()) ?? 0;
        ActivitiesIncludeModel activities = ActivitiesIncludeModel(
            id, act['activity'].toString(), act['image'] ?? "");
        activitiesFilter.add(activities);
      });
      List<dynamic> r = result['regions'];
      r.forEach((reg) {
        int id = int.tryParse(reg['id'].toString()) ?? 0;
        RegionFilterModel rm = RegionFilterModel(id, reg['region']);
        // regionFilter.add(rm);
      });
    }
  }

  void getRegions() async {
    regionList.clear();
    aimedFor();
    setState(() {
      loading = true;
    });
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/get_regions"), body: {
        'country_id': ccCode.toString(),
      });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> rm = decodedResponse['data'];
      rm.forEach((element) {
        int cId = int.tryParse(element['country_id'].toString()) ?? 0;
        int rId = int.tryParse(element['region_id'].toString()) ?? 0;
        RegionsModel r = RegionsModel(
          cId,
          element['country'] ?? "",
          rId,
          element['region'] ?? "",
        );
        regionList.add(r);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  void aimedFor() async {
    aimedForModel.clear();
    var response =
        await http.get(Uri.parse("${Constants.baseUrl}/api/v1/getServiceFor"));
    if (response.statusCode == 200) {
      mapAimedFilter = json.decode(response.body);
      List<dynamic> result = mapAimedFilter['message'];
      result.forEach((element) {
        int id = int.tryParse(element['id'].toString()) ?? 0;
        AimedForModel amf = AimedForModel(
          id,
          element['AimedName'] ?? "",
          element['image'] ?? "",
          element['created_at'] ?? "",
          element['updated_at'] ?? "",
          element['deleted_at'] ?? "",
          0,
          //  selected: false,
        );
        aimedForModel.add(amf);
      });
    }
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  // void getData() {
  //   regionList = Constants.regionList;
  //   categoryFilter = Constants.categoryFilter;
  //   filterSectors = Constants.filterSectors;
  //   serviceFilter = Constants.serviceFilter;
  //   durationFilter = Constants.durationFilter;
  //   regionFilter = Constants.regionFilter;
  //   levelFilter = Constants.levelFilter;
  //   activitiesFilter = Constants.activitiesFilter;
  //   aimedForModel = Constants.am;
  // }

  @override
  void dispose() {
    super.dispose();
    // _pageViewController.dispose(); // dispose the PageController
    // _timer.cancel();
  }

  void goToMessages() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const Chat();
        },
      ),
    );
    getDataCount();
  }

  void getDataCount() {
    Provider.of<NavigationIndexProvider>(context, listen: false)
        .getCounterChat(Constants.userId.toString());
  }

  abc() {}

  List<String> aimedText = [
    'Gents',
    'Ladies',
  ];
  List<bool> aimedTextBool = [
    false,
    false,
  ];
  List<IconData> aimedIconList = [
    Icons.person,
    Icons.person_2,
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

  void clearAll() {
    filterSectors.clear();
    categoryFilter.clear();
    serviceFilter.clear();
    countriesFilter.clear();
    levelFilter.clear();
    durationFilter.clear();
    activitiesFilter.clear();
    //  regionFilter.clear();
    aimedForModel.clear();
    fDM.clear();
  }

  // void getFilters() {
  //   setState(() {
  //     Constants.getFilter1(
  //       mapFilter,
  //       filterSectors,
  //       categoryFilter,
  //       serviceFilter,
  //       countriesFilter,
  //       levelFilter,
  //       durationFilter,
  //       activitiesFilter,
  //       regionFilter,
  //       dummyAm,
  //       fDM,
  //     );
  //   });
  // }

  // void aimedFor() async {
  //   var response =
  //       await http.get(Uri.parse("${Constants.baseUrl}/api/v1/getServiceFor"));
  //   if (response.statusCode == 200) {
  //     mapAimedFilter = json.decode(response.body);
  //     List<dynamic> result = mapAimedFilter['message'];
  //     result.forEach((element) {
  //       int id = int.tryParse(element['id'].toString()) ?? 0;
  //       AimedForModel amf = AimedForModel(
  //         id,
  //         element['AimedName'].toString() ?? "",
  //         element['image'].toString() ?? "",
  //         element['created_at'].toString() ?? "",
  //         element['updated_at'].toString() ?? "",
  //         element['deleted_at'].toString() ?? "",
  //         0,
  //       );
  //       am.add(amf);
  //     });
  //   }
  // }

  Future getCountries() async {
    var response =
        await http.get(Uri.parse("${Constants.baseUrl}/api/v1/get_countries"));
    if (response.statusCode == 200) {
      mapCountry = json.decode(response.body);
      List<dynamic> result = mapCountry['data'];
      filteredServices.clear();
      countriesList1.clear();
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
      if (mounted) {
        setState(() {
          filteredServices = countriesList1;
        });
      }
    }
  }

  void getC(String country, dynamic code, int id, String countryflag,
      String currencyP) {
    Navigator.of(context).pop();
    setState(
      () {
        c = currencyP;
        // Constants.countryId = id;
        // Constants.countryFlag = countryflag;
        // countryCode = country;
        ccCode = id.toString();
        // countryId = id;
        // flag = countryflag;
      },
    );
    Constants.getFilter();
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
        return StatefulBuilder(builder: (ctx, setState) {
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
                        ListTile(
                          onTap: () => showModalBottomSheet(
                              context: ctx,
                              builder: (ctx) {
                                return StatefulBuilder(
                                    builder: (ctx, setState1) {
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
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color:
                                                  blackColor.withOpacity(0.5),
                                            ),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              child: TextField(
                                                onChanged: (value) {
                                                  if (value.isNotEmpty) {
                                                    filteredServices =
                                                        countriesList1
                                                            .where((element) =>
                                                                element.country
                                                                    .toLowerCase()
                                                                    .contains(
                                                                        value))
                                                            .toList();
                                                    //log(filteredServices.length.toString());
                                                  } else {
                                                    filteredServices =
                                                        countriesList1;
                                                  }
                                                  setState(() {});
                                                },
                                                controller: searchController,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 8,
                                                          horizontal: 8),
                                                  hintText: 'Country'.tr(),
                                                  filled: true,
                                                  fillColor: lightGreyColor,
                                                  suffixIcon: GestureDetector(
                                                    //onTap: openMap,
                                                    child: const Icon(
                                                        Icons.search),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    borderSide: BorderSide(
                                                        color: greyColor
                                                            .withOpacity(0.2)),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    borderSide: BorderSide(
                                                        color: greyColor
                                                            .withOpacity(0.2)),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    borderSide: BorderSide(
                                                        color: greyColor
                                                            .withOpacity(0.2)),
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: filteredServices.length,
                                            itemBuilder: ((context, index) {
                                              return ListTile(
                                                leading: searchController
                                                        .text.isEmpty
                                                    ? Image.network(
                                                        "${"${Constants.baseUrl}/public/"}${countriesList1[index].flag}",
                                                        height: 25,
                                                        width: 40,
                                                      )
                                                    : null,
                                                title: Text(
                                                    filteredServices[index]
                                                        .country
                                                        .tr()),
                                                onTap: () {
                                                  setState(() {
                                                    ccCode =
                                                        filteredServices[index]
                                                            .id;
                                                    Constants.countryFlag =
                                                        filteredServices[index]
                                                            .flag;
                                                    Constants.country =
                                                        filteredServices[index]
                                                            .country;
                                                    c = filteredServices[index]
                                                        .currency;
                                                    // ccCode =
                                                    //     filteredServices[index]
                                                    //         .id;
                                                  });
                                                  Navigator.of(ctx).pop();
                                                  getRegions();
                                                  // getC(
                                                  //     filteredServices[index]
                                                  //         .country,
                                                  //     filteredServices[index]
                                                  //         .code,
                                                  //     filteredServices[index]
                                                  //         .id,
                                                  //     filteredServices[index]
                                                  //         .flag,
                                                  //     filteredServices[index]
                                                  //         .currency);
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
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          title: MyText(
                            text: "Country".tr(),
                            color: blackColor,
                            size: 16,
                            weight: FontWeight.w800,
                          ),
                          trailing: SizedBox(
                            width: 140,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: "Country".tr(),
                                  color: blackColor.withOpacity(0.6),
                                  size: 12,
                                  weight: FontWeight.w600,
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
                                      Constants.country,
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
                        ),
                        //pickCountry(context, 'Country Location'),
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
                                      min: 1,
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
                                              //Text("\$${values.start.toInt()}"),
                                              Text(
                                                  "$c ${values.start.toInt()}"),
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
                                                  "$c ${values.end.toInt().toString()}"),
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
                        // Divider(
                        //   indent: 18,
                        //   endIndent: 18,
                        //   color: blackColor.withOpacity(0.5),
                        // ),
                        // ListTile(
                        //   title: MyText(
                        //     text: "Region".tr(),
                        //     color: blackColor,
                        //     weight: FontWeight.bold,
                        //     size: 14,
                        //   ),
                        //   trailing: SizedBox(
                        //     width: 170,
                        //     child: Row(
                        //       children: [
                        //         Icon(
                        //           dDIconList[index],
                        //           color: blackColor,
                        //         ),
                        //         RegionFilterDropDown(
                        //           regionList,
                        //           show: true,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // if (regionList.isNotEmpty)
                        ExpansionTile(
                          title: Text(selectedRegion.isNotEmpty
                              ? selectedRegion
                              : 'selectRegion'.tr()),
                          children: [
                            for (int i = 0; i < regionList.length; i++)
                              CheckboxListTile(
                                dense: true,
                                visualDensity: VisualDensity.compact,
                                value: selectedRegion == regionList[i].region,
                                checkboxShape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                onChanged: (value) {
                                  setState(() {
                                    selectedRegion = regionList[i].region;
                                    selectedRegionId =
                                        regionList[i].regionId.toString();

                                    if (value == true) {
                                    } else {}
                                  });
                                },
                                title: Text(regionList[i].region.tr()),
                              ),
                            //   },
                            // )
                          ],
                        ),
                        ExpansionTile(
                          title: Text(
                            selectedServiceSector.isNotEmpty
                                ? selectedServiceSector
                                : 'serviceSector'.tr(),
                          ),
                          children: [
                            for (int a = 0; a < filterSectors.length; a++)
                              CheckboxListTile(
                                secondary: Image.network(
                                  "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${filterSectors[a].image}",
                                  height: 36,
                                  width: 26,
                                ),
                                dense: true,
                                visualDensity: VisualDensity.compact,
                                checkboxShape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                value: selectedServiceSector ==
                                    filterSectors[a].sector,
                                onChanged: (value) {
                                  setState(() {
                                    selectedServiceSector =
                                        filterSectors[a].sector;
                                    selectedServiceSectorId =
                                        filterSectors[a].id.toString();
                                  });
                                },
                                title: Text(filterSectors[a].sector.tr()),
                              ),
                            //   },
                            // )
                          ],
                        ),

                        // ListTile(
                        //   title: MyText(
                        //     text: "Sector".tr(),
                        //     color: blackColor,
                        //     weight: FontWeight.bold,
                        //     size: 14,
                        //   ),
                        //   trailing: SizedBox(
                        //     width: 180,
                        //     child: ServiceSectorDropDown(
                        //       filterSectors,
                        //       title: "",
                        //       show: true,
                        //     ),
                        //   ),
                        // ),
                        // ListTile(
                        //   title: MyText(
                        //     text: "Category".tr(),
                        //     color: blackColor,
                        //     weight: FontWeight.bold,
                        //     size: 14,
                        //   ),
                        //   trailing: SizedBox(
                        //     width: 180,
                        //     child: ServiceCategoryDropDown(
                        //       categoryFilter,
                        //       show: true,
                        //     ),
                        //   ),
                        // ),
                        ExpansionTile(
                          title: Text(
                            selectedCategory.isNotEmpty
                                ? selectedCategory
                                : 'serviceCategory'.tr(),
                          ),
                          children: [
                            for (int i = 0; i < categoryFilter.length; i++)
                              CheckboxListTile(
                                secondary: Image.network(
                                  "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${categoryFilter[i].image}",
                                  height: 36,
                                  width: 26,
                                ),
                                dense: true,
                                visualDensity: VisualDensity.compact,
                                value: selectedCategory ==
                                    categoryFilter[i].category,
                                checkboxShape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCategory =
                                        categoryFilter[i].category;
                                    selectedCategoryId =
                                        categoryFilter[i].id.toString();
                                  });
                                },
                                title: Text(categoryFilter[i].category.tr()),
                              ),
                          ],
                        ),
                        ExpansionTile(
                          title: Text(
                            selectedServiceType.isNotEmpty
                                ? selectedServiceType
                                : 'serviceType'.tr(),
                          ),
                          children: [
                            for (int b = 0; b < serviceFilter.length; b++)
                              CheckboxListTile(
                                secondary: Image.network(
                                  "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${serviceFilter[b].image}",
                                  height: 36,
                                  width: 26,
                                ),
                                dense: true,
                                visualDensity: VisualDensity.compact,
                                checkboxShape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                value: selectedServiceType ==
                                    serviceFilter[b].type,
                                onChanged: (value) {
                                  setState(() {
                                    selectedServiceType = serviceFilter[b].type;
                                    selectedServiceTypeId =
                                        serviceFilter[b].id.toString();
                                  });
                                },
                                title: Text(serviceFilter[b].type.tr()),
                              ),
                            //   },
                            // )
                          ],
                        ),
                        // ListTile(
                        //   title: MyText(
                        //     text: "Type".tr(),
                        //     color: blackColor,
                        //     weight: FontWeight.bold,
                        //     size: 14,
                        //   ),
                        //   trailing: SizedBox(
                        //     width: 180,
                        //     child: ServiceTypeDropDown(
                        //       serviceFilter,
                        //       show: true,
                        //     ),
                        //   ),
                        // ),
                        // ListTile(
                        //   dense: true,
                        //   visualDensity: VisualDensity.compact,
                        //   title: MyText(
                        //     text: "Level".tr(),
                        //     color: blackColor,
                        //     weight: FontWeight.bold,
                        //     size: 14,
                        //   ),
                        //   trailing: SizedBox(
                        //     width: 180,
                        //     child: LevelDropDown(
                        //       levelFilter,
                        //       show: true,
                        //     ),
                        //   ),
                        // ),
                        ExpansionTile(
                          title: Text(
                            selectedLevel.isNotEmpty
                                ? selectedLevel
                                : 'selectLevel'.tr(),
                          ),
                          children: [
                            for (int c = 0; c < levelFilter.length; c++)
                              CheckboxListTile(
                                secondary: Image.network(
                                  "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${levelFilter[c].image}",
                                  height: 36,
                                  width: 26,
                                ),
                                dense: true,
                                visualDensity: VisualDensity.compact,
                                checkboxShape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                value: selectedLevel == levelFilter[c].level,
                                onChanged: (value) {
                                  setState(() {
                                    selectedLevel = levelFilter[c].level;
                                    selectedLevelId =
                                        levelFilter[c].id.toString();
                                  });
                                },
                                title: Text(levelFilter[c].level.tr()),
                              ),
                          ],
                        ),
                        ExpansionTile(
                          title: Text(
                            selectedDuration.isNotEmpty
                                ? selectedDuration
                                : 'duration'.tr(),
                          ),
                          children: [
                            for (int d = 0; d < durationFilter.length; d++)
                              CheckboxListTile(
                                dense: true,
                                visualDensity: VisualDensity.compact,
                                value: selectedDuration ==
                                    durationFilter[d].duration,
                                checkboxShape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                onChanged: (value) {
                                  setState(() {
                                    selectedDuration =
                                        durationFilter[d].duration;
                                    selectedDurationId =
                                        durationFilter[d].id.toString();
                                  });
                                },
                                title: Text(durationFilter[d].duration.tr()),
                              ),
                            //   },
                            // )
                          ],
                        ),
                        // ListTile(
                        //   title: MyText(
                        //     text: "Duration".tr(),
                        //     color: blackColor,
                        //     weight: FontWeight.bold,
                        //     size: 14,
                        //   ),
                        //   trailing: SizedBox(
                        //     width: 180,
                        //     child: DurationDropDown(
                        //       durationFilter,
                        //       show: true,
                        //     ),
                        //   ),
                        // ),
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
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        ExpansionTile(
                          title: Text(
                            selectedAimedFor.isNotEmpty
                                ? selectedAimedFor
                                : 'aimedFor'.tr(),
                          ),
                          children: [
                            for (int d = 0; d < aimedForModel.length; d++)
                              CheckboxListTile(
                                secondary: Image.network(
                                  "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${aimedForModel[d].image}",
                                  height: 36,
                                  width: 26,
                                ),
                                dense: true,
                                visualDensity: VisualDensity.compact,
                                value: selectedAimedFor ==
                                    aimedForModel[d].aimedName,
                                checkboxShape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                onChanged: (value) {
                                  setState(() {
                                    selectedAimedFor =
                                        aimedForModel[d].aimedName;
                                    selectedAimedForId =
                                        aimedForModel[d].id.toString();
                                  });
                                },
                                title: Text(aimedForModel[d].aimedName.tr()),
                              ),
                            //   },
                            // )
                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 12.0),
                        //   child: Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: MyText(
                        //         text: 'aimedFor'.tr(),
                        //         weight: FontWeight.w800,
                        //         color: blackColor,
                        //         size: 18,
                        //         fontFamily: 'Raleway'),
                        //   ),
                        // ),
                        // ListView.builder(
                        //     itemCount: aimedText.length,
                        //     shrinkWrap: true,
                        //     physics: const ClampingScrollPhysics(),
                        //     itemBuilder: (context, index) {
                        //       return CheckboxListTile(
                        //         secondary: Icon(
                        //           aimedIconList[index],
                        //           color: blackColor,
                        //         ),
                        //         title: MyText(
                        //           text: aimedText[index],
                        //           color: blackColor.withOpacity(0.6),
                        //           weight: FontWeight.w700,
                        //           size: 15,
                        //         ),
                        //         value: aimedTextBool[index],
                        //         onChanged: ((bool? value) {
                        //           setState(() {
                        //             aimedTextBool[index] =
                        //                 !aimedTextBool[index];
                        //           });
                        //         }),
                        //       );
                        //     }),
                        // const SizedBox(
                        //   height: 3,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // filterSectors[selectedServiceSector]
                                    //     .showfilterSectors = false;
                                    ccCode = 0;
                                    selectedRegion = "";
                                    selectedRegionId = "";
                                    selectedServiceSectorId = "";
                                    selectedServiceSector = "";
                                    selectedLevelId = "";
                                    selectedLevel = "";
                                    selectedDurationId = "";
                                    selectedDuration = "";
                                    selectedCategory = "";
                                    selectedCategoryId = "";
                                    selectedAimedFor = "";
                                    selectedAimedForId = "";
                                    selectedServiceType = "";
                                    selectedServiceTypeId = "";
                                  });

                                  //setState(() {});
                                  // Navigator.of(context).pop();
                                },
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
    String aimedFor = "";
    if (aimedTextBool[0]) {
      aimedFor = "Gents";
    } else {
      aimedFor = "Ladies";
    }
    Provider.of<ServicesProvider>(context, listen: false).getFilterList(
        ccCode.toString(),
        values.start.toStringAsFixed(0),
        values.end.toStringAsFixed(0),
        selectedServiceSectorId,
        selectedCategoryId,
        selectedServiceTypeId,
        selectedLevelId,
        selectedDurationId,
        selectedRegionId.toString(),
        aimedFor);
    Provider.of<ServicesProvider>(context, listen: false).searchFilter;
    Navigator.of(context).pop();
  }

  void clearFilter() {
    ccCode = 0;
    selectedServiceSectorId = "";
    selectedCategoryId = "";
    selectedServiceTypeId = "";
    selectedLevelId = "";
    selectedDurationId = "";
    selectedRegion = "";
    setState(() {});
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
    int unreadCount =
        Provider.of<NavigationIndexProvider>(context, listen: true).unreadCount;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: addActivites,
                // child: const FaIcon(
                //   FontAwesomeIcons.filter,
                //   color: bluishColor,
                //   size: 38,
                // ),
                child: const Icon(
                  Icons.filter_list_outlined,
                  color: bluishColor,
                  size: 42,
                ),
                // child: Container(
                //   height: 34,
                //   width: 32,
                //   decoration: BoxDecoration(
                //     color: bluishColor,
                //     image: const DecorationImage(
                //       image: ExactAssetImage(
                //         'images/pathpic.png',
                //       ),
                //     ),
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                // ),
              ),
              // const SizedBox(
              //   width: 2,
              // ),
              SearchContainer('search'.tr(), 1.4, 10, searchController,
                  'images/maskGroup51.png', true, true, Constants.country, 14),
              const SizedBox(
                width: 5,
              ),
              Stack(
                children: [
                  GestureDetector(
                    onTap: goToMessages,
                    child: const Icon(
                      Icons.message,
                      color: bluishColor,
                      size: 38,
                    ),
                  ),
                  if (unreadCount != "0")
                    Positioned(
                      right: 4,
                      bottom: -1,
                      child: Container(
                        height: 20,
                        width: 15,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 187, 39, 28),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: MyText(
                            text: unreadCount,
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
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 100,
            child: TopList(),
          ),
          Divider(
            thickness: 1.2,
            color: blackColor.withOpacity(0.2),
          )
        ],
      ),
    );
  }

  Widget pickCountry(context, String countryName) {
    return Container();
  }
}
