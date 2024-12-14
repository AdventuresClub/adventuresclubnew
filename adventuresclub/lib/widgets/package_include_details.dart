import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../models/packages_become_partner/bp_includes_model.dart';

class PackageIncludeDetails extends StatelessWidget {
  final List<BpIncludesModel> bp;
  const PackageIncludeDetails(this.bp, {super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: List.generate(bp.length, (index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 8,
              backgroundColor: whiteColor,
              child: bp[index].detailType == 1
                  ? const Image(
                      image: ExactAssetImage(
                        'images/ic_green_check.png',
                      ),
                    )
                  : const Image(
                      image: ExactAssetImage(
                        'images/ic_red_cross.png',
                      ),
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            MyText(
              text: bp[index].title.tr(),
              size: 12,
              height: 2.2,
              weight: FontWeight.w600,
            ),
          ],
        );
      }),
    );
  }
}
