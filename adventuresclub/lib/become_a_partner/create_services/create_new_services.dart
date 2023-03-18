// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:io';
import 'package:adventuresclub/become_a_partner/create_services/create_services_description.dart';
import 'package:adventuresclub/complete_profile/banner_page.dart';
import 'package:adventuresclub/complete_profile/cost.dart';
import 'package:adventuresclub/complete_profile/program.dart';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_create_new_services.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/widgets/buttons/bottom_button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
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
  String selectedRegion = "";
  int selectedSectorId = 0;
  List text = ['Banner', 'Description', 'Program', 'Cost/GeoLoc'];
  List text1 = ['1', '2', '3', '4'];
  int count = 0;
  List<File> imageList = [];
  List<AimedForModel> aimedFilter = [];
  List<bool> aimedValue = [];
  List aimedText = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    infoController.dispose();
    adventureName.dispose();
    availableSeatsController.dispose();
    super.dispose();
  }

  void getData() {
    aimedFilter = Constants.am;
    parseAimed(Constants.am);
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
    // Provider.of<CompleteProfileProvider>(context, listen: false)
    //     .aimedLevel(a, id);
  }

  void next() {
    if (count == 0 && imageList.length < 2) {
      MyText(text: "Please add Image");
    }
    setState(() {
      count++;
      ConstantsCreateNewServices.number++;
    });
    print(count);
  }

  void previous() {
    if (count == 0) {
      Navigator.of(context).pop();
    }
    setState(() {
      count--;
      ConstantsCreateNewServices.number--;
    });
  }

  void getImages(List<File> imgList) {
    imageList = imgList;
  }

  void getDescriptionData(TextEditingController name) {
    name = adventureName;
  }

  void createService() async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/create_service"),
          body: {
            'customer_id': Constants.userId, //"27",
            'adventure_name':
                adventureName.text, //adventureNameController.text,
            "country": Constants.countryId,
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
            "write_information": "", //infoController.text, //"",
            "service_plan": "",
            "cost_inc": "", //setCost1.text, //"",
            "cost_exc": "", //setCost2.text, //"",
            "currency": "1", //  %%% this is hardcoded
            "pre_requisites": "", //preReqController.text, //"",
            "minimum_requirements": "", //minController.text, //"",
            "terms_conditions": "", //tncController.text, //"",
            "recommended": "1", // this is hardcoded
            // this key needs to be discussed,
            "service_plan_days": "", //// %%%%this needs discussion
            "particular_date": "", //gatheringDate, //"",
            "schedule_title": "", //scheduleController.text, //"",
            // schedule title in array is skipped
            "gathering_date": "", //gatheringDate, //"",
            // api did not accept list here
            "activities": ConstantsCreateNewServices.selectedActivitesId
                .toString(), //"5", // activityId, //"",
            "specific_address": "", //iLiveInController.text, //"",
            // this is a wrong field only for testing purposes....
            "gathering_start_time": "", //gatheringDate, //"",
            "program_description": "", //scheduleDesController.text, //"",
            "service_for": "1,2,5", //"4", //["1", "4", "5", "7"], //"",
            "dependency": "2", //["1", "2", "3"],
            "banners": "", //adventureOne.toString(), //"",
            "latitude": "", //lat.toString(), //"",
            "longitude": "", //lng.toString(), //"",
            // 'mobile_code': ccCode,
          });
      // var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      print(response.statusCode);
      print(response.body);
      print(response.headers);
      // print(decodedResponse['data']['user_id']);
    } catch (e) {
      print(e.toString());
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
                            )),
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
            Expanded(
              child: IndexedStack(
                index: count,
                children: [
                  BannerPage(getImages),
                  CreateServicesDescription(
                    TFWithSize('Available Seats', availableSeatsController, 16,
                        lightGreyColor, 2.4),
                    adventureName,
                    infoController,
                    Wrap(
                      direction: Axis.vertical,
                      children: List.generate(aimedFilter.length, (index) {
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
                      }),
                    ),
                  ),
                  const Program(),
                  const Cost(),
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
