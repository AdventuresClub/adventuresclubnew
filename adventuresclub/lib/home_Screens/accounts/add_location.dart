// ignore_for_file: avoid_print

import 'dart:io';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/submitting_info.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:adventuresclub/widgets/text_fields/multiline_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  TextEditingController nameController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController geoController = TextEditingController();
  TextEditingController addController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController webController = TextEditingController();
  TextEditingController desController = TextEditingController();

  String dropdownValue1 = 'Select type of destination';
  File? pickedMedia;
  List<String> mediaFiles = [];
  final picker = ImagePicker();
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
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
    final XFile? photo = await picker.pickImage(
        source: from == "Camera" ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 300,
        maxHeight: 30);
    if (photo != null) {
      pickedMedia = File(photo.path);
      uploadMedia(pickedMedia!);
    }
  }

  void uploadMedia(File file) async {
    // User? user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   setState(() {
    //     loading = true;
    //   });
    //   String id = FirebaseFirestore.instance.collection('UserMediaFiles').doc().id;
    //   final ref = FirebaseStorage.instance.ref().child('mediaFiles').child(id);
    //   UploadTask uploadTask = ref.putFile(file);
    //   String url = await (await uploadTask).ref.getDownloadURL();
    //   saveImageLink(url, id);
  }

  void saveImageLink(String url, String id) async {
    //       {'profileURL': url}, SetOptions(merge: true));
    //  // updateProfile(url);
    //   await batch.commit().then((value) {

    //   }).catchError(
    //     (onError) {
    //       print(onError.toString());
    //     },
    //   );
    // }
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

  void goToAddLocation() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const AddLocation();
        },
      ),
    );
  }

  void addLocation() async {
    //otpController.clear();
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/visited_location"),
          body: {
            'user_id': "27",
            'destination_image': "/C:/Users/Manish-Pc/Desktop/Images/2.jpg",
            'destination_name': nameController.text,
            "destination_type": "Travel",
            "get_location": geoController.text, //"",
            "destination_address": desController.text, //"",
            "dest_mobile": mobileController.text, //"",
            "dest_website": webController.text, //"",
            "dest_description": desController.text, //"",
            "latitude": "455.221", //"",
            "longitude": "983.15", //"",
          });
      // setState(() {
      //   //userID = response.body.
      // });
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
    goToSubInfo();
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
            text: 'Add Your Location',
            color: bluishColor,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: addMedia,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: blackTypeColor.withOpacity(0.2)),
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
                          text: 'Tap to browse',
                          color: greyColor,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyText(
                          text: 'Add banner(image) to effectively adventure',
                          color: greyColor,
                          align: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TFWithSize('Enter Destination Name', nameController, 14,
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
                      value: dropdownValue1,
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
                          value = value!;
                        });
                      },
                      items:
                          list1.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
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
                    controller: geoController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      hintText: 'Enter: Geolocation',
                      filled: true,
                      fillColor: lightGreyColor,
                      suffixIcon: const Image(
                        image: ExactAssetImage('images/map-symbol.png'),
                        height: 10,
                        width: 10,
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
                const SizedBox(
                  height: 20,
                ),
                TFWithSize(
                    'Enter Address', addController, 14, lightGreyColor, 1),
                const SizedBox(
                  height: 20,
                ),
                TFWithSize('Enter Mobile Number', mobileController, 14,
                    lightGreyColor, 1),
                const SizedBox(
                  height: 20,
                ),
                TFWithSize(
                    'Enter Website Link', webController, 14, lightGreyColor, 1),
                const SizedBox(
                  height: 20,
                ),
                MultiLineField('write description in brief', 5, lightGreyColor,
                    desController),
                const SizedBox(
                  height: 20,
                ),
                ButtonIconLess(
                    'Submit', bluishColor, whiteColor, 1.5, 17, 16, addLocation)
              ],
            ),
          ),
        ));
  }
}
