// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:adventuresclub/become_a_partner/create_services/create_services_description.dart';
import 'package:adventuresclub/complete_profile/banner_page.dart';
import 'package:adventuresclub/complete_profile/cost.dart';
import 'package:adventuresclub/complete_profile/program.dart';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_create_new_services.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/models/services/dependencies_model.dart';
import 'package:adventuresclub/widgets/buttons/bottom_button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
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
  bool particularCalender = true;
  bool particularWeekDay = false;
  bool particularWeekDays = false;
  bool particularWeek = true;
  DateTime? pickedDate;
  var formattedDate;
  var endDate;
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
  String title = "";
  String schedule = "";

  @override
  void initState() {
    super.initState();
    formattedDate = 'Start Date';
    endDate = "End Date";
    getData();
    if (i == 1) {
      titleController.add(scheduleController);
      scheduleControllerList.add(scheduleDescription);
    }
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

  void next() {
    if (count == 0) {
      MyText(text: "Please add Image");
      setState(() {
        count++;
      });
    } else if (count == 1) {
      aimed();
      servicePlan();
      dependency();
      setState(() {
        count++;
      });
    } else if (count == 2) {
      setState(() {
        count++;
      });
    } else if (count == 3) {
      createService();
    }
    print(count);
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

  void getDescriptionData(TextEditingController name) {
    name = adventureName;
  }

  void createService() async {
    titleController.forEach((element) {
      sTitle.add(element.text);
      title = sTitle.join(",");
    });
    title = sTitle.join(",");
    scheduleControllerList.forEach((element) {
      sSchedule.add(element.text);
    });
    schedule = sSchedule.join(",");
    if (particularWeekDay) {
      setState(() {
        sPlan = 1;
      });
    } else {
      setState(() {
        sPlan = 2;
      });
    }
    selectedActivityIncludesId =
        ConstantsCreateNewServices.selectedActivitesId.join(",");
    List<Uint8List> banners = [];
    imageList.forEach((element) {
      banners.add(element.readAsBytesSync());
    });
    try {
      if (adventureName.text.isNotEmpty) {
        var request = http.MultipartRequest(
          "POST",
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/create_service"),
        );
        String fileName = "${DateTime.now().millisecondsSinceEpoch.toString()}.png";
        request.files.add(http.MultipartFile.fromBytes('banner[]', banners[0], filename: fileName));

        request.fields.addAll({
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
          "start_date": ConstantsCreateNewServices.startDate
              .toString(), //startDate, //"",
          "end_date":
              ConstantsCreateNewServices.endDate.toString(), //endDate, //"",
          "write_information": infoController.text, //infoController.text, //"",
          // it is for particular week or calender
          "service_plan": "1", //sPlan, //"1", //"",
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
          "schedule_title[]":
              title, //titleController, //scheduleController.text, //scheduleController.text, //"",
          // schedule title in array is skipped
          // this is an array
          "gathering_date[]": "654", //gatheringDate, //"",
          // api did not accept list here
          "activities": selectedActivityIncludesId, //"5", // activityId, //"",
          "specific_address": specificAddressController
              .text, //"", //iLiveInController.text, //"",
          // this is a wrong field only for testing purposes....
          // this is an array
          "gathering_start_time[]": "10",
          // this is an arrayt
          "gathering_end_time[]": "15",
          "" //gatheringDate, //"",
                  // this is an array
                  "program_description[]":
              schedule, // scheduleControllerList, //scheduleDesController.text, //"",
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
        });
        final response = await request.send();
        

        log(response.toString());
        print(response.statusCode);
        // print(response.body);
        print(response.headers);
        close();
        // var response = await http.post(
        //     Uri.parse(
        //         "https://adventuresclub.net/adventureClub/api/v1/create_service"),
        //     body: {
        //       'customer_id': Constants.userId.toString(), //"27",
        //       'adventure_name':
        //           adventureName.text, //adventureNameController.text,
        //       "country": Constants.countryId.toString(),
        //       'region': ConstantsCreateNewServices.selectedRegionId
        //           .toString(), //selectedRegionId.toString(),
        //       "service_sector": ConstantsCreateNewServices.selectedSectorId
        //           .toString(), //selectedSectorId.toString(), //"",
        //       "service_category": ConstantsCreateNewServices.selectedCategoryId
        //           .toString(), //"", //selectedCategoryId.toString(), //"",
        //       "service_type": ConstantsCreateNewServices.serviceTypeId
        //           .toString(), // //serviceTypeId.toString(), //"",
        //       "service_level": ConstantsCreateNewServices.selectedlevelId
        //           .toString(), //selectedlevelId.toString(), //"",
        //       "duration": ConstantsCreateNewServices.selectedDurationId
        //           .toString(), //selectedDurationId.toString(), //"",
        //       "available_seats": availableSeatsController.text, //"",
        //       "start_date": ConstantsCreateNewServices.startDate
        //           .toString(), //startDate, //"",
        //       "end_date": ConstantsCreateNewServices.endDate
        //           .toString(), //endDate, //"",
        //       "write_information":
        //           infoController.text, //infoController.text, //"",
        //       // it is for particular week or calender
        //       "service_plan": "1", //sPlan, //"1", //"",
        //       "cost_inc": costOne.text, //setCost1.text, //"",
        //       "cost_exc": costTwo.text, //setCost2.text, //"",
        //       "currency": "1", //  %%% this is hardcoded
        //       "pre_requisites":
        //           preRequisites.text, //"", //preReqController.text, //"",
        //       "minimum_requirements":
        //           minimumRequirement.text, //minController.text, //"",
        //       "terms_conditions": terms.text, //tncController.text, //"",
        //       "recommended": "1", // this is hardcoded
        //       // this key needs to be discussed,
        //       "service_plan_days": servicePlanId, //selectedActivitesId
        //       //.toString(), //"1,6,7", //// %%%%this needs discussion
        //       // "availability": servicePlanId,
        //       "service_for":
        //           selectedActivitesId, //selectedActivitesId.toString(),
        //       "particular_date":
        //           ConstantsCreateNewServices.startDate, //gatheringDate, //"",
        //       // this is an array
        //       "schedule_title[]":
        //           title, //titleController, //scheduleController.text, //scheduleController.text, //"",
        //       // schedule title in array is skipped
        //       // this is an array
        //       "gathering_date[]": "654", //gatheringDate, //"",
        //       // api did not accept list here
        //       "activities":
        //           selectedActivityIncludesId, //"5", // activityId, //"",
        //       "specific_address": specificAddressController
        //           .text, //"", //iLiveInController.text, //"",
        //       // this is a wrong field only for testing purposes....
        //       // this is an array
        //       "gathering_start_time[]": "10",
        //       // this is an arrayt
        //       "gathering_end_time[]": "15",
        //       "" //gatheringDate, //"",
        //               // this is an array
        //               "program_description[]":
        //           schedule, // scheduleControllerList, //scheduleDesController.text, //"",
        //       // "service_for": selectedActivitesId
        //       //     .toString(), //"1,2,5", //"4", //["1", "4", "5", "7"], //"",
        //       "dependency":
        //           selectedDependencyId, //selectedDependencyId.toString(), //["1", "2", "3"],
        //       "banner[]": banners[0], //adventureOne.toString(), //"",
        //       // banner image name.
        //       // we need file name,
        //       // after bytes array when adding into parameter. send the name of file.
        //       //
        //       "latitude": ConstantsCreateNewServices.lat
        //           .toString(), //lat.toString(), //"",
        //       "longitude": ConstantsCreateNewServices.lng
        //           .toString(), //lng.toString(), //"",
        //       // 'mobile_code': ccCode,
        //     });
        // print(response.statusCode);
        // print(response.body);
        // print(response.headers);
        // close();
      } else {
        message("AdventureName cannot be empty");
      }
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

  // Future<void> _selectDate(BuildContext context, var givenDate) async {
  //   pickedDate = await showDatePicker(
  //       context: context,
  //       initialDate: currentDate,
  //       firstDate: DateTime(DateTime.now().day - 1),
  //       lastDate: DateTime(2050));
  //   if (pickedDate != null && pickedDate != currentDate) {
  //     setState(() {
  //       var date = DateTime.parse(pickedDate.toString());
  //       formattedDate = "${date.day}-${date.month}-${date.year}";
  //       currentDate = pickedDate!;
  //     });
  //   }
  //   getDates(formattedDate.toString());
  // }

  // void getDates(String gatheringDate) {
  //   setState(() {
  //     ConstantsCreateNewServices.gatheringDate;
  //   });
  // }

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
        loading = true;
        i = 2;
        titleHeading.add("Schedule Title");
        descriptionHeading.add("Schedule Description");
        titleController.add(scheduleController1);
        scheduleControllerList.add(scheduleDescription1);
      });
      changeStatus();
    } else if (i == 2) {
      setState(() {
        loading = true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                text: 'Just follow simple four steps to list up your adventure',
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
                                                value: particularWeekDays,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24)),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    ConstantsCreateNewServices
                                                            .particularWeekDays =
                                                        value!;
                                                    particularWeekDays = value!;
                                                    particularCalender =
                                                        !particularCalender;
                                                  });
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
                                                    // tristate: true,
                                                    value: daysValue[index],
                                                    onChanged: (bool? value) {
                                                      setState(
                                                        () {
                                                          daysValue[index] =
                                                              value!;
                                                        },
                                                      );
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
                        particularCalender
                            ? SizedBox(
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
                                                particularWeek =
                                                    !particularWeek;
                                              });
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
                                                    const EdgeInsets.symmetric(
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
                                                    const EdgeInsets.symmetric(
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
                    ListView.builder(
                      itemCount: i,
                      itemBuilder: ((context, index) {
                        return ConstantsCreateNewServices.particularWeekDays
                            ? Column(
                                children: [
                                  const SizedBox(height: 20),
                                  TFWithSize(
                                      titleHeading[index],
                                      titleController[index],
                                      12,
                                      lightGreyColor,
                                      1),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TFWithSize(
                                      descriptionHeading[index],
                                      scheduleControllerList[index],
                                      12,
                                      lightGreyColor,
                                      1),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: addFields,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Image(
                                            image: ExactAssetImage(
                                                'images/add-circle.png'),
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
                                ],
                              )
                            : Column(
                                children: [
                                  const SizedBox(height: 20),
                                  TFWithSize(
                                      titleHeading[index],
                                      scheduleControllerList[index],
                                      12,
                                      lightGreyColor,
                                      1),
                                  const SizedBox(height: 10),
                                  // const SizedBox(height: 20),
                                  Column(
                                    children: [
                                      GestureDetector(
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
                                              color:
                                                  blackColor.withOpacity(0.6),
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TFWithSize(
                                      descriptionHeading[index],
                                      scheduleDescription,
                                      12,
                                      lightGreyColor,
                                      1),
                                  const SizedBox(height: 20),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: addFields,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Image(
                                            image: ExactAssetImage(
                                                'images/add-circle.png'),
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
                                ],
                              );
                      }),
                    ),
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
    );
  }
}
