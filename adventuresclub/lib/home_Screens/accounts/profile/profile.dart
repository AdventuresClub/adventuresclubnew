// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:adventuresclub/camera/camera_access.dart';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/profile/profile_tab.dart';
import 'package:adventuresclub/provider/navigation_index_provider.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/text_fields.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../provider/services_provider.dart';
import '../../../sign_up/sign_in.dart';

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
  File crCopy = File("");
  String uniqueId = "";
  DateTime? today = DateTime.now();
  Uint8List crcopyList = Uint8List(0);
  @override
  void initState() {
    super.initState();
    Constants.getProfile();
  }

  void addMedia() async {
    if (!await checkPermission()) {
      goToCamera();
    } else {
      if (mounted) {
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
    }
  }

  Future<bool> checkPermission() async {
    PermissionStatus status = await Permission.camera.status;
    if (status.isPermanentlyDenied || status.isDenied) {
      return false;
    }
    return true;
  }

  void changeIndex() {
    Provider.of<NavigationIndexProvider>(context, listen: false).homeIndex = 0;
  }

  void logout() {
    Constants.clear();
    changeIndex();
    print(Constants.userId);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) {
          return const SignIn();
        },
      ),
      (route) => false,
    );
  }

  void showConfirmation(String title, String message) async {
    showDialog(
        context: context,
        builder: (ctx) => SimpleDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: MyText(
                text: title.tr(),
                size: 18,
                weight: FontWeight.bold,
                color: blackColor,
              ),
              children: [
                const SizedBox(
                  height: 10,
                ),
                //Text("data"),
                Text(
                  message.tr(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: MyText(
                        text: "no".tr(),
                        color: blackColor,
                        weight: FontWeight.bold,
                      ),
                    ),
                    MaterialButton(
                      onPressed: logout,
                      child: MyText(
                        text: "yes".tr(),
                        color: blackColor,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                //BottomButton(bgColor: blueButtonColor, onTap: homePage)
              ],
            ));
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
    } else {}
    setState(() {
      loading = false;
      uniqueId = "${Constants.userId}${today.toString()}.png";
      //  crCopyString = "${}"
    });
    updateProfilePicture();
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
                              text: 'changePassword'.tr(),
                              weight: FontWeight.bold,
                              color: blackColor,
                              size: 20,
                              fontFamily: 'Roboto'),
                          const SizedBox(height: 20),
                          TextFields(
                              'oldPassword', oldPassword, 15, whiteColor, true),
                          const SizedBox(height: 10),
                          TextFields(
                              'newPassword', newPassword, 15, whiteColor, true),
                          const SizedBox(height: 10),
                          TextFields('confirmNewPassword', confirmPassword, 15,
                              whiteColor, true),
                          const SizedBox(height: 10),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    Center(
                        child: Button(
                            'save'.tr(),
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
                Uri.parse("${Constants.baseUrl}/api/v1/change_password"),
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

  void updateProfilePicture() async {
    setState(() {
      loading = true;
    });
    if (crCopy.path.isNotEmpty) {
      crcopyList = crCopy.readAsBytesSync();
    }
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${Constants.baseUrl}/api/v1/profilePhotoUpdate"),
      );
      String fileName =
          "${DateTime.now().millisecondsSinceEpoch.toString()}.png";
      request.files.add(http.MultipartFile.fromBytes(
          "profile_picture", crcopyList,
          filename: fileName));
      dynamic programData = {
        'user_id': Constants.userId.toString(), //"27", //27, //"27",
      };
      request.fields.addAll(programData);
      log(request.fields.toString());
      final response = await request.send();
      if (response.statusCode == 200) {
        message("Display Picture Updated");
      } else {
        dynamic body = jsonDecode(response.toString());
        message(body['message'].toString());
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      message(e.toString());
    }
  }

  void goToCamera() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const CameraAccess();
    }));
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
            text: 'profile'.tr(),
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
                  crCopy.path.isEmpty
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              "${'${Constants.baseUrl}/public/'}${Constants.profile.profileImage}"),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            //image: DecorationImage(image: widget(child: Image.file(pickedMedia)))
                          ),
                          child: ClipRRect(
                            child: Image.file(
                              crCopy,
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
//   ${Constants.baseUrl}/api/v1/update_profile
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
