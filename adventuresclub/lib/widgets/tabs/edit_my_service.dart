import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/filter_data_model/activities_inc_model.dart';
import 'package:adventuresclub/models/filter_data_model/category_filter_model.dart';
import 'package:adventuresclub/models/filter_data_model/display_data_model.dart';
import 'package:adventuresclub/models/filter_data_model/durations_model.dart';
import 'package:adventuresclub/models/filter_data_model/level_filter_mode.dart';
import 'package:adventuresclub/models/filter_data_model/region_model.dart';
import 'package:adventuresclub/models/filter_data_model/sector_filter_model.dart';
import 'package:adventuresclub/models/filter_data_model/service_types_filter.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/models/services/dependencies_model.dart';
import 'package:adventuresclub/models/services/included_activities_model.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/loading_widget.dart';
import 'package:adventuresclub/widgets/my_service_banner_container.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/service_program/service_plans.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditMyService extends StatefulWidget {
  final ServicesModel gm;
  const EditMyService({required this.gm, super.key});

  @override
  State<EditMyService> createState() => _EditMyServiceState();
}

class _EditMyServiceState extends State<EditMyService> {
  TextEditingController nameController = TextEditingController();
  TextEditingController costInc = TextEditingController();
  TextEditingController costExl = TextEditingController();
  TextEditingController desriptionController = TextEditingController();
  TextEditingController preRequisitesController = TextEditingController();
  TextEditingController minimumRequirements = TextEditingController();
  TextEditingController terms = TextEditingController();
  List<String> categoryList = [];
  List<SectorFilterModel> filterSectors = [];
  List<CategoryFilterModel> categoryFilter = [];
  List<LevelFilterModel> levelFilter = [];
  List<ServiceTypeFilterModel> serviceType = [];
  List<RegionFilterModel> regionFilter = [];
  List<DurationsModel> durationFilter = [];
  List<DisplayDataModel> dataList = [];
  List<bool> dataListBool = [];
  String st = "";
  String ed = "";
  DateTime startDate = DateTime.now();
  DateTime endDate1 = DateTime.now();
  String aPlan = "";
  List<String> adventuresPlan = [""];
  int activitiesLength = 0;
  List<ActivitiesIncludeModel> activitiesFilter = [];
  List<bool> activityValue = [];
  List<String> activityList = [];
  List<int> selectedActivitesid = [];
  List<String> selectedActivites = [];
  List<AimedForModel> aimedFilter = [];
  List<DependenciesModel> dependencyList = [];
  List<String> dependencyText = [];
  List<bool> dependencyValue = [];
  ServicesModel? currentService;
  bool loading = false;
  List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List<bool> daysValue = [false, false, false, false, false, false, false];
  bool editDay = false;
  int servicePlanId = 0;
  var formattedDate;
  var endDate;
  DateTime eDate = DateTime.now();
  DateTime? pickedDate;
  DateTime currentDate = DateTime.now();
  String selectedActivityIncludesId = "";

  @override
  void initState() {
    getSteps();
    categoryList.add(widget.gm.serviceCategory);
    categoryList.add(widget.gm.serviceSector);
    categoryList.add(widget.gm.serviceType);
    categoryList.add(widget.gm.serviceLevel);
    getData();
    if (widget.gm.sPlan == 2) {
      startDate =
          DateTime.tryParse(widget.gm.availability[0].st) ?? DateTime.now();
      String sMonth = DateFormat('MMM').format(startDate);
      st = "${startDate.day}-$sMonth-${startDate.year}";
      endDate =
          DateTime.tryParse(widget.gm.availability[0].ed) ?? DateTime.now();
      String eMonth = DateFormat('MMM').format(startDate);
      ed = "${endDate.day}-$eMonth-${endDate.year}";
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    costExl.dispose();
    costInc.dispose();
    desriptionController.dispose();
    super.dispose();
  }

  void getData() {
    // regionList = Constants.regionList;
    categoryFilter = Constants.categoryFilter;
    filterSectors = Constants.filterSectors;
    serviceType = Constants.serviceFilter;
    //   durationFilter = Constants.durationFilter;
    //   regionFilter = Constants.regionFilter;
    levelFilter = Constants.levelFilter;
    regionFilter = Constants.regionFilter;
    durationFilter = Constants.durationFilter;
    activitiesFilter = Constants.activitiesFilter;
    aimedFilter = Constants.am;
    dependencyList = Constants.dependency;
    parseActivity(Constants.activitiesFilter);
    parseDependency(Constants.dependency);
  }

  void parseDependency(List<DependenciesModel> dm) {
    for (var element in dm) {
      if (element.dName.isNotEmpty) {
        dependencyText.add(element.dName.tr());
      }
    }
    for (var element in dependencyText) {
      dependencyValue.add(false);
    }
  }

  void setEdit(String type) {
    if (type == "daysValue") {
      setState(() {
        editDay = !editDay;
      });
    }
  }

  void typeData(String type) {
    TextEditingController controller = TextEditingController();
    String title = "";
    String hint = "";
    int max = 2;
    if (type == "adventureName") {
      nameController = controller;
      title = widget.gm.adventureName;
      hint = "Adventure Name";
      max = 3;
    } else if (type == "costInc") {
      costInc = controller;
      title = widget.gm.costInc;
      hint = "Cost Inc";
      max = 1;
    } else if (type == "costExl") {
      costExl = controller;
      title = widget.gm.costExc;
      hint = "Cost Excluding";
      max = 1;
    } else if (type == "description") {
      desriptionController = controller;
      title = widget.gm.writeInformation;
      hint = "Description";
    } else if (type == "prerequisites") {
      preRequisitesController = controller;
      title = widget.gm.preRequisites;
      hint = "Pre-Requisites";
    } else if (type == "minimumRequirements") {
      minimumRequirements = controller;
      title = widget.gm.mRequirements;
      hint = "minimumRequirements";
    } else if (type == "terms") {
      terms = controller;
      title = widget.gm.tnc;
      hint = "termsNConditions";
    }
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: ((context, setState) {
              return SimpleDialog(
                contentPadding: const EdgeInsets.all(16),
                backgroundColor: Colors.white,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  MyText(
                    text: title,
                    color: blackColor,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: const TextStyle(color: blackTypeColor4),
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(color: greyColor.withOpacity(0.5)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(color: greyColor.withOpacity(0.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(color: greyColor.withOpacity(0.5)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // TextButton(
                  //     onPressed: () => editService("name"),
                  //     child: const Text("Update"),),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bluishColor, // Background color
                      ),
                      onPressed: () => editService(type),
                      child: const Text(
                        "Edit",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              );
            }),
          );
        });
  }

  void addData(String type) {
    if (type == "sector") {
      // currentService = ServicesModel(
      //   id: widget.gm.id,
      //   owner: widget.gm.owner,
      //   adventureName: adventureName,
      //   country: widget.gm.country,
      //   region: widget.gm.region,
      //   cityId: widget.gm.cityId,
      //    serviceSector: serviceSector,
      //     serviceCategory: serviceCategory,
      //      serviceType: serviceType,
      //      serviceLevel: serviceLevel,
      //      duration: duration,
      //      aSeats: aSeats,
      //       startDate: startDate,
      //       endDate: endDate,
      //       lat: lat,
      //       lng: lng,
      //       writeInformation: writeInformation,
      //        sPlan: sPlan,
      //        sForID: sForID,
      //        availability: availability,
      //        availabilityPlan: availabilityPlan,
      //         geoLocation: geoLocation,
      //         sAddress: sAddress,
      //         costInc: costInc,
      //         costExc: costExc,
      //          currency: currency,
      //          points: points,
      //          preRequisites: preRequisites,
      //          mRequirements: mRequirements,
      //           tnc: tnc,
      //           recommended: recommended,
      //           status: status,
      //           image: image,
      //           des: des,
      //            fImage: fImage,
      //            ca: ca,
      //            upda: upda,
      //            da: da,
      //            providerId: providerId,
      //            serviceId: serviceId,
      //             pName: pName,
      //             pProfile: pProfile,
      //             iaot: iaot,
      //             eaot: eaot,
      //             activityIncludes: activityIncludes,
      //              dependency: dependency,
      //              bp: bp,
      //              am: am,
      //              programmes: programmes,
      //              stars: stars,
      //              isLiked: isLiked,
      //               baseURL: baseURL,
      //               images: images,
      //               rating: rating,
      //               reviewdBy: reviewdBy,
      //               remainingSeats: remainingSeats,
      //                serviceCategoryImage: serviceCategoryImage,
      //                serviceSectorImage: serviceSectorImage,
      //                serviceTypeImage: serviceTypeImage,
      //                serviceLevelImage: serviceLevelImage)

      // "service_sector": sectorId
      //   .toString(),
    }
  }

  void addActivites(String type, String title) {
    dataList.clear();
    if (type != "activities" && type != "audience" && type != "dependency") {
      dataListBool.clear();
    }
    if (type == "sector") {
      for (var element in filterSectors) {
        dataList.add(DisplayDataModel(
            id: element.id.toString(),
            image: element.image,
            title: element.sector));
        if (element.sector == title) {
          dataListBool.add(true);
        } else {
          dataListBool.add(false);
        }
      }
    } else if (type == "category") {
      for (var element in categoryFilter) {
        dataList.add(DisplayDataModel(
            id: element.id.toString(),
            image: element.image,
            title: element.category));
        if (element.category == title) {
          dataListBool.add(true);
        } else {
          dataListBool.add(false);
        }
      }
    } else if (type == "type") {
      for (var element in serviceType) {
        dataList.add(DisplayDataModel(
            id: element.id.toString(),
            image: element.image,
            title: element.type));
        if (element.type == title) {
          dataListBool.add(true);
        } else {
          dataListBool.add(false);
        }
      }
    } else if (type == "level") {
      for (var element in levelFilter) {
        dataList.add(DisplayDataModel(
            id: element.id.toString(),
            image: element.image,
            title: element.level));
        if (element.level == title) {
          dataListBool.add(true);
        } else {
          dataListBool.add(false);
        }
      }
    } else if (type == "region") {
      for (var element in regionFilter) {
        dataList.add(DisplayDataModel(
            id: element.id.toString(), image: "", title: element.regions));
        if (element.regions == title) {
          dataListBool.add(true);
        } else {
          dataListBool.add(false);
        }
      }
    } else if (type == "activities") {
      dataListBool = List.filled(activitiesFilter.length, false);
      for (int j = 0; j < activitiesFilter.length; j++) {
        for (int i = 0; i < widget.gm.activityIncludes.length; i++) {
          if (activitiesFilter[j].activity ==
              widget.gm.activityIncludes[i].activity) {
            dataListBool[j] = true;
          }
        }
        dataList.add(
          DisplayDataModel(
              id: activitiesFilter[j].id.toString(),
              image: activitiesFilter[j].image,
              title: activitiesFilter[j].activity),
        );
      }
    } else if (type == "audience") {
      dataListBool = List.filled(aimedFilter.length, false);
      for (int j = 0; j < aimedFilter.length; j++) {
        for (int i = 0; i < widget.gm.am.length; i++) {
          if (aimedFilter[j].aimedName == widget.gm.am[i].aimedName) {
            dataListBool[j] = true;
          }
        }
        dataList.add(
          DisplayDataModel(
              id: aimedFilter[j].id.toString(),
              image: aimedFilter[j].image,
              title: aimedFilter[j].aimedName),
        );
      }
      // dataList.add(DisplayDataModel(
      //     id: element.id.toString(),
      //     image: element.image,
      //     title: element.aimedName));
      // for (var e in widget.gm.am) {
      //   if (e.aimedName == element.aimedName) {
      //     dataListBool.add(true);
      //   } else {
      //     dataListBool.add(false);
      //   }
      // }
    } else if (type == "dependency") {
      dataListBool = List.filled(dependencyList.length, false);
      for (int j = 0; j < dependencyList.length; j++) {
        for (int i = 0; i < widget.gm.dependency.length; i++) {
          if (dependencyList[j].dName == widget.gm.dependency[i].dName) {
            dataListBool[j] = true;
          }
        }
        dataList.add(
          DisplayDataModel(
              id: dependencyList[j].id.toString(),
              image: "",
              title: dependencyList[j].dName),
        );
      }
      // for (var element in dependencyList) {
      //   dataListBool = List.filled(dependencyList.length, false);
      //   dataList.add(DisplayDataModel(
      //       id: element.id.toString(), image: "", title: element.dName));
      //   if (widget.gm.dependency.contains(element)) {
      //     dataListBool.add(true);
      //   } else {
      //     dataListBool.add(false);
      //   }
      //   // for (var e in widget.gm.dependency) {
      //   //   if (e.dName == element.dName) {
      //   //     dataListBool.add(true);
      //   //   } else {
      //   //     dataListBool.add(false);
      //   //   }
      //   // }
      // }
    } else if (type == "duration") {
      for (var element in durationFilter) {
        dataList.add(DisplayDataModel(
            id: element.id.toString(), image: "", title: element.duration));
        if (element.duration == title) {
          dataListBool.add(true);
        } else {
          dataListBool.add(false);
        }
      }
    }
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: ((context, setState) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: SingleChildScrollView(
                  child: SizedBox(
                    child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 5.0, left: 5, top: 10),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 10),
                                child: MyText(
                                    text: type.tr(),
                                    weight: FontWeight.bold,
                                    color: bluishColor,
                                    size: 18,
                                    fontFamily: 'Raleway'),
                              ),
                              const SizedBox(height: 20),
                              for (int index = 0;
                                  index < dataList.length;
                                  index++)
                                SizedBox(
                                  //width: MediaQuery.of(context).size.width / 1,
                                  child: Column(
                                    children: [
                                      CheckboxListTile(
                                        secondary:
                                            dataList[index].image.isNotEmpty
                                                ? Image.network(
                                                    //   "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.serviceCategoryImage}",
                                                    "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${dataList[index].image}",
                                                    height: 36,
                                                    width: 26,
                                                  )
                                                : Image.asset(
                                                    //   "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.serviceCategoryImage}",
                                                    'images/blueLogo.png',
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
                                        selected: dataListBool[index],
                                        value: dataListBool[index],
                                        onChanged: (value) {
                                          if (type == "activities" ||
                                              type == "audience" ||
                                              type == "dependency") {
                                            setState(() {
                                              dataListBool[index] =
                                                  !dataListBool[index];
                                            });
                                          } else {
                                            setState(() {
                                              for (int i = 0;
                                                  i < dataListBool.length;
                                                  i++) {
                                                dataListBool[i] = (i == index);
                                              }
                                            });
                                          }
                                        },
                                        title: MyText(
                                          text: dataList[index].title.tr(),
                                          color: greyColor,
                                          fontFamily: 'Raleway',
                                          size: 18,
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      bluishColor, // Background color
                                ),
                                onPressed: () => editService(type),
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(color: whiteColor),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
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
    for (var element in am) {
      if (element.activity.isNotEmpty) {
        activityList.add(element.activity.tr());
      }
    }
    for (var element in activityList) {
      for (var i in widget.gm.activityIncludes) {
        if (element == i.activity) {
          activityValue.add(true);
        } else {
          activityValue.add(false);
        }
      }
    }
  }

  void servicePlan() {
    List<String> d = [];
    for (int i = 0; i < daysValue.length; i++) {
      if (daysValue[i]) {
        d.add(days[i]);
      }
    }
    planDaysId(d);
  }

  void planDaysId(List<String> pDays) async {
    List<int> id = [];
    for (var element in pDays) {
      if (element == "Mon") {
        id.add(2);
      } else if (element == "Tue") {
        id.add(3);
      } else if (element == "Wed") {
        id.add(4);
      } else if (element == "Thu") {
        id.add(5);
      } else if (element == "Fri") {
        id.add(6);
      } else if (element == "Sat") {
        id.add(7);
      } else if (element == "Sun") {
        id.add(1);
      }
    }
    // setState(() {
    // int s = int.parse(id.join());
    servicePlanId = int.parse(id.join());
    // });
    editService("daysValue");
  }

  void editService(String type) async {
    Navigator.of(context).pop();
    dynamic b = {};
    if (type == "category") {
      String categoryId = "";
      for (int i = 0; i < dataListBool.length; i++) {
        if (dataListBool[i]) {
          categoryId = dataList[i].id;
          categoryList.removeAt(0);
          categoryList.insert(0, dataList[i].title);
          widget.gm.serviceCategoryImage = dataList[i].image;
        }
      }
      b = {
        'service_id': widget.gm.id.toString(),
        'customer_id': widget.gm.providerId.toString(),
        "service_category": categoryId
      };
    } else if (type == "sector") {
      String sectorId = "";
      for (int i = 0; i < dataListBool.length; i++) {
        if (dataListBool[i]) {
          sectorId = dataList[i].id;
          categoryList.removeAt(1);
          categoryList.insert(1, dataList[i].title);
          widget.gm.serviceSectorImage = dataList[i].image;
        }
      }
      b = {
        'service_id': widget.gm.id.toString(),
        'customer_id': widget.gm.providerId.toString(),
        "service_sector": sectorId
      };
    } else if (type == "type") {
      String typeId = "";
      for (int i = 0; i < dataListBool.length; i++) {
        if (dataListBool[i]) {
          typeId = dataList[i].id;
          categoryList.removeAt(2);
          categoryList.insert(2, dataList[i].title);
          widget.gm.serviceTypeImage = dataList[i].image;
        }
      }
      b = {
        'service_id': widget.gm.id.toString(),
        'customer_id': widget.gm.providerId.toString(),
        "service_type": typeId
      };
    } else if (type == "level") {
      String levelId = "";
      for (int i = 0; i < dataListBool.length; i++) {
        if (dataListBool[i]) {
          levelId = dataList[i].id;
          categoryList.removeAt(3);
          categoryList.insert(3, dataList[i].title);
          widget.gm.serviceLevelImage = dataList[i].image;
        }
      }
      b = {
        'service_id': widget.gm.id.toString(),
        'customer_id': widget.gm.providerId.toString(),
        "service_level": levelId,
      };
    } else if (type == "region") {
      String regionId = "";
      for (int i = 0; i < dataListBool.length; i++) {
        if (dataListBool[i]) {
          regionId = dataList[i].id;
          widget.gm.region = dataList[i].title;
        }
      }
      b = {
        'service_id': widget.gm.id.toString(),
        'customer_id': widget.gm.providerId.toString(),
        "region": regionId,
      };
    } else if (type == "costInc") {
      widget.gm.costInc = costInc.text;
      b = {
        'service_id': widget.gm.id.toString(),
        'customer_id': widget.gm.providerId.toString(),
        "cost_inc": costInc.text.trim(),
      };
    } else if (type == "costExl") {
      widget.gm.costExc = costExl.text;
      b = {
        'service_id': widget.gm.id.toString(),
        'customer_id': widget.gm.providerId.toString(),
        "cost_exc": costExl.text.trim(),
      };
    } else if (type == "duration") {
      String durationId = "";
      for (int i = 0; i < dataListBool.length; i++) {
        if (dataListBool[i]) {
          durationId = dataList[i].id;
          widget.gm.duration = dataList[i].title;
        }
      }
      b = {
        'service_id': widget.gm.id.toString(),
        'customer_id': widget.gm.providerId.toString(),
        "duration": durationId,
      };
    } else if (type == "daysValue") {
      b = {
        'service_id': widget.gm.id.toString(),
        'customer_id': widget.gm.providerId.toString(),
        "service_plan_days": "23", //servicePlanId,
        "service_plan": "1",
      };
    } else if (type == "plan2") {
    } else if (type == "activities") {
      List<ActivitiesIncludeModel> activity = [];
      widget.gm.activityIncludes.clear();
      for (int j = 0; j < widget.gm.activityIncludes.length; j++) {
        activity.add(ActivitiesIncludeModel(
            widget.gm.activityIncludes[j].id,
            widget.gm.activityIncludes[j].activity,
            widget.gm.activityIncludes[j].image));
      }
      for (int i = 0; i < activitiesFilter.length; i++) {
        if (dataListBool[i]) {
          selectedActivitesid.add(
            activitiesFilter[i].id,
          );
          widget.gm.activityIncludes.add(IncludedActivitiesModel(
              activitiesFilter[i].id,
              0,
              "",
              activitiesFilter[i].activity,
              activitiesFilter[i].image));
        }
      }
      selectedActivityIncludesId = selectedActivitesid.join(",");
      b = {
        'service_id': widget.gm.id.toString(),
        'customer_id': widget.gm.providerId.toString(),
        "activities": selectedActivityIncludesId,
      };
    } else if (type == "description") {
      widget.gm.writeInformation = desriptionController.text;
      b = {
        'service_id': widget.gm.id.toString(),
        'customer_id': widget.gm.providerId.toString(),
        "write_information": desriptionController.text,
      };
    } else if (type == "audience") {
      List<int> selectedAimedForList = [];
      String aimedId = "";
      widget.gm.am.clear();
      for (int i = 0; i < aimedFilter.length; i++) {
        if (dataListBool[i]) {
          selectedAimedForList.add(aimedFilter[i].id);
        }
        widget.gm.am.add(aimedFilter[i]);
      }
      aimedId = selectedAimedForList.join(",");
      b = {
        'service_id': widget.gm.id.toString(),
        'customer_id': widget.gm.providerId.toString(),
        "service_for": aimedId,
      };
    } else if (type == "dependency") {
      List<int> selectedDependencyList = [];
      String dependencyId = "";
      widget.gm.dependency.clear();
      for (int i = 0; i < dependencyList.length; i++) {
        if (dataListBool[i]) {
          selectedDependencyList.add(dependencyList[i].id);
        }
        widget.gm.dependency.add(dependencyList[i]);
      }
      dependencyId = selectedDependencyList.join(",");
      b = {
        'service_id': widget.gm.id.toString(),
        'customer_id': widget.gm.providerId.toString(),
        "dependency": dependencyId,
      };
    } else if (type == "prerequisites") {
      widget.gm.preRequisites = preRequisitesController.text.trim();
      b = {
        'service_id': widget.gm.id.toString(),
        'customer_id': widget.gm.providerId.toString(),
        "pre_requisites": preRequisitesController.text.trim(), //
      };
    } else if (type == "minimumRequirements") {
      widget.gm.mRequirements = minimumRequirements.text.trim();
      b = {
        'service_id': widget.gm.id.toString(),
        'customer_id': widget.gm.providerId.toString(),
        "minimum_requirements": minimumRequirements.text.trim(), //
      };
    } else if (type == "terms") {
      widget.gm.tnc = terms.text.trim();
      b = {
        'service_id': widget.gm.id.toString(),
        'customer_id': widget.gm.providerId.toString(),
        "terms_conditions": terms.text.trim(), //
      };
    }
    // debugPrint(b);
    setState(() {
      loading = true;
    });
    try {
      var response = await http.post(
        Uri.parse("${Constants.baseUrl}/api/v1/edit_service"),
        body: b,
      );
      if (response.statusCode == 200) {
        debugPrint(response.body);
      }
    } catch (e) {
      if (mounted) {
        Constants.showMessage(context, e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  void getSteps() {
    for (var element in widget.gm.availabilityPlan) {
      adventuresPlan.add(element.day.tr());
      if (element.day == "Monday") {
        daysValue[0] = true;
      } else if (element.day == "Tuesday") {
        daysValue[1] = true;
      } else if (element.day == "Wednesday") {
        daysValue[2] = true;
      } else if (element.day == "Thursday") {
        daysValue[3] = true;
      } else if (element.day == "Friday") {
        daysValue[4] = true;
      } else if (element.day == "Saturday") {
        daysValue[5] = true;
      } else if (element.day == "Sunday") {
        daysValue[6] = true;
      }
    }
    aPlan = adventuresPlan.join(", ");
  }

  void removeId(int id) {
    if (selectedActivitesid.contains(id)) {
      selectedActivitesid.remove(id);
    }
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
    for (var element in activity) {
      selectedActivites.add(element.activity);
      selectedActivitesid.add(element.id);
    }
  }

  void addActivitesButton() {
    activitiesLength = 0;
    //selectedActivitesid.clear;
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

  Future<void> _selectDate(BuildContext context, var givenDate) async {
    if (givenDate == formattedDate) {
      pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2050));
    } else if (givenDate == endDate) {
      pickedDate = await showDatePicker(
          context: context,
          initialDate: startDate,
          firstDate: startDate,
          lastDate: DateTime(2050));
    }
    if (pickedDate != null && pickedDate != currentDate) {
      if (givenDate == formattedDate) {
        var date = DateTime.parse(pickedDate.toString());
        String m = date.month < 10 ? "0${date.month}" : "${date.month}";
        String d = date.day < 10 ? "0${date.day}" : "${date.day}";
        setState(() {
          formattedDate = "${date.year}-$m-$d";
          startDate = pickedDate!;
          //pm[0].startDate = startDate;
          //  pm.insert(0, CreateServicesProgramModel(title, startDate, endDate, Duration(), Duration(), "description", DateTime.now, adventureEndDate))
        });
      } else if (givenDate == endDate) {
        DateTime eDate = DateTime(
            pickedDate!.year, pickedDate!.month, pickedDate!.day, 23, 59, 59);
        print(eDate);
        var date = DateTime.parse(eDate.toString());
        String m = date.month < 10 ? "0${date.month}" : "${date.month}";
        String d = date.day < 10 ? "0${date.day}" : "${date.day}";
        setState(() {
          endDate = "${date.year}-$m-$d";
          //   pm[0].endDate = eDate;
          currentDate = eDate;
        });
      }
    }
    print(currentDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: loading
          ? const LoadingWidget()
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: widget.gm.images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width / 1.6,
                            child: MyServiceBannerContainer(
                              image: widget.gm.images[index].imageUrl,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 0; i < categoryList.length; i++)
                          GestureDetector(
                            onTap: i == 0
                                ? () =>
                                    addActivites("category", categoryList[i])
                                : i == 1
                                    ? () =>
                                        addActivites("sector", categoryList[i])
                                    : i == 2
                                        ? () => addActivites(
                                            "type", categoryList[i])
                                        : () => addActivites(
                                            "level", categoryList[i]),
                            child: Column(
                              children: [
                                const Icon(Icons.edit),
                                const SizedBox(
                                  height: 10,
                                ),
                                Image.network(
                                  i == 0
                                      ? "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.serviceCategoryImage}"
                                      : i == 1
                                          ? "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.serviceSectorImage}"
                                          : i == 2
                                              ? "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.serviceTypeImage}"
                                              : //i == 3 ?
                                              "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.serviceLevelImage}",
                                  height: 42,
                                  width: 42,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                MyText(
                                  text: categoryList[i],
                                  color: bluishColor,
                                )
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        MyText(
                          text: widget.gm.adventureName,
                          //'River Rafting',
                          weight: FontWeight.bold,
                          color: bluishColor,
                          size: 22,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () => typeData("adventureName"),
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //
                        Row(
                          children: [
                            MyText(
                              text:
                                  "${widget.gm.country.tr()}, ${widget.gm.region.tr()}"
                                      .tr(),
                              //'River Rafting',
                              // weight: FontWeight.bold,
                              color: blackColor,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              onPressed: () =>
                                  addActivites("region", widget.gm.region),
                              icon: const Icon(Icons.edit),
                            ),
                          ],
                        ),
                        MyText(
                          text:
                              "${widget.gm.aSeats} ${"seats".tr()} (${widget.gm.remainingSeats} ${"left".tr()})",
                          //'River Rafting',
                          // weight: FontWeight.w600,
                          color: blackColor,
                          size: 14,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyText(
                          text: "${widget.gm.duration.tr()} ${"Activity".tr()}",
                          //'River Rafting',
                          // weight: FontWeight.w600,
                          color: blackColor,
                          size: 14,
                        ),
                        IconButton(
                            onPressed: () =>
                                addActivites("duration", widget.gm.duration),
                            icon: const Icon(Icons.edit))
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  visualDensity: VisualDensity.compact,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0))),
                                  value: false,
                                  onChanged: (value) {},
                                ),
                                MyText(
                                  text:
                                      "${widget.gm.currency}  ${widget.gm.costInc}",
                                  //'River Rafting',
                                  weight: FontWeight.bold,
                                  color: bluishColor,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                  onPressed: () => typeData("costInc"),
                                  icon: const Icon(Icons.edit),
                                ),
                              ],
                            ),
                            MyText(
                              text: "includingGears".tr(),
                              //'River Rafting',
                              //weight: FontWeight.w700,
                              color: redColor,
                              size: 14,
                            ),
                          ],
                        ),
                        Container(
                          color: blackColor,
                          width: 0.5,
                          height: 55,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  visualDensity: VisualDensity.compact,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0))),
                                  value: false,
                                  onChanged: (value) => {},
                                ),
                                MyText(
                                  text:
                                      "${widget.gm.currency}  ${widget.gm.costExc}",
                                  //'River Rafting',
                                  weight: FontWeight.bold,
                                  color: bluishColor,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                  onPressed: () => typeData("costExl"),
                                  icon: const Icon(Icons.edit),
                                ),
                              ],
                            ),
                            MyText(
                              text: "excludingGears".tr(),
                              //'River Rafting',
                              //  weight: FontWeight.w700,
                              color: redColor,
                              size: 14,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // if (widget.gm.sPlan == 2)
                    //   Column(
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           MyText(
                    //             text: "${"Start Date : "} $st",
                    //             //'River Rafting',
                    //             //weight: FontWeight.w700,
                    //             color: blackColor,
                    //             size: 14,
                    //           ),
                    //           MyText(
                    //             text: "${"End Date : "} $ed",
                    //             //'River Rafting',
                    //             //weight: FontWeight.w700,
                    //             color: blackColor,
                    //             size: 14,
                    //           ),
                    //         ],
                    //       ),
                    //       const SizedBox(
                    //         height: 10,
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //         children: [
                    //           Expanded(
                    //             child: GestureDetector(
                    //               onTap: () =>
                    //                   _selectDate(context, formattedDate),
                    //               child: Container(
                    //                 height: 50,
                    //                 padding:
                    //                     const EdgeInsets.symmetric(vertical: 0),
                    //                 //width: MediaQuery.of(context).size.width / 1,
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(10),
                    //                   color: lightGreyColor,
                    //                   border: Border.all(
                    //                     width: 1,
                    //                     color: greyColor.withOpacity(0.2),
                    //                   ),
                    //                 ),
                    //                 child: ListTile(
                    //                   contentPadding:
                    //                       const EdgeInsets.symmetric(
                    //                           vertical: 0, horizontal: 10),
                    //                   leading: Text(
                    //                     formattedDate.toString().tr(),
                    //                     style: TextStyle(
                    //                         color: blackColor.withOpacity(0.6),
                    //                         fontSize: 14),
                    //                   ),
                    //                   trailing: Icon(
                    //                     Icons.calendar_today,
                    //                     color: blackColor.withOpacity(0.6),
                    //                     size: 20,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           const SizedBox(
                    //             width: 10,
                    //           ),
                    //           Expanded(
                    //             child: GestureDetector(
                    //               onTap: () => _selectDate(context, endDate),
                    //               child: Container(
                    //                 height: 50,
                    //                 padding:
                    //                     const EdgeInsets.symmetric(vertical: 0),
                    //                 //width: MediaQuery.of(context).size.width / 1,
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(10),
                    //                   color: lightGreyColor,
                    //                   border: Border.all(
                    //                     width: 1,
                    //                     color: greyColor.withOpacity(0.2),
                    //                   ),
                    //                 ),
                    //                 child: ListTile(
                    //                   contentPadding:
                    //                       const EdgeInsets.symmetric(
                    //                           vertical: 0, horizontal: 10),
                    //                   leading: Text(
                    //                     endDate.toString(),
                    //                     style: TextStyle(
                    //                         color: blackColor.withOpacity(0.6),
                    //                         fontSize: 14),
                    //                   ),
                    //                   trailing: Icon(
                    //                     Icons.calendar_today,
                    //                     color: blackColor.withOpacity(0.6),
                    //                     size: 20,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // if (widget.gm.sPlan == 1)
                    //   Container(
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(12)),
                    //     padding: const EdgeInsets.all(12),
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           children: [
                    //             Expanded(
                    //               child: RichText(
                    //                 text: TextSpan(
                    //                   text: 'Availability'.tr(),
                    //                   style: const TextStyle(
                    //                       color: bluishColor,
                    //                       fontSize: 14,
                    //                       fontWeight: FontWeight.bold,
                    //                       fontFamily: 'Raleway'),
                    //                   children: <TextSpan>[
                    //                     TextSpan(
                    //                         text: aPlan,
                    //                         style: const TextStyle(
                    //                             fontSize: 14,
                    //                             fontWeight: FontWeight.w400,
                    //                             color: blackColor,
                    //                             fontFamily: 'Raleway')),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //             const SizedBox(
                    //               width: 5,
                    //             ),
                    //             IconButton(
                    //               onPressed: () => setEdit("daysValue"),
                    //               icon: const Icon(Icons.edit),
                    //             ),
                    //           ],
                    //         ),
                    //         const SizedBox(
                    //           height: 5,
                    //         ),
                    //         if (editDay)
                    //           Column(
                    //             children: [
                    //               Wrap(
                    //                 direction: Axis.horizontal,
                    //                 children: List.generate(
                    //                   days.length,
                    //                   (index) {
                    //                     return Column(
                    //                       children: [
                    //                         MyText(
                    //                           text: days[index],
                    //                           color: blackTypeColor,
                    //                           align: TextAlign.center,
                    //                           size: 14,
                    //                           weight: FontWeight.w500,
                    //                         ),
                    //                         Checkbox(
                    //                           activeColor: Colors.green,
                    //                           checkColor: whiteColor,
                    //                           value: daysValue[index],
                    //                           onChanged: (bool? value) {
                    //                             setState(
                    //                               () {
                    //                                 daysValue[index] = value!;
                    //                               },
                    //                             );
                    //                           },
                    //                         ),
                    //                       ],
                    //                     );
                    //                   },
                    //                 ),
                    //               ),
                    //               const SizedBox(
                    //                 height: 5,
                    //               ),
                    //               ElevatedButton(
                    //                   style: ElevatedButton.styleFrom(
                    //                     backgroundColor:
                    //                         greenishColor, // Background color
                    //                   ),
                    //                   onPressed: servicePlan,
                    //                   child: const Text(
                    //                     "Edit",
                    //                     style: TextStyle(color: Colors.white),
                    //                   ))
                    //             ],
                    //           ),
                    //       ],
                    //     ),
                    //   ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        MyText(
                          text: "activitiesIncludes".tr(),
                          color: bluishColor,
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () => addActivites("activities", ""),
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      children: [
                        for (int i = 0;
                            i < widget.gm.activityIncludes.length;
                            i++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.network(
                                  "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.activityIncludes[i].image}",
                                  height: 42,
                                  width: 42,
                                ),
                                const SizedBox(width: 5),
                                MyText(
                                  text: widget.gm.activityIncludes[i].activity
                                      .tr(),
                                  color: blackColor, //greyTextColor,
                                  // weight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(vertical: 10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           MyText(
                    //               text: 'activitiesIncludes'.tr(),
                    //               weight: FontWeight.bold,
                    //               color: blackTypeColor1),
                    //           MyText(
                    //               text:
                    //                   "$activitiesLength ${"activitiesIncludes".tr()}",
                    //               weight: FontWeight.bold,
                    //               color: blackTypeColor),
                    //         ],
                    //       ),
                    //       Button(
                    //           'addActivities',
                    //           bluishColor,
                    //           bluishColor,
                    //           whiteColor,
                    //           14,
                    //           addActivitesButton,
                    //           Icons.arrow_forward,
                    //           whiteColor,
                    //           true,
                    //           2.5,
                    //           'Roboto',
                    //           FontWeight.w400,
                    //           16),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      thickness: 1,
                      color: blackColor.withOpacity(0.2),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        MyText(
                          text: "description".tr(),
                          color: bluishColor,
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          onPressed: () => typeData("description"),
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MyText(
                      text: widget.gm.writeInformation,
                      color: blackColor,
                      // weight: FontWeight.w500,
                      size: 14,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: blackColor.withOpacity(0.2),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        MyText(
                          text: "audience".tr(),
                          color: bluishColor,
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () => addActivites("audience", ""),
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      children: [
                        for (int i = 0; i < widget.gm.am.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 6),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.network(
                                  "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.am[i].image}",
                                  height: 42,
                                  width: 42,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                MyText(
                                  text: widget.gm.am[i].aimedName,
                                  //text: aimedFor[index],
                                  color: blackColor,
                                  // weight: FontWeight.w700,
                                  fontFamily: 'Roboto',
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: blackColor.withOpacity(0.2),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        MyText(
                          text: "dependency".tr(),
                          color: bluishColor,
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          onPressed: () => addActivites("dependency", ""),
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(children: [
                      for (int i = 0; i < widget.gm.dependency.length; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 6),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(
                                "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.dependency[i].name}",
                                height: 42,
                                width: 42,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              MyText(
                                text: widget.gm.dependency[i].dName.tr(),
                                //text: aimedFor[index],
                                color: blackColor,
                                //weight: FontWeight.w700,
                                fontFamily: 'Roboto',
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: blackColor.withOpacity(0.2),
                    ),
                    Row(
                      children: [
                        MyText(
                          text: "prerequisites",
                          color: bluishColor,
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          onPressed: () => typeData("prerequisites"),
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MyText(
                      text: widget.gm.preRequisites,
                      color: blackColor,
                      //weight: FontWeight.w500,
                      size: 14,
                    ),
                    // ServicesPlans(widget.gm.sPlan, widget.gm.programmes),
                    Divider(
                      thickness: 1,
                      color: blackColor.withOpacity(0.2),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        MyText(
                          text: "minimumRequirements",
                          color: bluishColor,
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          onPressed: () => typeData("minimumRequirements"),
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MyText(
                      text: widget.gm.mRequirements,
                      color: blackColor,
                      //weight: FontWeight.w500,
                      size: 14,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: blackColor.withOpacity(0.2),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        MyText(
                          text: "termsAndConditions",
                          color: bluishColor,
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          onPressed: () => typeData("terms"),
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MyText(
                      text: widget.gm.tnc,
                      color: blackColor,
                      //weight: FontWeight.w500,
                      size: 14,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
