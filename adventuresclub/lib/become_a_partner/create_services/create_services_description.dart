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
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/models/weightnheight_model.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:adventuresclub/widgets/text_fields/multiline_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateServicesDescription extends StatefulWidget {
  final TextEditingController available;
  final TextEditingController info;
  final Widget aimedFor;
  final TextEditingController daysBeforeActController;
  final Widget servicePlan;
  final Widget dependency;
  final Function tapped;
  final Function getActivityIds;
  final ServicesModel? draftService;
  const CreateServicesDescription(
      {required this.available,
      required this.info,
      required this.aimedFor,
      required this.daysBeforeActController,
      required this.servicePlan,
      required this.dependency,
      required this.tapped,
      required this.getActivityIds,
      this.draftService,
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
  int selectedRegion = 1;
  int selectedCategory = 1;
  int selectedServiceSector = 1;
  int selectedServiceType = 1;
  int selectedDuration = 1;
  int selectedLevel = 1;
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
    if (widget.draftService != null) {
      if (widget.draftService!.region.isNotEmpty) {
        parseDataDraft("region");
      }
      if (widget.draftService!.serviceSector.isNotEmpty) {
        parseDataDraft("sector");
      }
      if (widget.draftService!.serviceCategory.isNotEmpty) {
        parseDataDraft('category');
      }
    }
    if (widget.draftService!.serviceType.isNotEmpty) {
      parseDataDraft("type");
    }
    if (widget.draftService!.duration.isNotEmpty) {
      parseDataDraft("duration");
    }
    if (widget.draftService!.serviceLevel.isNotEmpty) {
      parseDataDraft("level");
    }
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

  void parseDataDraft(String type) {
    if (type == "region") {
      if (widget.draftService!.region.isNotEmpty) {
        selectedRegion = regionList.indexWhere(
            (element) => element.region == widget.draftService!.region);
      }
      if (selectedRegion >= 0) {
        setState(() {
          regionList[selectedRegion].showCountry = true;
        });
      }
    } else if (type == "sector") {
      if (widget.draftService!.serviceSector.isNotEmpty) {
        selectedServiceSector = filterSectors.indexWhere(
            (element) => element.sector == widget.draftService!.serviceSector);
      }
      setState(() {
        filterSectors[selectedServiceSector].showfilterSectors = true;
      });
    } else if (type == "category") {
      selectedCategory = categoryFilter.indexWhere((element) =>
          element.category == widget.draftService!.serviceCategory);
      setState(() {
        categoryFilter[selectedCategory].showCategoryFilter = true;
      });
    } else if (type == "type") {
      selectedServiceType = serviceFilter.indexWhere(
          (element) => element.type == widget.draftService!.serviceType);
      setState(() {
        serviceFilter[selectedServiceType].showServiceFilter = true;
      });
    } else if (type == "duration") {
      selectedDuration = durationFilter.indexWhere(
          (element) => element.duration == widget.draftService!.duration);
      setState(() {
        durationFilter[selectedDuration].showDuration = true;
      });
    } else if (type == "level") {
      selectedLevel = levelFilter.indexWhere(
          (element) => element.level == widget.draftService!.serviceLevel);
      setState(() {
        levelFilter[selectedLevel].showLevel = true;
      });
    }
  }

  void removeId(int id) {
    // if (ConstantsCreateNewServices.selectedActivitesId.contains(id)) {
    //   ConstantsCreateNewServices.selectedActivitesId.remove(id);
    // }
    if (selectedActivitesid.contains(id)) {
      selectedActivitesid.remove(id);
    }
    print(selectedActivitesid);
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
    widget.getActivityIds(selectedActivitesid);
    // setState(() {
    //   ConstantsCreateNewServices.selectedActivites = selectedActivites;
    //   ConstantsCreateNewServices.selectedActivitesId = selectedActivitesid;
    // });
    // print(selectedActivites);
    // print(selectedActivites);
    // Provider.of<CompleteProfileProvider>(context, listen: false)
    //     .activityLevel(a, id);
    //print(ConstantsCreateNewServices.selectedActivitesId);
    print(selectedActivitesid);
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
                                        secondary: Image.network(
                                          //   "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.serviceCategoryImage}",
                                          "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${activitiesFilter[i].image}",
                                          height: 36,
                                          width: 26,
                                        ),
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
    List<String> customActivityList = [];
    if (widget.draftService != null) {
      for (var element in widget.draftService!.activityIncludes) {
        customActivityList.add(element.activity);
      }
    }
    am.forEach((element) {
      if (element.activity.isNotEmpty) {
        activityList.add(element.activity.tr());
      }
    });
    activityList.forEach(
      (element) {
        if (widget.draftService != null) {
          if (customActivityList.contains(element)) {
            activityValue.add(true);
            activitiesLength += 1;
          } else {
            activityValue.add(false);
          }
        } else {
          activityValue.add(false);
        }
      },
    );
  }

  void parseData(String type, int regionId) {
    widget.tapped(
      type,
      regionId,
    );
  }

  void checkText(TextEditingController m, String message) {
    if (message.length < 3) {
      m.value = TextEditingValue(
        text: message,
        selection: TextSelection.collapsed(offset: message.length),
      );
    }
    if (message.length > 50) {
      m.value = TextEditingValue(
        text: message.substring(0, 50),
        selection: const TextSelection.collapsed(offset: 50),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Column(
            children: [CircularProgressIndicator(), Text("Loading...")],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // TFWithSize(
              //   'adventureName',
              //   widget.adventureName,
              //   12,
              //   lightGreyColor,
              //   1,
              //   minimumLetters: 3,
              //   maximumLetters: 50,
              // ),
              const SizedBox(height: 5),
              MultiLineField(
                'typeInformation',
                5,
                lightGreyColor,
                widget.info,
                maximumLetters: 300,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          //height: 60,
                          //width: MediaQuery.of(context).size.width / 2.4,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                            color: lightGreyColor,
                            border: Border.all(
                                color: greyColor.withOpacity(0.2), width: 1.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: MyText(
                              text: Constants.country
                                  .tr(), //getCountry.toString(),
                              color: blackTypeColor,
                              size: 14,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TFWithSize(
                      'availableSeats',
                      widget.available,
                      14,
                      lightGreyColor,
                      2.6,
                      show:
                          const TextInputType.numberWithOptions(decimal: false),
                      maximumLetters: 8,
                    ),
                  ),
                ],
              ),
              if (regionList.isNotEmpty)
                ExpansionTile(
                  title: Text(regionList[selectedRegion].showCountry == false
                      ? 'selectRegion'.tr()
                      : regionList[selectedRegion].region.tr()),
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
                          checkboxShape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          onChanged: (value) {
                            setState(() {
                              selectedRegion = index;
                              regionList[selectedRegion].showCountry = value;
                              if (value == true) {
                                parseData("region", regionList[index].regionId);
                              } else {
                                parseData("region", 0);
                              }

                              // ConstantsCreateNewServices.selectedRegionId =
                              //     regionList[index].regionId;
                            });
                          },
                          title: Text(regionList[index].region.tr()),
                        );
                      },
                    )
                  ],
                ),
              //const SizedBox(height: 20),
              if (filterSectors.isNotEmpty)
                ExpansionTile(
                  title: Text(
                    // categoryFilter[selectedServiceSector].showCategoryFilter ==
                    //         true
                    //     ? categoryFilter[selectedServiceSector].category
                    //     : 'Service Sector',
                    filterSectors[selectedServiceSector].showfilterSectors ==
                            true
                        ? filterSectors[selectedServiceSector].sector.tr()
                        : 'Service Sector'.tr(),
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
                            height: 36,
                            width: 26,
                          ),
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          checkboxShape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          value: selectedServiceSector == index
                              ? filterSectors[index].showfilterSectors
                              : false,
                          onChanged: (value) {
                            setState(() {
                              selectedServiceSector = index;
                              filterSectors[selectedServiceSector]
                                  .showfilterSectors = value;
                              if (value == true) {
                                parseData("sector", filterSectors[index].id);
                              } else {
                                parseData("sector", 0);
                              }

                              // ConstantsCreateNewServices.selectedCategoryId =
                              //     filterSectors[index].id;
                            });
                          },
                          title: Text(filterSectors[index].sector.tr()),
                        );
                      },
                    )
                  ],
                ),
              if (categoryFilter.isNotEmpty)
                ExpansionTile(
                  // categoryFilter[selectedServiceSector].showCategoryFilter ==
                  //         true
                  //     ? categoryFilter[selectedServiceSector].category
                  //     : 'Service Sector',
                  title: Text(
                    categoryFilter[selectedCategory].showCategoryFilter == true
                        ? categoryFilter[selectedCategory].category.tr()
                        : 'Service Category'.tr(),
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
                            height: 36,
                            width: 26,
                          ),
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          value: selectedCategory == index
                              ? categoryFilter[index].showCategoryFilter
                              : false,
                          checkboxShape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = index;
                              // selectedServiceSector = index;
                              categoryFilter[selectedCategory]
                                  .showCategoryFilter = value;
                              if (value == true) {
                                parseData("category", categoryFilter[index].id);
                              } else {
                                parseData("category", 0);
                              }

                              // ConstantsCreateNewServices.selectedSectorId =
                              //     categoryFilter[index].id;
                            });
                          },
                          title: Text(categoryFilter[index].category.tr()),
                        );
                      },
                    )
                  ],
                ),
              // Expanded(
              //   child: ServiceCategoryDropDown(categoryFilter),
              // ),

              //       const SizedBox(height: 20),
              if (serviceFilter.isNotEmpty)
                ExpansionTile(
                  title: Text(
                    serviceFilter[selectedServiceType].showServiceFilter == true
                        ? serviceFilter[selectedServiceType].type.tr()
                        : 'Service Type'.tr(),
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
                            height: 36,
                            width: 26,
                          ),
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          checkboxShape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          value: selectedServiceType == index
                              ? serviceFilter[index].showServiceFilter
                              : false,
                          onChanged: (value) {
                            setState(() {
                              selectedServiceType = index;
                              serviceFilter[selectedServiceType]
                                  .showServiceFilter = value;
                              if (value == true) {
                                parseData("type", serviceFilter[index].id);
                              } else {
                                parseData("type", 0);
                              }

                              // ConstantsCreateNewServices.serviceTypeId =
                              //     serviceFilter[index].id;
                            });
                          },
                          title: Text(serviceFilter[index].type.tr()),
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
              if (durationFilter.isNotEmpty)
                ExpansionTile(
                  title: Text(
                    durationFilter[selectedDuration].showDuration == true
                        ? durationFilter[selectedDuration].duration
                        : 'Duration'.tr(),
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
                          checkboxShape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          onChanged: (value) {
                            setState(() {
                              selectedDuration = index;
                              durationFilter[selectedDuration].showDuration =
                                  value;
                              if (value == true) {
                                parseData("duration", durationFilter[index].id);
                              } else {
                                parseData("duration", 0);
                              }

                              // ConstantsCreateNewServices.selectedDurationId =
                              //     durationFilter[index].id;
                            });
                          },
                          title: Text(durationFilter[index].duration.tr()),
                        );
                      },
                    )
                  ],
                ),
              if (levelFilter.isNotEmpty)
                ExpansionTile(
                  title: Text(
                    levelFilter[selectedLevel].showLevel == true
                        ? levelFilter[selectedLevel].level
                        : 'selectLevel'.tr(),
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: levelFilter.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          secondary: Image.network(
                            "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${levelFilter[index].image}",
                            height: 36,
                            width: 26,
                          ),
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          checkboxShape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          value: selectedLevel == index
                              ? levelFilter[index].showLevel
                              : false,
                          onChanged: (value) {
                            setState(() {
                              selectedLevel = index;
                              levelFilter[selectedLevel].showLevel = value;
                              if (value == true) {
                                parseData("level", levelFilter[index].id);
                              } else {
                                parseData("level", 0);
                              }

                              // ConstantsCreateNewServices.selectedlevelId =
                              //     levelFilter[index].id;
                            });
                          },
                          title: Text(levelFilter[index].level.tr()),
                        );
                      },
                    )
                  ],
                ),
              //  Row(
              //    children: [
              //      Expanded(child: LevelDropDown(levelFilter)),
              //    ],
              //  ),
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
              // MyText(
              //   text: 'registrationClosedBy'.tr(),
              //   color: greyShadeColor,
              //   align: TextAlign.center,
              //   weight: FontWeight.w500,
              //   size: 16,
              // ),
              // Row(
              //   children: [
              //     MyText(
              //       text: 'daysBeforeTheActivityStarts',
              //       color: greyShadeColor,
              //       align: TextAlign.center,
              //       size: 14,
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     TFWithSize('2', widget.daysBeforeActController, 16,
              //         lightGreyColor, 8)
              //   ],
              // ),
            ],
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
