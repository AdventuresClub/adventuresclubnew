// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_create_new_services.dart';
import 'package:adventuresclub/google_page.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:adventuresclub/widgets/text_fields/multiline_field.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class Cost extends StatefulWidget {
  final TextEditingController iliveController;
  final TextEditingController specificAddress;
  final TextEditingController costOne;
  final TextEditingController costTwo;
  final TextEditingController preRequisites;
  final TextEditingController minimumRequirement;
  final TextEditingController terms;
  const Cost(this.iliveController, this.specificAddress, this.costOne,
      this.costTwo, this.preRequisites, this.minimumRequirement, this.terms,
      {super.key});

  @override
  State<Cost> createState() => _CostState();
}

class _CostState extends State<Cost> {
  TextEditingController controller = TextEditingController();

  int countryId = 0;
  TextEditingController scheduleController = TextEditingController();
  String locationMessage = "Getting location ...";
  String userlocation = "";
  bool loading = false;
  double lat = 0;
  double lng = 0;
  void addActivites() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 0),
                    const Image(
                      image: ExactAssetImage('images/check_circle.png'),
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 10),
                      child: MyText(
                          text: 'Activities Included',
                          weight: FontWeight.bold,
                          color: blackColor,
                          size: 14,
                          fontFamily: 'Raleway'),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15),
                      child: Button(
                          'Okay ,Got it',
                          greenishColor,
                          greyColorShade400,
                          whiteColor,
                          16,
                          goToBottomNavigation,
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
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose(); // dispose the PageController
    //_timer.cancel();
  }

  void goToBottomNavigation() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const BottomNavigation();
        },
      ),
    );
  }

  void createService() async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/create_service"),
          body: {
            'customer_id': "3",
            'adventure_name': "",
            "country_id": Constants.countryId,
            'region': "",

            // 'mobile_code': ccCode,
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      print(response.statusCode);
      print(response.body);
      print(response.headers);
      print(decodedResponse['data']['user_id']);
    } catch (e) {
      print(e.toString());
    }
  }

  void getMyLocation() async {
    if (!loading) {
      setState(() {
        loading = true;
      });
      String locationData = await Constants.getLocation();
      List<String> location = locationData.split(":");
      lat = double.tryParse(location[0]) ?? 0;
      lng = double.tryParse(location[1]) ?? 0;
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        bool found = false;
        placemarks.forEach((placeMark) async {
          if (!found && placeMark.locality != "" && placeMark.country != "") {
            var myLoc =
                placeMark.locality! + ", " + placeMark.country.toString();
            setState(() {
              loading = false;
            });
            widget.iliveController.text = myLoc;
            userlocation = myLoc;
            //addLocation(iLiveInController);
          }
        });
      } else {
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.green.shade800,
            ),
            child: const ListTile(
              tileColor: redColor,
              minLeadingWidth: 20,
              leading: Icon(Icons.info, color: whiteColor),
              title: Text(
                'Saved',
                style: TextStyle(
                  fontSize: 15,
                  color: whiteColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
        setState(() {
          loading = false;
        });
      }
    }
  }

  void openMap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) {
          return GoogleMapPage(setLocation);
        },
      ),
    );
  }

  void setLocation(String loc, double lt, double lg) {
    Navigator.of(context).pop();
    widget.iliveController.text = loc;
    lat = lt;
    lng = lg;
    setState(
      () {
        userlocation = loc;
      },
    );
    addLocation(lat, lng);
  }

  void addLocation(lat, lng) {
    setState(() {
      ConstantsCreateNewServices.lat = lat;
      ConstantsCreateNewServices.lng = lng;
    });
  }

  abc() {}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1,
            child: TextField(
              controller: widget.iliveController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                hintText: 'Enter: Geolocation',
                filled: true,
                fillColor: lightGreyColor,
                suffixIcon: GestureDetector(
                  onTap: openMap,
                  child: const Image(
                    image: ExactAssetImage('images/map-symbol.png'),
                    height: 15,
                    width: 20,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: greyColor.withOpacity(0.2)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: greyColor.withOpacity(0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: greyColor.withOpacity(0.2)),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TFWithSize('Type Specific Address/Location', widget.specificAddress,
              15, lightGreyColor, 1),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TFWithSize(
                  'Set Cost',
                  widget.costOne,
                  16,
                  lightGreyColor,
                  3.4,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TFWithSize(
                  'Set Cost',
                  widget.costTwo,
                  16,
                  lightGreyColor,
                  3.4,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 50,
                  //width: MediaQuery.of(context).size.width / 2.4,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    border: Border.all(
                        color: greyColor.withOpacity(0.2), width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: MyText(
                    text: "OMR", //getCountry.toString(),
                    color: blackTypeColor.withOpacity(0.5),
                    size: 14,
                    weight: FontWeight.w500,
                  ),
                ),
              ),
              //DdButton(5.5)
            ],
          ),
          const SizedBox(height: 15),
          // Align(
          //     alignment: Alignment.centerLeft,
          //     child: MyText(
          //       text: 'Terms and conditions',
          //       color: blackTypeColor,
          //       weight: FontWeight.w500,
          //     )),
          const SizedBox(height: 20),
          MultiLineField(
              'Type Pre-Requisites….', 5, lightGreyColor, widget.preRequisites),
          const SizedBox(height: 20),
          MultiLineField('Type Minimum Requirement....', 5, lightGreyColor,
              widget.minimumRequirement),
          const SizedBox(height: 20),
          MultiLineField(
              'Type Terms & Conditions.....', 4, lightGreyColor, widget.terms),
        ]),
      ),
    );
  }
}
