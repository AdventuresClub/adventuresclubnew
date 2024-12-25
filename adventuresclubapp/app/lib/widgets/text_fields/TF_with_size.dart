import 'package:app/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TFWithSize extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool? edit;
  final TextInputType? show;
  final double verticalPadding;
  final Function? function;
  final Function? onEdit;
  final fillColor;
  final double width;
  final int? hintLines;
  final bool? type;
  final String? label;
  final int? maximumLetters;
  final int? minimumLetters;
  final Function? tapped;
  const TFWithSize(this.hintText, this.controller, this.verticalPadding,
      this.fillColor, this.width,
      {Key? key,
      this.edit = true,
      this.show = TextInputType.text,
      this.function,
      this.onEdit,
      this.hintLines = 2,
      this.type = false,
      this.maximumLetters = 500,
      this.minimumLetters = 1,
      this.tapped,
      this.label})
      : super(key: key);

  @override
  State<TFWithSize> createState() => _TFWithSizeState();
}

class _TFWithSizeState extends State<TFWithSize> {
  void abc() {}

  void edit() {
    FocusScope.of(context).unfocus();
    if (widget.onEdit != null) {
      widget.onEdit!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / widget.width,
      child: TextField(
        maxLength: widget.maximumLetters,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        onEditingComplete: edit,
        keyboardType: widget.show,
        controller: widget.controller,

        // onChanged: (text) {
        //  // widget.tapped;
        //   // if (text.length < 3) {
        //   //   widget.controller!.value = TextEditingValue(
        //   //     text: text,
        //   //     selection: TextSelection.collapsed(offset: text.length),
        //   //   );
        //   // }
        //   // if (text.length > 50) {
        //   //   widget.controller!.value = TextEditingValue(
        //   //     text: text.substring(0, 50),
        //   //     selection: const TextSelection.collapsed(offset: 50),
        //   //   );
        //   // }
        // },

        // inputFormatters: [
        //   LengthLimitingTextInputFormatter(widget.maximumLetters),
        //   MinLengthLimitingTextInputFormatter(widget.minimumLetters!),
        //   // FilteringTextInputFormatter.digitsOnly,
        //   // NumericRangeFormatter(
        //   //     min: widget.minimumLetters!, max: widget.maximumLetters!)
        // ],
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(
              color: blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Raleway'),
          // contentPadding: EdgeInsets.symmetric(
          //     vertical: widget.verticalPadding, horizontal: 18),
          hintText: widget.hintText.tr(),
          hintStyle: TextStyle(
              color: blackColor.withOpacity(0.5),
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Raleway'),
          hintMaxLines: widget.hintLines,
          isDense: true,
          filled: true,
          fillColor: widget.fillColor,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: widget.type!
                  ? greyTextColor.withOpacity(0.5)
                  : greyTextColor.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: widget.type!
                  ? greyTextColor.withOpacity(0.5)
                  : greyTextColor.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: widget.type!
                  ? greyTextColor.withOpacity(0.5)
                  : greyTextColor.withOpacity(0.2),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
