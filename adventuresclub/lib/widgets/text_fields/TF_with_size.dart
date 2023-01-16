import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';

class TFWithSize extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool? edit;
  final TextInputType? show;
  final double verticalPadding;
  
 final fillColor;
  final double width;
  const TFWithSize(this.hintText, this.controller,this.verticalPadding,this.fillColor,this.width, {Key? key, this.edit = true, this.show = TextInputType.text,})
      : super(key: key);

  @override
  State<TFWithSize> createState() => _TFWithSizeState();
}

class _TFWithSizeState extends State<TFWithSize> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/widget.width,
      child: TextField(
        autofocus: true,
        keyboardType: 
        widget.show ,

        controller: widget.controller,
        
        decoration: InputDecoration(
            contentPadding:
                 EdgeInsets.symmetric(vertical: widget.verticalPadding, horizontal: 15),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: blackColor,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              fontFamily: 'Raleway'
            ),
            hintMaxLines: 1,
           
            isDense: true,
            filled: true,
            fillColor: widget.fillColor,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: greyColor.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color:greyColor.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: greyColor.withOpacity(0.2))
            )),
      ),
    );
  }
}
