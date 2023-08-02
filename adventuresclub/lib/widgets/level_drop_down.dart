import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_filter.dart';
import 'package:adventuresclub/models/filter_data_model/level_filter_mode.dart';
import 'package:flutter/material.dart';

class LevelDropDownList extends StatefulWidget {
  final double width;
  const LevelDropDownList(this.width, {super.key});

  @override
  State<LevelDropDownList> createState() => _LevelDropDownListState();
}

class _LevelDropDownListState extends State<LevelDropDownList> {
  String level = "";
  List<LevelFilterModel> levelList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    levelList = Constants.levelFilter;
    level = levelList[0].level;
    ConstantsFilter.levelId = levelList[0].id.toString();
  }

  void updateData(LevelFilterModel t) {
    ConstantsFilter.levelId = t.id.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width / widget.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: level,
          icon: const Icon(Icons.keyboard_arrow_down),
          elevation: 12,
          style: const TextStyle(color: blackTypeColor),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              level = value!;
            });
          },
          items:
              levelList.map<DropdownMenuItem<String>>((LevelFilterModel value) {
            return DropdownMenuItem<String>(
              onTap: () => updateData(value),
              value: value.level,
              child: Text(
                value.level,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
