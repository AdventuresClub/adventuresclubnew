// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:io';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/google_page.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class OfficialDetails extends StatefulWidget {
  const OfficialDetails({super.key});

  @override
  State<OfficialDetails> createState() => _OfficialDetailsState();
}

class _OfficialDetailsState extends State<OfficialDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addController = TextEditingController();
  TextEditingController geoController = TextEditingController();
  TextEditingController crName = TextEditingController();
  TextEditingController crNumber = TextEditingController();
  TextEditingController payPalId = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController accountName = TextEditingController();
  TextEditingController accountNum = TextEditingController();
  TextEditingController iLiveInController = TextEditingController();
  String locationMessage = "Getting location ...";
  String userlocation = "";
  bool loading = false;
  double lat = 0;
  double lng = 0;
  bool value = true;
  bool value1 = false;
  String license = "No";
  File crCopy = File("");
  String name = "";
  String location = "";
  String address = "";
  String crNameText = "";
  String crNumberText = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    changeValue();
    setState(() {
      name = Constants.profile.bp.companyName;
      address = Constants.profile.bp.address;
      location = Constants.profile.bp.location;
      crNameText = Constants.profile.bp.crName;
      crNumberText = Constants.profile.bp.crNumber;
    });
  }

  void changeValue() {
    if (Constants.profile.bp.license == "No") {
      setState(() {
        value = true;
      });
    } else {
      setState(() {
        value = false;
      });
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
            var myLoc = "${placeMark.locality!}, ${placeMark.country}";
            setState(() {
              loading = false;
            });
            iLiveInController.text = myLoc;
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
    iLiveInController.text = loc;
    lat = lt;
    lng = lg;
    setState(
      () {
        userlocation = loc;
      },
    );
    // addLocation(iLiveInController, lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TFWithSize(name, nameController, 12, lightGreyColor, 1),
            const SizedBox(height: 20),
            TFWithSize(address, addController, 12, lightGreyColor, 1),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              child: TextField(
                controller: iLiveInController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  hintText: location,
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
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: MyText(
                text: 'Are you having License?',
                color: blackTypeColor1,
                align: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Checkbox(
                    value: value,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    onChanged: (bool? valuee1) {
                      setState(() {
                        value = valuee1!;
                        value1 = false;
                        license = "No";
                      });
                      print(license);
                    }),
                MyText(
                  text: 'I’m not licensed yet, will sooner get license',
                  color: blackTypeColor,
                  align: TextAlign.center,
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: value1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    onChanged: (bool? value2) {
                      setState(() {
                        value1 = value2!;
                        value = false;
                        license = "Yes";
                      });
                      print(license);
                    }),
                MyText(
                  text: 'Yes! I am lincensed',
                  color: blackTypeColor,
                  align: TextAlign.center,
                ),
              ],
            ),
            //if (value1 == true)
            Column(
              children: [
                const SizedBox(height: 20),
                TFWithSize(crNameText, crName, 12, lightGreyColor, 1),
                const SizedBox(height: 20),
                TFWithSize(crNumberText, crNumber, 12, lightGreyColor, 1),
                const SizedBox(height: 20),
                GestureDetector(
                  //onTap: addMedia,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: lightGreyColor,
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: greyColor.withOpacity(0.4))),
                      child: Column(children: [
                        crCopy.path.isEmpty
                            ? const Image(
                                image: ExactAssetImage('images/upload.png'),
                                height: 50,
                              )
                            : Image.file(
                                crCopy,
                                height: 50,
                                width: 50,
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyText(
                          text: 'Attach CR copy',
                          color: blackTypeColor1,
                          align: TextAlign.center,
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Button(
                'Save',
                greenishColor,
                greenishColor,
                whiteColor,
                18,
                () {},
                Icons.add,
                whiteColor,
                false,
                1.3,
                'Raleway',
                FontWeight.w600,
                16),
          ],
        ),
      ),
    );
  }
}
