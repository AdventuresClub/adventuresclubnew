// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';

class TfImage extends StatefulWidget {
  final hinttext;
  final image;
  final width;
  final controller;
  const TfImage(this.hinttext,this.image,this.width,this.controller,{super.key});

  @override
  State<TfImage> createState() => _TfImageState();
}

class _TfImageState extends State<TfImage> {
  @override
  Widget build(BuildContext context) {
    return   TextField(
                          controller: widget.controller,
                        decoration: InputDecoration(
contentPadding:const EdgeInsets.symmetric(vertical: 20,horizontal: 8),
                        hintStyle: TextStyle(    fontSize: 14,),
                        hintText: widget.hinttext,
                        filled: true,
                        fillColor: whiteColor,
                        suffixIcon: Image(image: ExactAssetImage(widget.image),height: 4,width:4,),
                           border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: greyColor.withOpacity(0.2)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: greyColor.withOpacity(0.2)),
                ),
                 focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: greyColor.withOpacity(0.2)),
              ),
                  
                ),
                
                      );
  }
}