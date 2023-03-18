// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_create_new_services.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/filter_data_model/durations_model.dart';

class DurationDropDown extends StatefulWidget {
  final List<DurationsModel> dFilter;
  final bool show;
  const DurationDropDown(this.dFilter, {this.show = false, super.key});

  @override
  State<DurationDropDown> createState() => DurationDropDownState();
}

class DurationDropDownState extends State<DurationDropDown> {
  String country = "";
  //String selectedRegion = "";
  int selectedId = 0;
  String selectedRegion = "5 Minutes";
  int id = 0;

  @override
  void initState() {
    super.initState();
    selectedRegion = widget.dFilter[0].duration;
  }

  void sId(DurationsModel dFilter) {
    setState(() {
      ConstantsCreateNewServices.selectedDuration = dFilter.duration;
      ConstantsCreateNewServices.selectedDurationId = dFilter.id;
    });
  }

  void fId(DurationsModel sFilter) {
    setState(() {
      selectedRegion = sFilter.duration;
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
                items: widget.dFilter
                    .map<DropdownMenuItem<String>>((DurationsModel cFilter) {
                  return DropdownMenuItem<String>(
                    onTap: () => fId(cFilter),
                    value: cFilter.duration,
                    child: Transform.translate(
                      offset: const Offset(4, 2),
                      child: Text(cFilter.duration),
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
                items: widget.dFilter.map<DropdownMenuItem<String>>(
                  (DurationsModel dFilter) {
                    return DropdownMenuItem<String>(
                      onTap: () => sId(
                        dFilter,
                      ),
                      value: dFilter.duration,
                      child: Text(dFilter.duration),
                    );
                  },
                ).toList(),
              ),
            ),
          );
  }
}
