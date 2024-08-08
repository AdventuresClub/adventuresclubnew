import 'package:adventuresclub/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MultiLineField extends StatefulWidget {
  final String hinttext;
  final int lines;
  final color;
  final TextEditingController? controller;
  final bool? show;
  final int? maximumLetters;
  final int? minimumLetters;
  final String? label;
  const MultiLineField(this.hinttext, this.lines, this.color, this.controller,
      {this.show = false,
      this.maximumLetters = 500,
      this.minimumLetters = 1,
      this.label = "",
      super.key});

  @override
  State<MultiLineField> createState() => _MultiLineFieldState();
}

class _MultiLineFieldState extends State<MultiLineField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      // onChanged: (value) {
      //   debugPrint(Constants.getTranslatedNumber(value));
      // },
      maxLength: widget.maximumLetters,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      autofocus: false,
      controller: widget.controller,
      maxLines: widget.lines,
      decoration: InputDecoration(
          labelText: widget.label!.tr(),
          labelStyle: const TextStyle(
              color: blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Raleway'),
          // contentPadding:
          //     const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          hintText: widget.hinttext.tr(),
          hintStyle: const TextStyle(
              color: blackColor,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              fontFamily: 'Raleway'),
          hintMaxLines: 1,
          isDense: true,
          filled: true,
          fillColor: widget.color,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
                color: widget.show!
                    ? greyColor.withOpacity(0.5)
                    : greyColor.withOpacity(0.2),
                width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
                color: widget.show!
                    ? greyColor.withOpacity(0.5)
                    : greyColor.withOpacity(0.2),
                width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                  color: widget.show!
                      ? greyColor.withOpacity(0.5)
                      : greyColor.withOpacity(0.2),
                  width: 1.5))),
    );
  }
}
