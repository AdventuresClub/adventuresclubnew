// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:adventuresclub/become_a_partner/create_services/create_program.dart';
import 'package:adventuresclub/become_a_partner/create_services/create_services_description.dart';
import 'package:adventuresclub/complete_profile/banner_page.dart';
import 'package:adventuresclub/complete_profile/cost.dart';
import 'package:adventuresclub/complete_profile/program.dart';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_create_new_services.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/models/services/create_services/create_services_program%20_model.dart';
import 'package:adventuresclub/models/services/dependencies_model.dart';
import 'package:adventuresclub/widgets/buttons/bottom_button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:http/http.dart' as http;

class CreateNewServices extends StatefulWidget {
  const CreateNewServices({super.key});

  @override
  State<CreateNewServices> createState() => _CreateNewServicesState();
}

class _CreateNewServicesState extends State<CreateNewServices> {
  TextEditingController adventureName = TextEditingController();
  TextEditingController availableSeatsController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  TextEditingController scheduleController1 = TextEditingController();
  TextEditingController scheduleController2 = TextEditingController();
  TextEditingController scheduleController3 = TextEditingController();
  TextEditingController scheduleController4 = TextEditingController();
  TextEditingController scheduleDescription = TextEditingController();
  TextEditingController scheduleDescription1 = TextEditingController();
  TextEditingController scheduleDescription2 = TextEditingController();
  TextEditingController scheduleDescription3 = TextEditingController();
  TextEditingController scheduleDescription4 = TextEditingController();
  TextEditingController iLiveInController = TextEditingController();
  TextEditingController specificAddressController = TextEditingController();
  TextEditingController costOne = TextEditingController();
  TextEditingController costTwo = TextEditingController();
  TextEditingController preRequisites = TextEditingController();
  TextEditingController minimumRequirement = TextEditingController();
  TextEditingController terms = TextEditingController();
  TextEditingController daysExpiry = TextEditingController();
  String selectedRegion = "";
  int selectedSectorId = 0;
  List text = ['Banner', 'Description', 'Program', 'Cost/GeoLoc'];
  List text1 = ['1', '2', '3', '4'];
  int count = 0;
  int i = 1;
  List<File> imageList = [];
  List<AimedForModel> aimedFilter = [];
  List<DependenciesModel> dependencyList = [];
  List<bool> aimedValue = [];
  List<bool> dependencyValue = [];
  List aimedText = [];
  List dependencyText = [];
  List days = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];
  List<bool> daysValue = [false, false, false, false, false, false, false];
  List<String> servicePlanDays = [];
  List<int> servicePlanDaysId = [];
  bool particularDay = false;
  // bool particularWeekDay = false;
  bool particularWeekDays = true;
  bool particularWeek = true;
  DateTime? pickedDate;
  var formattedDate;
  var endDate;
  // var startTime;
  // var endTime;
  DateTime currentDate = DateTime.now();
  String selectedActivitesId = "";
  String selectedDependencyId = "";
  String servicePlanId = "";
  String selectedActivityIncludesId = "";
  int sPlan = 0;
  List<String> titleHeading = [
    "Schedule Title",
  ];
  List<String> descriptionHeading = ["Schedule Description"];
  List<TextEditingController> titleController = [];
  List<TextEditingController> scheduleControllerList = [];
  bool loading = false;
  List<String> sTitle = [];
  List<String> sSchedule = [];
  List<String> sDate = [];
  List<String> sTime = [];
  String title = "";
  String schedule = "";
  String programsDate = "";
  String programeTime = "";
  TimeOfDay time = TimeOfDay.now();
  bool planChecked = false;
  List<CreateServicesProgramModel> pm = [];
  String programSchedule = "";
  String programTitle = "";
  String programSelecteDate1 = "";
  String programSelecteDate2 = "";
  String programStartTime1 = "";
  String programStartTime2 = "";
  String programEndTime = "";
  Duration timeSt = const Duration();
  Duration endSt = const Duration();
  List<String> st = [];
  List<String> et = [];
  List<String> titleList = [];
  List<String> descriptionList = [];
  List<String> d = [];

  @override
  void initState() {
    super.initState();
    DateTime dt = DateTime(currentDate.year, currentDate.month, currentDate.day,
        time.hour, time.minute);
    formattedDate = 'Start Date';
    endDate = "End Date";
    getData();
    addProgramData();
  }

  void getProgramData(CreateServicesProgramModel data, int index) {
    pm[index] = data;
    //  pm.add(data);
  }

  void addProgramData() {
    setState(() {
      pm.add(CreateServicesProgramModel(
          "", DateTime.now(), const Duration(), const Duration(), ""));
    });
  }

  @override
  void dispose() {
    infoController.dispose();
    adventureName.dispose();
    availableSeatsController.dispose();
    scheduleController.dispose();
    scheduleController1.dispose();
    scheduleController2.dispose();
    scheduleController3.dispose();
    scheduleController4.dispose();
    scheduleDescription.dispose();
    scheduleDescription1.dispose();
    scheduleDescription2.dispose();
    scheduleDescription3.dispose();
    scheduleDescription4.dispose();
    iLiveInController.dispose();
    specificAddressController.dispose();
    costOne.dispose();
    costTwo.dispose();
    preRequisites.dispose();
    minimumRequirement.dispose();
    terms.dispose();
    daysExpiry.dispose();
    super.dispose();
  }

  void getData() {
    aimedFilter = Constants.am;
    dependencyList = Constants.dependency;
    parseAimed(Constants.am);
    parseDependency(Constants.dependency);
  }

  void parseDependency(List<DependenciesModel> dm) {
    dm.forEach((element) {
      if (element.dName.isNotEmpty) {
        dependencyText.add(element.dName);
      }
    });
    dependencyText.forEach((element) {
      dependencyValue.add(false);
    });
  }

  void dependency() {
    List<DependenciesModel> f = [];
    for (int i = 0; i < dependencyValue.length; i++) {
      if (dependencyValue[i]) {
        f.add(dependencyList[i]);
      }
    }
    dependencyParse(f);
  }

  void dependencyParse(List<DependenciesModel> am) async {
    List<String> a = [];
    List<int> id = [];
    am.forEach((element) {
      a.add(element.dName);
      id.add(element.id);
    });
    // String resultString = id.join(",");
    setState(() {
      selectedDependencyId = id.join(",");
    });
    print(selectedDependencyId);
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
    setState(() {
      selectedActivitesId = id.join(",");
    });
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
    pDays.forEach((element) {
      if (element == "Mon") {
        id.add(2);
      } else if (element == "Tue") {
        id.add(3);
      } else if (element == "Wed") {
        id.add(4);
      } else if (element == "Thur") {
        id.add(5);
      } else if (element == "Fri") {
        id.add(6);
      } else if (element == "Sat") {
        id.add(7);
      } else if (element == "Sun") {
        id.add(1);
      }
    });
    setState(() {
      servicePlanId = id.join(",");
    });
    print(servicePlanId);
  }

  void checkPlan() {
    if (count == 1 && sPlan == 2) {
      if (ConstantsCreateNewServices.startDate.isNotEmpty &&
          ConstantsCreateNewServices.endDate.isNotEmpty) {
        setState(() {
          planChecked = true;
        });
      } else if (ConstantsCreateNewServices.startDate.isEmpty) {
        message("Start Date Cannot be empty");
      } else if (ConstantsCreateNewServices.endDate.isEmpty) {
        message("End Date Cannot be empty");
      }
    }
  }

  void next() async {
    checkPlan();
    if (count == 0
        //&& imageList.isNotEmpty
        ) {
      setState(() {
        count++;
      });
    }
    // else if (imageList.isEmpty) {
    //   message("Images cannot be empty");
    // }
    else if (count == 1 &&
        adventureName.text.isNotEmpty &&
        ConstantsCreateNewServices.selectedRegionId > 0 &&
        ConstantsCreateNewServices.selectedSectorId > 0 &&
        ConstantsCreateNewServices.selectedCategoryId > 0 &&
        ConstantsCreateNewServices.serviceTypeId > 0 &&
        ConstantsCreateNewServices.selectedDurationId > 0 &&
        ConstantsCreateNewServices.selectedlevelId > 0 &&
        availableSeatsController.text.isNotEmpty &&
        sPlan > 0 &&
        planChecked) {
      await convertProgramData();
      aimed();
      servicePlan();
      dependency();
      setState(() {
        count++;
      });
    } else if (adventureName.text.isEmpty) {
      message("Please enter the adventure name");
    } else if (ConstantsCreateNewServices.selectedRegionId == 0) {
      message("Please select region");
    } else if (ConstantsCreateNewServices.selectedSectorId == 0) {
      message("Please select service sector");
    } else if (ConstantsCreateNewServices.selectedCategoryId == 0) {
      message("Please select category");
    } else if (ConstantsCreateNewServices.serviceTypeId == 0) {
      message("Please select service type");
    } else if (ConstantsCreateNewServices.selectedDurationId == 0) {
      message("Please select duration");
    } else if (ConstantsCreateNewServices.selectedlevelId == 0) {
      message("Please select level");
    } else if (availableSeatsController.text.isEmpty) {
      message("Please add availaible seats");
    } else if (sPlan == 0) {
      message("Please select from the service plan");
    } else if (count == 2 && pm.isNotEmpty) {
      setState(() {
        count++;
      });
    } else if (pm.isEmpty) {
      message("Please enter program");
    } else if (count == 3 &&
        // ConstantsCreateNewServices.lat > 0 &&
        // ConstantsCreateNewServices.lng >  &&
        specificAddressController.text.isNotEmpty &&
        costOne.text.isNotEmpty &&
        costTwo.text.isNotEmpty &&
        preRequisites.text.isNotEmpty &&
        minimumRequirement.text.isNotEmpty) {
      //convertProgramData();
      createService();
    }
    // else if (ConstantsCreateNewServices.lat < 0) {
    //   message("Please enter geolocation");
    // } else if (ConstantsCreateNewServices.lng < 0) {
    //   message("Please enter geolocation");
    // }
    else if (specificAddressController.text.isEmpty) {
      message("Specific Address Cannot be empty");
    } else if (costOne.text.isEmpty) {
      message("Please set cost one");
    } else if (costTwo.text.isEmpty) {
      message("Please set cost two");
    } else if (preRequisites.text.isEmpty) {
      message("Please Type prerequisites");
    } else if (minimumRequirement.text.isEmpty) {
      message("Please Type Minimum Requirements");
    } else if (terms.text.isEmpty) {
      message("Please Type Terms");
    }
  }

  void previous() {
    if (count == 0) {
      Navigator.of(context).pop();
    }
    setState(() {
      count--;
    });
  }

  void getImages(List<File> imgList) {
    imageList = imgList;
  }

  Future<void> convertProgramData() async {
    pm.forEach((element) {
      titleList.add(element.title);
    });
    //programTitle = titleList.join(",");
    pm.forEach((element) {
      descriptionList.add(element.description);
    });
    // programSchedule = descriptionList.join(",");
    pm.forEach((element) {
      d.add(element.startDate.toString());
    });
    // programSelecteDate1 = d.join(",");
    pm.forEach((element) {
      st.add(element.startDate.toString());
    });
    // programStartTime1 = st.join(",");
    pm.forEach((element) {
      et.add(element.endTime.toString());
    });
    //programEndTime = et.join(",");
  }

  void createService() async {
    await convertProgramData();
    selectedActivityIncludesId =
        ConstantsCreateNewServices.selectedActivitesId.join(",");
    List<Uint8List> banners = [];
    imageList.forEach((element) {
      banners.add(element.readAsBytesSync());
    });
    try {
      // if (selectedActivityIncludesId.isNotEmpty) {
      // if (selectedActivitesId.isNotEmpty) {
      //if (selectedDependencyId.isNotEmpty) {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse(
            "https://adventuresclub.net/adventureClub/api/v1/create_service"),
      );
      String fileName =
          "${DateTime.now().millisecondsSinceEpoch.toString()}.png";
      request.files.add(http.MultipartFile.fromBytes('banner[]', banners[0],
          filename: fileName));
      dynamic programData = {
        'customer_id': Constants.userId.toString(),
        'adventure_name': adventureName.text,
        "country": Constants.countryId.toString(),
        'region': ConstantsCreateNewServices.selectedRegionId
            .toString(), //selectedRegionId.toString(),
        "service_sector": ConstantsCreateNewServices.selectedSectorId
            .toString(), //selectedSectorId.toString(), //"",
        "service_category": ConstantsCreateNewServices.selectedCategoryId
            .toString(), //"", //selectedCategoryId.toString(), //"",
        "service_type": ConstantsCreateNewServices.serviceTypeId
            .toString(), // //serviceTypeId.toString(), //"",
        "service_level": ConstantsCreateNewServices.selectedlevelId
            .toString(), //selectedlevelId.toString(), //"",
        "duration": ConstantsCreateNewServices.selectedDurationId
            .toString(), //selectedDurationId.toString(), //"",
        "available_seats": availableSeatsController.text, //"",
        "start_date":
            ConstantsCreateNewServices.startDate.toString(), //startDate, //"",
        "end_date":
            ConstantsCreateNewServices.endDate.toString(), //endDate, //"",
        "write_information": infoController.text, //infoController.text, //"",
        // it is for particular week or calender
        "service_plan": sPlan.toString(), //"1", //"",
        "cost_inc": costOne.text, //setCost1.text, //"",
        "cost_exc": costTwo.text, //setCost2.text, //"",
        "currency": "1", //  %%% this is hardcoded
        "pre_requisites":
            preRequisites.text, //"", //preReqController.text, //"",
        "minimum_requirements":
            minimumRequirement.text, //minController.text, //"",
        "terms_conditions": terms.text, //tncController.text, //"",
        "recommended": "1", // this is hardcoded
        // this key needs to be discussed,
        "service_plan_days": servicePlanId, //selectedActivitesId
        //.toString(), //"1,6,7", //// %%%%this needs discussion
        // "availability": servicePlanId,
        "service_for": selectedActivitesId, //selectedActivitesId.toString(),
        "particular_date":
            ConstantsCreateNewServices.startDate, //gatheringDate, //"",
        // this is an array
        // "schedule_title[]":
        //   programTitle, //titleController, //scheduleController.text, //scheduleController.text, //"",
        // schedule title in array is skipped
        // this is an array
        //"gathering_date[]": programSelecteDate1, //gatheringDate, //"",
        // api did not accept list here
        "activities": selectedActivityIncludesId, //"5", // activityId, //"",
        "specific_address": specificAddressController
            .text, //"", //iLiveInController.text, //"",
        // this is a wrong field only for testing purposes....
        // this is an array
        //"gathering_start_time[]": programStartTime2, //"10",
        // this is an arrayt
        //"gathering_end_time[]": programEndTime, //"15",
        "" //gatheringDate, //"",
                // this is an array
                // "program_description[]":
                //"scheule 2 , schule 1", // scheduleControllerList, //scheduleDesController.text, //"",
                // "service_for": selectedActivitesId
                //     .toString(), //"1,2,5", //"4", //["1", "4", "5", "7"], //"",
                "dependency":
            selectedDependencyId, //selectedDependencyId.toString(), //["1", "2", "3"],
        //"banners[]": "${banners[0]},test032423231108.png",
        //"banner[]":
        //"${banners[0]},test0324232311147.png", //adventureOne.toString(), //"",
        // banner image name.
        // we need file name,
        // after bytes array when adding into parameter. send the name of file.
        //
        "latitude":
            ConstantsCreateNewServices.lat.toString(), //lat.toString(), //"",
        "longitude":
            ConstantsCreateNewServices.lng.toString(), //lng.toString(), //"",
        // 'mobile_code': ccCode,
      };
      st.forEach((element) {
        programData["gathering_start_time[]"] = element;
      });
      et.forEach((element) {
        programData["gathering_end_time[]"] = element;
      });
      titleList.forEach((element) {
        programData["schedule_title[]"] = element;
      });
      descriptionList.forEach((element) {
        programData["program_description[]"] = element;
      });
      d.forEach((element) {
        programData["gathering_date[]"] = element;
      });
      request.fields.addAll(programData);
      final response = await request.send();

      log(response.toString());
      print(response.statusCode);
      // print(response.body);
      print(response.headers);
      close();
      // } else {
      //   message("Please choose dependencies");
      // }
      // } else {
      //   message("Please choose aimed for");
      // }
      // } else {
      //   message("Please select Activities");
      // }
    } catch (e) {
      print(e.toString());
    }
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void close() {
    Navigator.of(context).pop();
  }

  Future<void> _selectDate(BuildContext context, var givenDate) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      if (givenDate == 'Start Date') {
        setState(() {
          var date = DateTime.parse(pickedDate.toString());
          String m = date.month < 10 ? "0${date.month}" : "${date.month}";
          String d = date.day < 10 ? "0${date.day}" : "${date.day}";
          formattedDate = "${date.year}-$m-$d";
        });
      } else if (givenDate == "End Date") {
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
      ConstantsCreateNewServices.endDate = eDate;
    });
  }

  void changeStatus() {
    setState(() {
      loading = false;
    });
  }

  void addProgram() {
    if (ConstantsCreateNewServices.particularWeekDays) {}
  }

  void addFields() {
    if (i == 1) {
      setState(() {
        i = 2;
        titleHeading.add("Schedule Title");
        descriptionHeading.add("Schedule Description");
        titleController.add(scheduleController1);
        scheduleControllerList.add(scheduleDescription1);
      });
    } else if (i == 2) {
      setState(() {
        i = 3;
        titleHeading.add("Schedule Title");
        descriptionHeading.add("Schedule Description");
        titleController.add(scheduleDescription2);
        scheduleControllerList.add(scheduleDescription2);
      });
    } else if (i == 3) {
      setState(() {
        loading = true;
        i = 4;
        titleHeading.add("Schedule Title");
        descriptionHeading.add("Schedule Description");
        titleController.add(scheduleDescription3);
        scheduleControllerList.add(scheduleDescription3);
      });
    } else if (i == 4) {
      setState(() {
        loading = true;
        i = 5;
        titleHeading.add("Schedule Title");
        descriptionHeading.add("Schedule Description");
        titleController.add(scheduleDescription4);
        scheduleControllerList.add(scheduleDescription4);
      });
    } else if (i == 5) {
      message("Maximum of 5 are allowed");
    }
  }

  void setId() {
    if (particularWeekDays) {
      setState(() {
        sPlan = 1;
      });
    } else if (particularDay) {
      setState(() {
        sPlan = 2;
      });
    } else {
      setState(() {
        sPlan = 0;
      });
    }
    print("${"this is a plan id"}${sPlan}");
  }

  void addServicePlan() {
    setState(() {
      ConstantsCreateNewServices.particularWeekDays =
          !ConstantsCreateNewServices.particularWeekDays;
      particularWeekDays = !particularWeekDays;
    });
    setId();
  }

  void daysPlan() {
    setState(() {
      particularDay = !particularDay;
      particularWeek = !particularWeek;
    });
    setId();

    //print("${"this is a plan id"}${sPlan}");
    // if (particularWeekDays == false) {
    //   daysValue.forEach((element) {
    //     setState(() {
    //       element == false;
    //     });
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1.5,
          centerTitle: true,
          leading: IconButton(
            icon: Image.asset(
              'images/backArrow.png',
              height: 20,
            ),
            onPressed: previous, //() => Navigator.of(context).pop(),
          ),
          title: MyText(
            text: 'Create Adventure',
            color: bluishColor,
            weight: FontWeight.bold,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: MyText(
                  text:
                      'Just follow simple four steps to list up your adventure',
                  size: 14,
                  weight: FontWeight.w600,
                  color: greyColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              StepProgressIndicator(
                padding: 0,
                totalSteps: text1.length,
                currentStep: count + 1,
                size: 60,
                selectedColor: bluishColor,
                unselectedColor: greyColor,
                customStep: (index, color, _) => color == bluishColor
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                    color: bluishColor,
                                    borderRadius: BorderRadius.circular(65)),
                                child: Center(
                                    child: MyText(
                                  text: text1[index],
                                  color: whiteColor,
                                  weight: FontWeight.w700,
                                  fontFamily: 'Roboto',
                                  size: 12,
                                )),
                              ),
                              const Expanded(
                                child: Divider(
                                  color: bluishColor,
                                  thickness: 7,
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: MyText(
                              text: text[index],
                              color: bluishColor,
                              weight: FontWeight.w700,
                              fontFamily: 'Roboto',
                              size: 12,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                    color: greyColor3,
                                    borderRadius: BorderRadius.circular(65)),
                                child: Center(
                                    child: MyText(
                                  text: text1[index],
                                  color: whiteColor,
                                  weight: FontWeight.w700,
                                  fontFamily: 'Roboto',
                                  size: 12,
                                )),
                              ),
                              if (index != 3)
                                const Expanded(
                                  child: Divider(
                                    color: greyColor,
                                    thickness: 7,
                                  ),
                                ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: MyText(
                              text: text[index],
                              color: greyColor,
                              weight: FontWeight.w700,
                              fontFamily: 'Roboto',
                              size: 12,
                            ),
                          ),
                        ],
                      ),
              ),
              //Text((selectedActivitesId.join(""))),
              Expanded(
                child: IndexedStack(
                  index: count,
                  children: [
                    BannerPage(getImages),
                    CreateServicesDescription(
                      adventureName,
                      availableSeatsController,
                      infoController,
                      Wrap(
                        direction: Axis.vertical,
                        children: List.generate(
                          aimedFilter.length,
                          (index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: CheckboxListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: 0, top: 0, bottom: 0, right: 25),
                                side: const BorderSide(color: bluishColor),
                                checkboxShape: const RoundedRectangleBorder(
                                  side: BorderSide(color: bluishColor),
                                ),
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -4),
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
                          },
                        ),
                      ),
                      daysExpiry,
                      Column(
                        children: [
                          particularWeek
                              ? Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: MyText(
                                        text: 'Service Plan',
                                        color: blackTypeColor1,
                                        align: TextAlign.center,
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 120,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                  activeColor: bluishColor,
                                                  checkColor: whiteColor,
                                                  side: const BorderSide(
                                                      color: bluishColor,
                                                      width: 2),
                                                  value: particularWeekDays,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              28)),
                                                  onChanged: (bool? value) {
                                                    addServicePlan();
                                                  }),
                                              MyText(
                                                text:
                                                    'Every particular week days',
                                                color: blackTypeColor,
                                                align: TextAlign.center,
                                                weight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                          Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                              days.length,
                                              (index) {
                                                return Column(
                                                  children: [
                                                    MyText(
                                                      text: days[index],
                                                      color: blackTypeColor,
                                                      align: TextAlign.center,
                                                      size: 14,
                                                      weight: FontWeight.w500,
                                                    ),
                                                    Checkbox(
                                                      activeColor: bluishColor,
                                                      checkColor: whiteColor,
                                                      value: daysValue[index],
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30)),
                                                      onChanged: (bool? value) {
                                                        if (particularWeekDays) {
                                                          setState(
                                                            () {
                                                              daysValue[index] =
                                                                  value!;
                                                            },
                                                          );
                                                        }
                                                        if (particularWeekDays ==
                                                            false) {
                                                          setState(() {
                                                            daysValue[index] =
                                                                false;
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          //const SizedBox(height: 20),
                          particularWeekDays == false
                              ? SizedBox(
                                  height: 110,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                              activeColor: bluishColor,
                                              checkColor: whiteColor,
                                              value: particularDay,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          28)),
                                              onChanged: (bool? value) {
                                                daysPlan();
                                              }),
                                          MyText(
                                            text:
                                                'Every particular calendar date',
                                            color: blackTypeColor,
                                            align: TextAlign.center,
                                            weight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () => _selectDate(
                                                  context, formattedDate),
                                              child: Container(
                                                height: 50,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 0),
                                                //width: MediaQuery.of(context).size.width / 1,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: lightGreyColor,
                                                  border: Border.all(
                                                    width: 1,
                                                    color: greyColor
                                                        .withOpacity(0.2),
                                                  ),
                                                ),
                                                child: ListTile(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 0,
                                                          horizontal: 10),
                                                  leading: Text(
                                                    formattedDate.toString(),
                                                    style: TextStyle(
                                                        color: blackColor
                                                            .withOpacity(0.6)),
                                                  ),
                                                  trailing: Icon(
                                                    Icons.calendar_today,
                                                    color: blackColor
                                                        .withOpacity(0.6),
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
                                              onTap: () =>
                                                  _selectDate(context, endDate),
                                              child: Container(
                                                height: 50,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 0),
                                                //width: MediaQuery.of(context).size.width / 1,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: lightGreyColor,
                                                  border: Border.all(
                                                    width: 1,
                                                    color: greyColor
                                                        .withOpacity(0.2),
                                                  ),
                                                ),
                                                child: ListTile(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 0,
                                                          horizontal: 10),
                                                  leading: Text(
                                                    endDate.toString(),
                                                    style: TextStyle(
                                                        color: blackColor
                                                            .withOpacity(0.6)),
                                                  ),
                                                  trailing: Icon(
                                                    Icons.calendar_today,
                                                    color: blackColor
                                                        .withOpacity(0.6),
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
                                )
                              : Container(),
                        ],
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
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
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
                    ),
                    Program(
                      scheduleController,
                      scheduleController1,
                      scheduleDescription,
                      scheduleDescription1,
                      Column(
                        children: [
                          for (int z = 0; z < pm.length; z++)
                            CreateProgram(getProgramData, z),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: addProgramData,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Image(
                                image: ExactAssetImage('images/add-circle.png'),
                                height: 20),
                            const SizedBox(
                              width: 5,
                            ),
                            MyText(
                              text: 'Add More Schedule',
                              color: bluishColor,
                            ),
                          ],
                        ),
                      ),
                      // ListView.builder(
                      //   itemCount: i,
                      //   itemBuilder: ((context, index) {
                      //     return particularWeekDays
                      //         ? Column(
                      //             children: [
                      //               const SizedBox(height: 20),
                      //               TFWithSize(
                      //                   titleHeading[index],
                      //                   titleController[index],
                      //                   12,
                      //                   lightGreyColor,
                      //                   1),
                      //               const SizedBox(
                      //                 height: 10,
                      //               ),
                      //               TFWithSize(
                      //                   descriptionHeading[index],
                      //                   scheduleControllerList[index],
                      //                   12,
                      //                   lightGreyColor,
                      //                   1),
                      //               const SizedBox(height: 20),
                      //               GestureDetector(
                      //                 onTap: addFields,
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.end,
                      //                   children: [
                      //                     const Image(
                      //                         image: ExactAssetImage(
                      //                             'images/add-circle.png'),
                      //                         height: 20),
                      //                     const SizedBox(
                      //                       width: 5,
                      //                     ),
                      //                     MyText(
                      //                       text: 'Add More Schedule',
                      //                       color: bluishColor,
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ],
                      //           )
                      //         : Container();

                      //     // Column(
                      //     //     children: [
                      //     //       const SizedBox(height: 20),
                      //     //       TFWithSize(
                      //     //           titleHeading[index],
                      //     //           titleController[index],
                      //     //           12,
                      //     //           lightGreyColor,
                      //     //           1),
                      //     //       const SizedBox(height: 10),
                      //     //       // const SizedBox(height: 20),
                      //     //       Column(
                      //     //         children: [
                      //     //           programDateList[index],
                      //     //           const SizedBox(
                      //     //             height: 10,
                      //     //           ),
                      //     //           // programDate(context, formattedDate),
                      //     //           // GestureDetector(
                      //     //           //   onTap: () =>
                      //     //           //       _selectDate(context, formattedDate),
                      //     //           //   child: Container(
                      //     //           //     height: 50,
                      //     //           //     padding: const EdgeInsets.symmetric(
                      //     //           //         vertical: 0),
                      //     //           //     //width: MediaQuery.of(context).size.width / 1,
                      //     //           //     decoration: BoxDecoration(
                      //     //           //       borderRadius:
                      //     //           //           BorderRadius.circular(10),
                      //     //           //       color: lightGreyColor,
                      //     //           //       border: Border.all(
                      //     //           //         width: 1,
                      //     //           //         color: greyColor.withOpacity(0.2),
                      //     //           //       ),
                      //     //           //     ),
                      //     //           //     child: ListTile(
                      //     //           //       contentPadding:
                      //     //           //           const EdgeInsets.symmetric(
                      //     //           //               vertical: 0,
                      //     //           //               horizontal: 10),
                      //     //           //       leading: Text(
                      //     //           //         formattedDate.toString(),
                      //     //           //         style: TextStyle(
                      //     //           //             color: blackColor
                      //     //           //                 .withOpacity(0.6)),
                      //     //           //       ),
                      //     //           //       trailing: Icon(
                      //     //           //         Icons.calendar_today,
                      //     //           //         color:
                      //     //           //             blackColor.withOpacity(0.6),
                      //     //           //         size: 20,
                      //     //           //       ),
                      //     //           //     ),
                      //     //           //   ),
                      //     //           // ),
                      //     //           //programTime(context, startTime, endTime),
                      //     //           programTimeList[index],
                      //     //           const SizedBox(
                      //     //             height: 10,
                      //     //           ),
                      //     //         ],
                      //     //       ),
                      //     //       TFWithSize(
                      //     //           descriptionHeading[index],
                      //     //           scheduleControllerList[index],
                      //     //           12,
                      //     //           lightGreyColor,
                      //     //           1),
                      //     //       const SizedBox(height: 20),
                      //     //       //addFieldButton(addFields),
                      //     //       GestureDetector(
                      //     //         onTap: addFields,
                      //     //         child: Row(
                      //     //           mainAxisAlignment:
                      //     //               MainAxisAlignment.end,
                      //     //           children: [
                      //     //             const Image(
                      //     //                 image: ExactAssetImage(
                      //     //                     'images/add-circle.png'),
                      //     //                 height: 20),
                      //     //             const SizedBox(
                      //     //               width: 5,
                      //     //             ),
                      //     //             MyText(
                      //     //               text: 'Add More Schedule',
                      //     //               color: bluishColor,
                      //     //             ),
                      //     //           ],
                      //     //         ),
                      //     //       ),
                      //     //     ],
                      //     //   );
                      //   }),
                      // ),
                    ),
                    Cost(
                      iLiveInController,
                      specificAddressController,
                      costOne,
                      costTwo,
                      preRequisites,
                      minimumRequirement,
                      terms,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomButton(bgColor: whiteColor, onTap: next),
      ),
    );
  }

  Widget programDateWidget(BuildContext context, var i) {
    return GestureDetector(
      onTap: () => _selectDate(context, i),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 0),
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
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          leading: Text(
            i.toString(),
            style: TextStyle(color: blackColor.withOpacity(0.6)),
          ),
          trailing: Icon(
            Icons.calendar_today,
            color: blackColor.withOpacity(0.6),
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget programTimeWidget(BuildContext context, TimeOfDay sd, TimeOfDay ed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 0),
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
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                leading: Text(
                  "${sd.hour.toString().padLeft(2, "0")} : ${sd.minute.toString().padLeft(2, '0')}",
                  style: TextStyle(color: blackColor.withOpacity(0.6)),
                ),
                trailing: Icon(
                  Icons.punch_clock_sharp,
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
            onTap: () => {},
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 0),
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
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                leading: Text(
                  "${ed.hour.toString().padLeft(2, "0")} : ${ed.minute.toString().padLeft(2, '0')}",
                ),
                trailing: Icon(
                  Icons.lock_clock_sharp,
                  color: blackColor.withOpacity(0.6),
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
