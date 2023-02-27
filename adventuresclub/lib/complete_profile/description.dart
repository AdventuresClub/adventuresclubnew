// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/category/category_model.dart';
import 'package:adventuresclub/models/create_adventure/regions_model.dart';
import 'package:adventuresclub/models/filter_data_model/activities_inc_model.dart';
import 'package:adventuresclub/models/filter_data_model/category_filter_model.dart';
import 'package:adventuresclub/models/filter_data_model/countries_filter.dart';
import 'package:adventuresclub/models/filter_data_model/durations_model.dart';
import 'package:adventuresclub/models/filter_data_model/filter_data_model.dart';
import 'package:adventuresclub/models/filter_data_model/level_filter_mode.dart';
import 'package:adventuresclub/models/filter_data_model/region_model.dart';
import 'package:adventuresclub/models/filter_data_model/sector_filter_model.dart';
import 'package:adventuresclub/models/filter_data_model/service_types_filter.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/dropdown_button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:adventuresclub/widgets/text_fields/multiline_field.dart';
import 'package:adventuresclub/widgets/text_fields/tf_with_Size_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Description extends StatefulWidget {
  const Description({super.key});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  TextEditingController nameController = TextEditingController();
  int countryId = 0;
  Map mapFilter = {};
  List<SectorFilterModel> filterSectors = [];
  List<CategoryFilterModel> categoryFilter = [];
  List<ServiceTypeFilterModel> serviceFilter = [];
  List<CountriesFilterModel> countriesFilter = [];
  List<LevelFilterModel> levelFilter = [];
  List<DurationsModel> durationFilter = [];
  List<ActivitiesIncludeModel> activitiesFilter = [];
  List<RegionFilterModel> regionFilter = [];
  List<AimedForModel> aimedFilter = [];
  List<FilterDataModel> fDM = [];

  List<String> countryList = [
    "Oman",
    "India",
  ];
  List<String> cList = [
    "Category",
    "Land",
    "Water",
    "Sky",
    "Transport",
    "Accomodation"
  ];
  List<CategoryModel> categoryList = [];
  List<RegionsModel> regionList = [];
  List<String> rList = [];
  List<String> serviceSector = ["Training", "Tour"];
  List<String> sFilterList = [];
  List days = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];
  List aimedText = [
    'kids',
    'Ladies',
    'Gents',
    'Families',
    'Everyone',
  ];
  List dependencyText = [
    'Weather',
    'Health Conditions',
    'License',
  ];
  List activityText = [
    'Transportation for gathering area',
    'Drinks ',
    'Snacks',
    'Bike Riding',
    'Sand Bashing',
    'Sand Skiing',
    'Climbing',
    'Swimming',
  ];

  List<bool> daysValue = [false, false, false, false, false, false, false];
  List<bool> activityValue = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  List<bool> aimedValue = [false, false, false, false, false];
  List<bool> dependencyValue = [false, false, false];
  bool value = false;
  abc() {}
  void addActivites() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 10),
                          child: MyText(
                              text: 'Activities Included',
                              weight: FontWeight.bold,
                              color: blackColor,
                              size: 14,
                              fontFamily: 'Raleway'),
                        ),
                        const SizedBox(height: 30),
                        Wrap(
                          children: List.generate(activityText.length, (index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width / 1,
                              child: Column(
                                children: [
                                  CheckboxListTile(
                                    side: const BorderSide(color: bluishColor),
                                    checkboxShape: const RoundedRectangleBorder(
                                      side: BorderSide(color: bluishColor),
                                    ),
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: -4),
                                    activeColor: greyProfileColor,
                                    checkColor: bluishColor,
                                    value: activityValue[index],
                                    onChanged: ((bool? value2) {
                                      setState(() {
                                        activityValue[index] = value2!;
                                      });
                                    }),
                                    title: MyText(
                                      text: activityText[index],
                                      color: greyColor,
                                      fontFamily: 'Raleway',
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 15),
                          child: Button(
                              'Done',
                              greenishColor,
                              greyColorShade400,
                              whiteColor,
                              16,
                              abc,
                              Icons.add,
                              whiteColor,
                              false,
                              1.3,
                              'Raleway',
                              FontWeight.w600,
                              16),
                        ),
                      ],
                    ),
                  )),
            ),
          );
        });
  }

  // void getData() async {
  //   SharedPreferences prefs = await Constants.getPrefs();
  //   p
  // }

  @override
  void initState() {
    super.initState();
    rList.insert(0, "Region");
    // cList.insert(0, "Category");
    getData();
    getRegions();
    getFilter();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void parseRegions(List<RegionsModel> rm) {
    rm.forEach(
      (element) {
        if (element.region.isNotEmpty) {
          rList.add(element.region);
        }
      },
    );
  }

  void parseCategories(List<CategoryModel> cm) {
    cm.forEach(
      (element) {
        if (element.category.isNotEmpty) {
          cList.add(element.category);
        }
      },
    );
  }

  void getData() async {
    countryId =
        Provider.of<CompleteProfileProvider>(context, listen: false).countryId;
    // categoryList =
    //     Provider.of<CompleteProfileProvider>(context, listen: false).pCM;
  }

  void getFilter() async {
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/filter_modal_data"));
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
        ActivitiesIncludeModel activities =
            ActivitiesIncludeModel(id, act['id'].toString());
        activitiesFilter.add(activities);
      });
      List<dynamic> r = result['regions'];
      r.forEach((reg) {
        int id = int.tryParse(reg['id'].toString()) ?? 0;
        RegionFilterModel rm = RegionFilterModel(id, reg['region']);
        regionFilter.add(rm);
      });
      FilterDataModel fm = FilterDataModel(
          filterSectors,
          categoryFilter,
          serviceFilter,
          aimedFilter,
          countriesFilter,
          levelFilter,
          durationFilter,
          activitiesFilter,
          regionFilter);
      fDM.add(fm);
    }
  }

  void getRegions() async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/get_regions"),
          body: {
            'country_id': "1",
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> rm = decodedResponse['data'];
      rm.forEach((element) {
        int cId = int.tryParse(element['country_id'].toString()) ?? 0;
        int rId = int.tryParse(element['region_id'].toString()) ?? 0;
        RegionsModel r = RegionsModel(
          cId,
          element['country'].toString() ?? "",
          rId,
          element['region'].toString() ?? "",
        );
        regionList.add(r);
      });
      parseRegions(regionList);
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          TFWithSize('Adventure Name', nameController, 12, lightGreyColor, 1),
          const SizedBox(height: 20),
          GestureDetector(onTap: getRegions, child: Text("Test")),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DdButton(
                2.4,
                dropDown: "Oman",
                dropDownList: countryList,
              ),
              DdButton(
                2.4,
                dropDown: "Region",
                dropDownList: rList,
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DdButton(
                2.4,
                dropDown: "Training",
                dropDownList: serviceSector,
              ),
              DdButton(
                2.4,
                dropDown: "Category",
                dropDownList: cList,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [DdButton(2.4), DdButton(2.4)],
          // ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // DdButton(2.4),
              TFWithSize(
                  'Available Seats', nameController, 16, lightGreyColor, 2.4)
            ],
          ),
          const SizedBox(height: 20),
          MultiLineField('Type Information', 4, lightGreyColor, nameController),
          const Divider(),
          Align(
            alignment: Alignment.centerLeft,
            child: MyText(
              text: 'Service Plan',
              color: blackTypeColor1,
              align: TextAlign.center,
            ),
          ),
          Row(
            children: [
              Checkbox(
                  value: value,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  onChanged: (bool? value1) {
                    setState(() {
                      value = value1!;
                    });
                  }),
              MyText(
                text: 'Every particular week days',
                color: blackTypeColor,
                align: TextAlign.center,
              ),
            ],
          ),
          Wrap(
            direction: Axis.horizontal,
            children: List.generate(days.length, (index) {
              return Column(
                children: [
                  MyText(
                    text: days[index],
                    color: blackTypeColor,
                    align: TextAlign.center,
                    size: 9,
                  ),
                  Checkbox(
                      value: daysValue[index],
                      onChanged: (bool? value1) {
                        setState(() {
                          daysValue[index] = value1!;
                        });
                      }),
                ],
              );
            }),
          ),
          Row(
            children: [
              Checkbox(
                  value: value,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  onChanged: (bool? value1) {
                    setState(() {
                      value = value1!;
                    });
                  }),
              MyText(
                text: 'Every particular calendar date',
                color: blackTypeColor,
                align: TextAlign.center,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TFWithSizeImage(
                    'Start Date',
                    nameController,
                    16,
                    lightGreyColor,
                    2.5,
                    Icons.calendar_month_outlined,
                    bluishColor),
              ),
              Expanded(
                child: TFWithSizeImage(
                    'End Date',
                    nameController,
                    16,
                    lightGreyColor,
                    2.5,
                    Icons.calendar_month_outlined,
                    bluishColor),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                        text: 'Activities Includes',
                        weight: FontWeight.w500,
                        color: blackTypeColor1),
                    MyText(
                        text: '20 Activities included',
                        weight: FontWeight.w400,
                        color: blackTypeColor),
                  ],
                ),
                Button(
                    'Add Activities',
                    bluishColor,
                    bluishColor,
                    whiteColor,
                    14,
                    addActivites,
                    Icons.arrow_forward,
                    whiteColor,
                    true,
                    2.5,
                    'Roboto',
                    FontWeight.w400,
                    16)
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: MyText(
              text: 'Aimed For',
              color: blackTypeColor1,
              align: TextAlign.center,
              weight: FontWeight.w500,
            ),
          ),
          Wrap(
            direction: Axis.vertical,
            children: List.generate(aimedText.length, (index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CheckboxListTile(
                  contentPadding: const EdgeInsets.only(
                      left: 0, top: 5, bottom: 5, right: 25),
                  side: const BorderSide(color: bluishColor),
                  checkboxShape: const RoundedRectangleBorder(
                    side: BorderSide(color: bluishColor),
                  ),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  activeColor: greyProfileColor,
                  checkColor: bluishColor,
                  value: aimedValue[index],
                  onChanged: ((bool? value2) {
                    setState(() {
                      aimedValue[index] = value2!;
                    });
                  }),
                  title: MyText(
                    text: aimedText[index],
                    color: blackTypeColor,
                    fontFamily: 'Raleway',
                    size: 18,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: MyText(
              text: 'Dependency',
              color: blackTypeColor1,
              align: TextAlign.center,
              weight: FontWeight.w500,
            ),
          ),
          Wrap(
            direction: Axis.vertical,
            children: List.generate(dependencyText.length, (index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CheckboxListTile(
                  contentPadding: const EdgeInsets.only(
                      left: 0, top: 5, bottom: 5, right: 25),
                  side: const BorderSide(color: bluishColor),
                  checkboxShape: const RoundedRectangleBorder(
                    side: BorderSide(color: bluishColor),
                  ),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  activeColor: greyProfileColor,
                  checkColor: bluishColor,
                  value: dependencyValue[index],
                  onChanged: ((bool? value2) {
                    setState(() {
                      dependencyValue[index] = value2!;
                    });
                  }),
                  title: MyText(
                    text: dependencyText[index],
                    color: greyColor,
                    fontFamily: 'Raleway',
                    size: 18,
                  ),
                ),
              );
            }),
          ),
          Divider(),
          Align(
            alignment: Alignment.centerLeft,
            child: MyText(
              text: 'Registration Closure By',
              color: blackTypeColor1,
              align: TextAlign.center,
              weight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              MyText(
                text: 'Days before the activity starts',
                color: blackTypeColor,
                align: TextAlign.center,
              ),
              const SizedBox(
                width: 10,
              ),
              TFWithSize('2', nameController, 16, lightGreyColor, 7.2)
            ],
          ),
        ],
      ),
    );
  }
}
