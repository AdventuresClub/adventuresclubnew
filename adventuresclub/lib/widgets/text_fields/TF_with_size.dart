import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';

class TFWithSize extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool? edit;
  final TextInputType? show;
  final double verticalPadding;
  final Function? function;
  final Function? onEdit;
  final fillColor;
  final double width;
  final int? hintLines;
  final bool? type;
  const TFWithSize(this.hintText, this.controller, this.verticalPadding,
      this.fillColor, this.width,
      {Key? key,
      this.edit = true,
      this.show = TextInputType.text,
      this.function,
      this.onEdit,
      this.hintLines = 2,
      this.type = false})
      : super(key: key);

  @override
  State<TFWithSize> createState() => _TFWithSizeState();
}

class _TFWithSizeState extends State<TFWithSize> {
  void abc() {}
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / widget.width,
      child: TextField(
        onEditingComplete: () => widget.onEdit,
        keyboardType: widget.show,
        controller: widget.controller,
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.symmetric(
          //     vertical: widget.verticalPadding, horizontal: 18),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: blackColor.withOpacity(0.5),
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Raleway'),
          hintMaxLines: widget.hintLines,
          isDense: true,
          filled: true,
          fillColor: widget.fillColor,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: widget.type!
                  ? greyTextColor.withOpacity(0.5)
                  : greyTextColor.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: widget.type!
                  ? greyTextColor.withOpacity(0.5)
                  : greyTextColor.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: widget.type!
                  ? greyTextColor.withOpacity(0.5)
                  : greyTextColor.withOpacity(0.2),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
