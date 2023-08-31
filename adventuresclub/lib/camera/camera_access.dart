import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants.dart';
import '../widgets/buttons/button.dart';
import '../widgets/my_text.dart';

class CameraAccess extends StatefulWidget {
  const CameraAccess({super.key});

  @override
  State<CameraAccess> createState() => _CameraAccessState();
}

class _CameraAccessState extends State<CameraAccess> {
  void getPermissions() async {
    PermissionStatus status = await Permission.camera.status;
    if (!status.isGranted) {
      PermissionStatus request = await Permission.camera.request();
      if (request.isPermanentlyDenied) {
        openAppSettings();
      } else if (request.isDenied) {
        openAppSettings();
      }
    }
    goBack();
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 41, 113, 146),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                const Icon(
                  CupertinoIcons.info_circle_fill,
                  color: kSecondaryColor,
                  size: 42,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  height: 80,
                  width: 360,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: whiteColor),
                  child: Center(
                    child: ListTile(
                      title: MyText(
                        align: TextAlign.left,
                        text:
                            "Allow camera to access to update profile picture",
                        color: blackColor,
                        weight: FontWeight.bold,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18), color: whiteColor),
              //color: whiteColor,
              child: Column(
                children: [
                  ListTile(
                    // tileColor: whiteColor,
                    leading: const CircleAvatar(
                        backgroundColor: kSecondaryColor,
                        child: Icon(Icons.camera)),
                    title: MyText(
                      text: "Camera",
                      color: blackColor,
                      weight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: kSecondaryColor,
                        child: Icon(Icons.picture_in_picture)),
                    title: MyText(
                      text: "Gallery",
                      color: blackColor,
                      weight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                MyText(
                  align: TextAlign.left,
                  text: "*You can change this option later in the settings app",
                  color: blackColor,
                  weight: FontWeight.bold,
                  size: 14,
                ),
                const SizedBox(
                  height: 30,
                ),
                Button(
                    'Continue',
                    greenishColor,
                    greenishColor,
                    whiteColor,
                    18,
                    getPermissions,
                    Icons.add,
                    whiteColor,
                    false,
                    1.3,
                    'Raleway',
                    FontWeight.w600,
                    16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
