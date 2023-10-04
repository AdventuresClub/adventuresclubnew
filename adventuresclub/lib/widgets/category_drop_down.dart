import 'package:adventuresclub/constants_filter.dart';
import 'package:adventuresclub/models/filter_data_model/category_filter_model.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CategoryDropDown extends StatefulWidget {
  final List<CategoryFilterModel>? dropDownList;
  final String title;
  final double width;
  const CategoryDropDown(this.width,
      {required this.title, required this.dropDownList, super.key});

  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  String dropdownValue = 'One';
  String category = "";
  List<CategoryFilterModel> categoryList = [];
  late CategoryFilterModel selected;
  bool isSelected = false;

  List<PopupMenuEntry<CategoryFilterModel>> itemBuilder(BuildContext context) {
    return widget.dropDownList!.map((e) {
      return PopupMenuItem(
        value: e,
        child: Text(e.category),
      );
    }).toList();
  }

  void select(CategoryFilterModel s) {
    setState(() {
      selected = s;
      isSelected = true;
      ConstantsFilter.sectorId = s.id.toString();
    });
  }

  void updateData(CategoryFilterModel s) {
    ConstantsFilter.categoryId = s.id.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / widget.width,
        child: PopupMenuButton(
          itemBuilder: itemBuilder,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          offset: const Offset(10, 45),
          onSelected: (CategoryFilterModel result) => select(result),
          child: ListTile(
            leading: const Icon(
              Icons.place_rounded,
              color: blackColor,
            ),
            horizontalTitleGap: 5,
            title: Text(
              widget.title,
            ),
            subtitle: isSelected ? Text(selected.category) : const Text(""),
            trailing: const Icon(Icons.keyboard_arrow_down),
          ),
        ));
  }
}
