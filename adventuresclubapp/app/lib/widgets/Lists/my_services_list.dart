import 'dart:io';

import 'package:app/constants.dart';
import 'package:app/models/home_services/services_model.dart';
import 'package:app/widgets/edit_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyServicesList extends StatefulWidget {
  final ServicesModel sm;
  final bool? edit;
  final Function? sendImages;
  const MyServicesList(this.sm,
      {this.edit = false, this.sendImages, super.key});

  @override
  State<MyServicesList> createState() => _MyServicesListState();
}

class _MyServicesListState extends State<MyServicesList> {
  bool edit = false;
  bool loading = false;
  final picker = ImagePicker();
  List<File> imageList = [];
  File pickedMedia = File("");
  List<File> imageBanners = [File(""), File("")];
  @override
  void didUpdateWidget(covariant MyServicesList oldWidget) {
    edit = widget.edit!;
    super.didUpdateWidget(oldWidget);
    if (edit) {
      // getEmployees();
    }
  }

  void pickMedia(int i) async {
    // Navigator.of(context).pop();
    setState(() {
      loading = true;
    });
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      pickedMedia = File(photo.path);
      imageList.add(pickedMedia);
      imageBanners[i] = pickedMedia;
      setState(() {
        loading = false;
      });
      //getAllImages();
      widget.sendImages!(imageList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: widget.sm.images.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            width: MediaQuery.of(context).size.width / 1.6,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  // colorFilter: ColorFilter.mode(
                  //     Colors.black.withOpacity(0.2), BlendMode.darken),
                  image:
                      // const ExactAssetImage(
                      //   'images/picture1.png',
                      // ),
                      NetworkImage(
                    "${"${Constants.baseUrl}/public/uploads/"}${widget.sm.images[index].imageUrl}",
                  ),
                  fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                if (edit)
                  Positioned(
                      top: 5,
                      right: 10,
                      child: EditIcon(
                        tapped: pickMedia,
                        i: index,
                        indexRequired: true,
                      )
                      // Container(
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(64)),
                      //   child: IconButton(
                      //     autofocus: true,
                      //     splashColor: Colors.white,
                      //     hoverColor: Colors.white,
                      //     highlightColor: Colors.white,
                      //     focusColor: Colors.white,
                      //     color: Colors.white,
                      //     onPressed: () => pickMedia(index),
                      //     icon: const Icon(
                      //       size: 34,
                      //       Icons.edit,
                      //       color: Colors.red,
                      //     ),
                      //   ),
                      // ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
