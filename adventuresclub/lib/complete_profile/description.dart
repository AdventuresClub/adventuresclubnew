// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables

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
import 'package:adventuresclub/models/weightnheight_model.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/dropdowns/duration_drop_down.dart';
import 'package:adventuresclub/widgets/dropdowns/level_drop_down.dart';
import 'package:adventuresclub/widgets/dropdowns/region_dropdown.dart';
import 'package:adventuresclub/widgets/dropdowns/service_category.dart';
import 'package:adventuresclub/widgets/dropdowns/service_sector_drop_down.dart';
import 'package:adventuresclub/widgets/dropdowns/service_type_drop_down.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:adventuresclub/widgets/text_fields/multiline_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Description extends StatefulWidget {
  const Description({super.key});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  TextEditingController infoController = TextEditingController();
  TextEditingController seatsController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  int countryId = 0;
  bool loading = false;
  Map mapFilter = {};
  Map mapAimedFilter = {};
  bool particularWeekDays = false;
  bool particularDay = false;
  DateTime currentDate = DateTime.now();
  List<int> activityId = [];
  List<String> activity = [];
  var formattedDate;
  var endDate;
  List<SectorFilterModel> filterSectors = [];
  List<CategoryFilterModel> categoryFilter = [];
  List<ServiceTypeFilterModel> serviceFilter = [];
  List<CountriesFilterModel> countriesFilter = [];
  List<LevelFilterModel> levelFilter = [];
  List<DurationsModel> durationFilter = [];
  List<ActivitiesIncludeModel> activitiesFilter = [];
  List<RegionFilterModel> regionFilter = [];
  List<AimedForModel> aimedFilter = [];
  List<AimedForModel> am = [];
  List<FilterDataModel> fDM = [];
  DateTime? pickedDate;
  int? currentIndex;
  var getCountry = 'Oman';
  List<WnHModel> weightList = [];
  List<String> countryList = [
    "Oman",
  ];
  List<String> cList = [
    // "Service Category",
    // "Land",
    // "Water",
    // "Sky",
    // "Transport",
    // "Accomodation"
  ];
  List<CategoryModel> categoryList = [];
  List<RegionsModel> regionList = [];
  List<String> rList = [];
  List<String> serviceSector = ["Training", "Tour"];
  List<String> sFilterList = [];
  List<String> durationList = [];
  List<String> levelList = [];
  List<String> activityList = [];
  List days = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];
  List aimedText = [
    // 'kids',
    // 'Gents',
    // 'Ladies',
    // 'Adults',
    // 'Mixed Gender',
    // 'Girls',
  ];
  List dependencyText = [
    'Licensed',
    'Weather Conditions',
    'Health Conditions',
    'Heat',
    'Chillness',
    'Climate',
  ];
  List<bool> dependencyValue = [false, false, false, false, false, false];
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
    //false,
    // false,
    // false,
    // false,
    // false,
    // false,
    // false,
    // false
  ];

  List<bool> aimedValue = [
    //false, false, false, false, false, false
  ];

  void abc() {
    Navigator.of(context).pop();
    List<ActivitiesIncludeModel> a = [];
    for (int i = 0; i < activityValue.length; i++) {
      if (activityValue[i]) {
        a.add(activitiesFilter[i]);
      }
    }
    sId(a);
  }

  void getCurrentIndex() {
    int cIndex = Provider.of<CompleteProfileProvider>(context, listen: true)
        .currentIndex;
    if (cIndex == 2) {
      aimed();
    }
  }

  void aimed() {
    List<AimedForModel> f = [];
    for (int i = 0; i < aimedValue.length; i++) {
      if (aimedValue[i]) {
        f.add(aimedFilter[i]);
      }
    }
    aimedForF(f);
  }

  void aimedForF(List<AimedForModel> am) async {
    List<String> a = [];
    List<int> id = [];
    am.forEach((element) {
      a.add(element.aimedName);
      id.add(element.id);
    });
    Provider.of<CompleteProfileProvider>(context, listen: false)
        .aimedLevel(a, id);
  }

  void addActivites() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width / 1.2,
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
                              size: 16,
                              fontFamily: 'Raleway'),
                        ),
                        const SizedBox(height: 30),
                        Wrap(
                          children: List.generate(activityList.length, (index) {
                            return SizedBox(
                              //width: MediaQuery.of(context).size.width / 1,
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
                                    selected: activityValue[index],
                                    value: activityValue[index],
                                    onChanged: (value) {
                                      setState(() {
                                        activityValue[index] = value!;
                                        // activityId
                                        //     .add(activitiesFilter[index].id);
                                        // activity.add(
                                        //     activitiesFilter[index].activity);
                                      });
                                    },
                                    title: MyText(
                                      text: activitiesFilter[index].activity,
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

  void sId(List<ActivitiesIncludeModel> activity) async {
    List<String> a = [];
    List<int> id = [];
    activity.forEach((element) {
      a.add(element.activity);
      id.add(element.id);
    });
    Provider.of<CompleteProfileProvider>(context, listen: false)
        .activityLevel(a, id);
  }

  // void getData() async {
  //   SharedPreferences prefs = await Constants.getPrefs();
  //   p
  // }

  @override
  void initState() {
    super.initState();
    rList.insert(0, "Region");
    sFilterList.insert(0, "Service Type");
    durationList.insert(0, "Duration");
    levelList.insert(0, "Select Level");
    cList.insert(0, "Service Category");
    formattedDate = 'Start Date';
    endDate = "End Date";
    // cList.insert(0, "Category");
    getRegions();
    getFilter();
  }

  @override
  void dispose() {
    infoController.dispose();
    seatsController.dispose();
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

  void parseCategories(List<CategoryFilterModel> cm) {
    cm.forEach(
      (element) {
        if (element.category.isNotEmpty) {
          cList.add(element.category);
        }
      },
    );
  }

  void parseService(List<ServiceTypeFilterModel> st) {
    st.forEach((element) {
      if (element.type.isNotEmpty) {
        sFilterList.add(element.type);
      }
    });
  }

  void parseDuration(List<DurationsModel> dm) {
    dm.forEach((element) {
      if (element.duration.isNotEmpty) {
        durationList.add(element.duration);
      }
    });
  }

  void parseLevel(List<LevelFilterModel> lm) {
    lm.forEach((element) {
      if (element.level.isNotEmpty) {
        levelList.add(element.level);
      }
    });
  }

  void parseActivity(List<ActivitiesIncludeModel> am) {
    am.forEach((element) {
      if (element.activity.isNotEmpty) {
        activityList.add(element.activity);
      }
    });
    activityList.forEach((element) {
      activityValue.add(false);
    });
  }

  void parseAimed(List<AimedForModel> am) {
    am.forEach((element) {
      if (element.aimedName.isNotEmpty) {
        aimedText.add(element.aimedName);
      }
    });
    aimedText.forEach((element) {
      aimedValue.add(false);
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
        aimedFilter.add(amf);
      });
      parseAimed(aimedFilter);
    }
  }

  void getFilter() async {
    aimedFor();
    setState(() {
      loading = true;
    });
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
            ActivitiesIncludeModel(id, act['activity'].toString());
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
          am,
          countriesFilter,
          levelFilter,
          durationFilter,
          activitiesFilter,
          regionFilter);
      fDM.add(fm);
      // parseService(serviceFilter);
      // parseDuration(durationFilter);
      // parseLevel(levelFilter);
      // parseCategories(categoryFilter);
      parseActivity(activitiesFilter);
      setState(() {
        loading = false;
      });
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

  Future<void> _selectDate(BuildContext context, var givenDate) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(DateTime.now().day - 1),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      if (givenDate == 'Start Date') {
        setState(() {
          var date = DateTime.parse(pickedDate.toString());
          formattedDate = "${date.day}-${date.month}-${date.year}";
          currentDate = pickedDate!;
        });
      } else {
        setState(() {
          var date = DateTime.parse(pickedDate.toString());
          endDate = "${date.day}-${date.month}-${date.year}";
          currentDate = pickedDate!;
        });
      }
    }
    getDates(formattedDate.toString(), endDate.toString());
  }

  void getDates(String startDate, String endData) {
    Provider.of<CompleteProfileProvider>(context, listen: false).startDate =
        startDate;
    Provider.of<CompleteProfileProvider>(context, listen: false).endDate =
        endData;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Column(
            children: [CircularProgressIndicator(), Text("Loading...")],
          )
        : Consumer<CompleteProfileProvider>(
            builder: (context, provider, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TFWithSize('Adventure Name', provider.adventureNameController,
                      12, lightGreyColor, 1),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      pickingWeight(context, 'Oman'),
                      // Expanded(
                      //   child: DdButton(
                      //     2.4,
                      //     dropDown: "Oman",
                      //     dropDownList: countryList,
                      //   ),
                      // ),
                      const SizedBox(
                        width: 10,
                      ),
                      //    Description(regionFilter),
                      Expanded(child: RegionDropDown(regionFilter)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // const Expanded(
                      //   child: ServiceSectorDropDown(
                      //       //filterSectors
                      //       ),
                      // ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      Expanded(
                        child: ServiceCategoryDropDown(categoryFilter),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: ServiceSectorDropDown(filterSectors),
                      ),
                      // DdButton(
                      //   2.4,
                      //   dropDown: "Training",
                      //   dropDownList: serviceSector,
                      // ),
                      // DdButton(
                      //   2.4,
                      //   dropDown: "Service Category",
                      //   dropDownList: cList,
                      // ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ServiceTypeDropDown(serviceFilter),
                      ),
                      // DdButton(
                      //   2.4,
                      //   dropDown: "Service Type",
                      //   dropDownList: sFilterList,
                      // ),
                      // DdButton(
                      //   2.4,
                      //   dropDown: "Duration",
                      //   dropDownList: durationList,
                      // ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(child: DurationDropDown(durationFilter))
                    ],
                  ),
                  const SizedBox(height: 20),
                  // DdButton(
                  //   2.4,
                  //   dropDown: "Select Level",
                  //   dropDownList: levelList,
                  // ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: LevelDropDown(levelFilter)),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TFWithSize(
                                'Available Seats',
                                provider.availableSeats,
                                16,
                                lightGreyColor,
                                2.4),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      MultiLineField('Type Information', 1, lightGreyColor,
                          provider.infoController),
                      const Divider(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MyText(
                          text: 'Service Plan',
                          color: blackTypeColor1,
                          align: TextAlign.center,
                        ),
                      ),
                      particularDay
                          ? Container()
                          : SizedBox(
                              height: 120,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: particularWeekDays,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24)),
                                          onChanged: (bool? value1) {
                                            setState(() {
                                              particularWeekDays = value1!;
                                              provider.particularWeekDay =
                                                  value1;
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
                                    children:
                                        List.generate(days.length, (index) {
                                      return Column(
                                        children: [
                                          MyText(
                                            text: days[index],
                                            color: blackTypeColor,
                                            align: TextAlign.center,
                                            size: 14,
                                          ),
                                          Checkbox(
                                            value: daysValue[index],
                                            onChanged: (bool? value) {
                                              setState(
                                                () {
                                                  // if () {

                                                  // }
                                                  daysValue[index] = value!;
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                  particularWeekDays
                      ? Container()
                      : SizedBox(
                          height: 110,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      value: particularDay,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          particularDay = value!;
                                          provider.particularDay = value;
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () =>
                                          _selectDate(context, formattedDate),
                                      child: Container(
                                        height: 50,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0),
                                        //width: MediaQuery.of(context).size.width / 1,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: lightGreyColor,
                                          border: Border.all(
                                            width: 1,
                                            color: greyColor.withOpacity(0.2),
                                          ),
                                        ),
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 10),
                                          leading: Text(
                                            formattedDate.toString(),
                                            style: TextStyle(
                                                color: blackColor
                                                    .withOpacity(0.6)),
                                          ),
                                          trailing: Icon(
                                            Icons.calendar_today,
                                            color: blackColor.withOpacity(0.6),
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // GestureDetector(
                                  //   onTap: () => _selectDate(context),
                                  //   child: Expanded(
                                  //     child: TFWithSizeImage(
                                  //         'Start Date',
                                  //         startDateController,
                                  //         16,
                                  //         lightGreyColor,
                                  //         2.5,
                                  //         Icons.calendar_month_outlined,
                                  //         bluishColor),
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () =>
                                          _selectDate(context, endDate),
                                      child: Container(
                                        height: 50,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0),
                                        //width: MediaQuery.of(context).size.width / 1,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: lightGreyColor,
                                          border: Border.all(
                                            width: 1,
                                            color: greyColor.withOpacity(0.2),
                                          ),
                                        ),
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 10),
                                          leading: Text(
                                            endDate.toString(),
                                            style: TextStyle(
                                                color: blackColor
                                                    .withOpacity(0.6)),
                                          ),
                                          trailing: Icon(
                                            Icons.calendar_today,
                                            color: blackColor.withOpacity(0.6),
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Expanded(
                                  //   child: TFWithSizeImage(
                                  //       'End Date',
                                  //       endDateController,
                                  //       16,
                                  //       lightGreyColor,
                                  //       2.5,
                                  //       Icons.calendar_month_outlined,
                                  //       bluishColor),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                  const Divider(),
                  // activities container
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
                  Divider(
                    thickness: 1.5,
                    color: blackColor.withOpacity(0.5),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // aimed for
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: 'Aimed For',
                      color: blackTypeColor1,
                      size: 16,
                      align: TextAlign.center,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Wrap(
                    direction: Axis.vertical,
                    children: List.generate(aimedFilter.length, (index) {
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
                          activeColor: bluishColor,
                          checkColor: whiteColor,
                          value: aimedValue[index],
                          onChanged: ((bool? value) {
                            setState(() {
                              aimedValue[index] = value!;
                            });
                          }),
                          title: MyText(
                            text:
                                //aimedText[index],
                                aimedFilter[index].aimedName,
                            color: blackTypeColor.withOpacity(0.5),
                            fontFamily: 'Raleway',
                            size: 16,
                            weight: FontWeight.w500,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1.5,
                    color: blackColor.withOpacity(0.4),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: 'Dependency',
                      color: blackTypeColor1,
                      align: TextAlign.center,
                      weight: FontWeight.bold,
                      size: 16,
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
                          activeColor: bluishColor,
                          checkColor: whiteColor,
                          value: dependencyValue[index],
                          onChanged: ((bool? value2) {
                            setState(() {
                              dependencyValue[index] = value2!;
                            });
                          }),
                          title: MyText(
                            text: dependencyText[index],
                            color: blackTypeColor1.withOpacity(0.5),
                            fontFamily: 'Raleway',
                            weight: FontWeight.w500,
                            size: 16,
                          ),
                        ),
                      );
                    }),
                  ),
                  Divider(
                    thickness: 1.5,
                    color: blackColor.withOpacity(0.4),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: 'Registration Closed By',
                      color: greyShadeColor,
                      align: TextAlign.center,
                      weight: FontWeight.w500,
                      size: 16,
                    ),
                  ),
                  Row(
                    children: [
                      MyText(
                        text: 'Days before the activity starts',
                        color: greyShadeColor,
                        align: TextAlign.center,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TFWithSize('2', provider.daysBeforeActController, 16,
                          lightGreyColor, 8)
                    ],
                  ),
                ],
              ),
            );
          });
  }

  Widget pickingWeight(context, String getName) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            child: Container(
              height: 300,
              color: whiteColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: MyText(
                          text: 'Oman',
                          weight: FontWeight.bold,
                          color: blackColor,
                          size: 20,
                          fontFamily: 'Raleway'),
                    ),
                  ),
                  Container(
                    height: 200,
                    color: whiteColor,
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: CupertinoPicker(
                                itemExtent: 82.0,
                                diameterRatio: 22,
                                backgroundColor: whiteColor,
                                onSelectedItemChanged: (int index) {
                                  //print(index + 1);
                                  setState(() {
                                    getCountry = countryList[index];

                                    // getWeight == null
                                    //     ? cont = false
                                    //     : cont = true;
                                    // ft = (index + 1);
                                    // heightController.text =
                                    //     "$ft' $inches\"";
                                  });
                                },
                                selectionOverlay:
                                    const CupertinoPickerDefaultSelectionOverlay(
                                  background: transparentColor,
                                ),
                                children: List.generate(
                                  countryList.length,
                                  (index) {
                                    return Center(
                                      child: MyText(
                                          text: countryList[index],
                                          size: 14,
                                          color: blackTypeColor4),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              top: 70,
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width / 1.2,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        color: blackColor.withOpacity(0.7),
                                        width: 1.5),
                                    bottom: BorderSide(
                                        color: blackColor.withOpacity(0.7),
                                        width: 1.5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: MyText(
                            text: 'Cancel',
                            color: bluishColor,
                          )),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: MyText(
                            text: 'Ok',
                            color: bluishColor,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      child: Container(
        width: MediaQuery.of(context).size.width / 2.4,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: greyProfileColor,
          border: Border.all(color: greyColor.withOpacity(0.7), width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: getCountry.toString(),
              color: blackColor.withOpacity(0.6),
              size: 14,
              weight: FontWeight.w500,
            ),
            const Image(
              image: ExactAssetImage('images/ic_drop_down.png'),
              height: 16,
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
}
