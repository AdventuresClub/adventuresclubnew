import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';

class TFWithSize extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool? edit;
  final TextInputType? show;
  final double verticalPadding;
  final Function? function;

  final fillColor;
  final double width;
  const TFWithSize(this.hintText, this.controller, this.verticalPadding,
      this.fillColor, this.width,
      {Key? key,
      this.edit = true,
      this.show = TextInputType.text,
      this.function})
      : super(key: key);

  @override
  State<TFWithSize> createState() => _TFWithSizeState();
}

class _TFWithSizeState extends State<TFWithSize> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / widget.width,
      child: TextField(
        autofocus: true,
        keyboardType: widget.show,
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: widget.verticalPadding, horizontal: 18),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: blackColor.withOpacity(0.5),
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Raleway'),
          hintMaxLines: 2,
          isDense: true,
          filled: true,
          fillColor: widget.fillColor,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: greyTextColor.withOpacity(0.2),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: greyTextColor.withOpacity(0.2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: greyTextColor.withOpacity(0.2),
            ),
          ),
        ),
      ),
    );
  }
}
