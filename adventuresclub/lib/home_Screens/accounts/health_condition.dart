// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, unused_local_variable

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/health_condition_model.dart';
import 'package:adventuresclub/models/weightnheight_model.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HealthCondition extends StatefulWidget {
  const HealthCondition({super.key});

  @override
  State<HealthCondition> createState() => _HealthConditionState();
}

class _HealthConditionState extends State<HealthCondition> {
  TextEditingController kGcontroller = TextEditingController();
  TextEditingController cMcontroller = TextEditingController();
  Map mapCountry = {};
  List<HealthConditionModel> healthList = [];
  List<WnHModel> weightList = [];
  List<WnHModel> heightList = [];
  List<bool> healthValue = [];
  List<String> currentHealth = [];
  List<HealthConditionModel> selectedHealth = [];
  bool loading = false;
  String selectedHealthId = "";
  var getWeight = 'Weight';
  var getheight = 'Height';
  List<bool> value1 = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List<String> text = [
    'Good Condition',
    'Bone Weakness',
    'Bone Difficulty',
    'Mussels Issue',
    'Backbone Issue',
    'Joints Issue',
    'Ligament Issue',
    'Not Good Condition',
    'Weight & Height'
  ];
  TextEditingController heightController = TextEditingController();
  int ft = 0;
  int inches = 0;
  String cm = '';
  List pickWeight = [
    '10KG (22 Pounds)',
    '11KG (24.2 Pounds)',
    '12KG (26.4 Pounds)'
  ];
  List pickHeight = [
    '50CM (19.7Inch)',
    '51CM (20Inch)',
    '52CM (20.5Inch)',
    '53CM (20.8Inch)',
    '54CM (21.30Inch)',
    '55CM (20Inch)',
    '56CM (20Inch)',
    '57CM (22.4Inch)',
    '58CM (22.8Inch)',
    '59CM (23.2Inch)',
  ];
  abc() {}

  @override
  void initState() {
    super.initState();
    Constants.getProfile();
    getHealth();
  }

  Future getWeightNHeight() async {
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/get_heights_weights"));
    if (response.statusCode == 200) {
      mapCountry = json.decode(response.body);
      dynamic result = mapCountry['data'];
      List<dynamic> height = result['heights'];
      height.forEach((h) {
        int id = int.tryParse(h['Id'].toString()) ?? 0;
        WnHModel heightModel = WnHModel(
          id,
          h['heightName'] ?? "",
          h['image'].toString() ?? "",
          h['deleted_at'].toString() ?? "",
          h['created_at'].toString() ?? "",
          h['updated_at'].toString() ?? "",
        );
        heightList.add(heightModel);
      });
      List<dynamic> weight = result['weights'];
      weight.forEach((w) {
        int id = int.tryParse(w['Id'].toString()) ?? 0;
        WnHModel weightModel = WnHModel(
          id,
          w['weightName'] ?? "",
          w['image'].toString() ?? "",
          w['deleted_at'].toString() ?? "",
          w['created_at'].toString() ?? "",
          w['updated_at'].toString() ?? "",
        );
        weightList.add(weightModel);
      });
    }
  }

  Future getHealth() async {
    await getWeightNHeight();
    setState(() {
      loading = true;
    });
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/get_healths"));
    if (response.statusCode == 200) {
      mapCountry = json.decode(response.body);
      List<dynamic> result = mapCountry['data'];
      result.forEach((element) {
        HealthConditionModel hc =
            HealthConditionModel(element['id'], element['name']);
        healthList.add(hc);
      });
    }
    getHealthValues();
  }

  void getHealthValues() {
    healthList.forEach((element) {
      //for (int i = 0; i <)
      healthValue.add(false);
    });
    setState(() {
      loading = false;
    });
    getCurrentHealth();
  }

  void getCurrentHealth() {
    Constants.profile.healthConditionsId;
    getWeight = Constants.profile.weight;
    getheight = Constants.profile.height;
    currentHealth = Constants.profile.healthCondtions.split(",");
    for (int i = 0; i < healthList.length; i++) {
      for (int y = 0; y < currentHealth.length; y++) {
        if (healthList[i].healthCondition == currentHealth[y]) {
          healthValue[i] = true;
          break;
        }
      }
    }
    setState(() {});
    print(currentHealth);
  }

  void health() {
    List<HealthConditionModel> f = [];
    for (int i = 0; i < healthValue.length; i++) {
      if (healthValue[i]) {
        f.add(healthList[i]);
      }
    }
    healthParse(f);
  }

  void healthParse(List<HealthConditionModel> am) async {
    List<String> a = [];
    List<int> id = [];
    am.forEach((element) {
      a.add(element.healthCondition);
      id.add(element.id);
    });
    // String resultString = id.join(",");
    setState(() {
      selectedHealthId = id.join(",");
    });
    print(selectedHealthId);
  }

  void editHealth() async {
    health();
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/update_health_conditions"),
          body: {
            'user_id': Constants.userId.toString(), //ccCode.toString(),
            "health_conditions": selectedHealthId,
            "height": getheight.toString(),
            "weight": getWeight.toString(),
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        Constants.getProfile();
        cancel();
        message("Health Condition Amended");
      }
      // setState(() {
      //   userID = decodedResponse['data']['user_id'];
      // });
      print(response.statusCode);
    } catch (e) {
      print(e.toString());
    }
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: greyProfileColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1.5,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Image.asset(
              'images/backArrow.png',
              height: 20,
            ),
          ),
          title: GestureDetector(
            onTap: getHealth,
            child: MyText(
              text: 'Health Condition',
              color: bluishColor,
              weight: FontWeight.bold,
            ),
          ),
        ),
        body: loading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 5,
                  ),
                  MyText(
                    text: "Loading",
                    size: 14,
                    weight: FontWeight.bold,
                  )
                ],
              )
            : SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(children: [
                      Wrap(
                        children: List.generate(healthList.length, (index) {
                          return Column(
                            children: [
                              CheckboxListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 6),
                                side: const BorderSide(color: bluishColor),
                                checkboxShape: const RoundedRectangleBorder(
                                  side: BorderSide(color: bluishColor),
                                ),
                                visualDensity: const VisualDensity(
                                    horizontal: -2, vertical: -4),
                                activeColor: bluishColor,
                                checkColor: whiteColor,
                                value: healthValue[index],
                                onChanged: ((bool? value2) {
                                  setState(() {
                                    healthValue[index] = value2!;
                                  });
                                  //  health();
                                }),
                                title: MyText(
                                  text: healthList[index].healthCondition,
                                  color: greyColor,
                                  fontFamily: 'Raleway',
                                  size: 16,
                                ),
                              ),
                              // if (text[index] != "Weight & Height")
                              //   const Divider(
                              //     endIndent: 6,
                              //     indent: 6,
                              //     color: blackTypeColor3,
                              //   ),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        endIndent: 6,
                        indent: 6,
                        color: blackTypeColor3,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MyText(
                          text: "Weight & Height",
                          weight: FontWeight.w500,
                          color: blackColor.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: pickingWeight(
                                  context, getWeight, true, weightList)),
                          //TFWithSuffixText('60', kGcontroller,'KG'),

                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: pickingWeight(
                                  context, getheight, false, heightList))
                        ],
                      ),
                      const SizedBox(height: 20),
                      Button(
                          'Update',
                          bluishColor,
                          bluishColor,
                          whiteColor,
                          18,
                          editHealth,
                          Icons.add,
                          whiteColor,
                          false,
                          1.6,
                          'Roboto',
                          FontWeight.w400,
                          16),
                      const SizedBox(height: 20),
                    ])),
              ));
  }

  Widget pickingWeight(
      context, String genderName, bool showWidget, List<WnHModel> itemList) {
    return Card(
      elevation: 1,
      color: whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
          onTap: () => showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
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
                                  text: showWidget == true
                                      ? 'Weight in Kg'
                                      : 'Height in CM',
                                  weight: FontWeight.bold,
                                  color: blackColor,
                                  size: 12,
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
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      child: CupertinoPicker(
                                          itemExtent: 82.0,
                                          diameterRatio: 22,
                                          backgroundColor: whiteColor,
                                          onSelectedItemChanged: (int index) {
                                            print(index + 1);
                                            showWidget
                                                ? setState(() {
                                                    getWeight = itemList[index]
                                                        .heightName;
                                                  })
                                                : setState(() {
                                                    getheight = itemList[index]
                                                        .heightName;
                                                  });
                                          },
                                          selectionOverlay:
                                              const CupertinoPickerDefaultSelectionOverlay(
                                            background: transparentColor,
                                          ),
                                          children: List.generate(
                                              itemList.length, (index) {
                                            return Center(
                                              child: MyText(
                                                  text: itemList[index]
                                                      .heightName,
                                                  size: 14,
                                                  color: blackTypeColor4),
                                            );
                                          })),
                                    ),
                                    Positioned(
                                      top: 70,
                                      child: Container(
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: blackColor
                                                        .withOpacity(0.7),
                                                    width: 1.5),
                                                bottom: BorderSide(
                                                    color: blackColor
                                                        .withOpacity(0.7),
                                                    width: 1.5))),
                                      ),
                                    )
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
                          )
                        ],
                      ),
                    ));
              }),
          tileColor: transparentColor,
          selectedTileColor: whiteColor,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          title: MyText(
            text: genderName,
            color: blackColor.withOpacity(0.6),
            size: 12,
            weight: FontWeight.w500,
          ),
          trailing: const Image(
            image: ExactAssetImage('images/ic_drop_down.png'),
            height: 16,
            width: 16,
          )),
    );
  }
}
