import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_filter.dart';
import 'package:adventuresclub/models/filter_data_model/category_filter_model.dart';
import 'package:flutter/material.dart';

class CategoryDropDown extends StatefulWidget {
  final List<CategoryFilterModel>? dropDownList;
  final double width;
  const CategoryDropDown(this.width, {this.dropDownList, super.key});

  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  String dropdownValue = 'One';
  String category = "";
  List<CategoryFilterModel> categoryList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    categoryList = Constants.categoryFilter;
    category = categoryList[0].category;
    ConstantsFilter.categoryId = categoryList[0].id.toString();
  }

  void updateData(CategoryFilterModel s) {
    ConstantsFilter.categoryId = s.id.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width / widget.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: category,
          icon: const Icon(Icons.keyboard_arrow_down),
          elevation: 12,
          style: const TextStyle(color: blackTypeColor),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              category = value!;
            });
          },
          items: categoryList
              .map<DropdownMenuItem<String>>((CategoryFilterModel value) {
            return DropdownMenuItem<String>(
              onTap: () => updateData(value),
              value: value.category,
              child: Text(
                value.category,
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
