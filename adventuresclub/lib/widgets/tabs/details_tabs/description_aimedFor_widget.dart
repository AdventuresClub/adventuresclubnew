// ignore_for_file: file_names

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class DescriptionAimedFor extends StatelessWidget {
  final List<AimedForModel> am;
  const DescriptionAimedFor(this.am, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: MyText(
                  text: 'Aimed For',
                  color: greyColor.withOpacity(0.6),
                  weight: FontWeight.bold,
                  fontFamily: 'Roboto',
                )),
            const SizedBox(height: 5),
            Wrap(
              children: [
                for (int i = 0; i < am.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                          "${"https://adventuresclub.net/adventureClub/public/uploads/selection_manager/"}${am[i].image}",
                          height: 18,
                          width: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        MyText(
                          text: am[i].aimedName,
                          //text: aimedFor[index],
                          color: greyColor2,
                          weight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          size: 12,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
