import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_filter.dart';
import 'package:adventuresclub/models/filter_data_model/sector_filter_model.dart';
import 'package:flutter/material.dart';

class SectorDropDown extends StatefulWidget {
  final List<SectorFilterModel>? dropDownList;
  final double width;
  const SectorDropDown(this.width, {this.dropDownList, super.key});

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

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    filterSectors = Constants.filterSectors;
    sector = filterSectors[0].sector;
    ConstantsFilter.sectorId = filterSectors[0].id.toString();
  }

  void updateData(SectorFilterModel s) {
    ConstantsFilter.sectorId = s.id.toString();
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
          items: filterSectors
              .map<DropdownMenuItem<String>>((SectorFilterModel value) {
            return DropdownMenuItem<String>(
              onTap: () => updateData(value),
              value: value.sector,
              child: Text(
                value.sector,
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
