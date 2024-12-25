import 'package:flutter/material.dart';

class EditIcon extends StatelessWidget {
  final Function tapped;
  final int? i;
  final bool? indexRequired;
  final double? sizeIcon;
  final String? type;
  const EditIcon(
      {required this.tapped,
      this.i,
      this.indexRequired = false,
      this.sizeIcon = 34,
      this.type,
      super.key});

  @override
  Widget build(BuildContext context) {
    void navFunction() {
      if (indexRequired!) {
        tapped(i);
      } else {
        tapped;
      }
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(64)),
      child: IconButton(
        autofocus: true,
        splashColor: Colors.white,
        hoverColor: Colors.white,
        highlightColor: Colors.white,
        focusColor: Colors.white,
        color: Colors.white,
        onPressed: navFunction,
        icon: Icon(
          size: sizeIcon,
          Icons.edit,
          color: Colors.red,
        ),
      ),
    );
  }
}
