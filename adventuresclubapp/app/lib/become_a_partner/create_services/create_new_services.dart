// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, unused_local_variable
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:app/become_a_partner/create_services/create_plan_one.dart';
import 'package:app/become_a_partner/create_services/create_program.dart';
import 'package:app/become_a_partner/create_services/create_services_description.dart';
import 'package:app/complete_profile/banner_page.dart';
import 'package:app/complete_profile/cost.dart';
import 'package:app/constants.dart';
import 'package:app/constants_create_new_services.dart';
import 'package:app/models/services/aimed_for_model.dart';
import 'package:app/models/services/create_services/create_services_plan_one.dart';
import 'package:app/models/services/create_services/create_services_program%20_model.dart';
import 'package:app/models/services/dependencies_model.dart';
import 'package:app/provider/services_provider.dart';
import 'package:app/widgets/buttons/bottom_button.dart';
import 'package:app/widgets/loading_widget.dart';
import 'package:app/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:http/http.dart' as http;

class CreateNewServices extends StatefulWidget {
  const CreateNewServices({super.key});

  @override
  State<CreateNewServices> createState() => _CreateNewServicesState();
}

class _CreateNewServicesState extends State<CreateNewServices> {
  ScrollController heightController = ScrollController();
  TextEditingController adventureName = TextEditingController();
  TextEditingController availableSeatsController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  TextEditingController iLiveInController = TextEditingController();
  TextEditingController specificAddressController = TextEditingController();
  TextEditingController costOne = TextEditingController();
  TextEditingController costTwo = TextEditingController();
  TextEditingController preRequisites = TextEditingController();
  TextEditingController minimumRequirement = TextEditingController();
  TextEditingController terms = TextEditingController();
  TextEditingController daysExpiry = TextEditingController();
  List stepTitle = ['banner', 'description', 'program', 'cost/geoloc'];
  List text1 = ['1', '2', '3', '4'];
  int count = 0;
  int i = 1;
  List<File> imageList = [];
  List<AimedForModel> aimedFilter = [];
  List<DependenciesModel> dependencyList = [];
  List<bool> aimedValue = [];
  List<bool> dependencyValue = [];
  List aimedText = [];
  List<String> dependencyText = [];
  List days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List<bool> daysValue = [false, false, false, false, false, false, false];
  List<String> servicePlanDays = [];
  List<int> servicePlanDaysId = [];
  bool particularDay = false;
  // bool particularWeekDay = false;
  bool particularWeekDays = false;
  bool particularWeek = false;
  DateTime? pickedDate;
  var formattedDate;
  var endDate;
  DateTime startDate = DateTime.now();
  DateTime eDate = DateTime.now();
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
  String reasonOne = "";
  String reasonTwo = "";
  String title = "";
  String schedule = "";
  String programsDate = "";
  String programeTime = "";
  TimeOfDay time = TimeOfDay.now();
  bool planChecked = false;
  List<CreateServicesProgramModel> pm = [
    // CreateServicesProgramModel(
    //     "title 1 ",
    //     DateTime.now(),
    //     DateTime.now(),
    //     Duration(),
    //     Duration(),
    //     "Description 1 ",
    //     DateTime.now(),
    //     DateTime.now())
  ];
  List<CreateServicesPlanOneModel> onePlan = [
    CreateServicesPlanOneModel("", "")
  ];
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
  List<String> programOnetitleList = [];
  List<String> programOnedescriptionList = [];
  bool isTimeAfter = false;
  int regionId = 0;
  int sectorId = 0;
  int categoryId = 0;
  int typeId = 0;
  int durationId = 0;
  int levelId = 0;
  List<int> activitiesId = [];
  double lat = 0;
  double lng = 0;
  Map mapFilter = {};
  Map mapAimedFilter = {};
  int serviceId = 0;

  @override
  void initState() {
    super.initState();
    DateTime dt = DateTime(currentDate.year, currentDate.month, currentDate.day,
        time.hour, time.minute);
    formattedDate = 'startDate';
    endDate = "endDate".tr();
    getData();
    aimedFor();
    // addProgramData();
  }

  void getProgramData(List<CreateServicesProgramModel> data) {
    pm = data;
    // .add(CreateServicesProgramModel(
    //     data.title,
    //     data.startDate,
    //     data.endDate,
    //     data.startTime,
    //     data.endTime,
    //     data.description,
    //     data.adventureStartDate,
    //     data.adventureEndDate));
    //isTimeAfter = time;
    setState(() {});
    //  pm.add(data);
  }

  void deleteProgramData(int i) {
    pm.removeAt(i);
    setState(() {});
  }

  void getProgramOneData(CreateServicesPlanOneModel data, int index) {
    onePlan[index] = data;
    //  pm.add(data);
  }

  void addProgramOneData() {
    setState(() {
      onePlan.add(CreateServicesPlanOneModel("", ""));
    });
  }

  void addProgramData() {
    setState(() {
      pm.add(CreateServicesProgramModel("", startDate, currentDate,
          const Duration(), const Duration(), "", startDate, currentDate));
    });
  }

  @override
  void dispose() {
    infoController.dispose();
    adventureName.dispose();
    availableSeatsController.dispose();
    scheduleController.dispose();
    iLiveInController.dispose();
    specificAddressController.dispose();
    costOne.dispose();
    costTwo.dispose();
    preRequisites.dispose();
    minimumRequirement.dispose();
    terms.dispose();
    daysExpiry.dispose();
    heightController.dispose();
    super.dispose();
  }

  void getData() {
    aimedFilter = Constants.am;
    dependencyList = Constants.dependency;
    parseAimed(Constants.am);
    parseDependency(Constants.dependency);
  }

  void aimedFor() async {
    //https://adventuresclub.net/adventureClubSIT/api/v1/services_cost
    var response =
        await http.get(Uri.parse("${Constants.baseUrl}api/v1/services_cost"));
    if (response.statusCode == 200) {
      List<dynamic> result = mapAimedFilter['message'];
      result.forEach((element) {
        int id = int.tryParse(element['id'].toString()) ?? 0;
        AimedForModel amf = AimedForModel(
          id,
          element['AimedName'] ?? "",
          element['image'] ?? "",
          element['created_at'] ?? "",
          element['updated_at'] ?? "",
          element['deleted_at'] ?? "",
          0,
          //  selected: false,
        );
        // am.add(amf);
      });
    }
  }

  void showConfirmation() async {
    showDialog(
        context: context,
        builder: (ctx) => SimpleDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: const Icon(
                Icons.check_circle,
                size: 80,
                color: greenColor1,
              ),
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "adventureDetailsHasBeenSubmitted".tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: blackColor,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                //Text("data"),
                Text(
                  "userWillBeAbleToEnrol".tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                // text:
                //     "After approval you'll be notified and have to buy your subscription package",
                // size: 18,
                // weight: FontWeight.w500,
                // color: blackColor.withOpacity(0.6),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: homePage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: bluishColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: MyText(
                      text: "okGotIt".tr(),
                      weight: FontWeight.bold,
                      color: whiteColor,
                    ))
                //BottomButton(bgColor: blueButtonColor, onTap: homePage)
              ],
            ));
  }

  void homePage() {
    Navigator.of(context).pop();
    cancel();
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void parseDependency(List<DependenciesModel> dm) {
    dm.forEach((element) {
      if (element.dName.isNotEmpty) {
        dependencyText.add(element.dName.tr());
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
    print(selectedActivitesId);
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
      } else if (element == "Thu") {
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
    print(planChecked);
    if (count == 1 && sPlan == 2) {
      if (ConstantsCreateNewServices.startDate != "Start Date" &&
          ConstantsCreateNewServices.endDate != "End Date") {
        setState(() {
          planChecked = true;
        });
      } else if (ConstantsCreateNewServices.startDate == "Start Date") {
        message("Start Date Cannot be empty");
      } else if (ConstantsCreateNewServices.endDate == "End Date") {
        message("End Date Cannot be empty");
      }
    } else {
      checkPlanTwo();
    }
  }

  void checkPlanTwo() async {
    servicePlan();
    if (count == 1 && sPlan == 1) {
      if (servicePlanId.isNotEmpty) {
        setState(() {
          planChecked = true;
        });
      } else if (servicePlanId.isEmpty) {
        message("Please select Particular week days");
      }
    }
    print(servicePlanId);
  }

  void planTwoCheck() {
    if (sPlan == 2 && planChecked == false) {}
  }

  void next1() {
    // createService();
  }

  bool checkPlans() {
    bool result = false;
    pm.forEach((element) {
      if (element.title.trim().isEmpty || element.title.length < 3) {
        Constants.showMessage(
            context, "Schdule Title Cannot Be for less than 3 characters");
        result = false;
      } else if (element.description.trim().isEmpty ||
          element.description.length < 50) {
        Constants.showMessage(
            context, "Schdule Title Cannot Be for less than 50 characters");
        result = false;
      } else if (element.adventureStartDate.day == 0) {
        Constants.showMessage(context, "Please Select Start Time");
        result = false;
      } else if (element.adventureEndDate.day == 0) {
        Constants.showMessage(context, "Please Select End Time");
        result = false;
      }
      // else if (element.startTime.inHours == 0) {
      //   result = false;
      // } else if (element.endDate.day == 0) {
      //   result = false;
      // }
      else if (element.startTime.inHours == 0) {
        Constants.showMessage(context, "Please Select Start Time");
        result = false;
      } else if (element.endTime.inHours == 0) {
        Constants.showMessage(context, "Please Select End Time");
        result = false;
      } else {
        result = true;
      }
      // if (element.title.length < 3) {
      //   Constants.showMessage(
      //       context, "Schdule Title Cannot Be for less than 3 characters");
      //   return;
      // }
      // if () {
      //   Constants.showMessage(
      //       context, "Schdule Title Cannot Be for less than 50 characters");
      //   return;
      // }
    });

    return result;
  }

  bool checkOnePlan() {
    bool result = false;
    int i = onePlan.length;
    onePlan.forEach((element) {
      if (element.title.trim().isEmpty || element.title.length < 3) {
        Constants.showMessage(
            context, "Schdule Title Cannot Be for less than 3 characters");
        result = false;
      } else if (element.description.trim().isEmpty ||
          element.description.length < 50) {
        Constants.showMessage(
            context, "Schdule Body Cannot Be for less than 50 characters");
        result = false;
      } else {
        result = true;
      }
      // if (element.title.length < 3) {
      //   Constants.showMessage(
      //       context, "Schdule Title Cannot Be for less than 3 characters");
      //   return;
      // }
      // if (element.description.length < 50) {
      //   Constants.showMessage(
      //       context, "Schdule Title Cannot Be for less than 50 characters");
      //   return;
      // } else {
      //   result = true;
      // }
    });
    return result;
  }

  void getDraftId() async {
    try {
      var response = await http.post(
          Uri.parse("${Constants.baseUrl}/api/v1/get_draft_service"),
          body: {
            "provider_id": Constants.userId
                .toString(), //Constants.profile.bp.id.toString(),
            "country_id": Constants.countryId.toString(),
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = decodedResponse['data'];
      for (var element in result) {
        serviceId = int.tryParse(element['id'].toString()) ?? 0;
      }
      setState(() {});
    } catch (e) {
      if (mounted) {
        Constants.showMessage(context, "message");
      }
    }
    debugPrint(serviceId.toString());
  }

  void next() async {
    checkPlan();
    if (count == 0 && imageList.isNotEmpty) {
      //  createService();
      setState(() {
        count = 1;
      });
      saveDraft();
    } else if (imageList.isEmpty) {
      message("Images cannot be empty");
    } else if (count == 1) {
      (selectedDependencyId.isNotEmpty && planChecked);
      if (adventureName.text.trim().isEmpty) {
        message("Please enter the adventure name");
        return;
      }
      if (adventureName.text.trim().length < 3) {
        message("Adventure Cannot be for less than 3 characters");
        return;
      }
      if (infoController.text.trim().isEmpty) {
        message("Please type information");
        return;
      }
      if (infoController.text.trim().length < 50) {
        message("Information cannot be for less than 50 characters");
        return;
      }
      if (availableSeatsController.text.trim().isEmpty) {
        message("Please add availaible seats");
        return;
      }
      if (availableSeatsController.text == "0") {
        message("Available Seats Cannot be less than 1");
        return;
      }
      //if (ConstantsCreateNewServices.selectedRegionId == 0)
      if (regionId == 0) {
        message("Please select region");
        return;
      }
      // if (ConstantsCreateNewServices.selectedSectorId == 0)
      if (sectorId == 0) {
        message("Please select service sector");
        return;
      }
      //if (ConstantsCreateNewServices.selectedCategoryId == 0)
      if (categoryId == 0) {
        message("Please select category");
        return;
      }
      //if (ConstantsCreateNewServices.serviceTypeId == 0)
      if (typeId == 0) {
        message("Please select service type");
        return;
      }
      //if (ConstantsCreateNewServices.selectedDurationId == 0)
      if (durationId == 0) {
        message("Please select duration");
        return;
      }
      //if (ConstantsCreateNewServices.selectedlevelId == 0)
      if (levelId == 0) {
        message("Please select level");
        return;
      }

      if (sPlan == 0) {
        message("Please select from the service plan");
        return;
      }
      if (sPlan == 2 && formattedDate == "startDate") {
        message("Please select start Date");
        return;
      }
      if (sPlan == 2 && endDate == "End Date") {
        message("Please select End Date");
        return;
      }
      //if (ConstantsCreateNewServices.selectedActivitesId.isEmpty)
      if (activitiesId.isEmpty) {
        message("Please Activities Included");
        return;
      }
      if (selectedActivitesId.isEmpty) {
        message("Please select from aimed for");
        return;
      }
      if (selectedDependencyId.isEmpty) {
        message("Please select Dependency");
        return;
      }
      // pm[0].startDate = startDate;
      // pm[0].endDate = currentDate;
      // pm[0].adventureStartDate = startDate;
      // pm[0].adventureEndDate = currentDate;
      await saveSecondDraft();
      setState(() {
        count = 2;
      });

      heightController.animateTo(heightController.position.minScrollExtent,
          duration: const Duration(milliseconds: 500), curve: Curves.bounceIn);
    } else if (count == 2
        // &&
        //     pm[0].title.isNotEmpty &&
        //     pm[0].description.isNotEmpty &&
        //     isTimeAfter == false
        ) {
      if (sPlan == 1) {
        bool check = checkOnePlan();
        if (!check) {
          message("Please Fill Empty fields");
          return;
        }
      } else {
        bool check = checkPlans();
        if (!check) {
          //message("Please Fill Empty Plan Infomation");
          return;
        }
      }

      if (particularWeekDays) {
        // onePlan.isEmpty;
        // message("Please enter program title");
        // return;
      } else if (!particularWeekDays) {
        // pm[0].title.isEmpty;
        // pm[0].description.isEmpty;
        // message("Please fill the empty fields");
        // return;
      } else if (isTimeAfter) {
        message("End Time Cannot be before Start Time");
      }
      saveThirdPage();
      setState(() {
        count = 3;
      });
    } else if (count == 3
        // ConstantsCreateNewServices.lat > 0 &&
        // ConstantsCreateNewServices.lng >  &&

        ) {
      if (ConstantsCreateNewServices.lat == 0) {
        message("Please set location Correctly");
        return;
      }
      if (ConstantsCreateNewServices.lng == 0) {
        message("Please set location Correctly");
        return;
      }
      if (iLiveInController.text.trim().isEmpty) {
        message("Location Cannot be empty");
        return;
      }
      if (specificAddressController.text.trim().isEmpty) {
        message("Specific Address Cannot be empty");
        return;
      }
      if (costOne.text.trim().isEmpty) {
        message("Please set cost one");
        return;
      }
      if (costOne.text.trim() == "0") {
        message("Cost Cannot be less than 1");
        return;
      }
      if (preRequisites.text.trim().isEmpty) {
        message("Please Type prerequisites");
        return;
      }
      if (preRequisites.text.trim().length < 3) {
        message("Prerequisites cannot be for less than 3 characters");
        return;
      }
      if (minimumRequirement.text.trim().isEmpty) {
        message("Please Type Minimum Requirements");
        return;
      }
      if (minimumRequirement.text.trim().length < 5) {
        message("Minimum Requirements cannot be for less than 5 characters");
        return;
      }
      if (minimumRequirement.text.trim().isEmpty) {
        message("Please Type Minimum Requirements");
        return;
      }
      if (terms.text.trim().isEmpty) {
        message("Please Type Terms");
        return;
      }
      if (terms.text.trim().length < 30) {
        message("Terms cannot be for less than 30 characters");
        return;
      }
      //convertProgramData();
      saveLastPage();
    }
  }

  void clearAll() async {
    ConstantsCreateNewServices.clearAll();
  }

  void previous() {
    clearAll();
    if (count == 0) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        count--;
      });
    }
  }

  void getImages(List<File> imgList) {
    imageList = imgList;
  }

  Future<void> getCostReason() async {
    reasonOne = Provider.of<ServicesProvider>(context, listen: false).reasonOne;
    reasonTwo = Provider.of<ServicesProvider>(context, listen: false).reasonTwo;
  }

  Future<void> convertProgramData() async {
    if (sPlan == 1) {
      onePlan.forEach((element) {
        titleList.add(element.title);
      });
      //programTitle = titleList.join(",");
      onePlan.forEach((element) {
        descriptionList.add(element.description);
      });
    } else {
      pm.forEach((element) {
        titleList.add(element.title);
      });
      //programTitle = titleList.join(",");
      pm.forEach((element) {
        descriptionList.add(element.description);
      });
      // programSchedule = descriptionList.join(",");
      pm.forEach((element) {
        String c =
            "${element.startDate.year}-${element.startDate.month}-${element.startDate.day}";
        // d.add(element.startDate.toString());
        d.add(c);
      });
      // programSelecteDate1 = d.join(",");
      pm.forEach((element) {
        String startTime = element.startDate.hour.toString();
        startTime += ":${element.startDate.minute}";
        startTime += ":${element.startDate.second}";
        st.add(startTime);
        //st.add(element.startTime.toString());
      });
      // programStartTime1 = st.join(",");
      pm.forEach((element) {
        String endTime = element.endDate.hour.toString();
        endTime += ":${element.endDate.minute}";
        endTime += ":${element.endDate.second}";
        et.add(endTime);
        //et.add(element.endTime.toString());
      });
      //programEndTime = et.join(",");
    }
  }

  void clearProgramdata() {
    if (sPlan == 1) {
      titleList.clear();
      descriptionList.clear();
    } else {
      pm = [];
    }
  }

  void saveThirdPage() async {
    convertProgramData();
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${Constants.baseUrl}/api/v1/third_program_creation"),
      );

      dynamic programData = {
        "provider_id": Constants.userId.toString(),
        "service_id": serviceId.toString()
      };
      String space = "";
      if (sPlan == 2) {
        st.forEach((element) {
          programData["gathering_start_time[]$space"] = element;
          space += " ";
        });
      } else {
        titleList.forEach((element) {
          programData["gathering_start_time[]$space"] = "element";
          space += " ";
        });
      }
      space = "";
      if (sPlan == 2) {
        et.forEach((element1) {
          programData["gathering_end_time[]$space"] = element1;
          space += " ";
        });
      } else {
        titleList.forEach((element1) {
          programData["gathering_end_time[]$space"] = "element1";
          space += " ";
        });
      }
      space = "";
      titleList.forEach((element) {
        programData["schedule_title[]$space"] = element;
        space += " ";
      });
      space = "";
      descriptionList.forEach((element) {
        programData["program_description[]$space"] = element;
        space += " ";
      });
      space = "";
      if (sPlan == 2) {
        d.forEach((element) {
          programData["gathering_date[]$space"] = element;
          space += " ";
        });
      } else {
        titleList.forEach((element) {
          programData["gathering_date[]$space"] = "element";
          space += " ";
        });
      }

      request.fields.addAll(programData);
      final response = await request.send();
      log(response.toString());
      clearPrograms();
      debugPrint(response.statusCode.toString());
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  void clearPrograms() {
    titleList.clear();
    descriptionList.clear();
    d.clear();
    et.clear();
    st.clear();
  }

  // void createService() async {
  //   await convertProgramData();
  //   selectedActivityIncludesId = activitiesId.join(",");
  //   //ConstantsCreateNewServices.selectedActivitesId.join(",");

  //   List<Uint8List> banners = [];
  //   imageList.forEach((element) {
  //     banners.add(element.readAsBytesSync());
  //   });
  //   try {
  //     var request = http.MultipartRequest(
  //       "POST",
  //       Uri.parse(
  //           //${Constants.baseUrl}SIT
  //           "${Constants.baseUrl}/api/v1/create_service"),
  //     );
  //     banners.forEach((element) {
  //       String fileName =
  //           "${DateTime.now().millisecondsSinceEpoch.toString()}.png";
  //       request.files.add(http.MultipartFile.fromBytes('banner[]', element,
  //           filename: fileName));
  //     });
  //     dynamic programData = {
  //       'customer_id': Constants.userId.toString(),
  //       'adventure_name': adventureName.text,
  //       "country": Constants.countryId.toString(),
  //       'region':
  //           regionId.toString(), //ConstantsCreateNewServices.selectedRegionId
  //       //.toString(), //selectedRegionId.toString(),
  //       "service_sector": sectorId
  //           .toString(), //ConstantsCreateNewServices.selectedSectorId.toString(), //selectedSectorId.toString(), //"",
  //       "service_category": categoryId
  //           .toString(), //ConstantsCreateNewServices.selectedCategoryId.toString(), //"", //selectedCategoryId.toString(), //"",
  //       "service_type": typeId
  //           .toString(), //ConstantsCreateNewServices.serviceTypeId.toString(), // //serviceTypeId.toString(), //"",
  //       "service_level": levelId
  //           .toString(), //ConstantsCreateNewServices.selectedlevelId.toString(), //selectedlevelId.toString(), //"",
  //       "duration": durationId
  //           .toString(), //ConstantsCreateNewServices.selectedDurationId.toString(), //selectedDurationId.toString(), //"",
  //       "available_seats": availableSeatsController.text, //"",
  //       "start_date":
  //           ConstantsCreateNewServices.startDate.toString(), //startDate, //"",
  //       "end_date":
  //           ConstantsCreateNewServices.endDate.toString(), //endDate, //"",
  //       "write_information": infoController.text, //infoController.text, //"",
  //       // it is for particular week or calender
  //       "service_plan": sPlan.toString(), //"1", //"",
  //       "cost_inc":
  //           Constants.getTranslatedNumber(costOne.text), //setCost1.text, //"",
  //       "cost_exc": Constants.getTranslatedNumber(
  //           costTwo.text), //costTwo.text, //setCost2.text, //"",
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
  //       "service_for": selectedActivitesId, //selectedActivitesId.toString(),
  //       "particular_date":
  //           ConstantsCreateNewServices.startDate, //gatheringDate, //"",
  //       // this is an array
  //       // "schedule_title[]":
  //       //   programTitle, //titleController, //scheduleController.text, //scheduleController.text, //"",
  //       // schedule title in array is skipped
  //       // this is an array
  //       //"gathering_date[]": programSelecteDate1, //gatheringDate, //"",
  //       // api did not accept list here
  //       "activities": selectedActivityIncludesId, //"5", // activityId, //"",
  //       "specific_address": specificAddressController
  //           .text, //"", //iLiveInController.text, //"",
  //       // this is a wrong field only for testing purposes....
  //       // this is an array
  //       //"gathering_start_time[]": programStartTime2, //"10",
  //       // this is an arrayt
  //       //"gathering_end_time[]": programEndTime, //"15",
  //       //"" //gatheringDate, //"",
  //       // this is an array
  //       // "program_description[]":
  //       //"scheule 2 , schule 1", // scheduleControllerList, //scheduleDesController.text, //"",
  //       // "service_for": selectedActivitesId
  //       //     .toString(), //"1,2,5", //"4", //["1", "4", "5", "7"], //"",
  //       "dependency":
  //           selectedDependencyId, //selectedDependencyId.toString(), //["1", "2", "3"],
  //       //"banners[]": "${banners[0]},test032423231108.png",
  //       //"banner[]":
  //       //"${banners[0]},test0324232311147.png", //adventureOne.toString(), //"",
  //       // banner image name.
  //       // we need file name,
  //       // after bytes array when adding into parameter. send the name of file.
  //       //
  //       "latitude": //"27.0546", //
  //           ConstantsCreateNewServices.lat.toString(), //lat.toString(), //"",
  //       "longitude": //"57.05650"
  //           ConstantsCreateNewServices.lng.toString(), //lng.toString(), //"",
  //       // 'mobile_code': ccCode,
  //       // "gathering_start_time[]": "13:0:0",
  //       // "gathering_end_time[]": "15:0:0",
  //     };
  //     String space = "";
  //     st.forEach((element) {
  //       //log(element);
  //       programData["gathering_start_time[]$space"] = element;
  //       space += " ";
  //     });
  //     // String programDataString = jsonEncode(programData);
  //     // int index = programDataString.indexOf("}");
  //     // String first = programDataString.substring(0, index);
  //     // st.forEach((element) {
  //     //   String i = ",gathering_start_time[]:'$element'";
  //     //   first += i;
  //     // });
  //     // first += "}";
  //     // programData = jsonDecode(first);
  //     //log(first);
  //     space = "";
  //     et.forEach((element1) {
  //       // log(element1);
  //       programData["gathering_end_time[]$space"] = element1;
  //       space += " ";
  //     });
  //     space = "";
  //     titleList.forEach((element) {
  //       programData["schedule_title[]$space"] = element;
  //       space += " ";
  //     });
  //     space = "";
  //     descriptionList.forEach((element) {
  //       programData["program_description[]$space"] = element;
  //       space += " ";
  //     });
  //     space = "";
  //     d.forEach((element) {
  //       programData["gathering_date[]$space"] = element;
  //       space += " ";
  //     });
  //     request.fields.addAll(programData);
  //     // debugPrint(programData);
  //     final response = await request.send();

  //     log(response.toString());
  //     debugPrint(response.statusCode.toString());
  //     // print(response.body);
  //     print(response.headers);
  //     clearAll();
  //     showConfirmation();
  //     //close();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  void saveLastPage() async {
    await getCostReason();
    debugPrint(reasonOne);
    debugPrint(reasonTwo);
    setState(() {
      loading = true;
    });
    try {
      var response = await http.post(
          Uri.parse(
            "${Constants.baseUrl}/api/v1/third_geo_location_creation",
          ),
          body: {
            "provider_id": Constants.userId.toString(),
            "service_id": serviceId.toString(),
            "latitude": ConstantsCreateNewServices.lat.toString(),
            "longitude": ConstantsCreateNewServices.lng.toString(),
            "specific_address": specificAddressController.text,
            "cost_inc": costOne.text,
            "cost_exc": costTwo.text,
            "pre_requisites": preRequisites.text,
            "minimum_requirements": minimumRequirement.text,
            "terms_conditions": terms.text,
            "inc_description": reasonOne,
            "exc_description": reasonTwo,
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        showConfirmation();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        loading = true;
      });
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
    ConstantsCreateNewServices.clearAll();
    Navigator.of(context).pop();
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

  void setId() {
    if (particularWeekDays) {
      //setState(() {
      sPlan = 1;
      // });
    } else if (particularDay) {
      // setState(() {
      sPlan = 2;
      // });
    } else {
      //setState(() {
      sPlan = 0;
      //});
    }
    setState(() {});
  }

  void servicePlanfilter() {
    if (planChecked) {
      setState(() {
        planChecked = false;
      });
    }
  }

  void addServicePlan() {
    servicePlanfilter();
    setState(() {
      ConstantsCreateNewServices.particularWeekDays =
          !ConstantsCreateNewServices.particularWeekDays;
      particularWeekDays = !particularWeekDays;
      //particularDay = !particularDay;
      // planChecked = !planChecked;
    });
    print(planChecked);
    setId();
  }

  void daysPlan() {
    servicePlanfilter();
    setState(() {
      particularDay = !particularDay;
      particularWeek = !particularWeek;
      //planChecked = !planChecked;
    });
    print(planChecked);
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

  void getIds(String type, int id) {
    if (type == "region") {
      regionId = id;
    } else if (type == "sector") {
      sectorId = id;
    } else if (type == "category") {
      categoryId = id;
    } else if (type == "type") {
      typeId = id;
    } else if (type == "duration") {
      durationId = id;
    } else if (type == "level") {
      levelId = id;
    }
  }

  void getActivityId(List<int> aId) {
    activitiesId = aId;
  }

  void saveDraft1() async {
    List<Uint8List> banners = [];
    imageList.forEach((element) {
      banners.add(element.readAsBytesSync());
    });
    try {
      var response = await http.post(
          Uri.parse("${Constants.baseUrl}/api/v1/create_service_advanced"),
          body: {
            "provider_id": Constants.profile.bp.id.toString(),
            "adventure_name": adventureName.text,
            "country_id": Constants.countryId.toString(),
            //"banner":  --------------- file
          });
      if (response.statusCode == 200) {
        mapFilter = json.decode(response.body);
        dynamic result = mapFilter['data'];
        // result.forEach((element) {
        //   setState(() {
      } else {
        dynamic body = jsonDecode(response.body);
        message(body['message'].toString());
      }
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  void saveDraft() async {
    List<Uint8List> banners = [];
    imageList.forEach((element) {
      banners.add(element.readAsBytesSync());
    });
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${Constants.baseUrl}/api/v1/create_service_advanced"),
      );
      banners.forEach((element) {
        String fileName =
            "${DateTime.now().millisecondsSinceEpoch.toString()}.png";
        request.files.add(http.MultipartFile.fromBytes('banner[]', element,
            filename: fileName));
      });
      dynamic programData = {
        "provider_id": Constants.userId.toString(),
        "adventure_name": adventureName.text,
        "country_id": Constants.countryId.toString(),
      };
      request.fields.addAll(programData);
      final response = await request.send();
      log(response.toString());
      debugPrint(response.statusCode.toString());
      print(response.headers);
    } catch (e) {
      print(e.toString());
    } finally {
      getDraftId();
    }
  }

  // Future<void> saveSecondDraft1() async {
  //   await convertProgramData();
  //   selectedActivityIncludesId = activitiesId.join(",");
  //   List<Uint8List> banners = [];
  //   imageList.forEach((element) {
  //     banners.add(element.readAsBytesSync());
  //   });
  //   try {
  //     var request = http.MultipartRequest(
  //       "POST",
  //       Uri.parse(
  //           //${Constants.baseUrl}SIT
  //           "${Constants.baseUrl}/api/v1/second_page_service"),
  //     );
  //     dynamic programData = {
  //       "provider_id": Constants.profile.bp.id.toString(),
  //       "service_id": serviceId.toString(),
  //       "write_information": infoController.text.trim(),
  //       "available_seats": availableSeatsController.text.trim(),
  //       "service_sector": sectorId.toString(),
  //       "service_category": categoryId.toString(),
  //       "service_type": typeId.toString(),
  //       "service_level": levelId.toString(),
  //       "duration": durationId.toString(),
  //       'region': regionId.toString(),
  //       "service_for": selectedActivitesId,
  //       "dependency": selectedDependencyId,
  //       "service_plan": sPlan.toString(),
  //       "service_plan_days": servicePlanId,
  //       "particular_date": ConstantsCreateNewServices.startDate,
  //       "start_date": ConstantsCreateNewServices.startDate.toString(),
  //       "end_date": ConstantsCreateNewServices.endDate.toString(),
  //       "activities": selectedActivityIncludesId,
  //       'adventure_name': adventureName.text,
  //       "country": Constants.countryId.toString(),
  //       //ConstantsCreateNewServices.selectedRegionId
  //       ////endDate, //"",
  //       // it is for particular week or calender
  //       "cost_inc":
  //           Constants.getTranslatedNumber(costOne.text), //setCost1.text, //"",
  //       "cost_exc": Constants.getTranslatedNumber(
  //           costTwo.text), //costTwo.text, //setCost2.text, //"",
  //       "currency": "1", //  %%% this is hardcoded
  //       "pre_requisites":
  //           preRequisites.text, //"", //preReqController.text, //"",
  //       "minimum_requirements":
  //           minimumRequirement.text, //minController.text, //"",
  //       "terms_conditions": terms.text, //tncController.text, //"",
  //       "recommended": "1", // this is hardcoded
  //       // this key needs to be discussed,
  //       //"5", // activityId, //"",
  //       "specific_address": specificAddressController
  //           .text, //"", //iLiveInController.text, //"",
  //       //selectedDependencyId.toString(), //["1", "2", "3"],
  //       "latitude": //"27.0546", //
  //           ConstantsCreateNewServices.lat.toString(), //lat.toString(), //"",
  //       "longitude": //"57.05650"
  //           ConstantsCreateNewServices.lng.toString(), //lng.toString(), //"",
  //     };

  //     request.fields.addAll(programData);
  //     final response = await request.send();
  //     log(response.toString());
  //     debugPrint(response.statusCode.toString());
  //     // print(response.body);
  //     //print(response.headers);
  //     //clearAll();
  //     //showConfirmation();
  //     //close();
  //   } catch (e) {
  //     print(e.toString());
  //   } finally {
  //     clearProgramdata();
  //   }
  // }

  Future<void> saveSecondDraft() async {
    await convertProgramData();
    checkPlanTwo();
    List<String> d = [
      formattedDate,
      //ConstantsCreateNewServices.startDate.toString(),
      endDate,
    ];
    String particularDate = d.join(",");
    selectedActivityIncludesId = activitiesId.join(",");
    try {
      var response = await http.post(
          Uri.parse("${Constants.baseUrl}/api/v1/second_page_service"),
          body: {
            "provider_id": Constants.userId.toString(),
            "service_id": serviceId.toString(),
            "write_information": infoController.text.trim(),
            "available_seats": availableSeatsController.text.trim(),
            "service_sector": sectorId.toString(),
            "service_category": categoryId.toString(),
            "service_type": typeId.toString(),
            "service_level": levelId.toString(),
            "duration": durationId.toString(),
            'region': regionId.toString(),
            "service_for": selectedActivitesId,
            "dependency": selectedDependencyId,
            "service_plan": sPlan.toString(),
            "service_plan_days": servicePlanId, //"1,2",
            "particular_date":
                particularDate, //ConstantsCreateNewServices.startDate,
            "start_date":
                formattedDate, //ConstantsCreateNewServices.startDate.toString(),
            "end_date":
                endDate, //ConstantsCreateNewServices.endDate.toString(),
            "activities": selectedActivityIncludesId,
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {}
    } catch (e) {
      print(e.toString());
    } finally {
      clearProgramdata();
    }
  }

  void deleteData(int index) {
    setState(() {
      onePlan.removeAt(index);
    });
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
            text: 'createAdventure'.tr(),
            color: bluishColor,
            weight: FontWeight.bold,
          ),
        ),
        body: loading
            ? const LoadingWidget()
            : SingleChildScrollView(
                controller: heightController,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MyText(
                          text: 'justFollowSimpleFourStepsToListUpYourAdventure'
                              .tr(),
                          size: 12,
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
                        size: 85,
                        selectedColor: bluishColor,
                        unselectedColor: greyColor,
                        customStep: (index, color, _) => color == bluishColor
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                        decoration: BoxDecoration(
                                            color: bluishColor,
                                            borderRadius:
                                                BorderRadius.circular(65)),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      MyText(
                                        text: stepTitle[index],
                                        color: bluishColor,
                                        weight: FontWeight.w700,
                                        fontFamily: 'Roboto',
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                        decoration: BoxDecoration(
                                            color: greyColor3,
                                            borderRadius:
                                                BorderRadius.circular(65)),
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
                                  MyText(
                                    text: stepTitle[index],
                                    color: greyColor,
                                    weight: FontWeight.w700,
                                    fontFamily: 'Roboto',
                                    size: 12,
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Text((selectedActivitesId.join(""))),
                      IndexedStack(
                        index: count,
                        children: [
                          BannerPage(getImages, adventureName),
                          CreateServicesDescription(
                            getActivityIds: getActivityId,
                            tapped: getIds,
                            available: availableSeatsController,
                            info: infoController,
                            aimedFor: Wrap(
                              direction: Axis.vertical,
                              children: List.generate(
                                aimedFilter.length,
                                (index) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: CheckboxListTile(
                                      secondary: Image.network(
                                        "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${aimedFilter[index].image}",
                                        height: 36,
                                        width: 26,
                                      ),
                                      // contentPadding: const EdgeInsets.only(
                                      //     left: 0, top: 0, bottom: 0, right: 0),
                                      side:
                                          const BorderSide(color: bluishColor),
                                      checkboxShape:
                                          const RoundedRectangleBorder(
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
                                        aimed();
                                      }),
                                      title: MyText(
                                        text:
                                            //aimedText[index],
                                            aimedFilter[index].aimedName.tr(),
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
                            daysBeforeActController: daysExpiry,
                            servicePlan: Column(
                              children: [
                                particularWeek == false
                                    ? SizedBox(
                                        height: 150,
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: MyText(
                                                text: 'servicePlan'.tr(),
                                                color: blackTypeColor1,
                                                align: TextAlign.center,
                                                weight: FontWeight.bold,
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                        activeColor:
                                                            bluishColor,
                                                        checkColor: whiteColor,
                                                        side: const BorderSide(
                                                            color: bluishColor,
                                                            width: 2),
                                                        value:
                                                            particularWeekDays,
                                                        onChanged:
                                                            (bool? value) {
                                                          addServicePlan();
                                                        }),
                                                    MyText(
                                                      text:
                                                          'everyParticularWeekDays'
                                                              .tr(),
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
                                                            color:
                                                                blackTypeColor,
                                                            align: TextAlign
                                                                .center,
                                                            size: 14,
                                                            weight:
                                                                FontWeight.w500,
                                                          ),
                                                          Checkbox(
                                                            activeColor:
                                                                bluishColor,
                                                            checkColor:
                                                                whiteColor,
                                                            value: daysValue[
                                                                index],
                                                            onChanged:
                                                                (bool? value) {
                                                              if (particularWeekDays) {
                                                                setState(
                                                                  () {
                                                                    daysValue[
                                                                            index] =
                                                                        value!;
                                                                  },
                                                                );
                                                              }
                                                              if (particularWeekDays ==
                                                                  false) {
                                                                setState(() {
                                                                  daysValue[
                                                                          index] =
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
                                          ],
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 1,
                                        width: 1,
                                      ),
                                const SizedBox(height: 10),
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
                                                    onChanged: (bool? value) {
                                                      daysPlan();
                                                    }),
                                                MyText(
                                                  text:
                                                      'everyParticularCalenderDate'
                                                          .tr(),
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
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 0),
                                                      //width: MediaQuery.of(context).size.width / 1,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
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
                                                        leading: SizedBox(
                                                          width: 10,
                                                          child: Text(
                                                            formattedDate
                                                                .toString()
                                                                .tr(),
                                                            style: TextStyle(
                                                                color: blackColor
                                                                    .withOpacity(
                                                                        0.6),
                                                                fontSize: 14),
                                                          ),
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
                                                    onTap: () => _selectDate(
                                                        context, endDate),
                                                    child: Container(
                                                      height: 50,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 0),
                                                      //width: MediaQuery.of(context).size.width / 1,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
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
                                                        leading: SizedBox(
                                                          width: 20,
                                                          child: Text(
                                                            endDate.toString(),
                                                            style: TextStyle(
                                                                color: blackColor
                                                                    .withOpacity(
                                                                        0.6),
                                                                fontSize: 14),
                                                          ),
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
                                    : const SizedBox(
                                        height: 1,
                                        width: 1,
                                      ),
                              ],
                            ),
                            dependency: Wrap(
                              direction: Axis.vertical,
                              children:
                                  List.generate(dependencyText.length, (index) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: CheckboxListTile(
                                    secondary: Image.network(
                                      "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${dependencyList[index].name}",
                                      height: 36,
                                      width: 26,
                                    ),
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
                                      dependency();
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
                          particularWeekDays
                              ? SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (int y = 0; y < onePlan.length; y++)
                                        CreatePlanOne(
                                            getProgramOneData, y, deleteData),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: addProgramOneData,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            const Image(
                                                image: ExactAssetImage(
                                                    'images/add-circle.png'),
                                                height: 20),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            MyText(
                                              text: 'addMoreSchedule'.tr(),
                                              color: bluishColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      // for (int z = 0; z < pm.length; z++)
                                      CreateProgram(
                                          parseData:
                                              // key: ValueKey(z.toString()),
                                              getProgramData,
                                          deleteProgramData,
                                          startDate,
                                          currentDate
                                          //z,
                                          //pm[z],
                                          ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // GestureDetector(
                                      //   onTap: addProgramData,
                                      //   child: Row(
                                      //     mainAxisAlignment: MainAxisAlignment.end,
                                      //     children: [
                                      //       const Image(
                                      //           image: ExactAssetImage(
                                      //               'images/add-circle.png'),
                                      //           height: 20),
                                      //       const SizedBox(
                                      //         width: 5,
                                      //       ),
                                      //       MyText(
                                      //         text: 'addMoreSchedule',
                                      //         color: bluishColor,
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                          Cost(
                            iLiveInController,
                            lat,
                            lng,
                            specificAddressController,
                            costOne,
                            costTwo,
                            preRequisites,
                            minimumRequirement,
                            terms,
                          ),
                          // Container(child: Text("testting"))
                        ],
                      )
                    ],
                  ),
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
          leading: SizedBox(
            width: 20,
            child: Text(
              i.toString(),
              style: TextStyle(color: blackColor.withOpacity(0.6)),
            ),
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
                leading: SizedBox(
                  width: 20,
                  child: Text(
                    "${sd.hour.toString().padLeft(2, "0")} : ${sd.minute.toString().padLeft(2, '0')}",
                    style: TextStyle(color: blackColor.withOpacity(0.6)),
                  ),
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
                leading: SizedBox(
                  width: 20,
                  child: Text(
                    "${ed.hour.toString().padLeft(2, "0")} : ${ed.minute.toString().padLeft(2, '0')}",
                  ),
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
