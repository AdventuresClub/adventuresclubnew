// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/filter_data_model/level_filter_mode.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/filter_data_model/service_types_filter.dart';

class LevelDropDown extends StatefulWidget {
  final List<LevelFilterModel> lFilter;
  final bool show;
  const LevelDropDown(this.lFilter, {this.show = false, super.key});

  @override
  State<LevelDropDown> createState() => LevelDropDownState();
}

class LevelDropDownState extends State<LevelDropDown> {
  String country = "";
  //String selectedRegion = "";
  int selectedId = 0;
  String selectedRegion = "Elementary";
  int id = 0;

  @override
  void initState() {
    super.initState();
    // parseRegions(widget.rFilter);
    selectedRegion = widget.lFilter[0].level;
  }

  void sId(LevelFilterModel lFilter) {
    Provider.of<CompleteProfileProvider>(context, listen: false)
        .levelSelection(lFilter.level, lFilter.id);
  }

  void fId(LevelFilterModel sFilter) {
    setState(() {
      selectedRegion = sFilter.level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.show
        ? SizedBox(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedRegion,
                icon: Transform.translate(
                  offset: const Offset(-20, 4),
                  child: const Image(
                    image: ExactAssetImage(
                      'images/drop_down.png',
                    ),
                    fit: BoxFit.cover,
                    height: 10,
                    width: 18,
                  ),
                ),
                elevation: 12,
                style: const TextStyle(
                    color: blackTypeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    selectedRegion = value as String;
                  });
                },
                items: widget.lFilter
                    .map<DropdownMenuItem<String>>((LevelFilterModel cFilter) {
                  return DropdownMenuItem<String>(
                    onTap: () => fId(cFilter),
                    value: cFilter.level,
                    child: Transform.translate(
                      offset: const Offset(4, 2),
                      child: Text(cFilter.level),
                    ),
                  );
                }).toList(),
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: greyColor.withOpacity(0.2),
                )),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedRegion,
                icon: const Image(
                  image: ExactAssetImage(
                    'images/drop_down.png',
                  ),
                  height: 14,
                  width: 16,
                ),
                elevation: 12,
                style: const TextStyle(color: blackTypeColor),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    selectedRegion = value as String;
                    // selectedId =
                  });
                },
                items: widget.lFilter.map<DropdownMenuItem<String>>(
                  (LevelFilterModel lFilter) {
                    return DropdownMenuItem<String>(
                      onTap: () => sId(
                        lFilter,
                      ),
                      value: lFilter.level,
                      child: Text(lFilter.level),
                    );
                  },
                ).toList(),
              ),
            ),
          );
  }
}
