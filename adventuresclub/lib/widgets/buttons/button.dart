// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String name;
  final color;
  final borderColor;
  final textColor;
  final double fontSize;
  final function;
  final IconData icn;
  final iconColor;
  final bool showIcon;
  final getwidth;
  final fontFamily;
  final fontWeight;
  final double height;
  const Button(
      this.name,
      this.color,
      this.borderColor,
      this.textColor,
      this.fontSize,
      this.function,
      this.icn,
      this.iconColor,
      this.showIcon,
      this.getwidth,
      this.fontFamily,
      this.fontWeight,
      this.height,
      {Key? key})
      : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / widget.height,
      width: MediaQuery.of(context).size.width / widget.getwidth,
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.borderColor,
          width: 2.0,
        ),
        color: widget.color,
        borderRadius: const BorderRadius.all(Radius.circular(28)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.function,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.name.tr(),
                  style: TextStyle(
                      color: widget.textColor,
                      fontWeight: widget.fontWeight,
                      letterSpacing: 0.8,
                      fontFamily: widget.fontFamily,
                      fontSize: widget.fontSize),
                ),
                const SizedBox(width: 3),
                if (widget.showIcon == true)
                  Icon(
                    widget.icn,
                    color: widget.iconColor,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
