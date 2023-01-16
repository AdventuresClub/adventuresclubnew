import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';

class TFWithSizeImage extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool? edit;
  final TextInputType? show;
  final double verticalPadding;
 final fillColor;
  final double width;
  final IconData icon;
  final color;
  const TFWithSizeImage(this.hintText, this.controller,this.verticalPadding,this.fillColor,this.width,this.icon,this.color, {Key? key, this.edit = true, this.show = TextInputType.text,})
      : super(key: key);

  @override
  State<TFWithSizeImage> createState() => _TFWithSizeImageState();
}

class _TFWithSizeImageState extends State<TFWithSizeImage> {
  @override
  Widget build(BuildContext context) {
    return  TextField(
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
           suffixIcon:Icon(widget.icon,size: 30,color: widget.color,),
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
     
    );
  }
}
