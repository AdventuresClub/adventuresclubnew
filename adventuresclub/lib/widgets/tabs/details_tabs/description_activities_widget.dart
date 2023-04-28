import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/services/included_activities_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
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
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: MyText(
                text: 'Activities Includes',
                color: greyColor.withOpacity(0.6),
                weight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            GridView.count(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              mainAxisSpacing: 0,
              childAspectRatio: 4,
              crossAxisSpacing: 0,
              crossAxisCount: 3,
              children:
                  List.generate(activities.length, //activitesInclude.length,
                      (index) {
                return Row(
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
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
