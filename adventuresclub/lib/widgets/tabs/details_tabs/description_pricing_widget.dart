// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class DescriptionPricingWidget extends StatelessWidget {
  final String adventureName;
  final String costInc;
  final String currency;
  final String costExc;
  const DescriptionPricingWidget(
      this.adventureName, this.costInc, this.currency, this.costExc,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: adventureName,
                  //'River Rafting',
                  weight: FontWeight.bold,
                  color: blackColor,
                  size: 16,
                ),
                MyText(
                  text: 'Earn 180 Points',
                  weight: FontWeight.bold,
                  color: blueTextColor,
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: "$costInc "
                      "$currency",
                  //'\$150.00',
                  weight: FontWeight.bold,
                  color: blackColor,
                  size: 14,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: "${costExc} "
                          "${currency}",
                      //'\$18.18',
                      weight: FontWeight.w600,
                      color: blackColor,
                      size: 14,
                      fontFamily: 'Roboto',
                    )),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: 'Including gears and other taxes',
                  weight: FontWeight.bold,
                  color: Colors.red,
                  size: 10,
                  fontFamily: 'Roboto',
                ),
                MyText(
                  text: 'Excluding gears and other taxes',
                  weight: FontWeight.bold,
                  color: Colors.red,
                  size: 10,
                  fontFamily: 'Roboto',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}