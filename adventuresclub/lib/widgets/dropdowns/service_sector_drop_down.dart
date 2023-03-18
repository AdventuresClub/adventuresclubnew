// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_create_new_services.dart';
import 'package:adventuresclub/models/filter_data_model/sector_filter_model.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceSectorDropDown extends StatefulWidget {
  final List<SectorFilterModel> sFilter;
  final bool show;
  const ServiceSectorDropDown(this.sFilter, {this.show = false, super.key});

  @override
  State<ServiceSectorDropDown> createState() => ServiceSectorDropDownState();
}

class ServiceSectorDropDownState extends State<ServiceSectorDropDown> {
  String country = "";
  List<String> rList = ["Training", "Tour"];
  //List<SectorFilterModel> filterSectors = [];
  //String selectedRegion = "";
  int selectedId = 0;
  String selectedSector = "Training";
  int id = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedSector = widget.sFilter[0].sector;
    });
  }

  // void sId1(SectorFilterModel sFilter) {
  //   Provider.of<CompleteProfileProvider>(context, listen: false)
  //       .sectorSelection(sFilter.sector, sFilter.id);
  // }

  void fId(SectorFilterModel sFilter) {
    setState(() {
      selectedSector = sFilter.sector;
    });
  }

  void sId(SectorFilterModel rFilter) {
    setState(() {
      ConstantsCreateNewServices.selectedSector = rFilter.sector;
      ConstantsCreateNewServices.selectedSectorId = rFilter.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    //filterSectors = Provider.of<FilterProvider>(context).filterSectors;
    return widget.show
        ? SizedBox(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedSector,
                icon: Transform.translate(
                  offset: const Offset(-30, 4),
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
                    selectedSector = value as String;
                  });
                },
                items: widget.sFilter
                    .map<DropdownMenuItem<String>>((SectorFilterModel sFilter) {
                  return DropdownMenuItem<String>(
                    onTap: () => fId(sFilter),
                    value: sFilter.sector,
                    child: Transform.translate(
                        offset: const Offset(4, 2),
                        child: Text(sFilter.sector)),
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
                value: selectedSector,
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
                    selectedSector = value as String;
                    // selectedId =
                  });
                },
                items: widget.sFilter
                    .map<DropdownMenuItem<String>>((SectorFilterModel sFilter) {
                  return DropdownMenuItem<String>(
                    onTap: () => widget.show
                        ? fId(sFilter)
                        : sId(
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
