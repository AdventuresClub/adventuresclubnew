import 'dart:developer';

import 'package:app/constants_filter.dart';
import 'package:app/models/filter_data_model/category_filter_model.dart';
import 'package:app/models/home_services/services_model.dart';
import 'package:app/models/services_cost.dart';
import 'package:app/provider/services_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../constants.dart';

class ServicesCostDropdown extends StatefulWidget {
  final List<ServicesCost>? dropDownList;
  final String type;
  final ServicesModel? service;
  final bool? edit;
  final bool? update;
  final ServicesCost? selectedValue;
  const ServicesCostDropdown(
      {required this.dropDownList,
      required this.type,
      this.service,
      this.edit = false,
      this.update = false,
      this.selectedValue,
      super.key});

  @override
  State<ServicesCostDropdown> createState() => _ServicesCostDropdownState();
}

class _ServicesCostDropdownState extends State<ServicesCostDropdown> {
  String dropdownValue = 'One';
  String category = "";
  List<ServicesCost> categoryList = [];
  late ServicesCost selected;
  bool isSelected = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.selectedValue != null) {
      select(widget.selectedValue!, false);
    }
  }

  List<PopupMenuEntry<ServicesCost>> itemBuilder(BuildContext context) {
    return widget.dropDownList!.map((e) {
      return PopupMenuItem(
        value: e,
        child: Text(e.description.tr()),
      );
    }).toList();
  }

  void select(ServicesCost s, bool update) {
    if (widget.selectedValue == null) {
      selected = s;
      isSelected = true;
    } else {
      selected = widget.selectedValue!;
      isSelected = true;
    }
    if (mounted) {
      setState(() {});
    }
    if (!widget.edit!) {
      Provider.of<ServicesProvider>(context, listen: false)
          .updateReason(selected.description, widget.type);
    } else {
      if (update) {
        editService(widget.type);
      }
    }
  }

  void selectEdit(ServicesCost s, bool update) {
    selected = s;
    isSelected = true;
    if (mounted) {
      setState(() {});
    }

    editService(widget.type);
  }

  void editService(String type) async {
    dynamic b = {};
    if (type == "cost1") {
      b = {
        'service_id': widget.service!.id.toString(),
        'customer_id': widget.service!.providerId.toString(),
        "inc_description": selected.description,
      };
    } else if (type == "cost2") {
      b = {
        'service_id': widget.service!.id.toString(),
        'customer_id': widget.service!.providerId.toString(),
        "exc_description": selected.description,
      };
    }
    // debugPrint(b);
    try {
      var response = await http.post(
        Uri.parse("${Constants.baseUrl}/api/v1/edit_service"),
        body: b,
      );
      if (response.statusCode == 200) {
        if (mounted) {
          Constants.showMessage(context, "Success");
        }
        if (type == "plan2" || type == "daysValue") {}
      }
    } catch (e) {
      if (mounted) {
        Constants.showMessage(context, e.toString());
      }
    } finally {
      if (mounted) {}
    }
  }

  void updateData(CategoryFilterModel s) {
    ConstantsFilter.categoryId = s.id.toString();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: itemBuilder,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      offset: const Offset(10, 45),
      onSelected: (ServicesCost result) =>
          widget.edit! ? selectEdit(result, true) : select(result, true),
      child: ListTile(
        title: isSelected
            ? null
            : Text(
                "Cost Description",
              ),
        subtitle: isSelected ? Text(selected.description.tr()) : const Text(""),
        trailing: const Icon(Icons.keyboard_arrow_down),
      ),
    );
  }
}
