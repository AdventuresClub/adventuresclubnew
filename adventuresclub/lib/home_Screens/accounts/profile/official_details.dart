// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/temp_google_map.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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
  bool isLicensed = false;
  bool haveLicense = false;
  String license = "No";
  File crCopy = File("");
  String name = "";
  String location = "";
  String address = "";
  String crNameText = "";
  String crNumberText = "";
  final picker = ImagePicker();
  String uniqueId = "";
  DateTime? today = DateTime.now();
  int crNum = 0;
  int accNum = 0;
  Uint8List crcopyList = Uint8List(0);
  String licenseImage = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    changeValue();
    iLiveInController.text = Constants.profile.bp.location;
    nameController.text = Constants.profile.bp.companyName;
    addController.text = Constants.profile.bp.address;
    crName.text = Constants.profile.bp.crName;
    crNumber.text = Constants.profile.bp.crNumber;
    setState(() {
      name = Constants.profile.bp.companyName;
      address = Constants.profile.bp.address;
      location = Constants.profile.bp.location;
      crNameText = Constants.profile.bp.crName;
      crNumberText = Constants.profile.bp.crNumber;
      licenseImage = Constants.profile.bp.crCopy;
    });
  }

  void changeValue() {
    if (Constants.profile.bp.license == "No") {
      setState(() {
        isLicensed = true;
        haveLicense = false;
        license = "No";
      });
    } else {
      setState(() {
        isLicensed = false;
        haveLicense = true;
        license = "Yes";
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
          return TempGoogleMap(setLocation);
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

  void licenseStatus() {
    if (haveLicense) {
      setState(() {
        license = "Yes";
        isLicensed = false;
      });
    } else {
      setState(() {
        license = "No";
        isLicensed = true;
      });
    }
  }

  void addMedia() async {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text("From ?"),
        children: [
          GestureDetector(
            onTap: () => pickMedia(
              "Camera",
            ),
            child: const ListTile(
              title: Text("Camera"),
            ),
          ),
          GestureDetector(
            onTap: () => pickMedia(
              "Gallery",
            ),
            child: const ListTile(
              title: Text("Gallery"),
            ),
          ),
        ],
      ),
    );
  }

  void pickMedia(String from) async {
    Navigator.of(context).pop();
    setState(() {
      loading = true;
    });
    final XFile? photo = await picker.pickImage(
        source: from == "Camera" ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 300,
        maxHeight: 300);
    if (photo != null && crCopy.path.isEmpty) {
      crCopy = File(photo.path);
      //imageList[0] = crCopy;
      // addImage();
      //imagesList.add(pickedMedia);
    } else {}
    setState(() {
      loading = false;
      uniqueId = "${Constants.userId}${today.toString()}.png";
      //  crCopyString = "${}"
    });
  }

  // void editProfile() async {
  //   if (haveLicense) {
  //     setState(() {
  //       license = "Yes";
  //     });
  //   } else {
  //     setState(() {
  //       license = "No";
  //     });
  //   }
  //   if (nameController.text.isNotEmpty) {
  //     if (addController.text.isNotEmpty) {
  //       if (iLiveInController.text.isNotEmpty) {
  //         try {
  //           var response = await http.post(
  //               Uri.parse(
  //                   "${Constants.baseUrl}/api/v1/edit_partner_official_details"),
  //               body: {
  //                 'user_id': Constants.userId.toString(), //"27", //27, //"27",
  //                 'company_name': nameController.text, //deles
  //                 'address': addController.text, //pakistan
  //                 'location': iLiveInController.text, //lahore
  //                 // 'description': descriptionController.text,
  //                 "license": license, //"Yes", //license, //"Yes", //license,
  //                 "cr_name": crName.text,
  //                 "cr_number": crNumber.text, //crNum, //crNumber.text,
  //                 "cr_copy": crCopy,
  //                 // //uniqueId, //crCopy.toString(), //"/C:/Users/Manish-Pc/Desktop/Images/1.jpg",
  //                 // "debit_card": "1", //"0", //debit_card, //"897654",
  //                 // //"visa_card": null, //"456132",
  //                 // "payon_arrival": payArrivalClicked
  //                 //     .toString(), //"1", //payArrivalClicked, //"1", //payArrivalClicked.toString(),
  //                 // //"paypal": "", //payPalId.text,
  //                 // "bankname": bankName.text, //"null", //nameController.text,
  //                 // "account_holdername": accountName.text, //"null", //accountName.text,
  //                 // "account_number": accountNum.text,
  //                 // //"null", //accountNum.text, //accNum, //5645656454, //accountNum.text,
  //                 // "is_online": "1", // hardcoded
  //                 // "packages_id": "0", // hardcoded
  //                 // "is_wiretransfer": "0", //isWireTrasfer //"1", //isWireTrasfer,
  //               });
  //           if (response.statusCode == 200) {
  //             message("Information Updated");
  //           } else {
  //             dynamic body = jsonDecode(response.body);
  //             // error = decodedError['data']['name'];
  //             message(body['message'].toString());
  //           }
  //         } catch (e) {
  //           print(e.toString());
  //         }
  //       } else {
  //         message("Please Enter Your Company Name");
  //       }
  //     } else {
  //       message("Please Enter Address");
  //     }
  //   } else {
  //     message("Please Enter Location");
  //   }
  // }

  void editProfile() async {
    if (haveLicense) {
      setState(() {
        license = "Yes";
        loading = true;
      });
    } else {
      setState(() {
        license = "No";
        loading = true;
      });
    }
    if (nameController.text.isNotEmpty) {
      if (addController.text.isNotEmpty) {
        if (iLiveInController.text.isNotEmpty) {
          crNum = int.tryParse(crNumber.text) ?? 0;
          accNum = int.tryParse(accountNum.text) ?? 0;
          if (crCopy.path.isNotEmpty) {
            crcopyList = crCopy.readAsBytesSync();
          }
          try {
            var request = http.MultipartRequest(
              "POST",
              Uri.parse(
                  "${Constants.baseUrl}/api/v1/edit_partner_official_details"),
            );
            String fileName =
                "${DateTime.now().millisecondsSinceEpoch.toString()}.png";
            request.files.add(http.MultipartFile.fromBytes(
                "cr_copy", crcopyList,
                filename: fileName));
            dynamic programData = {
              'user_id': Constants.userId.toString(), //"27", //27, //"27",
              'company_name': nameController.text.trim(), //deles
              'address': addController.text.trim(), //pakistan
              'location': iLiveInController.text.trim(), //lahore
              "license": license, //"Yes", //license, //"Yes", //license,
              "cr_name": crName.text.trim(),
              "cr_number": crNumber.text.trim(), //crNum, //crNumber.text,
            };
            request.fields.addAll(programData);
            log(request.fields.toString());
            final response = await request.send();
            if (response.statusCode == 200) {
              // SharedPreferences prefs = await Constants.getPrefs();
              // prefs.setString("company_Name", nameController.text.trim());
              // prefs.setString("address", addController.text);
              // prefs.setString("location", iLiveInController.text.trim());
              // prefs.setString("license", license);
              // prefs.setString("cr_name", crName.text.trim());
              // prefs.setString("cr_number", crNumber.text.trim());
              //   Constants.emailId = nameController.text.trim();
              Constants.name = nameController.text.trim();
              Constants.getProfile();
              message("Information Updated Successfully");
            } else {
              dynamic body = jsonDecode(response.toString());
              message(body['message'].toString());
              setState(() {
                loading = false;
              });
            }
            print(response.statusCode);
            print(response.headers);
          } catch (e) {
            print(e.toString());
          }
        } else {
          message("Please Enter Your Location");
        }
      } else {
        message("Please Enter Company Address");
      }
    } else {
      message("Please Enter Company Name");
    }
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
                text: "areyoulicensed?".tr(),
                color: blackTypeColor1,
                align: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Checkbox(
                    value: isLicensed,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    onChanged: (bool? noLicense) {
                      setState(() {
                        isLicensed = noLicense!;
                        haveLicense = !haveLicense;
                        // value1 = false;
                        //  license = "No";
                      });
                      // licenseStatus();
                      print(license);
                    }),
                MyText(
                  text: 'imNotLicensedyet'.tr(),
                  color: blackTypeColor,
                  align: TextAlign.center,
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: haveLicense,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    onChanged: (bool? hlicense) {
                      // licenseStatus();
                      setState(() {
                        haveLicense = hlicense!;
                        isLicensed = !isLicensed;
                        //value = false;
                        //license = "Yes";
                      });
                      print(license);
                    }),
                MyText(
                  text: "areyoulicensed?".tr(),
                  color: blackTypeColor,
                  align: TextAlign.center,
                ),
              ],
            ),
            //if (value1 == true)
            if (haveLicense)
              Column(
                children: [
                  const SizedBox(height: 20),
                  TFWithSize(
                    crNameText,
                    crName,
                    12,
                    lightGreyColor,
                    1,
                    label: "License Name",
                  ),
                  const SizedBox(height: 20),
                  TFWithSize(
                    crNumberText,
                    crNumber,
                    12,
                    lightGreyColor,
                    1,
                    label: "License Number",
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: addMedia,
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
                          // licenseImage.isNotEmpty
                          //     ? Image.network(
                          //         "${"${Constants.baseUrl}/public/uploads/"}$licenseImage",
                          //         height: 50,
                          //         width: 50,
                          //       )
                          //     :
                          crCopy.path.isNotEmpty
                              ? Image.file(
                                  crCopy,
                                  height: 50,
                                  width: 50,
                                )
                              : licenseImage.isEmpty
                                  ? const Image(
                                      image:
                                          ExactAssetImage('images/upload.png'),
                                      height: 50,
                                    )
                                  : Image.network(
                                      licenseImage,
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
                'save'.tr(),
                greenishColor,
                greenishColor,
                whiteColor,
                18,
                editProfile,
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
