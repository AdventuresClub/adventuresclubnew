import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';

class TFContainer extends StatefulWidget {
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
  const TFContainer(this.hintText, this.controller, this.verticalPadding,
      this.fillColor, this.width,
      {Key? key,
      this.edit = true,
      this.show = TextInputType.text,
      this.function,
      this.onEdit,
      this.hintLines = 2})
      : super(key: key);

  @override
  State<TFContainer> createState() => TFContainerState();
}

class TFContainerState extends State<TFContainer> {
  void abc() {}
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / widget.width,
      child: TextField(
        readOnly: true,
        onEditingComplete: () => widget.onEdit,
        autofocus: true,
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
