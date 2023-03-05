// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/filter_data_model/category_filter_model.dart';

class ServiceCategoryDropDown extends StatefulWidget {
  final List<CategoryFilterModel> cFilter;
  const ServiceCategoryDropDown(this.cFilter, {super.key});

  @override
  State<ServiceCategoryDropDown> createState() =>
      ServiceCategoryDropDownState();
}

class ServiceCategoryDropDownState extends State<ServiceCategoryDropDown> {
  String country = "";
  //String selectedRegion = "";
  int selectedId = 0;
  String selectedRegion = "Service Category";
  int id = 0;

  @override
  void initState() {
    super.initState();
    // parseRegions(widget.rFilter);
    widget.cFilter.insert(
        0,
        CategoryFilterModel(
            7,
            "Service Category",
            "selection_manager1665463304.png",
            1,
            "2022-10-11 10:11:44",
            "2022-10-11 10:11:44",
            ""));
  }

  void sId(CategoryFilterModel cFilter) {
    Provider.of<CompleteProfileProvider>(context, listen: false)
        .categorySelection(cFilter.category, cFilter.id);
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
          items: widget.cFilter
              .map<DropdownMenuItem<String>>((CategoryFilterModel cFilter) {
            return DropdownMenuItem<String>(
              onTap: () => sId(
                cFilter,
              ),
              value: cFilter.category,
              child: Text(cFilter.category),
            );
          }).toList(),
        ),
      ),
    );
  }
}
