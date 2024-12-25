// ignore: file_names
import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class TFWithPrefixIcon extends StatefulWidget {
  final String hintText;
  final Image? icn;
  final TextEditingController? controller;
  final bool? show;
  const TFWithPrefixIcon(
    this.hintText,
    this.controller, {
    Key? key,
    this.show = false,
    this.icn,
  }) : super(key: key);

  @override
  State<TFWithPrefixIcon> createState() => _TFWithPrefixIconState();
}

class _TFWithPrefixIconState extends State<TFWithPrefixIcon> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: widget.show!,
      style: TextStyle(
        color: blackColor.withOpacity(0.4),
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      keyboardType: TextInputType.text,
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: blackColor.withOpacity(0.4),
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        prefixIcon: widget.icn,
        hintMaxLines: 1,
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
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: blackColor.withOpacity(0.1)),
        ),
      ),
    );
  }
}
