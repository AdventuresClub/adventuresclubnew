// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TFWithSiffixIcon extends StatefulWidget {
  final String hintText;

  final suffixIcon;
  final TextEditingController controller;

  final bool? showPassword;
  const TFWithSiffixIcon(
      this.hintText, this.suffixIcon, this.controller, this.showPassword,
      {Key? key})
      : super(key: key);

  @override
  State<TFWithSiffixIcon> createState() => _TFWithSiffixIconState();
}

class _TFWithSiffixIconState extends State<TFWithSiffixIcon> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.text,
      controller: widget.controller,
      obscureText: widget.showPassword!, //This will obscure text dynamically

      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: blackColor.withOpacity(0.6),
              fontWeight: FontWeight.w600,
              fontSize: 14,
              fontFamily: 'Raleway'),
          suffixIcon: widget.showPassword == true
              ? IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: bluishColor,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                )
              : Icon(widget.suffixIcon),
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
          )),
    );
  }
}
