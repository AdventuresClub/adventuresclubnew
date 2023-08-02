import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_filter.dart';
import 'package:flutter/material.dart';
import '../models/filter_data_model/service_types_filter.dart';

class TypeDropDown extends StatefulWidget {
  final double width;
  const TypeDropDown(this.width, {super.key});

  @override
  State<TypeDropDown> createState() => _TypeDropDownState();
}

class _TypeDropDownState extends State<TypeDropDown> {
  String type = "";
  List<ServiceTypeFilterModel> typeList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    typeList = Constants.serviceFilter;
    type = typeList[0].type;
    ConstantsFilter.typeId = typeList[0].id.toString();
  }

  void updateData(ServiceTypeFilterModel t) {
    ConstantsFilter.typeId = t.id.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width / widget.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: type,
          icon: const Icon(Icons.keyboard_arrow_down),
          elevation: 12,
          style: const TextStyle(color: blackTypeColor),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              type = value!;
            });
          },
          items: typeList
              .map<DropdownMenuItem<String>>((ServiceTypeFilterModel value) {
            return DropdownMenuItem<String>(
              onTap: () => updateData(value),
              value: value.type,
              child: Text(
                value.type,
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
