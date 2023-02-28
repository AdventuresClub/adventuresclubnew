// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/filter_data_model/sector_filter_model.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceSectorDropDown extends StatefulWidget {
  final List<SectorFilterModel> sFilter;
  const ServiceSectorDropDown(this.sFilter, {super.key});

  @override
  State<ServiceSectorDropDown> createState() => ServiceSectorDropDownState();
}

class ServiceSectorDropDownState extends State<ServiceSectorDropDown> {
  String country = "";
  List<String> rList = ["Training", "Tour"];
  //String selectedRegion = "";
  int selectedId = 0;
  String selectedRegion = "Service Sector";
  int id = 0;

  @override
  void initState() {
    super.initState();
    // parseRegions(widget.rFilter);
    widget.sFilter.insert(
        0,
        SectorFilterModel(7, "Training", "selection_manager1665463304.png", 1,
            "2022-10-11 10:11:44", "2022-10-11 10:11:44", ""));
  }

  void sId(SectorFilterModel sFilter) {
    Provider.of<CompleteProfileProvider>(context, listen: false)
        .regionSelection(sFilter.sector, sFilter.id);
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
          items: widget.sFilter
              .map<DropdownMenuItem<String>>((SectorFilterModel sFilter) {
            return DropdownMenuItem<String>(
              onTap: () => sId(
                sFilter,
              ),
              value: sFilter.sector,
              child: Text(sFilter.sector),
            );
          }).toList(),
        ),
      ),
    );
  }
}
