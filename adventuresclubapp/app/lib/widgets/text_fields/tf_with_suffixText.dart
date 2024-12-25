import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class TFWithSuffixText extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool? edit;

  final TextInputType? show;
  final String text;
  const TFWithSuffixText(
    this.hintText,
    this.controller,
    this.text, {
    Key? key,
    this.edit = true,
    this.show = TextInputType.text,
  }) : super(key: key);

  @override
  State<TFWithSuffixText> createState() => _TFWithSuffixTextState();
}

class _TFWithSuffixTextState extends State<TFWithSuffixText> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.show,
      controller: widget.controller,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
              color: blackColor,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              fontFamily: 'Raleway'),
          hintMaxLines: 1,
          suffixText: widget.text,
          isDense: true,
          filled: true,
          fillColor: whiteColor,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: blackColor.withOpacity(0.1)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: blackColor.withOpacity(0.1)),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: blackColor.withOpacity(0.1)))),
    );
  }
}
