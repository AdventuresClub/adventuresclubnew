import 'package:adventuresclub/app_theme.dart';
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
import 'package:adventuresclub/widgets/buttons/button.dart';
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
  DateTime endDate = DateTime.now();
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

  void typeData(String type) {
    TextEditingController controller = TextEditingController();
    String title = "";
    String hint = "";
    if (type == "adventureName") {
      nameController = controller;
      title = widget.gm.adventureName;
      hint = "Adventure Name";
    }
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: ((context, setState) {
              return Dialog(
                backgroundColor: Colors.white,
                child: Card(
                  child: Column(
                    children: [
                      MyText(
                        text: title,
                        color: blackColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: hint,
                          hintStyle: const TextStyle(color: blackTypeColor4),
                          border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: greyColor.withOpacity(0.2)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: greyColor.withOpacity(0.2)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: greyColor.withOpacity(0.2)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () => editService("name"),
                          child: const Text("Update"))
                    ],
                  ),
                ),
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
    dataListBool.clear();
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
      for (var element in activitiesFilter) {
        dataList.add(DisplayDataModel(
            id: element.id.toString(),
            image: element.image,
            title: element.activity));
        for (var e in widget.gm.activityIncludes) {
          if (e.activity == element.activity) {
            dataListBool.add(true);
          } else {
            dataListBool.add(false);
          }
        }
      }
    } else if (type == "audience") {
      for (var element in aimedFilter) {
        dataList.add(DisplayDataModel(
            id: element.id.toString(),
            image: element.image,
            title: element.aimedName));
        // if (element.aimedName == title) {
        //   dataListBool.add(true);
        // } else {
        //   dataListBool.add(false);
        // }
        for (var e in widget.gm.am) {
          if (e.aimedName == element.aimedName) {
            dataListBool.add(true);
          } else {
            dataListBool.add(false);
          }
        }
      }
    } else if (type == "dependency") {
      for (var element in dependencyList) {
        dataList.add(DisplayDataModel(
            id: element.id.toString(), image: "", title: element.dName));
        // if (element.aimedName == title) {
        //   dataListBool.add(true);
        // } else {
        //   dataListBool.add(false);
        // }
        for (var e in widget.gm.dependency) {
          if (e.dName == element.dName) {
            dataListBool.add(true);
          } else {
            dataListBool.add(false);
          }
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
                                          setState(() {
                                            for (int i = 0;
                                                i < dataListBool.length;
                                                i++) {
                                              dataListBool[i] = (i == index);
                                            }
                                            // for (int j = 0;
                                            //     j < dataListBool.length;
                                            //     j++) {
                                            //   if (i == dataListBool[i]) {
                                            //     dataListBool[i] = true;
                                            //   } else {
                                            //     dataListBool[j] = false;
                                            //   }
                                            // }
                                            //   // if (dataListBool[i]) {
                                            //   // } else {
                                            //   //   dataListBool[i] = false;
                                            //   // }
                                            // }

                                            //removeId(activitiesFilter[i].id);
                                          });
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
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 30.0, vertical: 15),
                              //   child: Button(
                              //       'done'.tr(),
                              //       greenishColor,
                              //       greyColorShade400,
                              //       whiteColor,
                              //       16,
                              //       () {},
                              //       Icons.add,
                              //       whiteColor,
                              //       false,
                              //       1.3,
                              //       'Raleway',
                              //       FontWeight.w600,
                              //       16),
                              // ),
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
      activityValue.add(false);
    }
  }

  void editService(String type) async {
    dynamic b = {};
    if (type == "category") {
      String categoryId = "";
      for (int i = 0; i < dataListBool.length; i++) {
        if (dataListBool[i]) {
          categoryId = dataList[i].id;
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
        }
      }
      b = {
        'service_id': widget.gm.id.toString(),
        'customer_id': widget.gm.providerId.toString(),
        "service_type": typeId
      };
    }

    try {
      var response = await http.post(
        Uri.parse("${Constants.baseUrl}/api/v1/edit_service"), body: b,
        //     {
        //   'service_id': widget.gm.id.toString(),
        //   'customer_id':
        //       widget.gm.providerId.toString(), //Constants.userId.toString(),
        //   'adventure_name': nameController.text.trim(), //ccCode.toString(),
        // },
      );
      if (response.statusCode == 200) {
        debugPrint(response.body);
      }
      print(response.statusCode);
    } catch (e) {
      print(e.toString());
    }
  }

  void getSteps() {
    for (var element in widget.gm.availabilityPlan) {
      adventuresPlan.add(element.day.tr());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 140,
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                          ? () => addActivites("category", categoryList[i])
                          : i == 1
                              ? () => addActivites("sector", categoryList[i])
                              : i == 2
                                  ? () => addActivites("type", categoryList[i])
                                  : () =>
                                      addActivites("level", categoryList[i]),
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
                          icon: const Icon(Icons.edit))
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            value: false,
                            onChanged: (value) {},
                          ),
                          MyText(
                            text: "${widget.gm.currency}  ${widget.gm.costInc}",
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            value: false,
                            onChanged: (value) => {},
                          ),
                          MyText(
                            text: "${widget.gm.currency}  ${widget.gm.costExc}",
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
              if (widget.gm.sPlan == 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: "${"Start Date : "} $st",
                      //'River Rafting',
                      //weight: FontWeight.w700,
                      color: blackColor,
                      size: 14,
                    ),
                    MyText(
                      text: "${"End Date : "} $ed",
                      //'River Rafting',
                      //weight: FontWeight.w700,
                      color: blackColor,
                      size: 14,
                    ),
                  ],
                ),
              if (widget.gm.sPlan == 1)
                RichText(
                  text: TextSpan(
                    text: 'Availability'.tr(),
                    style: const TextStyle(
                        color: bluishColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway'),
                    children: <TextSpan>[
                      TextSpan(
                          text: aPlan,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: blackColor,
                              fontFamily: 'Raleway')),
                    ],
                  ),
                ),
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
                        addActivitesButton,
                        Icons.arrow_forward,
                        whiteColor,
                        true,
                        2.5,
                        'Roboto',
                        FontWeight.w400,
                        16),
                  ],
                ),
              ),
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
                    text: "activitiesIncludes".tr(),
                    color: bluishColor,
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(
                    width: 5,
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
                  for (int i = 0; i < widget.gm.activityIncludes.length; i++)
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
                            text: widget.gm.activityIncludes[i].activity.tr(),
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
              ServicesPlans(widget.gm.sPlan, widget.gm.programmes),
              Divider(
                thickness: 1,
                color: blackColor.withOpacity(0.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
