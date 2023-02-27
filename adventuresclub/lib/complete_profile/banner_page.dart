// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({super.key});

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  bool loading = false;
  File pickedMedia = File("");
  File pickedMediaSecond = File("");
  final picker = ImagePicker();
  List<File> imagesList = [];

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
    if (photo != null && pickedMedia.path.isEmpty) {
      pickedMedia = File(photo.path);
      addImage();
      //imagesList.add(pickedMedia);
    } else {
      pickedMediaSecond = File(photo!.path);
      addSecondImage();
    }
    setState(() {
      loading = false;
    });
  }

  void addImage() {
    Provider.of<CompleteProfileProvider>(context, listen: false).adventureOne =
        pickedMedia;
  }

  void addSecondImage() {
    Provider.of<CompleteProfileProvider>(context, listen: false).adventureTwo =
        pickedMediaSecond;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Text("loading....")
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Image(
                      image: ExactAssetImage('images/add-circle.png'),
                      height: 20),
                  const SizedBox(
                    width: 5,
                  ),
                  MyText(
                    text: 'Add More',
                    color: bluishColor,
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      pickedMedia.path.isEmpty
                          ? Container(
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
                                  GestureDetector(
                                    onTap: addMedia,
                                    child: const Center(
                                      child: Image(
                                        image: ExactAssetImage(
                                            'images/upload.png'),
                                        height: 45,
                                      ),
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
                                    text:
                                        'Add banner(image) to effectively adventure',
                                    color: greyColor,
                                    align: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: blackTypeColor.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(12),
                                  color: lightGreyColor),
                              child: Center(
                                child: Image.file(
                                  pickedMedia,
                                  fit: BoxFit.fill,
                                  height: 150,
                                  width: 300,
                                ),
                              ),
                            ),
                      const SizedBox(height: 20),
                      pickedMediaSecond.path.isEmpty
                          ? Container(
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
                                  GestureDetector(
                                    onTap: addMedia,
                                    child: const Center(
                                      child: Image(
                                        image: ExactAssetImage(
                                            'images/upload.png'),
                                        height: 45,
                                      ),
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
                                    text:
                                        'Add banner(image) to effectively adventure',
                                    color: greyColor,
                                    align: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: blackTypeColor.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(12),
                                  color: lightGreyColor),
                              child: Center(
                                child: Image.file(
                                  pickedMediaSecond,
                                  fit: BoxFit.fill,
                                  height: 150,
                                  width: 300,
                                ),
                              ),
                            ),
                    ],
                  ))
            ],
          );
  }
}
