import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/text_fields/no_space.dart';
import 'package:flutter/material.dart';

class TextFields extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool? edit;
  final TextInputType? show;
  final double verticalPadding;
  final bool trim;
  // ignore: prefer_typing_uninitialized_variables
  final fillColor;
  const TextFields(
    this.hintText,
    this.controller,
    this.verticalPadding,
    this.fillColor,
    this.trim, {
    Key? key,
    this.edit = true,
    this.show = TextInputType.text,
  }) : super(key: key);

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextField(
        inputFormatters: [NoSpaceFormatter()],
        keyboardType: widget.show,
        controller: widget.controller,
        style: const TextStyle(
          decoration: TextDecoration.none,
        ),
        onChanged: (val) {
          if (widget.trim == true) {
            final trimVal = val.trim();
            if (val != trimVal) {
              setState(() {
                widget.controller!.text = trimVal;
                widget.controller!.selection = TextSelection.fromPosition(
                    TextPosition(offset: trimVal.length));
              });
            }
          }
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: widget.verticalPadding, horizontal: 15),
            hintText: widget.hintText,
            hintStyle: TextStyle(
                color: blackColor.withOpacity(
                  0.6,
                ),
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: 'Raleway'),
            hintMaxLines: 1,
            isDense: true,
            filled: true,
            fillColor: widget.fillColor,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: blackColor.withOpacity(0.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: blackColor.withOpacity(0.0)),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: blackColor.withOpacity(0.0)))),
      ),
    );
  }
}
