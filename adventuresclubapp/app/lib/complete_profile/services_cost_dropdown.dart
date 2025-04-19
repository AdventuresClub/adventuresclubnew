import 'dart:developer';

import 'package:app/constants_filter.dart';
import 'package:app/models/filter_data_model/category_filter_model.dart';
import 'package:app/models/services_cost.dart';
import 'package:app/provider/services_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ServicesCostDropdown extends StatefulWidget {
  final List<ServicesCost>? dropDownList;
  final String type;
  const ServicesCostDropdown(
      {required this.dropDownList, required this.type, super.key});

  @override
  State<ServicesCostDropdown> createState() => _ServicesCostDropdownState();
}

class _ServicesCostDropdownState extends State<ServicesCostDropdown> {
  String dropdownValue = 'One';
  String category = "";
  List<ServicesCost> categoryList = [];
  late ServicesCost selected;
  bool isSelected = false;

  List<PopupMenuEntry<ServicesCost>> itemBuilder(BuildContext context) {
    return widget.dropDownList!.map((e) {
      return PopupMenuItem(
        value: e,
        child: Text(e.description.tr()),
      );
    }).toList();
  }

  void select(ServicesCost s) {
    setState(() {
      selected = s;
      isSelected = true;
      ConstantsFilter.categoryId = s.id.toString();
    });
    Provider.of<ServicesProvider>(context, listen: false)
        .updateReason(selected.description, widget.type);
  }

  void updateData(CategoryFilterModel s) {
    ConstantsFilter.categoryId = s.id.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: PopupMenuButton(
      itemBuilder: itemBuilder,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      offset: const Offset(10, 45),
      onSelected: (ServicesCost result) => select(result),
      child: ListTile(
        title: Text(
          "Cost Description",
        ),
        subtitle: isSelected ? Text(selected.description.tr()) : const Text(""),
        trailing: const Icon(Icons.keyboard_arrow_down),
      ),
    ));
  }
}
