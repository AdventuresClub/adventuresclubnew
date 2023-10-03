import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/services/included_activities_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DescriptionActivitiesWidget extends StatelessWidget {
  final List<IncludedActivitiesModel> activities;
  const DescriptionActivitiesWidget(this.activities, {super.key});

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
                text: 'activitiesIncludes'.tr(),
                color: greyColor.withOpacity(0.6),
                weight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              children: [
                for (int i = 0; i < activities.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                          "${"https://adventuresclub.net/adventureClub/public/uploads/selection_manager/"}${activities[i].image}",
                          height: 18,
                          width: 18,
                        ),
                        const SizedBox(width: 5),
                        MyText(
                          text: activities[i].activity,
                          color: greyTextColor,
                          weight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          size: 12,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            /*
            GridView.count(
//                primary: false,
//                physics: const ScrollPhysics(),
              shrinkWrap: true,
              addAutomaticKeepAlives: true,
              mainAxisSpacing: 0,
              childAspectRatio: 4,
              crossAxisSpacing: 4,
              crossAxisCount: 3,
              children:
                  List.generate(activities.length, //activitesInclude.length,
                      (index) {
                return SizedBox(
                  height: 20,
                  child: Row(
                    children: [
                      Image.network(
                        "${"https://adventuresclub.net/adventureClub/public/uploads/selection_manager/"}${activities[index].image}",
                        height: 18,
                        width: 18,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      MyText(
                        text: activities[index].activity,
                        color: greyTextColor,
                        weight: FontWeight.w500,
                        fontFamily: 'Roboto',
                        size: 12,
                      ),
                    ],
                  ),
                );
              }),
            ),
            */
          ],
        ),
      ),
    );
  }
}
