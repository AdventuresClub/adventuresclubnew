// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';

class SquareButton extends StatefulWidget {
  final String name;
  final color;
  final textColor;
  final width;
  final height;
  final double fontSize;
  final Function function;
  const SquareButton(this.name, this.color, this.textColor, this.width,
      this.height, this.fontSize, this.function,
      {Key? key})
      : super(key: key);

  @override
  _SquareButtonState createState() => _SquareButtonState();
}

class _SquareButtonState extends State<SquareButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.function,
      child: Container(
        height: MediaQuery.of(context).size.height / widget.height,
        width: MediaQuery.of(context).size.width / widget.width,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                      color: widget.textColor,
                      fontSize: widget.fontSize,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
