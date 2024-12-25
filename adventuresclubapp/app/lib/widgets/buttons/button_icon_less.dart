// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:app/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ButtonIconLess extends StatefulWidget {
  final String name;
  final color;
  final textColor;
  final width;
  final height;
  final double fontSize;
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
    return Container(
      height: MediaQuery.of(context).size.height / widget.height,
      width: MediaQuery.of(context).size.width / widget.width,
      decoration: BoxDecoration(
        color: widget.color,
        border: Border.all(color: greenishColor),
        borderRadius: const BorderRadius.all(Radius.circular(40)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.function,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.name.tr(),
                    style: TextStyle(
                        color: widget.textColor,
                        fontSize: widget.fontSize,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
