import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class DescriptionComponents extends StatelessWidget {
  final String title;
  final String heading;
  const DescriptionComponents(this.title, this.heading, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 10),
            title: Text(
              title,
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: greyColor2),
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyText(
                  text: heading,
                  // text:
                  //     'The highest peak in Al-Hajar mountain range and in all of Oman,Jebel Shams(Mountain of the sun) towers above the northern town in Al-Hamra. Rising to about 10,000 feet(3,000 meters).',
                  color: greyColor2,
                  weight: FontWeight.w400,
                  fontFamily: 'Roboto',
                  height: 1.5,
                  size: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
