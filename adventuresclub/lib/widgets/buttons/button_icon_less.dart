// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';

class ButtonIconLess extends StatefulWidget {
  final String name;
  // ignore: prefer_typing_uninitialized_variables
  final color;

  // ignore: prefer_typing_uninitialized_variables
  final textColor;
  // ignore: prefer_typing_uninitialized_variables
  final width;
  // ignore: prefer_typing_uninitialized_variables
  final height;
  final double fontSize;
  // ignore: prefer_typing_uninitialized_variables
  final function;
  const ButtonIconLess(this.name, this.color, this.textColor, this.width,
      this.height, this.fontSize, this.function,
      {Key? key})
      : super(key: key);

  @override
  _ButtonIconLessState createState() => _ButtonIconLessState();
}

class _ButtonIconLessState extends State<ButtonIconLess> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.function,
      child: Container(
        height: MediaQuery.of(context).size.height / widget.height,
        width: MediaQuery.of(context).size.width / widget.width,
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(color: greenishColor),
          borderRadius: const BorderRadius.all(Radius.circular(40)),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                      color: widget.textColor,
                      fontSize: widget.fontSize,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
