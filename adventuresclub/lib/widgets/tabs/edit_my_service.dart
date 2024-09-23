import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/filter_data_model/category_filter_model.dart';
import 'package:adventuresclub/models/filter_data_model/display_data_model.dart';
import 'package:adventuresclub/models/filter_data_model/level_filter_mode.dart';
import 'package:adventuresclub/models/filter_data_model/sector_filter_model.dart';
import 'package:adventuresclub/models/filter_data_model/service_types_filter.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_service_banner_container.dart';
import 'package:adventuresclub/widgets/my_text.dart';
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
  List<DisplayDataModel> dataList = [];
  List<bool> dataListBool = [];

  @override
  void initState() {
    categoryList.add(widget.gm.serviceCategory);
    categoryList.add(widget.gm.serviceSector);
    categoryList.add(widget.gm.serviceType);
    categoryList.add(widget.gm.serviceLevel);
    getData();
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
    //   activitiesFilter = Constants.activitiesFilter;
    //   parseActivity(Constants.activitiesFilter);
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
                          onPressed: editService, child: const Text("Update"))
                    ],
                  ),
                ),
              );
            }),
          );
        });
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 10),
                                child: MyText(
                                    text: type.tr(),
                                    weight: FontWeight.bold,
                                    color: blackColor,
                                    size: 16,
                                    fontFamily: 'Raleway'),
                              ),
                              const SizedBox(height: 20),
                              for (int i = 0; i < dataList.length; i++)
                                SizedBox(
                                  //width: MediaQuery.of(context).size.width / 1,
                                  child: Column(
                                    children: [
                                      CheckboxListTile(
                                        secondary: Image.network(
                                          //   "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${widget.gm.serviceCategoryImage}",
                                          "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${dataList[i].image}",
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
                                        selected: dataListBool[i],
                                        value: dataListBool[i],
                                        onChanged: (value) {
                                          setState(() {
                                            dataListBool[i] = !dataListBool[i];
                                            //removeId(activitiesFilter[i].id);
                                          });
                                        },
                                        title: MyText(
                                          text: dataList[i].title.tr(),
                                          color: greyColor,
                                          fontFamily: 'Raleway',
                                          size: 18,
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 15),
                                child: Button(
                                    'done'.tr(),
                                    greenishColor,
                                    greyColorShade400,
                                    whiteColor,
                                    16,
                                    () {},
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

  void editService() async {
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/edit_service"), body: {
        'service_id': widget.gm.id.toString(),
        'customer_id': Constants.userId.toString(),
        'adventure_name': nameController.text.trim(), //ccCode.toString(),
      });
      if (response.statusCode == 200) {
        debugPrint(response.body);
      }
      print(response.statusCode);
    } catch (e) {
      print(e.toString());
    }
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
                      icon: const Icon(Icons.edit))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
