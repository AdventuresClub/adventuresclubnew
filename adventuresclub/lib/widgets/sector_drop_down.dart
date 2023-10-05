import 'package:adventuresclub/constants_filter.dart';
import 'package:adventuresclub/models/filter_data_model/sector_filter_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SectorDropDown extends StatefulWidget {
  final List<SectorFilterModel>? dropDownList;
  final String title;
  final double width;
  const SectorDropDown(this.width,
      {required this.dropDownList, required this.title, super.key});

  @override
  State<SectorDropDown> createState() => _SectorDropDownState();
}

class _SectorDropDownState extends State<SectorDropDown> {
  String dropdownValue = 'One';
  String sector = "";
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  SectorFilterModel sectorList =
      SectorFilterModel(0, "Sector", "", 0, "", "", "");
  List<SectorFilterModel> filterSectors = [];
  late SectorFilterModel selected;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  List<PopupMenuEntry<SectorFilterModel>> itemBuilder(BuildContext context) {
    return widget.dropDownList!.map((e) {
      return PopupMenuItem(
        value: e,
        child: Text(e.sector.tr()),
      );
    }).toList();
  }

  void select(SectorFilterModel s) {
    setState(() {
      selected = s;
      isSelected = true;
      ConstantsFilter.sectorId = s.id.toString();
    });
  }

  void updateData(SectorFilterModel s) {
    ConstantsFilter.sectorId = s.id.toString();
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
          onSelected: (SectorFilterModel result) => select(result),
          child: ListTile(
            horizontalTitleGap: 5,
            title: Text(widget.title.tr()),
            leading: const Icon(
              Icons.place_rounded,
              color: blackColor,
            ),
            subtitle: isSelected ? Text(selected.sector.tr()) : const Text(""),
            trailing: const Icon(Icons.keyboard_arrow_down),
          ),
        )
        // DropdownButtonHideUnderline(
        //   child: DropdownButton<String>(
        //     isExpanded: true,
        //     value: sector,
        //     icon: const Icon(Icons.keyboard_arrow_down),
        //     elevation: 12,
        //     style: const TextStyle(color: blackTypeColor),
        //     onChanged: (String? value) {
        //       // This is called when the user selects an item.
        //       setState(() {
        //         sector = value!;
        //       });
        //     },
        //     items: filterSectors
        //         .map<DropdownMenuItem<String>>((SectorFilterModel value) {
        //       return DropdownMenuItem<String>(
        //         onTap: () => updateData(value),
        //         value: value.sector,
        //         child: Text(
        //           value.sector,
        //           style:
        //               const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        //         ),
        //       );
        //     }).toList(),
        //   ),
        // ),
        );
  }
}
