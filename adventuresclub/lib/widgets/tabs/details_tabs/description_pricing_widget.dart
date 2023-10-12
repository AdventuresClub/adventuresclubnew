// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: MyText(
                    text: adventureName,
                    //'River Rafting',
                    weight: FontWeight.bold,
                    color: blackColor,
                    size: 16,
                  ),
                ),

                MyText(
                  text: "$costInc "
                      "$currency",
                  //'\$150.00',
                  weight: FontWeight.bold,
                  color: blackColor,
                  size: 16,
                ),
                // Expanded(
                //   child: MyText(
                //     text: 'Earn 180 Points',
                //     weight: FontWeight.bold,
                //     color: blueTextColor,
                //     size: 16,
                //   ),
                // ),
              ],
            ),
            // const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     // Align(
            //     //     alignment: Alignment.centerLeft,
            //     //     child: MyText(
            //     //       text: "${costExc} "
            //     //           "${currency}",
            //     //       //'\$18.18',
            //     //       weight: FontWeight.w600,
            //     //       color: blackColor,
            //     //       size: 14,
            //     //       fontFamily: 'Roboto',
            //     //     )),
            //   ],
            // ),
            // const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     // MyText(
            //     //   text: 'excludingGears'.tr(),
            //     //   weight: FontWeight.bold,
            //     //   color: Colors.red,
            //     //   size: 10,
            //     //   fontFamily: 'Roboto',
            //     // ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
