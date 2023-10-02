import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_filter.dart';
import 'package:adventuresclub/models/create_adventure/regions_model.dart';
import 'package:flutter/material.dart';

class RegionDropDown extends StatefulWidget {
  final List<RegionsModel>? dropDownList;
  final double width;
  const RegionDropDown(this.width, {this.dropDownList, super.key});

  @override
  State<RegionDropDown> createState() => _RegionDropDownState();
}

class _RegionDropDownState extends State<RegionDropDown> {
  String dropdownValue = 'One';
  String sector = "";
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  RegionsModel regionList = RegionsModel(
    0,
    "Region",
    0,
    "",
  );
  List<RegionsModel> regions = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    regions = Constants.regionList;
    sector = regions[0].region;
    ConstantsFilter.regionId = regions[0].regionId.toString();
  }

  void updateData(RegionsModel s) {
    ConstantsFilter.regionId = s.regionId.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width / widget.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: sector,
          icon: const Icon(Icons.keyboard_arrow_down),
          elevation: 12,
          style: const TextStyle(color: blackTypeColor),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              sector = value!;
            });
          },
          items: regions.map<DropdownMenuItem<String>>((RegionsModel value) {
            return DropdownMenuItem<String>(
              onTap: () => updateData(value),
              value: value.region,
              child: Text(
                value.region,
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
