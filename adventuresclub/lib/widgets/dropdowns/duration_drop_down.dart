// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/filter_data_model/durations_model.dart';
import '../../models/filter_data_model/service_types_filter.dart';

class DurationDropDown extends StatefulWidget {
  final List<DurationsModel> dFilter;
  const DurationDropDown(this.dFilter, {super.key});

  @override
  State<DurationDropDown> createState() => DurationDropDownState();
}

class DurationDropDownState extends State<DurationDropDown> {
  String country = "";
  //String selectedRegion = "";
  int selectedId = 0;
  String selectedRegion = "Duration";
  int id = 0;

  @override
  void initState() {
    super.initState();
    // parseRegions(widget.rFilter);
    widget.dFilter.insert(
      0,
      DurationsModel(
        7,
        "Duration",
      ),
    );
  }

  void sId(DurationsModel dFilter) {
    Provider.of<CompleteProfileProvider>(context, listen: false)
        .durationSelection(dFilter.duration, dFilter.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
