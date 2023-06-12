// ignore_for_file: unnecessary_null_comparison, avoid_function_literals_in_foreach_calls

import 'dart:io';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BannerPage extends StatefulWidget {
  final Function sendImages;
  const BannerPage(this.sendImages, {super.key});

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  bool loading = false;
  File pickedMedia = File("");
  File pickedMediaSecond = File("");
  final picker = ImagePicker();
  List<File> imageList = [];
  List<File> imageBanners = [File(""), File("")];

  // void addMedia(int i) async {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => SimpleDialog(
  //       title: const Text("From ?"),
  //       children: [
  //         GestureDetector(
  //           onTap: () => pickMedia("Camera", i),
  //           child: const ListTile(
  //             title: Text("Camera"),
  //           ),
  //         ),
  //         GestureDetector(
  //           onTap: () => pickMedia("Gallery", i),
  //           child: const ListTile(
  //             title: Text("Gallery"),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void pickMedia(int i) async {
    Navigator.of(context).pop();
    setState(() {
      loading = true;
    });
    final XFile? photo = await picker.pickImage(
        source: ImageSource.gallery, maxWidth: 300, maxHeight: 300);
    if (photo != null) {
      pickedMedia = File(photo.path);
      imageList.add(pickedMedia);
      imageBanners[i] = pickedMedia;
      setState(() {
        loading = false;
      });
      getAllImages();
      widget.sendImages(imageList);
    }
  }

  // void editMedia(int i) async {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => SimpleDialog(
  //       title: const Text("From ?"),
  //       children: [
  //         GestureDetector(
  //           onTap: () => editPickMedia("Camera", i),
  //           child: const ListTile(
  //             title: Text("Camera"),
  //           ),
  //         ),
  //         GestureDetector(
  //           onTap: () => editPickMedia("Gallery", i),
  //           child: const ListTile(
  //             title: Text("Gallery"),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void editPickMedia(int i) async {
    Navigator.of(context).pop();
    setState(() {
      loading = true;
    });
    final XFile? photo = await picker.pickImage(
        source: ImageSource.gallery, maxWidth: 300, maxHeight: 300);
    if (photo != null) {
      pickedMedia = File(photo.path);

      // imageList.add(pickedMedia);
      setState(() {
        imageList[i] = pickedMedia;
        loading = false;
      });
      getAllImages();
      widget.sendImages(imageList);
    }
  }

  void getAllImages() {
    for (int i = 0; i < imageList.length; i++) {
      if (imageList[i].path.isNotEmpty) {
        imageBanners[i] = imageList[i];
      } else {
        imageBanners[i].delete();
      }
    }
    setState(() {});
  }

  void addImage() {
    Provider.of<CompleteProfileProvider>(context, listen: false).adventureOne =
        pickedMedia;
  }

  void addSecondImage() {
    Provider.of<CompleteProfileProvider>(context, listen: false).adventureTwo =
        pickedMediaSecond;
  }

  void getImageData(File img, int index) {
    imageBanners[index] = img;
  }

  void addImageWidget() {
    if (imageBanners.length == 4) {
      message("Only 4 Images are allowed");
    } else {
      setState(() {
        imageBanners.add(File(""));
      });
    }
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void deleteImage(int i) {
    imageBanners.removeAt(i);
    imageList.removeAt(i);
    getAllImages();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Text("loading....")
        : SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: addImageWidget,
                  child: Row(
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
                ),
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        for (int y = 0; y < imageBanners.length; y++)
                          //ImageContainer(imageBanners[y], addMedia, y),
                          imageBanners[y].path.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: blackTypeColor
                                                .withOpacity(0.2)),
                                        borderRadius: BorderRadius.circular(12),
                                        color: lightGreyColor),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 20),
                                        GestureDetector(
                                          onTap: () => pickMedia(y),
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
                                                color: blackTypeColor
                                                    .withOpacity(0.2)),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: lightGreyColor),
                                        child: Center(
                                          child: Image.file(
                                            imageBanners[y],
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
                                          onTap: () => editPickMedia(y),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: blackColor,
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            ),
                                            child: const Icon(
                                              Icons.edit,
                                              color: whiteColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 5,
                                        top: 60,
                                        child: GestureDetector(
                                          onTap: () => deleteImage(y),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: blackColor,
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            ),
                                            child: const Icon(
                                              Icons.delete,
                                              color: redColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                        // pickedMedia.path.isEmpty
                        //     ? Container(
                        //         padding: const EdgeInsets.all(20),
                        //         decoration: BoxDecoration(
                        //             border: Border.all(
                        //                 color: blackTypeColor.withOpacity(0.2)),
                        //             borderRadius: BorderRadius.circular(12),
                        //             color: lightGreyColor),
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             const SizedBox(height: 20),
                        //             GestureDetector(
                        //               onTap: addMedia,
                        //               child: const Center(
                        //                 child: Image(
                        //                   image: ExactAssetImage(
                        //                       'images/upload.png'),
                        //                   height: 45,
                        //                 ),
                        //               ),
                        //             ),
                        //             const SizedBox(
                        //               height: 20,
                        //             ),
                        //             MyText(
                        //               text: 'Tap to browse',
                        //               color: greyColor,
                        //             ),
                        //             const SizedBox(
                        //               height: 20,
                        //             ),
                        //             MyText(
                        //               text:
                        //                   'Add banner(image) to effectively adventure',
                        //               color: greyColor,
                        //               align: TextAlign.center,
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     : Container(
                        //         padding: const EdgeInsets.all(20),
                        //         decoration: BoxDecoration(
                        //             border: Border.all(
                        //                 color: blackTypeColor.withOpacity(0.2)),
                        //             borderRadius: BorderRadius.circular(12),
                        //             color: lightGreyColor),
                        //         child: Center(
                        //           child: Image.file(
                        //             pickedMedia,
                        //             fit: BoxFit.fill,
                        //             height: 150,
                        //             width: 300,
                        //           ),
                        //         ),
                        //       ),
                        // const SizedBox(height: 20),
                        // pickedMediaSecond.path.isEmpty
                        //     ? Container(
                        //         padding: const EdgeInsets.all(20),
                        //         decoration: BoxDecoration(
                        //             border: Border.all(
                        //                 color: blackTypeColor.withOpacity(0.2)),
                        //             borderRadius: BorderRadius.circular(12),
                        //             color: lightGreyColor),
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             const SizedBox(height: 20),
                        //             GestureDetector(
                        //               onTap: addMedia,
                        //               child: const Center(
                        //                 child: Image(
                        //                   image: ExactAssetImage(
                        //                       'images/upload.png'),
                        //                   height: 45,
                        //                 ),
                        //               ),
                        //             ),
                        //             const SizedBox(
                        //               height: 20,
                        //             ),
                        //             MyText(
                        //               text: 'Tap to browse',
                        //               color: greyColor,
                        //             ),
                        //             const SizedBox(
                        //               height: 20,
                        //             ),
                        //             MyText(
                        //               text:
                        //                   'Add banner(image) to effectively adventure',
                        //               color: greyColor,
                        //               align: TextAlign.center,
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     : Container(
                        //         padding: const EdgeInsets.all(20),
                        //         decoration: BoxDecoration(
                        //             border: Border.all(
                        //                 color: blackTypeColor.withOpacity(0.2)),
                        //             borderRadius: BorderRadius.circular(12),
                        //             color: lightGreyColor),
                        //         child: Center(
                        //           child: Image.file(
                        //             pickedMediaSecond,
                        //             fit: BoxFit.fill,
                        //             height: 150,
                        //             width: 300,
                        //           ),
                        //         ),
                        //       ),
                      ],
                    ))
              ],
            ),
          );
  }
}
