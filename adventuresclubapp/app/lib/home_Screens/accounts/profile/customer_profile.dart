import 'dart:io';

import 'package:app/constants.dart';
import 'package:app/widgets/buttons/button.dart';
import 'package:app/widgets/my_text.dart';
import 'package:app/widgets/tabs/profile_tabs.dart';
import 'package:app/widgets/text_fields/text_fields.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  TextEditingController controller = TextEditingController();
  bool loading = false;
  File pickedMedia = File("");
  File pickedMediaSecond = File("");
  final picker = ImagePicker();
  List<File> imageList = [];
  List<File> imageBanners = [File(""), File("")];

  void addMedia() async {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text("From ?"),
        children: [
          GestureDetector(
            onTap: () => pickMedia("Camera"),
            child: const ListTile(
              title: Text("Camera"),
            ),
          ),
          GestureDetector(
            onTap: () => pickMedia("Gallery"),
            child: const ListTile(
              title: Text("Gallery"),
            ),
          ),
        ],
      ),
    );
  }

  void pickMedia(String type) async {
    Navigator.of(context).pop();
    setState(() {
      loading = true;
    });
    final XFile? photo = await picker.pickImage(
        source: type == "Camera" ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 300,
        maxHeight: 300);
    if (photo != null) {
      setState(() {
        pickedMedia = File(photo.path);
        loading = false;
      });
      // getAllImages();
      // widget.sendImages(imageList);
    }
  }

  abc() {}
  changePass() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2.3,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: MyText(
                          text: 'changePassword'.tr(),
                          weight: FontWeight.w400,
                          color: blackColor,
                          size: 20,
                          fontFamily: 'Roboto'),
                    ),
                    const SizedBox(height: 20),
                    TextFields('oldPassword', controller, 15, whiteColor, true),
                    TextFields('newPassword', controller, 15, whiteColor, true),
                    TextFields(
                        'confirmNewPassword', controller, 15, whiteColor, true),
                    const SizedBox(height: 30),
                    Center(
                        child: Button(
                            'save'.tr(),
                            greenishColor,
                            greyColorShade400,
                            whiteColor,
                            16,
                            abc,
                            Icons.add,
                            whiteColor,
                            false,
                            1.5,
                            'Roboto',
                            FontWeight.w600,
                            16)),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        });
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
        title: MyText(
          text: 'Profile',
          color: bluishColor,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: addMedia,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                pickedMedia.path.isEmpty
                    ? const CircleAvatar(
                        radius: 60,
                        backgroundImage: ExactAssetImage('images/avatar2.png'),
                      )
                    : CircleAvatar(
                        radius: 60,
                        //backgroundImage:
                        child: Image.file(
                          pickedMedia,
                          height: 50,
                        ),
                      ),
                const Positioned(
                    bottom: -10,
                    right: -10,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: bluishColor,
                      child: Image(
                        image: ExactAssetImage('images/camera.png'),
                        height: 22,
                        width: 22,
                      ),
                    ))
              ],
            ),
          ),
          const ProfileTabs(),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 20),
          Button('Save', bluishColor, bluishColor, whiteColor, 18, abc,
              Icons.add, whiteColor, false, 1.6, 'Roboto', FontWeight.w400, 16),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
