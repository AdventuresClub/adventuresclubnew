import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class DescriptionInformationWidget extends StatelessWidget {
  final String writeInformation;
  const DescriptionInformationWidget(this.writeInformation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: MyText(
                  text: 'Information',
                  color: greyColor2,
                  weight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  size: 16,
                )),
            const SizedBox(height: 5),
            MyText(
              text: writeInformation,
              color: greyColor2,
              weight: FontWeight.w500,
              fontFamily: 'Roboto',
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
