// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_create_new_services.dart';
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
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/dropdowns/duration_drop_down.dart';
import 'package:adventuresclub/widgets/dropdowns/level_drop_down.dart';
import 'package:adventuresclub/widgets/dropdowns/regionFilter_dropdown.dart';
import 'package:adventuresclub/widgets/dropdowns/service_category.dart';
import 'package:adventuresclub/widgets/dropdowns/service_sector_drop_down.dart';
import 'package:adventuresclub/widgets/dropdowns/service_type_drop_down.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:adventuresclub/widgets/text_fields/multiline_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateServicesDescription extends StatefulWidget {
  final TextEditingController adventureName;
  final Widget available;
  final TextEditingController info;
  final Widget aimedFor;
  const CreateServicesDescription(
      this.available, this.adventureName, this.info, this.aimedFor,
      {super.key});

  @override
  State<CreateServicesDescription> createState() =>
      _CreateServicesDescriptionState();
}

class _CreateServicesDescriptionState extends State<CreateServicesDescription> {
  TextEditingController adventureName = TextEditingController();
  TextEditingController availableSeats = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  TextEditingController scheduleDesController = TextEditingController();
  TextEditingController getLocationController = TextEditingController();
  TextEditingController gatheringDateController = TextEditingController();
  TextEditingController specificAddress = TextEditingController();
  TextEditingController setCost1 = TextEditingController();
  TextEditingController setCost2 = TextEditingController();
  TextEditingController preReqController = TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController tncController = TextEditingController();
  TextEditingController adventureNameController = TextEditingController();
  TextEditingController daysBeforeActController = TextEditingController();
  TextEditingController seatsController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  int countryId = 0;
  bool loading = false;
  Map mapFilter = {};
  Map mapAimedFilter = {};
  bool particularWeekDays = false;
  bool particularWeekDay = false;
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
  List<FilterDataModel> fDM = [];
  List<String> selectedActivites = [];
  List<int> selectedActivitesid = [];
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
  List<RegionFilterModel> regionList = [];
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

  @override
  void initState() {
    super.initState();
    formattedDate = 'Start Date';
    endDate = "End Date";
    getData();
  }

  void getData() {
    regionList = Constants.regionFilter;
    categoryFilter = Constants.categoryFilter;
    filterSectors = Constants.filterSectors;
    serviceFilter = Constants.serviceFilter;
    durationFilter = Constants.durationFilter;
    regionFilter = Constants.regionFilter;
    levelFilter = Constants.levelFilter;
    activitiesFilter = Constants.activitiesFilter;
    parseActivity(Constants.activitiesFilter);
  }

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

  void sId(List<ActivitiesIncludeModel> activity) async {
    activity.forEach((element) {
      selectedActivites.add(element.activity);
      selectedActivitesid.add(element.id);
    });
    setState(() {
      ConstantsCreateNewServices.selectedActivites = selectedActivites;
      ConstantsCreateNewServices.selectedActivitesId = selectedActivitesid;
    });
    // print(selectedActivites);
    // print(selectedActivites);
    // Provider.of<CompleteProfileProvider>(context, listen: false)
    //     .activityLevel(a, id);
  }

  void addActivites() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              // width: MediaQuery.of(context).size.width / 1.2,
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
                          children: List.generate(
                              activitiesFilter.length, //activityList.length,
                              (index) {
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
                                        activityValue[index] =
                                            !activityValue[index];
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
                                      weight: FontWeight.bold,
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
  void dispose() {
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
          String m = date.month < 10 ? "0${date.month}" : "${date.month}";
          String d = date.day < 10 ? "0${date.day}" : "${date.day}";
          formattedDate = "${date.year}-$m-$d";
        });
      } else {
        setState(() {
          var date = DateTime.parse(pickedDate.toString());
          String m = date.month < 10 ? "0${date.month}" : "${date.month}";
          String d = date.day < 10 ? "0${date.day}" : "${date.day}";
          endDate = "${date.year}-$m-$d";
          currentDate = pickedDate!;
        });
      }
    }
    getDates(formattedDate, endDate);
  }

  void getDates(String sDate, String eDate) {
    setState(() {
      ConstantsCreateNewServices.startDate = sDate;
      ConstantsCreateNewServices.startDate = eDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Column(
            children: const [CircularProgressIndicator(), Text("Loading...")],
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                TFWithSize('Adventure Name', widget.adventureName, 12,
                    lightGreyColor, 1),
                const SizedBox(height: 10),
                MultiLineField(
                    'Type Information', 5, lightGreyColor, widget.info),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //pickingWeight(context, 'Oman'),
                    Expanded(
                      child: Container(
                        //width: MediaQuery.of(context).size.width / 2.4,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                          color: lightGreyColor,
                          border: Border.all(
                              color: greyColor.withOpacity(0.2), width: 1.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: MyText(
                          text: Constants.country, //getCountry.toString(),
                          color: blackTypeColor,
                          size: 14,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(child: RegionFilterDropDown(regionList)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ServiceCategoryDropDown(categoryFilter),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: ServiceSectorDropDown(filterSectors),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ServiceTypeDropDown(serviceFilter),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(child: DurationDropDown(durationFilter))
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: LevelDropDown(levelFilter)),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: widget.available,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
                                            particularWeekDay = value1;
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
                                        particularDay = value;
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
                                  child: GestureDetector(
                                    onTap: () =>
                                        _selectDate(context, formattedDate),
                                    child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0),
                                      //width: MediaQuery.of(context).size.width / 1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                              color:
                                                  blackColor.withOpacity(0.6)),
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
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _selectDate(context, endDate),
                                    child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0),
                                      //width: MediaQuery.of(context).size.width / 1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                              color:
                                                  blackColor.withOpacity(0.6)),
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
                              weight: FontWeight.bold,
                              color: blackTypeColor1),
                          MyText(
                              text:
                                  "${selectedActivites.length} ${"Activites Included}"}",
                              weight: FontWeight.bold,
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
                widget.aimedFor,
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
                            left: 0, top: 0, bottom: 0, right: 25),
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
                    TFWithSize(
                        '2', daysBeforeActController, 16, lightGreyColor, 8)
                  ],
                ),
              ],
            ),
          );
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
