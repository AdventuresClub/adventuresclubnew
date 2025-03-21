// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:app/constants.dart';
import 'package:flutter/material.dart';

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
  void initState() {
    passwordVisible = widget.showPassword!;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      controller: widget.controller,
      obscureText: !passwordVisible, //This will obscure text dynamically
      style: const TextStyle(
        decoration: TextDecoration.none,
      ),
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: blackColor.withOpacity(0.6),
              fontWeight: FontWeight.w600,
              fontSize: 16,
              fontFamily: 'Raleway'),
          suffixIcon: widget.showPassword == false
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
