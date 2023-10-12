// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, avoid_function_literals_in_foreach_calls

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_create_new_services.dart';
import 'package:adventuresclub/google_page.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:adventuresclub/temp_google_map.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:adventuresclub/widgets/text_fields/multiline_field.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

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
  String glocation = "";
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
                          text: 'activitiesIncludes',
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
                          'okGotIt',
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
    //  glocation = location;
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

  void openGoogle() {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) {
          return TempGoogleMap(setLocation);
        },
      ),
    );
  }

  abc() {}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              controller: widget.iliveController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                hintText: 'enterGeolocation',
                filled: true,
                fillColor: lightGreyColor,
                suffixIcon: GestureDetector(
                  onTap: openGoogle,
                  child: const Image(
                    image: ExactAssetImage('images/map-symbol.png'),
                    height: 15,
                    width: 20,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide:
                      BorderSide(color: greyColor.withOpacity(0.5), width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide:
                      BorderSide(color: greyColor.withOpacity(0.5), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide:
                      BorderSide(color: greyColor.withOpacity(0.5), width: 1.5),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TFWithSize(
            'typeSpecificAddress/Location',
            widget.specificAddress,
            15,
            lightGreyColor,
            1,
            type: true,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TFWithSize(
                  show: TextInputType.number,
                  'setCost',
                  widget.costOne,
                  16,
                  lightGreyColor,
                  3.4,
                  type: true,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              // Expanded(
              //   child: TFWithSize(
              //     show: TextInputType.number,
              //     'setCost',
              //     widget.costTwo,
              //     16,
              //     lightGreyColor,
              //     3.4,
              //     type: true,
              //   ),
              // ),
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
                        color: greyColor.withOpacity(0.5), width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: MyText(
                      text: "omr", //getCountry.toString(),
                      color: blackTypeColor.withOpacity(0.5),
                      size: 14,
                      weight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              //DdButton(5.5)
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              SizedBox(
                width: 190,
                child: MyText(
                  text: "includingGears",
                  color: redColor,
                  size: 12,
                  weight: FontWeight.bold,
                ),
              ),
              // SizedBox(
              //   width: 130,
              //   child: MyText(
              //     text: "excludingGears",
              //     color: redColor,
              //     size: 12,
              //     weight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
          // Row(
          //         children: [
          //           MyText(
          //             text: "Including Gears & Other Taxes",
          //             color: redColor,
          //             size: 12,
          //             weight: FontWeight.bold,
          //           ),
          //           MyText(
          //             text: "Excluding Gears & Other Taxes",
          //             color: redColor,
          //             size: 12,
          //             weight: FontWeight.bold,
          //           )
          //         ],
          //       ),
          const SizedBox(height: 10),
          // Align(
          //     alignment: Alignment.centerLeft,
          //     child: MyText(
          //       text: 'Terms and conditions',
          //       color: blackTypeColor,
          //       weight: FontWeight.w500,
          //     )),
          MultiLineField(
            'prerequisites',
            5,
            lightGreyColor,
            widget.preRequisites,
            show: true,
          ),
          const SizedBox(height: 10),
          MultiLineField(
            'minimumRequirements',
            5,
            lightGreyColor,
            widget.minimumRequirement,
            show: true,
          ),
          const SizedBox(height: 10),
          MultiLineField(
            'termsAndConditions',
            4,
            lightGreyColor,
            widget.terms,
            show: true,
          ),
        ]),
      ),
    );
  }
}
