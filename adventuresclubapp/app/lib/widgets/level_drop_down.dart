import 'package:app/constants.dart';
import 'package:app/constants_filter.dart';
import 'package:app/models/filter_data_model/level_filter_mode.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LevelDropDownList extends StatefulWidget {
  final List<LevelFilterModel> lFilter;
  final String title;
  final double width;
  const LevelDropDownList(this.lFilter, this.title, this.width, {super.key});

  @override
  State<LevelDropDownList> createState() => _LevelDropDownListState();
}

class _LevelDropDownListState extends State<LevelDropDownList> {
  String level = "";
  List<LevelFilterModel> levelList = [];
  late LevelFilterModel selected;
  bool isSelected = false;

  List<PopupMenuEntry<LevelFilterModel>> itemBuilder(BuildContext context) {
    return widget.lFilter.map((e) {
      return PopupMenuItem(
        value: e,
        child: Text(e.level.tr()),
      );
    }).toList();
  }

  void select(LevelFilterModel s) {
    setState(() {
      selected = s;
      isSelected = true;
      ConstantsFilter.levelId = s.id.toString();
    });
  }

  void updateData(LevelFilterModel t) {
    ConstantsFilter.levelId = t.id.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / widget.width,
        child: PopupMenuButton(
          itemBuilder: itemBuilder,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          offset: const Offset(10, 45),
          onSelected: (LevelFilterModel result) => select(result),
          child: ListTile(
            horizontalTitleGap: 5,
            title: Text(widget.title.tr()),
            leading: const Icon(
              Icons.place_rounded,
              color: blackColor,
            ),
            subtitle: isSelected ? Text(selected.level.tr()) : const Text(""),
            trailing: const Icon(Icons.keyboard_arrow_down),
          ),
        ));
  }
}
