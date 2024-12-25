import 'dart:io';

import 'package:app/constants.dart';
import 'package:app/widgets/my_text.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final File bannerImage;
  final Function addImage;
  final int index;
  const ImageContainer(this.bannerImage, this.addImage, this.index,
      {super.key});

  @override
  Widget build(BuildContext context) {
    @override
    void newImage() {
      addImage;
    }

    return bannerImage.path.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: blackTypeColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(12),
                  color: lightGreyColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: newImage,
                    child: const Center(
                      child: Image(
                        image: ExactAssetImage('images/upload.png'),
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
                    text: 'Add banner(image) to effectively adventure',
                    color: greyColor,
                    align: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(color: blackTypeColor.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(12),
                color: lightGreyColor),
            child: Center(
              child: Image.file(
                bannerImage,
                fit: BoxFit.fill,
                height: 150,
                width: 300,
              ),
            ),
          );
  }
}
