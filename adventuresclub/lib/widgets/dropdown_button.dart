import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';

class DdButton extends StatefulWidget {
  final double width;
  const DdButton(this.width, {super.key});

  @override
  State<DdButton> createState() => _DdButtonState();
}

class _DdButtonState extends State<DdButton> {
  String dropdownValue = 'One';
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
          value: dropdownValue,
          icon: const Image(
            image: ExactAssetImage('images/drop_down.png'),
            height: 12,
          ),
          elevation: 16,
          style: const TextStyle(color: blackTypeColor),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              value = value!;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
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
