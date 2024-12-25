import 'package:app/constants.dart';
import 'package:app/constants_filter.dart';
import 'package:app/models/filter_data_model/durations_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DurationDropDownList extends StatefulWidget {
  final List<DurationsModel> dFilter;
  final double width;
  const DurationDropDownList(this.dFilter, this.width, {super.key});

  @override
  State<DurationDropDownList> createState() => _DurationDropDownListState();
}

class _DurationDropDownListState extends State<DurationDropDownList> {
  String duration = "";
  List<DurationsModel> durationList = [];
  late DurationsModel selected;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  List<PopupMenuEntry<DurationsModel>> itemBuilder(BuildContext context) {
    return widget.dFilter.map((e) {
      return PopupMenuItem(
        value: e,
        child: Text(e.duration.tr()),
      );
    }).toList();
  }

  void select(DurationsModel s) {
    setState(() {
      selected = s;
      isSelected = true;
      ConstantsFilter.durationId = s.id.toString();
    });
  }

  void updateData(DurationsModel t) {
    ConstantsFilter.durationId = t.id.toString();
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
          onSelected: (DurationsModel result) => select(result),
          child: ListTile(
            horizontalTitleGap: 5,
            title: Text("Duration".tr()),
            leading: const Icon(
              Icons.place_rounded,
              color: blackColor,
            ),
            subtitle:
                isSelected ? Text(selected.duration.tr()) : const Text(""),
            trailing: const Icon(Icons.keyboard_arrow_down),
          ),
        ));
  }
}
