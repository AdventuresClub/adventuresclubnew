// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class DropdownWithTI extends StatefulWidget {
  final text;
  final bool expanded;
  final showBorder;
  final width;
  final bool show;
  final showIcon;
  const DropdownWithTI(this.text, this.expanded, this.showBorder, this.width,
      this.show, this.showIcon,
      {super.key});

  @override
  State<DropdownWithTI> createState() => _DropdownWithTIState();
}

class _DropdownWithTIState extends State<DropdownWithTI> {
  String dropdownValue = 'One';
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / widget.width,
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
      height: 40,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(2),
          border: widget.showBorder
              ? Border.all(color: greyColor3.withOpacity(0.4))
              : Border.all(color: whiteColor)),
      child: widget.show
          ? DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: widget.expanded,
                value: dropdownValue,
                icon: widget.showIcon
                    ? const Image(
                        image: ExactAssetImage('images/chevron-right.png'),
                        height: 10,
                      )
                    : const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(
                    color: blackTypeColor, fontWeight: FontWeight.w500),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    value = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Text(value),
                    ),
                  );
                }).toList(),
              ),
            )
          : DropdownButton<String>(
              isExpanded: widget.expanded,
              value: dropdownValue,
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 8,
              ),
              elevation: 16,
              style: const TextStyle(
                  color: blackTypeColor, fontWeight: FontWeight.w500),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  value = value!;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Text(value),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
