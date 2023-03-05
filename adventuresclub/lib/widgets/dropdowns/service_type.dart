// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/filter_data_model/service_types_filter.dart';

class ServiceTypeDropDown extends StatefulWidget {
  final List<ServiceTypeFilterModel> sFilter;
  const ServiceTypeDropDown(this.sFilter, {super.key});

  @override
  State<ServiceTypeDropDown> createState() => ServiceTypeDropDownState();
}

class ServiceTypeDropDownState extends State<ServiceTypeDropDown> {
  String country = "";
  //String selectedRegion = "";
  int selectedId = 0;
  String selectedRegion = "Service Type";
  int id = 0;

  @override
  void initState() {
    super.initState();
    // parseRegions(widget.rFilter);
    widget.sFilter.insert(
      0,
      ServiceTypeFilterModel(
          7,
          "Service Type",
          "selection_manager1665463304.png",
          1,
          "2022-10-11 10:11:44",
          "2022-10-11 10:11:44",
          ""),
    );
  }

  void sId(ServiceTypeFilterModel sFilter) {
    Provider.of<CompleteProfileProvider>(context, listen: false)
        .typeSelection(sFilter.type, sFilter.id);
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
          items: widget.sFilter.map<DropdownMenuItem<String>>(
            (ServiceTypeFilterModel sFilter) {
              return DropdownMenuItem<String>(
                onTap: () => sId(
                  sFilter,
                ),
                value: sFilter.type,
                child: Text(sFilter.type),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
