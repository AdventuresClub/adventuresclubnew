import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';

class DdButton extends StatefulWidget {
  String? dropDown;
  final List<String>? dropDownList;
  final double width;
  DdButton(this.width, {this.dropDown = "Oman", this.dropDownList, super.key});

  @override
  State<DdButton> createState() => _DdButtonState();
}

class _DdButtonState extends State<DdButton> {
  String dropdownValue = 'One';
  String country = "";
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width / widget.width,
      decoration: BoxDecoration(
          color: lightGreyColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: greyColor.withOpacity(0.2),
          )),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: widget.dropDown,
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
              widget.dropDown = value as String;
            });
          },
          items: widget.dropDownList!
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
