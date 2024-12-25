import 'package:app/constants.dart';
import 'package:app/constants_filter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../models/filter_data_model/service_types_filter.dart';

class TypeDropDown extends StatefulWidget {
  final List<ServiceTypeFilterModel> sFilter;
  final String title;
  final double width;
  const TypeDropDown(this.sFilter, this.title, this.width, {super.key});

  @override
  State<TypeDropDown> createState() => _TypeDropDownState();
}

class _TypeDropDownState extends State<TypeDropDown> {
  String type = "";
  List<ServiceTypeFilterModel> typeList = [];
  late ServiceTypeFilterModel selected;
  bool isSelected = false;

  List<PopupMenuEntry<ServiceTypeFilterModel>> itemBuilder(
      BuildContext context) {
    return widget.sFilter.map((e) {
      return PopupMenuItem(
        value: e,
        child: Text(e.type.tr()),
      );
    }).toList();
  }

  void select(ServiceTypeFilterModel s) {
    setState(() {
      selected = s;
      isSelected = true;
      ConstantsFilter.typeId = s.id.toString();
    });
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
          onSelected: (ServiceTypeFilterModel result) => select(result),
          child: ListTile(
            horizontalTitleGap: 5,
            title: Text(widget.title.tr()),
            leading: const Icon(
              Icons.place_rounded,
              color: blackColor,
            ),
            subtitle: isSelected ? Text(selected.type.tr()) : const Text(""),
            trailing: const Icon(Icons.keyboard_arrow_down),
          ),
        ));
  }
}
