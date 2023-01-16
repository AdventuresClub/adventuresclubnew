// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';

class TFWithPrefixSuffixIcon extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final Image? preIcn, suffixIcn;
  final bool? show;
  const TFWithPrefixSuffixIcon(
    this.hintText,
    this.controller, {
    Key? key,
    this.preIcn,
    this.suffixIcn,
    this.show = false,
  }) : super(key: key);

  @override
  State<TFWithPrefixSuffixIcon> createState() => _TFWithPrefixSuffixIconState();
}

class _TFWithPrefixSuffixIconState extends State<TFWithPrefixSuffixIcon> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: blackColor.withOpacity(0.5),
      ),
      obscureText: widget.show!,
      autofocus: true,
      keyboardType: TextInputType.text,
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: blackColor.withOpacity(0.5),
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        prefixIcon: widget.preIcn,
        suffixIcon: widget.suffixIcn,
        hintMaxLines: 1,
        isDense: true,
        filled: true,
        fillColor: whiteColor,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: blackColor.withOpacity(0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: blackColor.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: blackColor.withOpacity(0.1)),
        ),
      ),
    );
  }
}
