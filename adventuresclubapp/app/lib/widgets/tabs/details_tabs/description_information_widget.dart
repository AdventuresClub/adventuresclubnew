import 'package:app/constants.dart';
import 'package:app/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
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
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: 'information'.tr(),
                color: greyColor2,
                weight: FontWeight.w500,
                fontFamily: 'Roboto',
                size: 16,
              ),
              const SizedBox(height: 5),
              MyText(
                text: writeInformation,
                align: TextAlign.left,
                color: greyColor2,
                weight: FontWeight.w500,
                fontFamily: 'Roboto',
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
