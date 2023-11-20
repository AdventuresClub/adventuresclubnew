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
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateServicesDescription extends StatefulWidget {
  final TextEditingController adventureName;
  final TextEditingController available;
  final TextEditingController info;
  final Widget aimedFor;
  final TextEditingController daysBeforeActController;
  final Widget servicePlan;
  final Widget dependency;
  const CreateServicesDescription(
      {required this.adventureName,
      required this.available,
      required this.info,
      required this.aimedFor,
      required this.daysBeforeActController,
      required this.servicePlan,
      required this.dependency,
      super.key});

  @override
  State<CreateServicesDescription> createState() =>
      _CreateServicesDescriptionState();
}

class _CreateServicesDescriptionState extends State<CreateServicesDescription> {
  int countryId = 0;
  bool loading = false;
  Map mapFilter = {};
  Map mapAimedFilter = {};
  DateTime currentDate = DateTime.now();
  List<int> activityId = [];
  List<String> activity = [];
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
  bool showRegion = false;
  int selectedRegion = 0;
  int selectedCategory = 0;
  int selectedServiceSector = 0;
  int selectedServiceType = 0;
  int selectedDuration = 0;
  int selectedLevel = 0;
  int? currentIndex;
  var getCountry = 'Oman';
  List<WnHModel> weightList = [];
  List<String> countryList = [
    "Oman",
  ];
  List<CategoryModel> categoryList = [];
  List<RegionsModel> regionList = [];
  List aimedText = [];
  List dependencyText = [
    'Licensed',
    'Weather Conditions',
    'Health Conditions',
    'Heat',
    'Chillness',
    'Climate',
  ];
  List<bool> dependencyValue = [false, false, false, false, false, false];
  List<String> activityList = [];
  List<bool> activityValue = [];
  List<bool> aimedValue = [];
  int activitiesLength = 0;

  @override
  void initState() {
    super.initState();
    getData();
    //   getRegionId();
  }

  void getRegionId() {
    print(ConstantsCreateNewServices.selectedRegionId);
  }

  void getData() {
    regionList = Constants.regionList;
    categoryFilter = Constants.categoryFilter;
    filterSectors = Constants.filterSectors;
    serviceFilter = Constants.serviceFilter;
    durationFilter = Constants.durationFilter;
    regionFilter = Constants.regionFilter;
    levelFilter = Constants.levelFilter;
    activitiesFilter = Constants.activitiesFilter;
    parseActivity(Constants.activitiesFilter);
  }

  void removeId(int id) {
    if (ConstantsCreateNewServices.selectedActivitesId.contains(id)) {
      ConstantsCreateNewServices.selectedActivitesId.remove(id);
    }
    print(ConstantsCreateNewServices.selectedActivitesId);
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void abc() {
    Navigator.of(context).pop();
    List<ActivitiesIncludeModel> a = [];
    for (int i = 0; i < activityValue.length; i++) {
      if (activityValue[i]) {
        if (!a.contains(activitiesFilter[i])) {
          a.add(activitiesFilter[i]);
        }
      }
    }
    sId(a);
  }

  void sId(List<ActivitiesIncludeModel> activity) async {
    setState(() {
      activitiesLength = activity.length;
    });
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
    print(ConstantsCreateNewServices.selectedActivitesId);
  }

  void addActivites() {
    activitiesLength = 0;
    selectedActivitesid.clear;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: ((context, setState) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: SingleChildScrollView(
                  child: SizedBox(
                    //height: MediaQuery.of(context).size.height / 1.5,
                    // width: MediaQuery.of(context).size.width / 1.2,
                    child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 5.0, left: 5, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 10),
                                child: MyText(
                                    text: 'activitiesIncludes'.tr(),
                                    weight: FontWeight.bold,
                                    color: blackColor,
                                    size: 16,
                                    fontFamily: 'Raleway'),
                              ),
                              const SizedBox(height: 20),
                              for (int i = 0; i < activitiesFilter.length; i++)
                                SizedBox(
                                  //width: MediaQuery.of(context).size.width / 1,
                                  child: Column(
                                    children: [
                                      CheckboxListTile(
                                        side: const BorderSide(
                                            color: bluishColor),
                                        checkboxShape:
                                            const RoundedRectangleBorder(
                                          side: BorderSide(color: bluishColor),
                                        ),
                                        visualDensity: const VisualDensity(
                                            horizontal: 0, vertical: -4),
                                        activeColor: greyProfileColor,
                                        checkColor: bluishColor,
                                        selected: activityValue[i],
                                        value: activityValue[i],
                                        onChanged: (value) {
                                          setState(() {
                                            activityValue[i] =
                                                !activityValue[i];
                                            removeId(activitiesFilter[i].id);
                                            // activityId
                                            //     .add(activitiesFilter[index].id);
                                            // activity.add(
                                            //     activitiesFilter[index].activity);
                                          });
                                        },
                                        title: MyText(
                                          text:
                                              activitiesFilter[i].activity.tr(),
                                          color: greyColor,
                                          fontFamily: 'Raleway',
                                          size: 18,
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              // Wrap(
                              //   children: List.generate(
                              //       activitiesFilter
                              //           .length, //activityList.length,
                              //       (index) {
                              //     return ;
                              //   }),
                              // ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 15),
                                child: Button(
                                    'done'.tr(),
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
                ),
              );
            }),
          );
        });
  }

  void parseActivity(List<ActivitiesIncludeModel> am) {
    am.forEach((element) {
      if (element.activity.isNotEmpty) {
        activityList.add(element.activity.tr());
      }
    });
    activityList.forEach(
      (element) {
        activityValue.add(false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Column(
            children: [CircularProgressIndicator(), Text("Loading...")],
          )
        : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                TFWithSize('adventureName', widget.adventureName, 12,
                    lightGreyColor, 1),
                const SizedBox(height: 10),
                MultiLineField(
                    'typeInformation', 5, lightGreyColor, widget.info),
                const SizedBox(height: 10),
                Row(
                  children: [
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
                          text: Constants.country.tr(), //getCountry.toString(),
                          color: blackTypeColor,
                          size: 14,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TFWithSize(
                        'Available Seats',
                        widget.available,
                        16,
                        lightGreyColor,
                        2.4,
                        show: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  collapsedBackgroundColor: greyBackgroundColor,
                  title: Text(
                    regionList[selectedRegion].showCountry == true
                        ? regionList[selectedRegion].region
                        : 'Select Region',
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: regionList.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          value: selectedRegion == index
                              ? regionList[index].showCountry
                              : false,
                          onChanged: (value) {
                            setState(() {
                              selectedRegion = index;
                              regionList[selectedRegion].showCountry = value;
                            });
                          },
                          title: Text(regionList[index].region),
                        );
                      },
                    )
                  ],
                ),
                //const SizedBox(height: 20),
                ExpansionTile(
                  title: Text(
                    categoryFilter[selectedServiceSector].showCategoryFilter ==
                            true
                        ? categoryFilter[selectedServiceSector].category
                        : 'Service Sector',
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: categoryFilter.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          secondary: Image.network(
                            "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${categoryFilter[index].image}",
                            height: 18,
                            width: 18,
                          ),
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          value: selectedServiceSector == index
                              ? categoryFilter[index].showCategoryFilter
                              : false,
                          onChanged: (value) {
                            setState(() {
                              selectedServiceSector = index;
                              categoryFilter[selectedServiceSector]
                                  .showCategoryFilter = value;
                            });
                          },
                          title: Text(categoryFilter[index].category),
                        );
                      },
                    )
                  ],
                ),
                // Expanded(
                //   child: ServiceCategoryDropDown(categoryFilter),
                // ),
                const SizedBox(
                  width: 5,
                ),
                ExpansionTile(
                  title: Text(
                    filterSectors[selectedCategory].showfilterSectors == true
                        ? filterSectors[selectedCategory].sector
                        : 'Type',
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: filterSectors.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          secondary: Image.network(
                            "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${filterSectors[index].image}",
                            height: 18,
                            width: 18,
                          ),
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          value: selectedCategory == index
                              ? filterSectors[index].showfilterSectors
                              : false,
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = index;
                              filterSectors[selectedCategory]
                                  .showfilterSectors = value;
                            });
                          },
                          title: Text(filterSectors[index].sector),
                        );
                      },
                    )
                  ],
                ),
                //       const SizedBox(height: 20),
                ExpansionTile(
                  title: Text(
                    serviceFilter[selectedServiceSector].showServiceFilter ==
                            true
                        ? serviceFilter[selectedServiceSector].type
                        : 'Service Filter',
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: serviceFilter.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          secondary: Image.network(
                            "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${serviceFilter[index].image}",
                            height: 18,
                            width: 18,
                          ),
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          value: selectedServiceSector == index
                              ? serviceFilter[index].showServiceFilter
                              : false,
                          onChanged: (value) {
                            setState(() {
                              selectedServiceSector = index;
                              serviceFilter[selectedServiceSector]
                                  .showServiceFilter = value;
                            });
                          },
                          title: Text(serviceFilter[index].type),
                        );
                      },
                    )
                  ],
                ),
                // Expanded(
                //   child: ServiceTypeDropDown(serviceFilter),
                // ),
                const SizedBox(
                  width: 10,
                ),
                ExpansionTile(
                  title: Text(
                    durationFilter[selectedDuration].showDuration == true
                        ? durationFilter[selectedDuration].duration
                        : 'Duration',
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: durationFilter.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          value: selectedDuration == index
                              ? durationFilter[index].showDuration
                              : false,
                          onChanged: (value) {
                            setState(() {
                              selectedDuration = index;
                              durationFilter[selectedDuration].showDuration =
                                  value;
                            });
                          },
                          title: Text(durationFilter[index].duration),
                        );
                      },
                    )
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    levelFilter[selectedLevel].showLevel == true
                        ? levelFilter[selectedLevel].level
                        : 'Level Filter',
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: levelFilter.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          value: selectedLevel == index
                              ? levelFilter[index].showLevel
                              : false,
                          onChanged: (value) {
                            setState(() {
                              selectedLevel = index;
                              levelFilter[selectedLevel].showLevel = value;
                            });
                          },
                          title: Text(levelFilter[index].level),
                        );
                      },
                    )
                  ],
                ),
                // Expanded(child: LevelDropDown(levelFilter)),
                const SizedBox(
                  width: 10,
                ),

                const SizedBox(height: 20),
                const Divider(),
                widget.servicePlan,
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
                              text: 'activitiesIncludes'.tr(),
                              weight: FontWeight.bold,
                              color: blackTypeColor1),
                          MyText(
                              text:
                                  "$activitiesLength ${"activitiesIncludes".tr()}",
                              weight: FontWeight.bold,
                              color: blackTypeColor),
                        ],
                      ),
                      Button(
                          'addActivities',
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
                MyText(
                  text: 'aimedFor'.tr(),
                  color: blackTypeColor1,
                  size: 16,
                  align: TextAlign.center,
                  weight: FontWeight.bold,
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
                MyText(
                  text: 'dependency'.tr(),
                  color: blackTypeColor1,
                  align: TextAlign.center,
                  weight: FontWeight.bold,
                  size: 16,
                ),
                widget.dependency,
                Divider(
                  thickness: 1.5,
                  color: blackColor.withOpacity(0.4),
                ),
                MyText(
                  text: 'registrationClosedBy'.tr(),
                  color: greyShadeColor,
                  align: TextAlign.center,
                  weight: FontWeight.w500,
                  size: 16,
                ),
                Row(
                  children: [
                    MyText(
                      text: 'daysBeforeTheActivityStarts',
                      color: greyShadeColor,
                      align: TextAlign.center,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TFWithSize('2', widget.daysBeforeActController, 16,
                        lightGreyColor, 8)
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
