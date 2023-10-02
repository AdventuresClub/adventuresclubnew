import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_filter.dart';
import 'package:adventuresclub/models/filter_data_model/activities_inc_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class ActivitiesFilterList extends StatefulWidget {
  const ActivitiesFilterList({super.key});

  @override
  State<ActivitiesFilterList> createState() => _ActivitiesFilterListState();
}

class _ActivitiesFilterListState extends State<ActivitiesFilterList> {
  List<ActivitiesIncludeModel> activitiesFilter = [];
  List<String> activityList = [];
  List<bool> activityValue = [];
  List<String> selectedActivites = [];
  List<int> selectedActivitesid = [];
  List<IconData> iconList = [
    Icons.place_rounded,
    Icons.no_drinks,
    Icons.food_bank,
    Icons.bike_scooter,
    Icons.get_app,
    Icons.skateboarding,
    Icons.upcoming,
    Icons.swipe,
    Icons.get_app,
    Icons.skateboarding,
    Icons.upcoming,
    Icons.swipe,
    Icons.get_app,
    Icons.skateboarding,
    Icons.upcoming,
    Icons.swipe,
    Icons.get_app,
    Icons.skateboarding,
    Icons.upcoming,
    Icons.swipe
  ];
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    activitiesFilter = Constants.activitiesFilter;
    parseActivity(activitiesFilter);
  }

  void parseActivity(List<ActivitiesIncludeModel> am) {
    am.forEach((element) {
      if (element.activity.isNotEmpty) {
        activityList.add(element.activity);
      }
    });
    activityList.forEach(
      (element) {
        activityValue.add(false);
      },
    );
  }

  void abc() {
    Navigator.of(context).pop();
    List<ActivitiesIncludeModel> a = [];
    for (int i = 0; i < activityValue.length; i++) {
      if (activityValue[i]) {
        a.add(activitiesFilter[i]);
      }
    }
    sId(a);
  }

  void sId(List<ActivitiesIncludeModel> activity) async {
    activity.forEach((element) {
      selectedActivites.add(element.activity);
      selectedActivitesid.add(element.id);
    });
    setState(() {
      ConstantsFilter.selectedActivitesId = selectedActivitesid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(activitiesFilter.length, //activityList.length,
          (index) {
        return SizedBox(
          //width: MediaQuery.of(context).size.width / 1,
          child: Column(
            children: [
              CheckboxListTile(
                secondary: Icon(
                  iconList[index],
                  color: blackColor,
                ),
                side: const BorderSide(color: bluishColor),
                checkboxShape: const RoundedRectangleBorder(
                  side: BorderSide(color: bluishColor),
                ),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                activeColor: greyProfileColor,
                checkColor: bluishColor,
                selected: activityValue[index],
                value: activityValue[index],
                onChanged: (value) {
                  setState(() {
                    activityValue[index] = !activityValue[index];
                    // activityId
                    //     .add(activitiesFilter[index].id);
                    // activity.add(
                    //     activitiesFilter[index].activity);
                  });
                },
                title: MyText(
                  text: activitiesFilter[index].activity,
                  color: greyColor,
                  fontFamily: 'Raleway',
                  size: 18,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
