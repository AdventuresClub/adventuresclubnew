// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_create_new_services.dart';
import 'package:adventuresclub/models/create_adventure/regions_model.dart';
import 'package:adventuresclub/models/filter_data_model/region_model.dart';
import 'package:adventuresclub/widgets/dropdowns/region_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RegionFilterDropDown extends StatefulWidget {
  final List<RegionsModel> rFilter;
  final bool show;
  const RegionFilterDropDown(this.rFilter, {this.show = false, super.key});

  @override
  State<RegionFilterDropDown> createState() => RegionFilterDropDownState();
}

class RegionFilterDropDownState extends State<RegionFilterDropDown> {
  String country = "";
  List<String> rList = [];
  //String selectedRegion = "";
  int selectedRegionId = 0;
  String selectedRegion = "Muscat";
  int id = 0;
  var getRegion = 'Select Region';

  @override
  void initState() {
    super.initState();
    // parseRegions(widget.rFilter);
    // selectedRegion = widget.rFilter[0].region;
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

  // void sId1(RegionsModel rFilter) {
  //   Provider.of<CompleteProfileProvider>(context, listen: false)
  //       .regionSelection(rFilter.region, rFilter.countryId);
  // }

  void fId(RegionFilterModel sFilter) {
    setState(() {
      selectedRegion = sFilter.regions;
    });
  }

  void sId(RegionsModel rFilter) {
    setState(() {
      ConstantsCreateNewServices.selectedRegion = rFilter.region;
      ConstantsCreateNewServices.selectedRegionId = rFilter.countryId;
    });
  }

  void sendRegion(String gRegion, int sRegionId) {
    setState(() {
      getRegion = gRegion;
      ConstantsCreateNewServices.selectedRegionId = sRegionId;
    });
    //  ConstantsCreateNewServices.selectedRegionId = selectedRegionId;
  }

  void selected() {
    if (getRegion.isEmpty) {
      getRegion = widget.rFilter[0].region;
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
    }
    print(getRegion);
  }

  @override
  Widget build(BuildContext context) {
    return widget.show
        ? RegionDropDown(
            3.5,
            filter: widget.rFilter,
            show: true,
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
                    .map<DropdownMenuItem<String>>((RegionsModel rFilter) {
                  return DropdownMenuItem<String>(
                    onTap: () => sId(
                      rFilter,
                    ),
                    value: rFilter.region.tr(),
                    child: Text(rFilter.region),
                  );
                }).toList(),
              ),
            ),
          );
  }
}
