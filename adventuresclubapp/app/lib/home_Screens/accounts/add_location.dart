// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app/constants.dart';
import 'package:app/home_Screens/accounts/submitting_info.dart';
import 'package:app/models/filter_data_model/service_types_filter.dart';
import 'package:app/temp_google_map.dart';
import 'package:app/widgets/buttons/button_icon_less.dart';
import 'package:app/widgets/my_text.dart';
import 'package:app/widgets/text_fields/TF_with_size.dart';
import 'package:app/widgets/text_fields/multiline_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  TextEditingController nameController = TextEditingController();
  TextEditingController geoController = TextEditingController();
  TextEditingController addController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController webController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController iLiveInController = TextEditingController();
  double lat = 0;
  double lng = 0;
  String dropdownValue1 = 'Select type of destination';
  File? pickedMedia;
  String destinationType = "";
  List<String> mediaFiles = [];
  final picker = ImagePicker();
  bool loading = false;
  File crCopy = File("");
  Uint8List crcopyList = Uint8List(0);
  File visitImage = File("");
  List<String> list1 = <String>[
    'Select type of destination',
    'Two',
    'Three',
    'Four'
  ];

  void addMedia() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Align(
          alignment: Alignment.center,
          child: Text("UPLOAD FROM ",
              style: TextStyle(color: blackColor, fontWeight: FontWeight.bold)),
        ),
        children: [
          GestureDetector(
            onTap: () => pickMedia("Camera"),
            child: const ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("CAMERA",
                      style: TextStyle(
                          color: blackColor, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const Divider(
            endIndent: 12,
            indent: 12,
          ),
          GestureDetector(
            onTap: () => pickMedia("Gallery"),
            child: const ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("GALLERY",
                      style: TextStyle(
                          color: blackColor, fontWeight: FontWeight.bold)),
                ],
              ),
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
        maxWidth: 450,
        maxHeight: 450);
    if (photo != null) {
      setState(() {
        visitImage = File(photo.path);
        loading = false;
      });
    }
  }

  void goToSubInfo() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const SubmittingInfo();
        },
      ),
    );
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
  }

  void addLocation() async {
    setState(() {
      loading = true;
    });
    if (visitImage.path.isNotEmpty) {
      crcopyList = visitImage.readAsBytesSync();
    }
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${Constants.baseUrl}/api/v1/visited_location"),
      );
      String fileName =
          "${DateTime.now().millisecondsSinceEpoch.toString()}.png";
      request.files.add(http.MultipartFile.fromBytes(
          "destination_image", crcopyList,
          filename: fileName));
      dynamic programData = {
        'user_id': Constants.userId.toString(),
        'destination_name': nameController.text,
        "destination_type": destinationType, //"Travel",
        "geo_location": iLiveInController.text, //"",
        "destination_address": "dsf", //desController.text, //"",
        "dest_mobile": "650", //mobileController.text, //"",
        "dest_website": "ww", //webController.text, //"",
        "dest_description": desController.text, //"",
        "latitude": lat.toString(), //"455.221", //"",
        "longitude": lng
            .toString(), //"983.15", //"", //isWireTrasfer //"1", //isWireTrasfer,
      };
      request.fields.addAll(programData);
      log(request.fields.toString());
      final response = await request.send();
      if (response.statusCode == 200) {
        message("Location added successfully");
        goToSubInfo();
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
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void editMedia() async {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text("From ?"),
        children: [
          GestureDetector(
            onTap: () => editPickMedia("Camera"),
            child: const ListTile(
              title: Text("Camera"),
            ),
          ),
          GestureDetector(
            onTap: () => editPickMedia("Gallery"),
            child: const ListTile(
              title: Text("Gallery"),
            ),
          ),
        ],
      ),
    );
  }

  void editPickMedia(String from) async {
    Navigator.of(context).pop();
    setState(() {
      loading = true;
    });
    final XFile? photo = await picker.pickImage(
        source: from == "Camera" ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 300,
        maxHeight: 300);
    if (photo != null) {
      pickedMedia = File(photo.path);
      // imageList.add(pickedMedia);
      setState(() {
        visitImage = pickedMedia!;
        loading = false;
      });
    }
  }

  void deleteImage() {
    visitImage.deleteSync();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: MyText(
            text: 'addYourLocation'.tr(),
            color: bluishColor,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                visitImage.path.isEmpty
                    ? GestureDetector(
                        onTap: addMedia,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: blackTypeColor.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(12),
                              color: lightGreyColor),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              const Center(
                                child: Image(
                                  image: ExactAssetImage('images/upload.png'),
                                  height: 45,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              MyText(
                                text: 'tapToBrowse'.tr(),
                                color: greyColor,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              MyText(
                                text:
                                    'addBannerImageToEffectivelyAdventure'.tr(),
                                color: greyColor,
                                align: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: blackTypeColor.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(12),
                                  color: lightGreyColor),
                              child: Center(
                                child: Image.file(
                                  visitImage,
                                  fit: BoxFit.fill,
                                  height: 150,
                                  width: 300,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 5,
                              top: 10,
                              child: GestureDetector(
                                onTap: editMedia,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: blackColor,
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                TFWithSize('enterDestinationName', nameController, 14,
                    lightGreyColor, 1),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  decoration: BoxDecoration(
                      color: lightGreyColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: greyColor.withOpacity(0.2))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: Constants.serviceFilter[0].type,
                      icon: const Image(
                        image: ExactAssetImage('images/drop_down.png'),
                        height: 12,
                      ),
                      elevation: 16,
                      style: const TextStyle(
                          color: greyColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          destinationType = value!;
                        });
                      },
                      items: Constants.serviceFilter
                          .map<DropdownMenuItem<String>>(
                              (ServiceTypeFilterModel value) {
                        return DropdownMenuItem<String>(
                          value: value.type,
                          child: Row(
                            children: [
                              Image.network(
                                "${"${Constants.baseUrl}/public/uploads/selection_manager/"}${value.image}",
                                height: 36,
                                width: 26,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(value.type.tr()),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1,
                  child: TextField(
                    controller: iLiveInController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      hintText: 'enterGeolocation'.tr(),
                      filled: true,
                      fillColor: lightGreyColor,
                      suffixIcon: InkWell(
                        onTap: openMap,
                        child: const Image(
                          image: ExactAssetImage('images/map-symbol.png'),
                          height: 10,
                          width: 10,
                        ),
                      ),
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
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // TFWithSize(
                //     'Enter Address', addController, 14, lightGreyColor, 1),
                // const SizedBox(
                //   height: 20,
                // ),
                // TFWithSize('Enter Mobile Number', mobileController, 14,
                //     lightGreyColor, 1),
                // const SizedBox(
                //   height: 20,
                // ),
                // TFWithSize(
                //     'Enter Website Link', webController, 14, lightGreyColor, 1),
                const SizedBox(
                  height: 20,
                ),
                MultiLineField('write description in brief', 5, lightGreyColor,
                    desController),
                const SizedBox(
                  height: 20,
                ),
                ButtonIconLess(
                    'submit', bluishColor, whiteColor, 1.5, 17, 16, addLocation)
              ],
            ),
          ),
        ));
  }
}
