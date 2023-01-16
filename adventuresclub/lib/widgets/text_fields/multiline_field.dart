import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';

class MultiLineField extends StatefulWidget {
  final String hinttext;
  final int lines;
  final color;
  const MultiLineField(this.hinttext,this.lines,this.color,{super.key});

  @override
  State<MultiLineField> createState() => _MultiLineFieldState();
}

class _MultiLineFieldState extends State<MultiLineField> {
  @override
  Widget build(BuildContext context) {
    return   TextField(
  maxLines: widget.lines,
  decoration: InputDecoration(
         
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          hintText: widget.hinttext,
          hintStyle: const TextStyle(
            color: blackColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: 'Raleway'
          ),
          hintMaxLines: 1,
         
          isDense: true,
          filled: true,
          fillColor: widget.color,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: blackColor.withOpacity(0.2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: blackColor.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: blackColor.withOpacity(0.2))
          )),
)    ;
  }
}