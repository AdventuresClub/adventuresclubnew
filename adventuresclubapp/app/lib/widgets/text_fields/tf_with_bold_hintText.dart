// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class TFWithBoldHintText extends StatefulWidget {
  final String hintText;

  final TextEditingController controller;

  const TFWithBoldHintText(this.hintText, this.controller, {Key? key})
      : super(key: key);

  @override
  State<TFWithBoldHintText> createState() => _TFWithBoldHintTextState();
}

class _TFWithBoldHintTextState extends State<TFWithBoldHintText> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        border: UnderlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: greyColor.withOpacity(0.5)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: greyColor.withOpacity(0.5)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: greyColor.withOpacity(0.5)),
        ),
      ),
    );
  }
}
