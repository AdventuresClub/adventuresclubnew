// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/filter_data_model/region_model.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegionDropDown extends StatefulWidget {
  final List<RegionFilterModel> rFilter;
  final bool show;
  const RegionDropDown(this.rFilter, {this.show = false, super.key});

  @override
  State<RegionDropDown> createState() => RegionDropDownState();
}

class RegionDropDownState extends State<RegionDropDown> {
  String country = "";
  List<String> rList = [];
  //String selectedRegion = "";
  int selectedId = 0;
  String selectedRegion = "Muscat";
  int id = 0;

  @override
  void initState() {
    super.initState();
    // parseRegions(widget.rFilter);
    selectedRegion = widget.rFilter[0].regions;
  }

  void parseRegions(List<RegionFilterModel> rm) {
    rm.forEach(
      (element) {
        if (element.regions.isNotEmpty) {
          rList.add(element.regions);
        }
      },
    );
  }

  void sId(RegionFilterModel rFilter) {
    Provider.of<CompleteProfileProvider>(context, listen: false)
        .regionSelection(rFilter.regions, rFilter.id);
  }

  void fId(RegionFilterModel sFilter) {
    setState(() {
      selectedRegion = sFilter.regions;
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
                items: widget.rFilter
                    .map<DropdownMenuItem<String>>((RegionFilterModel cFilter) {
                  return DropdownMenuItem<String>(
                    onTap: () => fId(cFilter),
                    value: cFilter.regions,
                    child: Transform.translate(
                      offset: const Offset(4, 2),
                      child: Text(cFilter.regions),
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
                items: widget.rFilter
                    .map<DropdownMenuItem<String>>((RegionFilterModel rFilter) {
                  return DropdownMenuItem<String>(
                    onTap: () => sId(
                      rFilter,
                    ),
                    value: rFilter.regions,
                    child: Text(rFilter.regions),
                  );
                }).toList(),
              ),
            ),
          );
  }
}
