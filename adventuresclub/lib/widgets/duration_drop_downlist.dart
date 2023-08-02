import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_filter.dart';
import 'package:adventuresclub/models/filter_data_model/durations_model.dart';
import 'package:flutter/material.dart';

class DurationDropDownList extends StatefulWidget {
  final double width;
  const DurationDropDownList(this.width, {super.key});

  @override
  State<DurationDropDownList> createState() => _DurationDropDownListState();
}

class _DurationDropDownListState extends State<DurationDropDownList> {
  String duration = "";
  List<DurationsModel> durationList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    durationList = Constants.durationFilter;
    duration = durationList[0].duration;
    ConstantsFilter.durationId = durationList[0].id.toString();
  }

  void updateData(DurationsModel t) {
    ConstantsFilter.durationId = t.id.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width / widget.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: duration,
          icon: const Icon(Icons.keyboard_arrow_down),
          elevation: 12,
          style: const TextStyle(color: blackTypeColor),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              duration = value!;
            });
          },
          items: durationList
              .map<DropdownMenuItem<String>>((DurationsModel value) {
            return DropdownMenuItem<String>(
              onTap: () => updateData(value),
              value: value.duration,
              child: Text(
                value.duration,
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
