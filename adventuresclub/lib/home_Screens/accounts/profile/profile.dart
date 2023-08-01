// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/profile/profile_tab.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  final bool? expired;
  final String? role;
  const Profile(this.expired, this.role, {super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
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
  void changePass() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: SizedBox(
              height: 400,
              //height: MediaQuery.of(context).size.height / 2.3,
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
                      child: Column(
                        children: [
                          MyText(
                              text: 'Change Password',
                              weight: FontWeight.bold,
                              color: blackColor,
                              size: 20,
                              fontFamily: 'Roboto'),
                          const SizedBox(height: 20),
                          TextFields('Old Password', oldPassword, 15,
                              whiteColor, true),
                          const SizedBox(height: 10),
                          TextFields('New Password', newPassword, 15,
                              whiteColor, true),
                          const SizedBox(height: 10),
                          TextFields('Confirm New Password', confirmPassword,
                              15, whiteColor, true),
                          const SizedBox(height: 10),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    Center(
                        child: Button(
                            'Save',
                            greenishColor,
                            greyColorShade400,
                            whiteColor,
                            16,
                            changePassword,
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

  void changePassword() async {
    Navigator.of(context).pop();
    if (oldPassword.text.isNotEmpty) {
      if (newPassword.text.isNotEmpty) {
        if (oldPassword.text.isNotEmpty) {
          try {
            var response = await http.post(
                Uri.parse(
                    "https://adventuresclub.net/adventureClub/api/v1/change_password"),
                body: {
                  'user_id': Constants.userId.toString(), //"",
                  'old_password': oldPassword.text.trim(),
                  'password': newPassword.text.trim(), //"0",
                  'password_confirmation': confirmPassword.text.trim(), //"0",
                });
            // var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
            if (response.statusCode == 200) {
              message("Password Updated Successfully");
              Constants.password = newPassword.text.trim();
            } else {
              dynamic body = jsonDecode(response.body);
              // error = decodedError['data']['name'];
              message(body['message'].toString());
            }
            print(response.statusCode);
          } catch (e) {
            print(e.toString());
          }
        } else {
          message("Please Confirm New Password");
        }
      } else {
        message("Please Enter New Password");
      }
    } else {
      message("Please Enter Old Password");
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
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
            weight: FontWeight.bold,
          ),
          actions: [
            GestureDetector(
              onTap: changePass,
              child: Icon(
                Icons.lock,
                color: greyColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: addMedia,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Constants.profile.profileImage.isEmpty
                  //     ? const CircleAvatar(
                  //         radius: 60,
                  //         backgroundImage:
                  //             ExactAssetImage('images/avatar2.png'),
                  //       )
                  pickedMedia.path.isEmpty
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              "${'https://adventuresclub.net/adventureClub/public/'}${Constants.profile.profileImage}"),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            //image: DecorationImage(image: widget(child: Image.file(pickedMedia)))
                          ),
                          child: ClipRRect(
                            child: Image.file(
                              pickedMedia,
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                  // CircleAvatar(
                  //     radius: 60,
                  //     //backgroundImage:
                  //     child: Image.file(
                  //       pickedMedia,
                  //       height: 50,
                  //     ),
                  //   ),
                  const Positioned(
                      bottom: -10,
                      right: -10,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: bluishColor,
                        child: Image(
                          image: ExactAssetImage('images/camera.png'),
                          height: 16,
                          width: 16,
                        ),
                      ))
                ],
              ),
            ),
            Expanded(child: ProfileTab(widget.role)),
          ],
        ),
//   https://adventuresclub.net/adventureClub/api/v1/update_profile
// user_id:2
// name:fgfd
// mobile_code:+91
// email:mmm@yopmail.com
        // body: Center(
        //   child: SingleChildScrollView(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Stack(
        //           clipBehavior: Clip.none,
        //           children: const [
        //             CircleAvatar(
        //               radius: 60,
        //               backgroundImage: ExactAssetImage('images/avatar2.png'),
        //             ),
        //             Positioned(
        //                 bottom: -10,
        //                 right: -10,
        //                 child: CircleAvatar(
        //                   radius: 25,
        //                   backgroundColor: bluishColor,
        //                   child: Image(
        //                     image: ExactAssetImage('images/camera.png'),
        //                     height: 22,
        //                     width: 22,
        //                   ),
        //                 ))
        //           ],
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.symmetric(
        //               horizontal: 8.0, vertical: 15),
        //           child: Column(
        //             children: [
        //               TextFields('Kenneth Gutierrez', controller, 15,
        //                   greyProfileColor, true),
        //               Divider(
        //                 indent: 4,
        //                 endIndent: 4,
        //                 color: greyColor.withOpacity(0.5),
        //               ),
        //               TextFields('+44-3658789456', controller, 15,
        //                   greyProfileColor, true),
        //               Divider(
        //                 indent: 4,
        //                 endIndent: 4,
        //                 color: greyColor.withOpacity(0.5),
        //               ),
        //               TextFields('demo@xyz.com', controller, 15,
        //                   greyProfileColor, true),
        //               Divider(
        //                 indent: 4,
        //                 endIndent: 4,
        //                 color: greyColor.withOpacity(0.5),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // )),
      ),
    );
  }
}
